package kr.co.soldesk.controller;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/search")
public class SearchController {

	@GetMapping("/result")
	private String result(@Param("result") String result, Model model) {
		model.addAttribute(result);
		return "/search/result";
	}
}
