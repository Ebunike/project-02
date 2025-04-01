package kr.co.soldesk.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.soldesk.beans.InquiryBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.service.InquiryService;
import kr.co.soldesk.service.MemberService;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {
	
	@Resource(name = "loginMemberBean")
	private MemberBean loginUser;
	
	@Autowired
	private InquiryService inquiryService;
	
	@GetMapping("inquiry_main")
	public String inquiry_main(@ModelAttribute("inquiryBean") InquiryBean inquiryBean) {
		
		 if (loginUser.getLogin().equals("buyer")||loginUser.getLogin().equals("seller")||loginUser.getLogin().equals("sellerawaiter")) {
			 System.out.println(loginUser.getLogin());
			 
			 return "inquiry/inquiry_main";      
		    }
		 String errorMessage;
		try {
			errorMessage = URLEncoder.encode("로그인을 먼저 해주세요.", "UTF-8");
			 return "redirect:/member/login?error=" + errorMessage;
		} catch (UnsupportedEncodingException e) {
			
			e.printStackTrace();
			return "redirect:/?error=알 수 없는 오류가 발생했습니다.";
		}
        
	}
	@PostMapping("inquiry_pro")
	public String inquiry_pro(@ModelAttribute("inquiryBean") InquiryBean inquiryBean,Model model) {
		
		inquiryBean.setId(loginUser.getId());
		System.out.println(inquiryBean.getId());
		
		inquiryService.inquiry(inquiryBean);
		model.addAttribute("id",loginUser.getId());
		return "inquiry/inquiry_success";
	}
	@GetMapping("inquiry_list")
	public String inquiry_list(@Param("id") String id, Model model) {
		List<InquiryBean> myinquiry= inquiryService.myInquiry(id);
		model.addAttribute("myinquiry",myinquiry);
		return "inquiry/inquiry_list";
	}
	@GetMapping("inquiry_detail")
	public String inquiry_detail(@Param("inquiry_idx") int inquiry_idx,Model model) {
		InquiryBean oneinquiry = inquiryService.oneinquiry(inquiry_idx);
		model.addAttribute("oneinquiry",oneinquiry);
		return "inquiry/inquiry_detail";
	}
	
	
	
}
