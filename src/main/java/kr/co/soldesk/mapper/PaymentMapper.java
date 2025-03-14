package kr.co.soldesk.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import kr.co.soldesk.beans.PaymentBean;

@Mapper
public interface PaymentMapper {

	
	//페이먼트 등록
	
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
	
}
