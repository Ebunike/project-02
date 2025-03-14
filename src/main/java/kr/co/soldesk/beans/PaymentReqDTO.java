package kr.co.soldesk.beans;

public class PaymentReqDTO {


    private String orderId;
    private int amount;  // 결제 금액임
    private String successUrl; 
    private String failUrl; 
    private String paymentKey;  
    private String pay_Method;  

	private String orderName;//주문이름 어케하지...
	private String customerEmail;
	private String customerName;
	
	private String customerMobilePhone;//나중에 추가한거라 오류터질수도
	
	
	
	public PaymentReqDTO() {
	}
	
	
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getSuccessUrl() {
		return successUrl;
	}
	public void setSuccessUrl(String successUrl) {
		this.successUrl = successUrl;
	}
	public String getFailUrl() {
		return failUrl;
	}
	public void setFailUrl(String failUrl) {
		this.failUrl = failUrl;
	}
	public String getPaymentKey() {
		return paymentKey;
	}
	public void setPaymentKey(String paymentKey) {
		this.paymentKey = paymentKey;
	}
	public String getPay_Method() {
		return pay_Method;
	}
	public void setPay_Method(String pay_Method) {
		this.pay_Method = pay_Method;
	}
	public String getOrderName() {
		return orderName;
	}
	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}
	public String getCustomerEmail() {
		return customerEmail;
	}
	public void setCustomerEmail(String customerEmail) {
		this.customerEmail = customerEmail;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}


	public String getCustomerMobilePhone() {
		return customerMobilePhone;
	}


	public void setCustomerMobilePhone(String customerMobilePhone) {
		this.customerMobilePhone = customerMobilePhone;
	}

	
	

	
}
