package kr.co.soldesk.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/hoon")
public class BoardTopController {

	@GetMapping("/main")
	public String main(@RequestParam("top_idx") int top_idx , Model model) {
		

		model.addAttribute("top_idx", top_idx);

		
		return "hoon/main";
	}
	
	
	
	
}