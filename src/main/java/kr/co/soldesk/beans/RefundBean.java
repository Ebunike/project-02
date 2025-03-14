package kr.co.soldesk.beans;

public class RefundBean {

	private int refund_index;
	private int order_detail_index;
	private String refund_reason;
	
	
	public int getRefund_index() {
		return refund_index;
	}
	public void setRefund_index(int refund_index) {
		this.refund_index = refund_index;
	}
	public int getOrder_detail_index() {
		return order_detail_index;
	}
	public void setOrder_detail_index(int order_detail_index) {
		this.order_detail_index = order_detail_index;
	}
	public String getRefund_reason() {
		return refund_reason;
	}
	public void setRefund_reason(String refund_reason) {
		this.refund_reason = refund_reason;
	}
	
}
