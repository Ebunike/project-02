package kr.co.soldesk.repository;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.ItemBean;
import kr.co.soldesk.mapper.ManagerMapper;

@Repository
public class ManagerRepository {

    @Autowired
    private ManagerMapper managerMapper;

	/*
	 * public List<Map<String, Object>> getWeeklySales() { return
	 * managerMapper.getWeeklySales(); }
	 * 
	 * public List<Map<String, Object>> getMonthlySales() { return
	 * managerMapper.getMonthlySales();}
	 */
    
    
    public List<ItemBean> getKitList(String userId) {
        return managerMapper.getKitList(userId);
     }

    
    public void deleteProduct(int productId) {
        managerMapper.deleteProduct(productId);
        
     }

     public void deleteKit(int productId) {
        managerMapper.deleteKit(productId);      
     }
     //판매금액 보여줌
     public int showSales(String id) {
        return managerMapper.showSales(id);
     }
 

}