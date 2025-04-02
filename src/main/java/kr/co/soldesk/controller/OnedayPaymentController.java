package kr.co.soldesk.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.OnedayDTO;
import kr.co.soldesk.beans.OnedayReservationDTO;
import kr.co.soldesk.dto.KakaoPayApproveDTO;
import kr.co.soldesk.dto.KakaoPayReadyDTO;
import kr.co.soldesk.service.KakaoPayService;
import kr.co.soldesk.service.NaverCalendarService;
import kr.co.soldesk.service.OnedayPaymentService;
import kr.co.soldesk.service.OnedayReservationService;
import kr.co.soldesk.service.OnedayService;

@Controller
@RequestMapping("/oneday/payment")
public class OnedayPaymentController {

    private static final Logger logger = LoggerFactory.getLogger(OnedayPaymentController.class);

    @Resource(name = "loginMemberBean")
    private MemberBean loginMember;

    @Autowired
    private OnedayService onedayService;
    
    @Autowired
    private NaverCalendarService naverCalendarService;

    @Autowired
    private OnedayReservationService reservationService;
    
    @Autowired
    private KakaoPayService kakaoPayService;

    @Autowired
    private OnedayPaymentService onedayPaymentService;

    @GetMapping("/prepare/{onedayIndex}")
    public String preparePage(@PathVariable("onedayIndex") int onedayIndex,
                              @RequestParam(value = "count", defaultValue = "1") int count,
                              @RequestParam(value = "specialRequests", required = false) String specialRequests,
                              Model model, HttpSession session) {

        if (loginMember.getId() == null) {
            logger.info("로그인 필요 - 로그인 페이지로 리다이렉트");
            return "redirect:/member/login";
        }

        OnedayDTO oneday = onedayService.getOnedayByIndex(onedayIndex);

        if (oneday == null) {
            logger.error("원데이 클래스 정보 없음 - 인덱스: {}", onedayIndex);
            return "redirect:/oneday/list";
        }

        if (!oneday.isAvailable()) {
            logger.error("예약 불가능한 클래스 - 인덱스: {}", onedayIndex);
            model.addAttribute("errorMessage", "정원이 초과되어 예약할 수 없습니다.");
            return "redirect:/oneday/detail/" + onedayIndex;
        }

        int totalAmount = oneday.getOneday_price() * count;

        model.addAttribute("oneday", oneday);
        model.addAttribute("count", count);
        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("loginMember", loginMember);

        if (specialRequests != null && !specialRequests.isEmpty()) {
            model.addAttribute("specialRequests", specialRequests);
        }

        session.setAttribute("onedayIndex", onedayIndex);
        session.setAttribute("participantCount", count);
        session.setAttribute("specialRequests", specialRequests);

        return "reservation/payment";
    }

    @PostMapping("/kakaopay")
    @ResponseBody
    public ResponseEntity<?> kakaopayReady(
            @RequestParam("onedayIndex") int onedayIndex,
            @RequestParam("count") int count,
            @RequestParam(value = "specialRequests", required = false) String specialRequests,
            HttpSession session) {

        logger.info("카카오페이 결제 준비 요청 - 클래스: {}, 인원: {}", onedayIndex, count);

        if (loginMember.getId() == null) {
            logger.error("로그인 정보 없음");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("로그인이 필요합니다.");
        }

        try {
            OnedayDTO oneday = onedayService.getOnedayByIndex(onedayIndex);

            if (oneday == null) {
                logger.error("원데이 클래스 정보 없음 - 인덱스: {}", onedayIndex);
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("원데이 클래스 정보를 찾을 수 없습니다.");
            }

            OnedayReservationDTO reservation = new OnedayReservationDTO();
            reservation.setOneday_index(onedayIndex);
            reservation.setMember_id(loginMember.getId());
            reservation.setParticipant_count(count);
            reservation.setSpecial_requests(specialRequests);

            KakaoPayReadyDTO response = onedayPaymentService.prepareKakaoPayment(oneday, reservation, session);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            logger.error("카카오페이 결제 준비 중 오류 발생", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("결제 준비 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    @GetMapping("/kakaopay/success")
    public String kakaopaySuccess(
            @RequestParam("pg_token") String pgToken,
            @RequestParam(value = "onedayIndex", required = false) Integer onedayIndexParam,
            @RequestParam(value = "count", required = false) Integer countParam,
            @RequestParam(value = "specialRequests", required = false) String specialRequestsParam,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {
        
        logger.info("카카오페이 결제 성공 - PG Token: {}, URL 파라미터: onedayIndex={}, count={}", 
                    pgToken, onedayIndexParam, countParam);
        
        if (loginMember.getId() == null) {
            logger.error("로그인 정보 없음");
            return "redirect:/member/login";
        }
        
        try {
            // 세션과 URL 파라미터에서 데이터 가져오기 (URL 파라미터 우선)
            String tid = (String) session.getAttribute("tid");
            String partnerOrderId = (String) session.getAttribute("partnerOrderId");
            String partnerUserId = (String) session.getAttribute("partnerUserId");
            
            Integer onedayIndex = onedayIndexParam != null ? onedayIndexParam : (Integer) session.getAttribute("onedayIndex");
            Integer participantCount = countParam != null ? countParam : (Integer) session.getAttribute("participantCount");
            String specialRequests = specialRequestsParam != null ? specialRequestsParam : (String) session.getAttribute("specialRequests");
            
            logger.info("결제 정보: tid={}, onedayIndex={}, participantCount={}", tid, onedayIndex, participantCount);
            
            if (tid == null || onedayIndex == null || participantCount == null) {
                logger.error("결제 정보 없음 - 결제 진행 불가");
                redirectAttributes.addFlashAttribute("errorMessage", "결제 정보가 유효하지 않습니다. 다시 시도해주세요.");
                return "redirect:/oneday/list";
            }
            
            // 결제 승인 요청
            KakaoPayApproveDTO approveResponse = kakaoPayService.kakaoPayApprove(tid, pgToken, partnerOrderId, partnerUserId);
            
            // 예약 정보 생성
            OnedayReservationDTO reservation = new OnedayReservationDTO();
            reservation.setOneday_index(onedayIndex);
            reservation.setMember_id(loginMember.getId());
            reservation.setParticipant_count(participantCount);
            reservation.setSpecial_requests(specialRequests);
            reservation.setReservation_status("CONFIRMED");
            
            // 네이버 캘린더 토큰
            String accessToken = naverCalendarService.getAccessTokenFromSession(session);
            
            // 예약 처리
            OnedayReservationDTO reservedClass = reservationService.reserveOneday(reservation, accessToken);
            
            if (reservedClass == null) {
                logger.error("예약 처리 실패");
                redirectAttributes.addFlashAttribute("errorMessage", "예약 처리에 실패했습니다.");
                return "redirect:/oneday/list";
            }
            
            // 세션 정보 정리
            session.removeAttribute("tid");
            session.removeAttribute("onedayIndex");
            session.removeAttribute("participantCount");
            session.removeAttribute("specialRequests");
            session.removeAttribute("partnerOrderId");
            session.removeAttribute("partnerUserId");
            
            // 성공 페이지로 이동
            return "redirect:/reservation/complete/" + reservedClass.getReservation_index();
        } catch (Exception e) {
            logger.error("결제 완료 처리 중 오류 발생", e);
            redirectAttributes.addFlashAttribute("errorMessage", "결제 처리 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/oneday/list";
        }
    }

    @GetMapping("/kakaopay/cancel")
    public String kakaopayCancel(Model model) {
        logger.info("카카오페이 결제 취소됨");
        model.addAttribute("message", "결제가 취소되었습니다.");
        return "reservation/payment_cancel";
    }

    @GetMapping("/kakaopay/fail")
    public String kakaopayFail(Model model) {
        logger.error("카카오페이 결제 실패");
        model.addAttribute("message", "결제에 실패했습니다. 다시 시도해주세요.");
        return "reservation/payment_fail";
    }

    @PostMapping("/cancel/{reservationIndex}")
    public String cancelPayment(@PathVariable("reservationIndex") int reservationIndex,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {

        logger.info("결제 취소 요청 - 예약: {}, 회원: {}", reservationIndex, loginMember.getId());

        if (loginMember.getId() == null) {
            logger.error("로그인 정보 없음");
            return "redirect:/member/login";
        }

        try {
            String accessToken = (String) session.getAttribute("naverAccessToken");

            boolean result = onedayPaymentService.cancelPayment(
                    reservationIndex, loginMember.getId(), accessToken);

            if (result) {
                logger.info("결제 취소 성공 - 예약: {}", reservationIndex);
                redirectAttributes.addFlashAttribute("message", "예약이 취소되고 환불 처리되었습니다.");
            } else {
                logger.error("결제 취소 실패 - 예약: {}", reservationIndex);
                redirectAttributes.addFlashAttribute("errorMessage", "예약 취소에 실패했습니다. 고객센터에 문의해주세요.");
            }

            return "redirect:/reservation/list";
        } catch (Exception e) {
            logger.error("결제 취소 처리 중 오류 발생", e);
            redirectAttributes.addFlashAttribute("errorMessage", "환불 처리 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/reservation/detail/" + reservationIndex;
        }
    }
}