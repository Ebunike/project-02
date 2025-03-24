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
        
        // 활성화된 상품 목록 가져오기
        List<ProductBean> productList = adminService.getActiveProducts();
        model.addAttribute("productList", productList);
        
        return "main";
    }
}