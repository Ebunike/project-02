package kr.co.soldesk.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.soldesk.beans.ThemeBean;

@Controller
@RequestMapping("/onedayclass")
public class OnedayController {

	@GetMapping("/onedayMain")
	public String onedayMain(Model model) {
        ThemeBean categoryBean = new ThemeBean();
        model.addAttribute("categoryBean", categoryBean);
        return "onedayclass/onedayMain";
    }
	
	@PostMapping("/category")
	public String category(@ModelAttribute("categoryBean") ThemeBean categoryBean) {
		
		return "onedayclass/category";
	}
}
