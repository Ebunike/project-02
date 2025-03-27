package kr.co.soldesk.beans;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class BuyingListDTO {
	
	    private String orderId;
	    private String orderDate;
	    private List<OrderDetailDTO> orderDetails;
	    private String paymentKey;
	    private int payAmount;
	    private String payMethod;
	    
	    
		public String getOrderId() {
			return orderId;
		}
		public void setOrderId(String orderId) {
			this.orderId = orderId;
		}
	
		public List<OrderDetailDTO> getOrderDetails() {
			return orderDetails;
		}
		public void setOrderDetails(List<OrderDetailDTO> orderDetails) {
			this.orderDetails = orderDetails;
		}
		public String getPaymentKey() {
			return paymentKey;
		}
		public void setPaymentKey(String paymentKey) {
			this.paymentKey = paymentKey;
		}
		public int getPayAmount() {
			return payAmount;
		}
		public void setPayAmount(int payAmount) {
			this.payAmount = payAmount;
		}
		public String getPayMethod() {
			return payMethod;
		}
		public void setPayMethod(String payMethod) {
			this.payMethod = payMethod;
		}
		public String getOrderDate() {
			return orderDate;
		}
		
		public void setOrderDate(String orderDate) {
			this.orderDate = orderDate;
		}
	    
	    
	    
}
