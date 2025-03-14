package kr.co.soldesk.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.PaymentBean;
import kr.co.soldesk.beans.RefundBean;

@Mapper
public interface PaymentMapper {

	
	//결제 정보 등록(paymentKey가 null일 경우 결제 안된거)
	@Insert("insert into Payment "
			+ "(pay_index, "
			+ "order_id, "
			+ "pay_date, "
			+ "pay_amount, "
			+ "pay_method) "
			+ "values(Payment_seq.nextval, "
			+ "#{order_id}, "
			+ "#{pay_date}, "
			+ "#{pay_amount}, "
			+ "#{pay_method})")
	void addPayment(PaymentBean payment);
	
	
	//paymentKey등록
	@Update("UPDATE Payment "
	        + "SET paymentKey = #{paymentKey} "
	        + "WHERE order_id = #{orderId}")
	void savePaymentKey(String paymentKey,String orderId);

	
	//order_detail_index 나중에
	
	
    //환불 정보 등록
    @Insert("INSERT INTO refund "
            + "(refund_index, order_detail_index, refund_reason) "
            + "VALUES (Refund_seq.nextval, #{order_detail_index}, #{refund_reason})")
    void addRefund(RefundBean refund);
	
}
