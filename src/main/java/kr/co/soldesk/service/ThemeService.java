package kr.co.soldesk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.ThemeBean;
import kr.co.soldesk.repository.ThemeRepository;

@Service
public class ThemeService {
	
	@Autowired
	private ThemeRepository themeRepository;
	
	public List<ThemeBean> getOneDayThemes(int themeCode) {
		
		return themeRepository.getOneDayThemes(themeCode);
	}

	public ThemeBean getThemeByIndex(int themeIndex, int themeCode) {
		// TODO Auto-generated method stub
		return themeRepository.getThemeByIndex(themeIndex, themeCode);
	}
}
