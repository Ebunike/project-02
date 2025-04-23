package kr.co.soldesk.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.OnedayDTO;
import kr.co.soldesk.beans.ThemeBean;
import kr.co.soldesk.mapper.MemberMapper;
import kr.co.soldesk.service.NaverCalendarService;
import kr.co.soldesk.service.OnedayService;
import kr.co.soldesk.service.ThemeService;


/**
 * 원데이 클래스 관련 요청을 처리하는 컨트롤러
 */
@Controller
@RequestMapping("/oneday")
public class OnedayController {
    
	@Resource(name = "loginMemberBean")
	private MemberBean loginMember;
	
	@Autowired
	private ThemeService themeService;
	
    @Autowired
    private OnedayService onedayService;
    
    
    @Autowired
    private MemberMapper sellerMapper;
    
    @Autowired
    private NaverCalendarService naverCalendarService;
    
    /**
     * 원데이 클래스 목록 페이지로 이동
     */
    @GetMapping("/list")
    public String list(Model model) {
        // 최근 등록된 원데이 클래스 목록 조회
        List<OnedayDTO> onedayList = onedayService.getRecentOnedays(20);
        model.addAttribute("onedayList", onedayList);
        model.addAttribute("loginMember", loginMember);
        
        if(loginMember.getId() == null) {
        	return "redirect:/member/login";
        }
        int sellerIndex = sellerMapper.getSellerIndex(loginMember.getId());
        model.addAttribute("sellerIndex", sellerIndex);
        
        return "item/onedayclass/list";
    }
    
    /**
     * 테마별 원데이 클래스 목록 페이지로 이동
     */
    @GetMapping("/theme/{themeIndex}")
    public String listByTheme(@PathVariable("themeIndex") int themeIndex, Model model) {
        // 테마별 원데이 클래스 목록 조회
    	ThemeBean theme = themeService.getThemeByIndex(themeIndex, 2);
        
        if (theme == null) {
            return "redirect:/oneday/list";
        }
        
        // 테마별 클래스 목록 조회
        List<OnedayDTO> onedayList = onedayService.getOnedaysByThemeIndex(themeIndex);
        
        model.addAttribute("theme", theme);
        model.addAttribute("onedayList", onedayList);
        
        return "item/onedayclass/list";
    }
    
    /**
     * 원데이 클래스 검색
     */
    @GetMapping("/search")
    public String search(@RequestParam("keyword") String keyword, Model model) {
        // 키워드로 원데이 클래스 검색
        List<OnedayDTO> onedayList = onedayService.searchOnedays(keyword);
        model.addAttribute("onedayList", onedayList);
        model.addAttribute("keyword", keyword);
        
        return "item/onedayclass/list";
    }
    
    /**
     * 원데이 클래스 상세 페이지로 이동
     */
    @GetMapping("/detail/{onedayIndex}")
    public String detail(@PathVariable("onedayIndex") int onedayIndex, Model model, HttpSession session) {
        // 원데이 클래스 정보 조회
        OnedayDTO oneday = onedayService.getOnedayByIndex(onedayIndex);
        
        if (oneday == null) {
            return "redirect:/item/onedayclass/list";
        }
        
        model.addAttribute("oneday", oneday);
        
        // 네이버 캘린더 연동 확인
        String accessToken = naverCalendarService.getAccessTokenFromSession(session);
        model.addAttribute("isNaverCalendarConnected", accessToken != null);
        model.addAttribute("loginMember", loginMember);
        return "item/onedayclass/detail";
    }
    
    /**
     * 원데이 클래스 등록 폼으로 이동
     */
    @GetMapping("/register")
    public String registerForm(Model model, HttpSession session) {
        // 로그인 상태 확인
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        
        // 판매자 확인
        int sellerIndex = sellerMapper.getSellerIndex(loginMember.getId());
        if (sellerIndex <= 0) {
            return "redirect:/member/login";
        }
        
        // 네이버 캘린더 연동 확인
        String accessToken = naverCalendarService.getAccessTokenFromSession(session);
        if (accessToken == null) {
            // 캘린더 연동 필요
            session.setAttribute("calendarRedirectUrl", "/oneday/register");
            return "redirect:/naver-calendar/auth";
        }
        
        List<ThemeBean> themeList = themeService.getOneDayThemes(2);
        model.addAttribute("themeList", themeList);
        model.addAttribute("loginMember", loginMember);
        model.addAttribute("oneday", new OnedayDTO());
        return "item/onedayclass/register";
    }
    
    /**
     * 원데이 클래스 등록 처리
     */
    @PostMapping("/register")
    public String register(@ModelAttribute OnedayDTO oneday,
                          @RequestParam("imageFile") MultipartFile imageFile,
    					  HttpSession session,
                          RedirectAttributes rttr,
                          HttpServletRequest request) {
        
    	
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        
        // 판매자 인덱스 설정
        int sellerIndex = sellerMapper.getSellerIndex(loginMember.getId());
        if (sellerIndex <= 0) {
            return "redirect:/member/login";
        }
        oneday.setSeller_index(sellerIndex);
        
        if (!imageFile.isEmpty()) {
            try {
                // 파일 저장 경로 설정
                String originalFilename = imageFile.getOriginalFilename();
                String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                String newFilename = UUID.randomUUID().toString() + extension;
                
                // 웹 애플리케이션 실제 경로 가져오기
                String realPath = request.getServletContext().getRealPath("/upload");
                
                // 폴더가 없으면 생성
                File uploadDir = new File(realPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                // 파일 저장
                File destFile = new File(realPath + File.separator + newFilename);
                imageFile.transferTo(destFile);
                
                // 이미지 URL 설정 - /upload 디렉토리에 직접 저장하므로 하위 경로 없음
                oneday.setOneday_imageUrl(newFilename);
                
            } catch (Exception e) {
                e.printStackTrace();
                rttr.addFlashAttribute("errorMessage", "이미지 업로드 중 오류가 발생했습니다.");
                return "redirect:/oneday/register";
            }
        }
        
        // 네이버 캘린더 액세스 토큰 가져오기
        String accessToken = naverCalendarService.getAccessTokenFromSession(session);
        if (accessToken == null) {
            // 캘린더 연동 필요
            session.setAttribute("calendarRedirectUrl", "/oneday/register");
            return "redirect:/naver-calendar/auth";
        }
        
        // 원데이 클래스 등록 (네이버 캘린더에도 등록)
        OnedayDTO createdOneday = onedayService.registerOneday(oneday, accessToken);
        System.out.println(createdOneday.getOneday_name());
        if (createdOneday != null) {
            rttr.addFlashAttribute("message", "원데이 클래스가 등록되었습니다.");
            return "redirect:/oneday/detail/" + createdOneday.getOneday_index();
        } else {
            rttr.addFlashAttribute("errorMessage", "원데이 클래스 등록에 실패했습니다.");
            return "redirect:/oneday/register";
        }
    }
    
    /**
     * 판매자가 등록한 원데이 클래스 목록 페이지로 이동
     */
    @GetMapping("/my-classes")
    public String myClasses(Model model, HttpSession session) {
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        
        // 판매자 인덱스 확인
        int sellerIndex = sellerMapper.getSellerIndex(loginMember.getId());
        System.out.println(sellerIndex);
        if (sellerIndex <= 0) {
            return "redirect:/member/login";
        }
        
        // 판매자가 등록한 원데이 클래스 목록 조회
        List<OnedayDTO> onedayList = onedayService.getOnedaysBySellerId(loginMember.getId());
        model.addAttribute("onedayList", onedayList);
        model.addAttribute("loginMember", loginMember);
        return "item/onedayclass/myClasses";
    }
    
    /**
     * 원데이 클래스 수정 폼으로 이동
     */
    @GetMapping("/edit/{onedayIndex}")
    public String editForm(@PathVariable("onedayIndex") int onedayIndex, Model model, HttpSession session) {
        // 로그인 상태 확인
       
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        
        // 판매자 권한 확인
        
        Integer sellerIndex = sellerMapper.getSellerIndex(loginMember.getId());
        if (sellerIndex == null) {
            return "redirect:/member/login";
        }
        
        // 클래스 정보 조회
        OnedayDTO oneday = onedayService.getOnedayByIndex(onedayIndex);
        
        // 등록자 확인
        if (oneday == null || oneday.getSeller_index() != sellerIndex) {
            return "redirect:/item/onedayclass/myClasses";
        }
        
        // 테마 목록 조회
        List<ThemeBean> themeList = themeService.getOneDayThemes(2);
        
        model.addAttribute("oneday", oneday);
        model.addAttribute("themeList", themeList);
        model.addAttribute("loginMember", loginMember);
        return "item/onedayclass/edit";
    }
}