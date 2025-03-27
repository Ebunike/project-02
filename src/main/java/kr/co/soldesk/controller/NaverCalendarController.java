package kr.co.soldesk.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.service.NaverCalendarService;


/**
 * 네이버 캘린더 인증 관련 요청을 처리하는 컨트롤러
 */
@Controller
@RequestMapping("/naver-calendar")
public class NaverCalendarController {
    
	@Resource(name = "loginMemberBean")
	private MemberBean loginMember;
	
    @Autowired
    private NaverCalendarService naverCalendarService;
    
    /**
     * 네이버 캘린더 인증 요청
     */
    @GetMapping("/auth")
    public String requestAuth(HttpSession session) {
        // 로그인 상태 확인
       
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        
        // 네이버 인증 URL로 리다이렉트
        String authUrl = naverCalendarService.getAuthorizationUrl();
        return "redirect:" + authUrl;
    }
    
    /**
     * 네이버 캘린더 인증 콜백
     */
    @GetMapping("/callback")
    public String authCallback(@RequestParam("code") String code, 
                              @RequestParam("state") String state,
                              HttpSession session,
                              RedirectAttributes rttr) {
        
        // 로그인 상태 확인
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        
        // 액세스 토큰 획득
        boolean result = naverCalendarService.getAccessToken(code, session);
        
        if (result) {
            rttr.addFlashAttribute("message", "네이버 캘린더 연동이 완료되었습니다.");
        } else {
            rttr.addFlashAttribute("errorMessage", "네이버 캘린더 연동에 실패했습니다.");
        }
        
        // 이전 페이지로 리다이렉트 (세션에 저장된 리다이렉트 URL 사용)
        String redirectUrl = (String) session.getAttribute("calendarRedirectUrl");
        if (redirectUrl != null) {
            session.removeAttribute("calendarRedirectUrl");
            return "redirect:" + redirectUrl;
        }
        
        return "redirect:/oneday/list";
    }
    
    /**
     * 네이버 캘린더 연동 해제
     */
    @GetMapping("/disconnect")
    public String disconnect(HttpSession session, RedirectAttributes rttr) {
        // 로그인 상태 확인
        
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        
        // 세션에서 토큰 정보 제거
        naverCalendarService.removeTokenFromSession(session);
        
        rttr.addFlashAttribute("message", "네이버 캘린더 연동이 해제되었습니다.");
        
        return "redirect:/mypage";
    }
}
