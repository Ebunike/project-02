package kr.co.soldesk.beans;

public class OrderDetailDTO {
	
	private int orderDetailIndex;
    private int itemIndex;
    private String itemName;
    private String itemImage;
    private int finalPrice;
    private int count;
    private String status;
    private String refundCheck;
    
    

	public int getOrderDetailIndex() {
		return orderDetailIndex;
	}
	public void setOrderDetailIndex(int orderDetailIndex) {
		this.orderDetailIndex = orderDetailIndex;
	}
	public int getItemIndex() {
		return itemIndex;
	}
	public void setItemIndex(int itemIndex) {
		this.itemIndex = itemIndex;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getItemImage() {
		return itemImage;
	}
	public void setItemImage(String itemImage) {
		this.itemImage = itemImage;
	}
	public int getFinalPrice() {
		return finalPrice;
	}
	public void setFinalPrice(int finalPrice) {
		this.finalPrice = finalPrice;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRefundCheck() {
		return refundCheck;
	}
	public void setRefundCheck(String refundCheck) {
		this.refundCheck = refundCheck;
	}
    
}
