package kr.co.soldesk.beans;

import javax.validation.constraints.NotNull;

public class KitBean {

	private int kit_index;
	private int item_index;
	@NotNull
	private String kit_name;
	
	public int getKit_index() {
		return kit_index;
	}
	public void setKit_index(int kit_index) {
		this.kit_index = kit_index;
	}
	public int getItem_index() {
		return item_index;
	}
	public void setItem_index(int item_index) {
		this.item_index = item_index;
	}
	public String getKit_name() {
		return kit_name;
	}
	public void setKit_name(String kit_name) {
		this.kit_name = kit_name;
	}
}
