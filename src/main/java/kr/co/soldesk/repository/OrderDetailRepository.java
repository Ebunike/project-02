package kr.co.soldesk.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.OrderDetailBean;
import kr.co.soldesk.mapper.OrderDetailMapper;

@Repository
public class OrderDetailRepository {

	@Autowired
    private OrderDetailMapper orderDetailMapper;
    
    /**
     * 주문 상세 정보를 저장하는 메서드
     * 
     * @param orderDetail 저장할 주문 상세 정보
     * @return 생성된 주문 상세 인덱스
     */
    public int insertOrderDetail(OrderDetailBean orderDetail) {
        orderDetailMapper.insertOrderDetail(orderDetail);
     
        
        
        return orderDetail.getOrder_detail_index();
    }
    
    /**
     * 주문 ID로 주문 상세 목록을 조회하는 메서드
     * 
     * @param orderId 주문 ID
     * @return 주문 상세 목록
     */
    public List<OrderDetailBean> getOrderDetailsByOrderId(String orderId) {
        return orderDetailMapper.getOrderDetailsByOrderId(orderId);
    }
    
    /**
     * 주문 상세 인덱스로 주문 상세 정보를 조회하는 메서드
     * 
     * @param orderDetailIndex 주문 상세 인덱스
     * @return 주문 상세 정보를 담은 OrderDetailDTO
     */
    public OrderDetailBean getOrderDetailByIndex(int orderDetailIndex) {
        return orderDetailMapper.getOrderDetailByIndex(orderDetailIndex);
    }
    
    /**
     * 주문 상세 상태를 업데이트하는 메서드
     * 
     * @param orderDetailIndex 주문 상세 인덱스
     * @param status 변경할 상태
     * @return 수정된 행의 수
     */
    public int updateOrderDetailStatus(int orderDetailIndex, String status) {
        return orderDetailMapper.updateOrderDetailStatus(orderDetailIndex, status);
    }
    
    public void deleteOrderDetail(String orderId) {
		orderDetailMapper.deleteOrderDetail(orderId);
		
	}
    //환불을 위한 seller 찾아오기
    public int getSeller(int order_detail_index) {
    	return orderDetailMapper.getSeller(order_detail_index);
    }
    
}
