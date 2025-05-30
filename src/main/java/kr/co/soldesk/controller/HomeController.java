package kr.co.soldesk.controller;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.co.soldesk.beans.BannerBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.ProductBean;
import kr.co.soldesk.service.AdminService;

@Controller
public class HomeController {
    
    @Resource(name = "loginMemberBean")
    private MemberBean loginMemberBean;
    
    @Autowired
    private AdminService adminService;
    
    @RequestMapping("/")
    public String main(Model model) {
        // 로그인 유저 정보 모델에 추가
        model.addAttribute("loginUser", loginMemberBean);
        
        // 활성화된 배너 목록 가져오기
        List<BannerBean> bannerList = adminService.getActiveBanners();
        model.addAttribute("bannerList", bannerList);
        
        // 각 카테고리별 상품 가져오기
        List<ProductBean> dailyProducts = adminService.getActiveProductsByCategory(1); // "오늘의 발견"
        List<ProductBean> bestProducts = adminService.getActiveProductsByCategory(2);  // "베스트 상품"
        List<ProductBean> newProducts = adminService.getActiveProductsByCategory(3);   // "신규 상품"
        List<ProductBean> saleProducts = adminService.getActiveProductsByCategory(4);  // "할인 상품"
        List<ProductBean> seasonalProducts = adminService.getActiveProductsByCategory(5); // "제철 상품"
        
        // 모든 상품 리스트를 모델에 추가
        model.addAttribute("dailyProducts", dailyProducts);
        model.addAttribute("bestProducts", bestProducts);
        model.addAttribute("newProducts", newProducts);
        model.addAttribute("saleProducts", saleProducts);
        model.addAttribute("seasonalProducts", seasonalProducts);
        
        return "main";
    }
}