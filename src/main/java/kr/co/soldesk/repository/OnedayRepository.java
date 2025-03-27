package kr.co.soldesk.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.OnedayDTO;
import kr.co.soldesk.mapper.OnedayMapper;

@Repository
public class OnedayRepository {
	
	@Autowired
	private OnedayMapper onedayMapper;

	public int insertOneday(OnedayDTO oneday) {
		onedayMapper.insertOneday(oneday);
		return 1;
	}
}
