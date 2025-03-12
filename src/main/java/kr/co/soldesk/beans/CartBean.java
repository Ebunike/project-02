package kr.co.soldesk.beans;

public class CartBean {

	
	private int cart_index;
    private String id;
    private int item_index;
    private String cart_id;
    private int cart_quantity;
    private int cart_totalAmount;
    
    public CartBean() {
		cart_id = " ";
	}
    
	public int getCart_index() {
		return cart_index;
	}
	public void setCart_index(int cart_index) {
		this.cart_index = cart_index;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getItem_index() {
		return item_index;
	}
	public void setItem_index(int item_index) {
		this.item_index = item_index;
	}
	public String getCart_id() {
		return cart_id;
	}
	public void setCart_id(String cart_id) {
		this.cart_id = cart_id;
	}
	public int getCart_quantity() {
		return cart_quantity;
	}
	public void setCart_quantity(int cart_quantity) {
		this.cart_quantity = cart_quantity;
	}
	public int getCart_totalAmount() {
		return cart_totalAmount;
	}
	public void setCart_totalAmount(int cart_totalAmount) {
		this.cart_totalAmount = cart_totalAmount;
	}
    
    
}
