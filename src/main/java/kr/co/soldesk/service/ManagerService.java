package kr.co.soldesk.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.ItemBean;
import kr.co.soldesk.repository.ManagerRepository;

@Service
public class ManagerService {

    @Autowired
    private ManagerRepository managerRepository;

    public List<Map<String, Object>> getWeeklySales() {
        return managerRepository.getWeeklySales();
    }

    public List<Map<String, Object>> getMonthlySales() {
        return managerRepository.getMonthlySales();
    }
    
    public List<ItemBean> getKitList(String userId) {
        return managerRepository.getKitList(userId);
     }
    public void deleteProduct(int productId) {
        managerRepository.deleteProduct(productId);
        
     }

     public void deleteKit(int productId) {
        managerRepository.deleteKit(productId);      
     }
   //판매금액 보여줌
     public int showSales(String id) {
        return managerRepository.showSales(id);
     }
}