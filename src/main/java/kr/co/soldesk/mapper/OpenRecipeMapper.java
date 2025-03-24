package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import kr.co.soldesk.beans.OpenRecipeBean;
import kr.co.soldesk.beans.UserLikesBean;
import kr.co.soldesk.handler.JsonTypeHandler;


@Mapper
public interface OpenRecipeMapper {

	//테마별 글 좋아요 순서대로 출력
	@Select("SELECT * FROM OpenRecipe "
			+ "where theme_index = #{theme_index} "
			+ "ORDER BY openRecipe_like DESC")
	List<OpenRecipeBean> getLikeRecipe(int theme_index, RowBounds rowBounds);
	
	//모든 글 좋아요 순서대로 출력
	@Select("SELECT * FROM OpenRecipe "
			+ "ORDER BY openRecipe_like DESC")
	List<OpenRecipeBean> getAllLikeRecipe(RowBounds rowBounds);
	
	//게시글의 개수
	@Select("select count(*) from OpenRecipe "
			+ "where theme_index = #{theme_index}")
	int getContentCnt(int theme_index);
	
	
	//레시피 작성
	@Insert("insert into OpenRecipe "
	        + "(openRecipe_index, "
	        + "id, "
	        + "theme_index, "
	        + "openRecipe_title, "
	        + "openRecipe_intro, "
	        + "openRecipe_prepare, "
	        + "openRecipe_content, "
	        + "openRecipe_picture, "
	        + "openRecipe_like) "
	        + "values(OpenRecipe_seq.nextval, "
	        + "#{id}, "
	        + "#{theme_index}, "
	        + "#{openRecipe_title}, "
	        + "#{openRecipe_intro}, "
	        + "#{openRecipe_prepare}, "
	        + "#{openRecipe_content}, "
	        + "#{openRecipe_picture, jdbcType=VARCHAR}, "
	        + "0)") 
	void addRecipe(OpenRecipeBean writeRecipe);

	
	@Select("select openRecipe_index, "
	        + "id, "
	        + "theme_index, "
	        + "openRecipe_title, "
	        + "openRecipe_intro, "
	        + "openRecipe_prepare, "
	        + "openRecipe_content, "
	        + "openRecipe_picture, "
	        + "openRecipe_like "  // 
	        + "from OpenRecipe "
	        + "where openRecipe_index = #{openRecipe_index}")
	@Results({
	    @Result(property = "openRecipe_content", column = "openRecipe_content", 
	            typeHandler = JsonTypeHandler.class)
	})
	OpenRecipeBean getRecipe(int openRecipe_index);
	
	
	//레시피 수정하기
	@Update("update OpenRecipe set "
	        + "openRecipe_title = #{openRecipe_title}, "
	        + "openRecipe_intro = #{openRecipe_intro}, "
	        + "openRecipe_prepare = #{openRecipe_prepare}, "
	        + "openRecipe_content = #{openRecipe_content}, "
	        + "openRecipe_picture = #{openRecipe_picture} "
	        + "where openRecipe_index = #{openRecipe_index}")
	void modifyRecipe(OpenRecipeBean modifyRecipe);

	
	//레시피 삭제하기
	@Delete("delete from OpenRecipe where openRecipe_index = #{openRecipe_index}")
	void deleteRecipe(int openRecipe_index);
	//레시피 삭제할때 좋아요도 삭제
	@Delete("DELETE FROM UserLikes WHERE openRecipe_index = #{openRecipe_index}")
	void deleteLikes(int openRecipe_index);
	
	
	//////////////////진행중///////////////////
	// 좋아요 상태 확인
	@Select("SELECT * FROM UserLikes WHERE id = #{id} AND openRecipe_index = #{openRecipe_index}")
	UserLikesBean findLike(UserLikesBean userLikesBean);
	
	// 좋아요 추가
	@Insert("INSERT INTO UserLikes (Likes_index, id, openRecipe_index, Likes_status) "
	+ "VALUES (UserLikes_seq.nextval, #{id}, #{openRecipe_index}, #{likes_status})")
	void addLike(UserLikesBean userLikesBean);
	
	// 좋아요 삭제
	@Delete("DELETE FROM UserLikes WHERE id = #{id} AND openRecipe_index = #{openRecipe_index}")
	void removeLike(UserLikesBean userLikesBean);
	
	// 좋아요 수 증가
	@Update("UPDATE OpenRecipe SET openRecipe_like = openRecipe_like + 1 WHERE openRecipe_index = #{openRecipe_index}")
	void increaseLike(int openRecipe_index);
	
	// 좋아요 수 감소
	@Update("UPDATE OpenRecipe SET openRecipe_like = openRecipe_like - 1 WHERE openRecipe_index = #{openRecipe_index}")
	void decreaseLike(int openRecipe_index);
	
	// 특정 레시피의 현재 좋아요 수 조회
	@Select("SELECT openRecipe_like FROM OpenRecipe WHERE openRecipe_index = #{openRecipe_index}")
	int getCurrentLikeCount(int openRecipe_index);
	}



