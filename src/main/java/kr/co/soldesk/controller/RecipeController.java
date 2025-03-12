package kr.co.soldesk.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.OpenRecipeBean;
import kr.co.soldesk.service.OpenRecipeService;

@Controller
@RequestMapping("/recipe")
public class RecipeController {

	
	@Autowired
	private OpenRecipeService openRecipeService;
	
	@Resource(name="loginMemberBean")
	private MemberBean loginMember;
	
	
	@GetMapping("/recipe_main")
	public String recipe_main(@RequestParam("theme_index") int theme_index, Model model) {
		
		List<OpenRecipeBean> openRecipeList =
				openRecipeService.getLikeRecipe(theme_index);
		
		model.addAttribute("openRecipeList", openRecipeList);
		model.addAttribute("theme_index",theme_index);
		
		return "recipe/recipe_main";
	}
	
	@GetMapping("/recipe_write")
	public String recipe_write(@ModelAttribute("writeRecipe") OpenRecipeBean writeRecipe,
		Model model) {
		writeRecipe.setId(loginMember.getId());
		
		return "recipe/recipe_write";
	}

	@PostMapping("/recipe_write_pro")
	public String recipe_write_pro(@ModelAttribute("writeRecipe") OpenRecipeBean writeRecipe, 
			
			BindingResult result) {
		
		System.out.println("컨트롤러: " + writeRecipe.getOpenRecipe_content());
		
		  if (writeRecipe.getTheme_index() == 0) {
			  System.out.println("카테고리 선택 오류");
			  return "recipe/recipe_write";  // 폼으로 돌아가서 오류 메시지를 표시
		   }
		  
		  //writeRecipe.setUpload_picture(upload_file);
		  
		  if(result.hasErrors()) {
			    System.out.println("OpenRecipe_write문제");
			    result.getAllErrors().forEach(error -> {
			        System.out.println(error.getDefaultMessage());
			    });
			    return "recipe/recipe_write";
			}
		
		openRecipeService.addOpenRecipe(writeRecipe);
		return "recipe/recipe_write_success";
		
	}
	
	@GetMapping("/recipe_read")
	public String recipe_read(@RequestParam("openRecipe_index") int openRecipe_index,
			Model model) {
		
		OpenRecipeBean openRecipe = openRecipeService.getRecipe(openRecipe_index);
		model.addAttribute("readRecipeBean", openRecipe);
		model.addAttribute("loginMember", loginMember);
		
		return "recipe/recipe_read";
	}
	
	@GetMapping("/recipe_modify")
	public String recipe_modify(@RequestParam("openRecipe_index") int openRecipe_index, Model model) {
		
		OpenRecipeBean modifyRecipe = openRecipeService.getRecipe(openRecipe_index);
		model.addAttribute("modifyRecipe", modifyRecipe);
		
		return "recipe/recipe_modify";
	}
	
	@PostMapping("/recipe_modify_pro")
	public String recipe_modifyPro(@Valid @ModelAttribute("modifyRecipeBean") OpenRecipeBean modifyRecipe,
			BindingResult result) {
		
		if(result.hasErrors()) {
			return "recipe/recipe_modify";
		}
		openRecipeService.modifyRecipe(modifyRecipe);
		
		return "recipe/recipe_modify_success";
	
	}
	
	@GetMapping("/recipe_delete")
	public String recipe_delete(@RequestParam("openRecipe_index") int openRecipe_index, 
			Model model) {
		
		openRecipeService.deleteRecipe(openRecipe_index);
		
		return "recipe/recipe_delete_success";
	}
	@GetMapping("/recipe_kit_main")
	public String main(@RequestParam("theme_index") int theme_index, Model model) {
		
	
	List<OpenRecipeBean> openRecipeList =
			openRecipeService.getLikeRecipe(theme_index);
	
	
	model.addAttribute("openRecipeList", openRecipeList);
	model.addAttribute("theme_index",theme_index);
	
		return "recipe/recipe_kit_main";
	}
	

}
