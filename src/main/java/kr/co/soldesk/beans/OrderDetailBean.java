package kr.co.soldesk.beans;

public class OrderDetailBean {

   private int order_detail_index;
    private String order_id;
    private int item_index;
    private int order_detail_finalPrice;
    private int order_detail_count;
    private String order_detail_status;
    private String refund_check;
    private String item_name;  // 상품명
    private String item_picture;  // 상품 이미지 URL
    
	   public int getOrder_detail_index() {
	      return order_detail_index;
	   }
	   public void setOrder_detail_index(int order_detail_index) {
	      this.order_detail_index = order_detail_index;
	   }
   
   	public String getOrder_id() {
	   return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public int getItem_index() {
		return item_index;
   }
   public void setItem_index(int item_index) {
      this.item_index = item_index;
   }
   public int getOrder_detail_finalPrice() {
      return order_detail_finalPrice;
   }
   public void setOrder_detail_finalPrice(int order_detail_finalPrice) {
      this.order_detail_finalPrice = order_detail_finalPrice;
   }
   public int getOrder_detail_count() {
      return order_detail_count;
   }
   public void setOrder_detail_count(int order_detail_count) {
      this.order_detail_count = order_detail_count;
   }
   public String getOrder_detail_status() {
      return order_detail_status;
   }
   public void setOrder_detail_status(String order_detail_status) {
      this.order_detail_status = order_detail_status;
   }
   public String getRefund_check() {
      return refund_check;
   }
   public void setRefund_check(String refund_check) {
      this.refund_check = refund_check;
   }
   public String getItem_name() {
      return item_name;
   }
   public void setItem_name(String item_name) {
      this.item_name = item_name;
   }
   public String getItem_picture() {
      return item_picture;
   }
   public void setItem_picture(String item_picture) {
      this.item_picture = item_picture;
   }
   @Override
   public String toString() {
      return "OrderDetailBean [order_detail_index=" + order_detail_index + ", orderId=" + order_id + ", item_index="
            + item_index + ", order_detail_finalPrice=" + order_detail_finalPrice + ", order_detail_count="
            + order_detail_count + ", order_detail_status=" + order_detail_status + ", refund_check=" + refund_check
            + ", item_name=" + item_name + ", item_picture=" + item_picture + "]";
   }
    
    
}
