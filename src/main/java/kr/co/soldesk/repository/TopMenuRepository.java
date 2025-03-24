package kr.co.soldesk.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/*import kr.co.soldesk.beans.BoardTopBean;*/
import kr.co.soldesk.mapper.TopMenuMapper;

@Repository
public class TopMenuRepository {

	@Autowired
	private TopMenuMapper topMenuMapper;

	/*
	 * public List<BoardTopBean> getMenuList(){ return topMenuMapper.getMenuList();
	 * }
	 */
	@Autowired
	public TopMenuRepository(TopMenuMapper topMenuMapper) {
		this.topMenuMapper = topMenuMapper;
	}
}
