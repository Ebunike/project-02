package kr.co.soldesk.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.MainOrderBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.OrderDetailBean;
import kr.co.soldesk.beans.OrderDetailDTO;
import kr.co.soldesk.beans.PaymentBean;
import kr.co.soldesk.beans.RefundBean;
import kr.co.soldesk.mapper.PaymentMapper;

@Repository
public class PaymentRepository {

	@Autowired
	private PaymentMapper paymentMapper;
	
	//Payment 등록
			public void addPayment(PaymentBean payment) {
				paymentMapper.addPayment(payment);
			}
		
	//DB에 paymentKey 등록
			public void savepaymentKey(String paymentKey,String orderId) {
				System.out.println("Mapper"+paymentKey);
				paymentMapper.savePaymentKey(paymentKey,orderId);
				
			}
			

			
		//환불 등록
		public void addRefund(RefundBean refund) {
			paymentMapper.addRefund(refund);
		}
	
		//판매자 sales를 amount만큼 올려주기. 관리자 or 판매자 매출 확인용
		public List<OrderDetailBean> getOrderDetails(String orderId) {
			return paymentMapper.getOrderDetails(orderId);
		}
		
		public int getSellerIndex(int item_index) {
			return paymentMapper.getSellerIndex(item_index);
		}
		public void addSales(int seller_index, int order_detail_fianlPrice) {
			paymentMapper.addSales(seller_index, order_detail_fianlPrice);
		}

		
		//결제 후 주문목록 가져오기
		//1.메인오더에서 orderId랑 orderDates가져오고.... 
		public List<MainOrderBean> findOrderIdDates(String id) {
			return paymentMapper.findOrderIdDates(id);
		}
		//2.Order_detail에서 상품별 총가격 등등 가져오고...
		public List<OrderDetailDTO> findItemIndex(String order_id) {
			return paymentMapper.findItemIndex(order_id);
		}
		//3.payment에서 필요한거도 가져오고..
		public PaymentBean findPayment(String order_id) {
			return paymentMapper.findPayment(order_id);
		}

		public void updaterefund(int order_detail_index) {
			paymentMapper.updaterefund(order_detail_index);
		}
		
		//환불금액 없애기
		public void removeSales(int seller_index, int cancelAmount) {
			paymentMapper.removeSales(seller_index, cancelAmount);
		}
	


}
