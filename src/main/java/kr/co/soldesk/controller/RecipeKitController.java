package kr.co.soldesk.controller;


import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.service.OpenRecipeService;

@Controller
@RequestMapping("/recipe_kit")
public class RecipeKitController {

	
	
	@Autowired
	private OpenRecipeService openRecipeService;
	
	@Resource(name="loginMemberBean")
	private MemberBean loginMember;
	
	
	
	
				
	}
	