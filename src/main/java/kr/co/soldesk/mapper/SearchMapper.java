package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.co.soldesk.beans.ItemBean;
import kr.co.soldesk.beans.OnedayBean;
import kr.co.soldesk.beans.OpenRecipeBean;

@Mapper
public interface SearchMapper {

	@Select("SELECT * FROM oneday WHERE oneday_name LIKE '%' || #{result} || '%' OR oneday_info LIKE '%' || #{result} || '%'")
	List<OnedayBean> OnedaySearch(String result);

	@Select("SELECT * FROM item WHERE item_name LIKE '%' || #{result} || '%' OR item_info LIKE '%' || #{result} || '%'")
	List<ItemBean> KitSearch(String result);

	@Select("SELECT * FROM openrecipe WHERE openrecipe_title LIKE '%' || #{result} || '%' OR openrecipe_content LIKE '%' || #{result} || '%'")
	List<OpenRecipeBean> OpenRecipeSearch(String result);
}
