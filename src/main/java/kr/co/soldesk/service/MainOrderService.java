package kr.co.soldesk.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.MainOrderBean;
import kr.co.soldesk.repository.MainOrderRepository;

@Service
public class MainOrderService {

	@Autowired
	private MainOrderRepository mainOrderRepository;
	
	public void saveOrder(MainOrderBean newOrder) {
		mainOrderRepository.saveOrder(newOrder);
	}
	public void deleteOrder(String orderId) {
		mainOrderRepository.deleteOrder(orderId);
	}
}
