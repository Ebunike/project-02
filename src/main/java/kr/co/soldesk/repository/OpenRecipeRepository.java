package kr.co.soldesk.repository;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.OpenRecipeBean;
import kr.co.soldesk.beans.StepBean;
import kr.co.soldesk.beans.UserLikesBean;
import kr.co.soldesk.mapper.OpenRecipeMapper;


@Repository
public class OpenRecipeRepository {


	@Autowired
	private OpenRecipeMapper openRecipeMapper;
	
	//테마별로 좋아요 순서대로 레시피 가져오기
	public List<OpenRecipeBean> getLikeRecipe(int theme_index, RowBounds rowBounds){
		return openRecipeMapper.getLikeRecipe(theme_index, rowBounds);
	}

	//좋아요 순서대로 모든 레시피 가져오기
	public List<OpenRecipeBean> getAllLikeRecipe(RowBounds rowBounds){
		return openRecipeMapper.getAllLikeRecipe(rowBounds);
	}
	
	//페이징 처리용
 	public int getContentCnt(int content_board_idx) {
 		return openRecipeMapper.getContentCnt(content_board_idx);
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
	//레시피 삭제할때 좋아요도 삭제
	public void deleteLikes(int openRecipe_index) {
		openRecipeMapper.deleteLikes(openRecipe_index);
	}
	
	 // 좋아요 수 증가
    public void increaseLike(int openRecipe_index) {
        openRecipeMapper.increaseLike(openRecipe_index);
    }

    // 좋아요 수 감소
    public void decreaseLike(int openRecipe_index) {
        openRecipeMapper.decreaseLike(openRecipe_index);
    }

    // 특정 레시피의 현재 좋아요 수 조회
    public int getCurrentLikeCount(int openRecipe_index) {
        return openRecipeMapper.getCurrentLikeCount(openRecipe_index);
    }
}
