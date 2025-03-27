package kr.co.soldesk.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.OnedayDTO;
import kr.co.soldesk.beans.OnedayReservationDTO;
import kr.co.soldesk.mapper.MemberMapper;
import kr.co.soldesk.service.NaverCalendarService;
import kr.co.soldesk.service.OnedayReservationService;
import kr.co.soldesk.service.OnedayService;

/**
 * 원데이 클래스 예약 관련 요청을 처리하는 컨트롤러
 */
@Controller
@RequestMapping("/reservation")
public class OnedayReservationController {
    
	@Resource(name = "loginMemberBean")
	private MemberBean loginMember;
	
    @Autowired
    private OnedayService onedayService;
    
    @Autowired
    private OnedayReservationService reservationService;
    
    @Autowired
    private NaverCalendarService naverCalendarService;
    
    @Autowired
    private MemberMapper memberMapper;
    
    /**
     * 원데이 클래스 예약 폼으로 이동
     */
    @GetMapping("/form/{onedayIndex}")
    public String reservationForm(@PathVariable("onedayIndex") int onedayIndex, Model model, HttpSession session) {
        // 로그인 상태 확인
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        
        // 원데이 클래스 정보 조회
        OnedayDTO oneday = onedayService.getOnedayByIndex(onedayIndex);
        if (oneday == null) {
            return "redirect:/item/onedayclass/list";
        }
        
        // 예약 가능 여부 확인
        if (!oneday.isAvailable()) {
            // 예약 불가능한 경우
            model.addAttribute("errorMessage", "정원이 초과되어 예약할 수 없습니다.");
            return "redirect:/item/onedayclass/detail/" + onedayIndex;
        }
        
        // 네이버 캘린더 연동 확인
        String accessToken = naverCalendarService.getAccessTokenFromSession(session);
        if (accessToken == null) {
            // 캘린더 연동 필요
            session.setAttribute("calendarRedirectUrl", "/reservation/form/" + onedayIndex);
            model.addAttribute("loginMember", loginMember);
            return "redirect:/naver-calendar/auth";
        }
        
        // 예약 정보 초기화
        OnedayReservationDTO reservation = new OnedayReservationDTO();
        reservation.setOneday_index(onedayIndex);
        reservation.setParticipant_count(1);  // 기본 1명
        
        model.addAttribute("oneday", oneday);
        model.addAttribute("reservation", reservation);
        model.addAttribute("loginMember", loginMember);
        
        return "reservation/form";
    }
    
    /**
     * 원데이 클래스 예약 처리
     */
    @PostMapping("/reserve")
    public String reserve(@ModelAttribute OnedayReservationDTO reservation,
                        HttpSession session,
                        RedirectAttributes rttr) {
        
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        
        // 원데이 클래스 정보 조회
        OnedayDTO oneday = onedayService.getOnedayByIndex(reservation.getOneday_index());
        if (oneday == null) {
            return "redirect:/oneday/list";
        }
        
        // 예약 가능 여부 다시 확인
        if (!oneday.isAvailable()) {
            rttr.addFlashAttribute("errorMessage", "정원이 초과되어 예약할 수 없습니다.");
            return "redirect:/oneday/detail/" + reservation.getOneday_index();
        }
        
        // 네이버 캘린더 연동 확인
        String accessToken = naverCalendarService.getAccessTokenFromSession(session);
        if (accessToken == null) {
            // 캘린더 연동 필요
            session.setAttribute("calendarRedirectUrl", "/reservation/form/" + reservation.getOneday_index());
            return "redirect:/naver-calendar/auth";
        }

        try {
            // 예약 처리 (네이버 캘린더에도 등록)
            OnedayReservationDTO reservedClass = reservationService.reserveOneday(reservation, accessToken);
            
            if (reservedClass != null) {
                rttr.addFlashAttribute("message", "원데이 클래스 예약이 완료되었습니다.");
                return "redirect:/reservation/complete/" + reservedClass.getReservation_index();
            } else {
                rttr.addFlashAttribute("errorMessage", "예약 처리 중 오류가 발생했습니다.");
                return "redirect:/oneday/detail/" + reservation.getOneday_index();
            }
            
        } catch (Exception e) {
            rttr.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/oneday/detail/" + reservation.getOneday_index();
        }
    }
    
    /**
     * 예약 완료 페이지로 이동
     */
    @GetMapping("/complete/{reservationIndex}")
    public String complete(@PathVariable("reservationIndex") int reservationIndex, Model model, HttpSession session) {
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        
        // 예약 정보 조회
        OnedayReservationDTO reservation = reservationService.getReservationByIndex(reservationIndex);
        
        // 예약 정보 확인 및 권한 체크
        if (reservation == null || !reservation.getMember_id().equals(loginMember.getId())) {
            return "redirect:/reservation/list";
        }
        
        model.addAttribute("reservation", reservation);
        model.addAttribute("loginMember", loginMember);
        return "reservation/complete";
    }
    
    /**
     * 예약 목록 페이지로 이동
     */
    @GetMapping("/list")
    public String list(Model model, HttpSession session) {
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        
        // 회원의 예약 목록 조회
        List<OnedayReservationDTO> reservationList = reservationService.getReservationsByMemberId(loginMember.getId());
        model.addAttribute("reservationList", reservationList);
        model.addAttribute("loginMember", loginMember);
        return "reservation/list";
    }
    
    /**
     * 예약 상세 페이지로 이동
     */
    @GetMapping("/detail/{reservationIndex}")
    public String detail(@PathVariable("reservationIndex") int reservationIndex, Model model, HttpSession session) {
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        
        // 예약 정보 조회
        OnedayReservationDTO reservation = reservationService.getReservationByIndex(reservationIndex);
        
        // 예약 정보 확인 및 권한 체크
        if (reservation == null || !reservation.getMember_id().equals(loginMember.getId())) {
            return "redirect:/reservation/list";
        }
        
        model.addAttribute("reservation", reservation);
        model.addAttribute("loginMember", loginMember);
        return "reservation/detail";
    }
    
    /**
     * 예약 취소 처리
     */
    @PostMapping("/cancel/{reservationIndex}")
    public String cancel(@PathVariable("reservationIndex") int reservationIndex,
                        HttpSession session,
                        RedirectAttributes rttr) {
        
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        
        // 네이버 캘린더 연동 확인
        String accessToken = naverCalendarService.getAccessTokenFromSession(session);
        if (accessToken == null) {
            // 캘린더 연동 필요
            session.setAttribute("calendarRedirectUrl", "/reservation/detail/" + reservationIndex);
            return "redirect:/naver-calendar/auth";
        }
        
        try {
            // 예약 취소 처리 (네이버 캘린더에서도 삭제)
            boolean result = reservationService.cancelReservation(reservationIndex, loginMember.getId(), accessToken);
            
            if (result) {
                rttr.addFlashAttribute("message", "예약이 취소되었습니다.");
            } else {
                rttr.addFlashAttribute("errorMessage", "예약 취소 처리 중 오류가 발생했습니다.");
            }
            
        } catch (Exception e) {
            rttr.addFlashAttribute("errorMessage", e.getMessage());
        }
        
        return "redirect:/reservation/list";
    }
    
    /**
     * 클래스별 예약 목록 페이지로 이동 (판매자 기능)
     */
    @GetMapping("/class/{oneday_index}")
    public String classReservations(@PathVariable("oneday_index") int oneday_index, Model model, HttpSession session) {
        // 로그인 상태 확인
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        
        // 판매자 권한 확인
        int sellerIndex = memberMapper.getSellerIndex(loginMember.getId());
        if (sellerIndex <= 0) {
            return "redirect:/member/login";
        }
        
        // 클래스 정보 조회
        OnedayDTO oneday = onedayService.getOnedayByIndex(oneday_index);
        if (oneday == null || oneday.getSeller_index() != sellerIndex) {
            // 존재하지 않는 클래스이거나 접근 권한이 없는 경우
            return "redirect:/oneday/my-classes";
        }
        
        // 예약 목록 조회
        List<OnedayReservationDTO> reservationList = reservationService.getReservationsByOnedayIndex(oneday_index);
        
        model.addAttribute("oneday", oneday);
        model.addAttribute("reservationList", reservationList);
        model.addAttribute("loginMember", loginMember);
        
        return "reservation/reservationList";
    }
    
    /**
     * 예약 상태 업데이트 (판매자용)
     */
    @PostMapping("/class/update-status")
    public String updateStatus(@RequestParam("reservation_index") int reservation_index,
                               @RequestParam("status") String status,
                               @RequestParam("oneday_index") int oneday_index,
                               HttpSession session,
                               RedirectAttributes rttr) {
        
        // 로그인 상태 확인
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        
        // 판매자 권한 확인
        int sellerIndex = memberMapper.getSellerIndex(loginMember.getId());
        if (sellerIndex <= 0) {
            return "redirect:/member/login";
        }
        
        // 클래스 정보 조회
        OnedayDTO oneday = onedayService.getOnedayByIndex(oneday_index);
        if (oneday == null || oneday.getSeller_index() != sellerIndex) {
            // 존재하지 않는 클래스이거나 접근 권한이 없는 경우
            return "redirect:/oneday/my-classes";
        }
        
        // 예약 상태 업데이트
        boolean result = reservationService.updateReservationStatus(reservation_index, status);
        
        if (result) {
            rttr.addFlashAttribute("message", "예약 상태가 업데이트되었습니다.");
        } else {
            rttr.addFlashAttribute("errorMessage", "예약 상태 업데이트에 실패했습니다.");
        }
        
        return "redirect:/reservation/class/" + oneday_index;
    }
}
