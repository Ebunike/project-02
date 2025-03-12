package kr.co.soldesk.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.OpenRecipeBean;
import kr.co.soldesk.mapper.OpenRecipeMapper;


@Repository
public class OpenRecipeRepository {


	@Autowired
	private OpenRecipeMapper openRecipeMapper;
	
	//좋아요 순서대로 레시피 가져오기
	public List<OpenRecipeBean> getLikeRecipe(int theme_index){
		return openRecipeMapper.getLikeRecipe(theme_index);
	}
	
	//오픈 레시피 등록
	public void addRecipe(OpenRecipeBean writeRecipe) {
		openRecipeMapper.addRecipe(writeRecipe);
	}
	//레시피 상세페이지
	public OpenRecipeBean getRecipe(int openRecipe_index) {
		return openRecipeMapper.getRecipe(openRecipe_index);
	}
	//레시피 수정
	public void modifyRecipe(OpenRecipeBean modifyRecipe) {
		openRecipeMapper.modifyRecipe(modifyRecipe);
	}
	//레시피 삭제
	public void deleteRecipe(int openRecipe_index) {
		openRecipeMapper.deleteRecipe(openRecipe_index);
	}
	
}
