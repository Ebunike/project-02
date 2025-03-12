package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.OpenRecipeBean;


@Mapper
public interface OpenRecipeMapper {

	//테마별 글 좋아요순서대로 출력
	@Select("SELECT * FROM OpenRecipe "
			+ "where theme_index = #{theme_index} "
			+ "ORDER BY openRecipe_like DESC")
	List<OpenRecipeBean> getLikeRecipe(int theme_index);
	
	//레시피 작성
	@Insert("insert into OpenRecipe "
	        + "(openRecipe_index, "
	        + "id, "
	        + "theme_index, "
	        + "openRecipe_title, "
	        + "openRecipe_content, "
	        + "openRecipe_picture) "
	        + "values(OpenRecipe_seq.nextval, "
	        + "#{id}, "
	        + "#{theme_index}, "
	        + "#{openRecipe_title}, "
	        + "#{openRecipe_content}, "
	        + "#{openRecipe_picture, jdbcType=VARCHAR})") 
	void addRecipe(OpenRecipeBean writeRecipe);

	//레시피 상세페이지
	@Select("select openRecipe_index, "
			+ "id, "
			+ "theme_index, "
			+ "openRecipe_title, "
			+ "openRecipe_content, "
			+ "openRecipe_picture "
			+ "from OpenRecipe "
			+ "where openRecipe_index = #{openRecipe_index}")
	OpenRecipeBean getRecipe(int openRecipe_index);

	
	//레시피 수정하기
	@Update("update OpenRecipe set "
	        + "openRecipe_title = #{openRecipe_title}, "
	        + "openRecipe_content = #{openRecipe_content}, "
	        + "openRecipe_picture = #{openRecipe_picture} "
	        + "where openRecipe_index = #{openRecipe_index}")
	public void modifyRecipe(OpenRecipeBean modifyRecipe);

	
	//레시피 삭제하기
	@Delete("delete from OpenRecipe where openRecipe_index = #{openRecipe_index}")
	public void deleteRecipe(int openRecipe_index);
	
}



