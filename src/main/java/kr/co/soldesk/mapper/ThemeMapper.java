package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;


import kr.co.soldesk.beans.ThemeBean;

@Mapper
public interface ThemeMapper {
	
	@Select("SELECT * FROM theme WHERE theme_code = #{themeCode}")
	List<ThemeBean> getOneDayThemes(int themeCode);

	@Select("SELECT * FROM theme WHERE theme_code = #{themeCode} AND theme_Index = #{themeIndex}")
	ThemeBean getThemeByIndex(@Param("themeCode") int themeIndex, @Param("themeCode") int themeCode);
}
