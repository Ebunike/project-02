package kr.co.soldesk.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.MainOrderBean;
import kr.co.soldesk.mapper.MainOrderMapper;

@Repository
public class MainOrderRepository {

	
	@Autowired
	private MainOrderMapper mainOrderMapper;
	
	public void saveOrder(MainOrderBean newOrder) {
		mainOrderMapper.saveOrder(newOrder);
	}

	public void deleteOrder(String orderId) {
		mainOrderMapper.deleteOrder(orderId);
		
	}
}
