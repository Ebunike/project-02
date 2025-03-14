package kr.co.soldesk.beans;

import java.util.Date;

public class PaymentBean {

	private int pay_index;
	private String order_id;
	private Date pay_date;
	private int pay_amount;
	private String pay_method;
	private String paymentKey;
	
	
	public Date getPay_date() {
		return pay_date;
	}
	public void setPay_date(Date pay_date) {
		this.pay_date = pay_date;
	}
	public int getPay_index() {
		return pay_index;
	}
	public void setPay_index(int pay_index) {
		this.pay_index = pay_index;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}

	public int getPay_amount() {
		return pay_amount;
	}
	public void setPay_amount(int pay_amount) {
		this.pay_amount = pay_amount;
	}
	public String getPay_method() {
		return pay_method;
	}
	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}
	public String getPaymentKey() {
		return paymentKey;
	}
	public void setPaymentKey(String paymentKey) {
		this.paymentKey = paymentKey;
	}
	
	
	
	
}
