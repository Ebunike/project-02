package kr.co.soldesk.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.soldesk.beans.KitBean;
import kr.co.soldesk.beans.OnedayBean;
import kr.co.soldesk.beans.OpenRecipeBean;
import kr.co.soldesk.service.SearchService;

@Controller
@RequestMapping("/search")
public class SearchController {

	@Autowired
	private SearchService searchService;
	
	@GetMapping("/result")
	private String result(@Param("result") String result, Model model) {
		/*List<OnedayBean> oneday = searchService.OnedaySearch(result);
		List<KitBean> kit = searchService.KitSearch(result);
		List<OpenRecipeBean> openrecipe = searchService.OpenRecipeSearch(result);*/
		
		model.addAttribute(result);
		return "/search/result";
	}
}
