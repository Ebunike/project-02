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
	
	@GetMapping("/report")
	public String suggestion(Model model) {
		List<ReportBean> report = adminService.getReport();
		model.addAttribute("report", report);
		return "admin/report";
	}
	@GetMapping("/viewinquiry")
	public String viewinquiry(@Param("id") int id, Model model) {
		ReportBean oneReport = adminService.oneReport(id);
		
		model.addAttribute("oneReport",oneReport);
		return "admin/viewinquiry";
	}
	@PostMapping("/viewinquiry_pro")
	public String viewinquiry_pro(@RequestParam("reply_content") String reply, @Param("id") int id, Model model) {
			
		System.out.println("id: " + id);
		System.out.println("reply: " + reply);
		adminService.addreply(reply, id);
		model.addAttribute("id",id);

		return "redirect:/admin/viewinquiry?id="+id;
	}
	@PostMapping("deleteReply")
	public String deleteReply(@Param("id") int id) {
		adminService.deleteReply(id);
		return "redirect:/admin/viewinquiry?id="+id;
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
	
		
	
}
