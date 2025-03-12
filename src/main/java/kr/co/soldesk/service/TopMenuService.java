package kr.co.soldesk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.BoardTopBean;
import kr.co.soldesk.repository.TopMenuRepository;

@Service
public class TopMenuService {

	@Autowired
	private TopMenuRepository topMenuRepostory;
	
public List<BoardTopBean> getMenuList(){
		
		return topMenuRepostory.getMenuList();
	}
}
