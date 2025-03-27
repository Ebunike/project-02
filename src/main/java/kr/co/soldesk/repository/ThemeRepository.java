package kr.co.soldesk.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.ThemeBean;
import kr.co.soldesk.mapper.ThemeMapper;

@Repository
public class ThemeRepository {
	
	@Autowired
	private ThemeMapper themeMapper;
	
	public List<ThemeBean> getOneDayThemes(int themeCode) {
		
		return themeMapper.getOneDayThemes(themeCode);
	}

	public ThemeBean getThemeByIndex(int themeIndex, int themeCode) {
		// TODO Auto-generated method stub
		return themeMapper.getThemeByIndex(themeIndex, themeCode);
	}
}
