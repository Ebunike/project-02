package kr.co.soldesk.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.OpenRecipeBean;
import kr.co.soldesk.beans.PageBean;
import kr.co.soldesk.beans.StepBean;
import kr.co.soldesk.beans.UserLikesBean;
import kr.co.soldesk.service.OpenRecipeService;


@Controller
@RequestMapping("/recipe")
public class RecipeController {

	
	@Autowired
	private OpenRecipeService openRecipeService;
	
	@Resource(name="loginMemberBean")
	private MemberBean loginMember;
	


	//메인
	@GetMapping("/recipe_main")
	public String recipe_main(@RequestParam(value = "theme_index", required = false, defaultValue = "0") int theme_index, @RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		
		List<OpenRecipeBean> openRecipeList =
				openRecipeService.getLikeRecipe(theme_index, page);
		
		PageBean pageBean = openRecipeService.getContentPage(theme_index, page);
		
		
		List<OpenRecipeBean> allRecipeList =
				openRecipeService.getAllLikeRecipe(page);
		
		
		model.addAttribute("openRecipeList", openRecipeList);
		model.addAttribute("allRecipeList", allRecipeList);
		model.addAttribute("theme_index",theme_index);
		model.addAttribute("pageBean", pageBean);
		model.addAttribute("page", page);
		
		
		return "recipe/recipe_main";
	}
	
	
	
	
	//글쓰기
	@GetMapping("/recipe_write")
	public String recipe_write(
		Model model) {
		  OpenRecipeBean writeRecipe = new OpenRecipeBean();
	        
	        // 기본 Step 20개 미리 생성 (JSP에서 표시/숨김 처리)
	        for (int i = 0; i < 20; i++) {
	            StepBean step = new StepBean();
	            step.setStepNumber(i + 1);
	            writeRecipe.getStepBeanList().add(step);
	        }
	        
	        writeRecipe.setId(loginMember.getId());
	        model.addAttribute("writeRecipe", writeRecipe);
	        
		return "recipe/recipe_write";
	}
	

	@PostMapping("/recipe_write_pro")
	public String recipe_write_pro(@ModelAttribute("writeRecipe") OpenRecipeBean writeRecipe, 
									
									BindingResult result, Model model) {
		
        // !!!!!유효성 검사 - 카테고리 선택 확인
        if (writeRecipe.getTheme_index() == 0) {
            return "recipe/recipe_write";
        }
        
        if (result.hasErrors()) {
            return "recipe/recipe_write";
        }
		
		// 사용되지 않은 Step 필터링 (텍스트가 없는 Step 제거)
        List<StepBean> filteredSteps = writeRecipe.getStepBeanList().stream()
                .filter(step -> step.getStepText() != null && !step.getStepText().trim().isEmpty())
                .collect(Collectors.toList());
        
        writeRecipe.setStepBeanList(filteredSteps);
		
        
        //stepBeanList로 들어온 상태. 각 스텝 이미지 저장하기
        List<StepBean> stepList = writeRecipe.getStepBeanList();
        
        for (StepBean step : stepList) {
        	openRecipeService.addStep(step);
        	//stepBean의 imageUrl에 String으로 파일명 저장됨
        	System.out.println("step이미지 들어왓는지 확인"+step.getStepImageUrl());
        }
        //혹시모르니까 writeRecipe의 리스트도 이미지 url채워놓기
        writeRecipe.setStepBeanList(stepList);
		
        //List<StepBean>을 JSON으로 변환해서 content에 저장
        writeRecipe.setOpenRecipe_content(writeRecipe.getStepBeanList());
        
        
        
        
        
        //글쓰기 카테고리 선택 안했을 경우
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
	
		model.addAttribute("theme_index", writeRecipe.getTheme_index());
		
		return "recipe/recipe_write_success";
		
	}
	
	
	
	
	
	//읽기
	@GetMapping("/recipe_read")
	public String recipe_read(@RequestParam("openRecipe_index") int openRecipe_index,
			Model model) {
		
		OpenRecipeBean openRecipe = openRecipeService.getRecipe(openRecipe_index);

		System.out.println("openRecipe 값: " + openRecipe.getOpenRecipe_content());
		
		//contents JSON 변환
		List<StepBean> readstepBeanList = openRecipe.getStepList();
		openRecipe.setStepBeanList(readstepBeanList);
		
		
		
		//contents쪽 오류 확인용 코드
		System.out.println("DB에서 읽어온 openRecipe_content: " + openRecipe);
		// 만약 stepList가 비어 있다면, 예외를 처리하거나 기본값을 설정할 수 있습니다.
	    if (readstepBeanList == null || readstepBeanList.isEmpty()) {
	        // 기본값 설정 또는 오류 처리
	        System.out.println("StepList is empty or null");
	    }
		
		System.out.println(openRecipe.getOpenRecipe_like());
		model.addAttribute("readRecipeBean", openRecipe);
		model.addAttribute("loginMember", loginMember);
		
		return "recipe/recipe_read";
	}
	
	
	
	
	
	
	//수정
	@GetMapping("/recipe_modify")
	public String recipe_modify(@RequestParam("openRecipe_index") int openRecipe_index, Model model) {
		
		OpenRecipeBean modifyRecipe = openRecipeService.getRecipe(openRecipe_index);
		
		 // 기본 Step 20개 미리 생성 (JSP에서 표시/숨김 처리)
        for (int i = 0; i < 20; i++) {
            StepBean step = new StepBean();
            step.setStepNumber(i + 1);
            modifyRecipe.getStepBeanList().add(step);
        }		
		
		//JSON List로 바꾸기
		List<StepBean> modistepBeanList = modifyRecipe.getStepList();
		modifyRecipe.setStepBeanList(modistepBeanList);
		
		model.addAttribute("modifyRecipe", modifyRecipe);
		
		return "recipe/recipe_modify";
	}
	//수정
	@PostMapping("/recipe_modify_pro")
	public String recipe_modifyPro(@Valid @ModelAttribute("modifyRecipeBean") OpenRecipeBean modifyRecipe,
			BindingResult result, Model model) {
		
		if(result.hasErrors()) {
			return "recipe/recipe_modify";
		}
		
		// 사용되지 않은 Step 필터링 (텍스트가 없는 Step 제거)
        List<StepBean> filteredSteps = modifyRecipe.getStepBeanList().stream()
                .filter(step -> step.getStepText() != null && !step.getStepText().trim().isEmpty())
                .collect(Collectors.toList());
        
        modifyRecipe.setStepBeanList(filteredSteps);
		
		
		List<StepBean> stepList = modifyRecipe.getStepBeanList();
		//스텝 사진등록
		for (StepBean step : stepList) {
	        	openRecipeService.addStep(step);
	        }
		
	       //혹시모르니까 writeRecipe의 리스트도 이미지 url채워놓기
	        modifyRecipe.setStepBeanList(stepList);
	        
	        //List<StepBean>을 JSON으로 변환해서 content에 저장
	        modifyRecipe.setOpenRecipe_content(modifyRecipe.getStepBeanList());
		 
		
		openRecipeService.modifyRecipe(modifyRecipe);
		
		model.addAttribute("openRecipe_index",modifyRecipe.getOpenRecipe_index());
		
		return "recipe/recipe_modify_success";
	
	}
	//삭제
	@GetMapping("/recipe_delete")
	public String recipe_delete(@RequestParam("openRecipe_index") int openRecipe_index, 
			Model model) {
		
		openRecipeService.deleteRecipe(openRecipe_index);
		
		return "recipe/recipe_delete_success";
	}
	
	
	//좋아요
	@PostMapping("/recipe_like")
	@ResponseBody
	public int recipeLike(@RequestParam("openRecipe_index") int openRecipe_index) {
	    
	    // 현재 로그인한 사용자의 ID와 레시피 인덱스로 UserLikesBean 생성
	    UserLikesBean userLikesBean = new UserLikesBean(loginMember.getId(), openRecipe_index);
	    
	    // 좋아요 처리 및 좋아요 수 반환
	    int likeCount = openRecipeService.processLike(userLikesBean);
	    
	    return likeCount;
	}
	
	
	
}
