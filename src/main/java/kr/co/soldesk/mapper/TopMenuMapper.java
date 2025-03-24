package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

/*import kr.co.soldesk.beans.BoardTopBean;
*/
@Mapper
public interface TopMenuMapper {

	/*
	 * @Select("select board_top_idx, board_top_name " + "from board_top_table")
	 * List<BoardTopBean> getMenuList();
	 */
	// 키트 제목 검색
    @Select("SELECT kit_name from cart ")
    String getKitName();
    
    // 원데이 제목 검색
    @Select("select oneday_name from oneday")
    String getOneDayName();
    
    // 오픈레시피 제목
    @Select("select openRecipe_title from openRecipe")
    String getOpenRecipe();
}
