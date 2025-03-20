package kr.co.soldesk.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.ReportBean;
import kr.co.soldesk.beans.SellerBean;
import kr.co.soldesk.beans.InquiryBean;
import kr.co.soldesk.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;
	
	@GetMapping("/adminmain")
	public String adminmain() {
		return "admin/adminmain";
	}
	
	@GetMapping("/inquiry")
	public String suggestion(Model model) {
		List<InquiryBean> inquiry = adminService.getInquiry();
		model.addAttribute("inquiry", inquiry);
		return "admin/inquiry";
	}
	@GetMapping("/viewinquiry")
	public String viewinquiry(@Param("idx") int idx, Model model) {
		InquiryBean oneInquiry = adminService.oneInquiry(idx);
		
		model.addAttribute("oneInquiry",oneInquiry);
		return "admin/viewinquiry";
	}
	@PostMapping("/viewinquiry_pro")
	public String viewinquiry_pro(@RequestParam("reply_content") String reply, @Param("idx") int idx, Model model) {
			
		System.out.println("id: " + idx);
		System.out.println("reply: " + reply);
		adminService.addreply(reply, idx);
		model.addAttribute("idx",idx);

		return "redirect:/admin/viewinquiry?idx="+idx;
	}
	@PostMapping("deleteReply")
	public String deleteReply(@Param("idx") int idx) {
		adminService.deleteReply(idx);
		return "redirect:/admin/viewinquiry?idx="+idx;
	}
	@GetMapping("/management")
	public String management(Model model) {
		List<MemberBean> allMember = adminService.allMember();
		model.addAttribute("allMember",allMember);
		return "admin/management";
	}
	@GetMapping("/notice")
	public String notice() {
		return "admin/notice";
	}
	@GetMapping("/memberinfo")
	public String memberinfo(@Param("id") String id, Model model) {
		MemberBean memberInfo = adminService.oneMember(id);
		String[] keyword = adminService.getkeyword(id);
		memberInfo.setKeyword(keyword);
		System.out.println(memberInfo.getKeyword());
		model.addAttribute("memberInfo",memberInfo);
		return "admin/memberinfo";
	}
	@GetMapping("/delete")
	public String delete(@Param("id") String id) {
		MemberBean memberInfo = adminService.oneMember(id);
		String[] keyword = adminService.getkeyword(id);
		memberInfo.setKeyword(keyword);
		memberInfo.setBirthday("d");
		memberInfo.setBirthyear("d");
		System.out.println(memberInfo.getId() + memberInfo.getPw()+ memberInfo.getAddress() + memberInfo.getAge() + memberInfo.getName() + memberInfo.getGender() + memberInfo.getBirthday() + memberInfo.getBirthyear() + memberInfo.getLogin() + memberInfo.getTel());
		boolean a = adminService.adminSellerDelete(memberInfo);
		System.out.println(a);
		if(a) {
			adminService.delete(memberInfo);
		}
		return "admin/adminmain";
	}
	@GetMapping("/salesapproval")
	public String salesapproval(Model model) {
		List<SellerBean> sellerBean = adminService.getSeller();
		List<SellerBean> sellerAwaiterBean = adminService.getSellerAwaiter();
		model.addAttribute("sellerAwaiterBean",sellerAwaiterBean);
		model.addAttribute("sellerBean",sellerBean);		
		return "admin/salesapproval";
	}
	@GetMapping("/salesapproval_pro")
	public String salesapproval_pro(@Param("result") String result, @Param("sellerId") String sellerId) {
		
		System.out.println("컨트롤러: " + sellerId + " / " + result);
		if(result.equals("o")) {
			adminService.approval(sellerId);
		}else if(result.equals("x")) {
			adminService.reject(sellerId);
		}
		return "redirect:/admin/salesapproval";
	}
	
		
	
}
