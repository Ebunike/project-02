package kr.co.soldesk.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
}
