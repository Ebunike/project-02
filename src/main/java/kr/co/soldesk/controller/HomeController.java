package kr.co.soldesk.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.soldesk.beans.MemberBean;

@Controller
public class HomeController {
	
	@Resource(name = "loginMemberBean")
	private MemberBean loginMemberBean;

	@RequestMapping("/")
	public String main(Model model) {
		
		model.addAttribute("loginUser", loginMemberBean);
		
		return "main";
	}
}
