package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.co.soldesk.beans.ItemBean;
import kr.co.soldesk.beans.KitBean;
import kr.co.soldesk.beans.ThemeBean;

@Mapper
public interface ItemMapper {

	@Insert("INSERT INTO Item (item_index, theme_index, seller_index, item_name, item_price, item_quantity, item_picture, item_info)\r\n"
			+ "VALUES (Item_seq.NEXTVAL, \r\n"
			+ "        #{itemBean.theme_index}, \r\n"
			+ "        (select seller_index from seller where id = #{id}), \r\n"
			+ "        #{itemBean.item_name}, \r\n"
			+ "        #{itemBean.item_price}, \r\n"
			+ "        #{itemBean.item_quantity}, \r\n"
			+ "        #{itemBean.item_picture, jdbcType=VARCHAR}, \r\n"
			+ "        #{itemBean.item_info})")
	void insert_kitItem(@Param("itemBean")ItemBean itemBean,@Param("id") String id);
	
	@Insert("insert into Kit (kit_index, item_index, kit_name)\r\n"
			+ "values (Kit_seq.NEXTVAL, \r\n"
			+ "			(select item_index from Item where item_name = #{itemBean.item_name}), \r\n"
			+ "			#{kitBean.kit_name})")
	void insert_kit(@Param("itemBean")ItemBean itemBean,@Param("kitBean") KitBean kitBean);
	
	@Select("select theme_index from theme where theme_name = #{themeBean.theme_name} and theme_code = 1")
	int getTheme_index(@Param("themeBean") ThemeBean themeBean);
	
	@Select("SELECT * \r\n"
			+ "FROM item i\r\n"
			+ "JOIN kit k ON i.item_name = k.kit_name")
	List<ItemBean> getItem();
}
