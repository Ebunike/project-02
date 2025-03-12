package kr.co.soldesk.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.OpenRecipeBean;
import kr.co.soldesk.service.OpenRecipeService;

@Controller
@RequestMapping("/recipe_kit")
public class RecipeKitController {

	
	
	@Autowired
	private OpenRecipeService openRecipeService;
	
	@Resource(name="loginMemberBean")
	private MemberBean loginMember;
	
	
	
	
				
	}
	