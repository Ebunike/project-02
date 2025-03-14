package kr.co.soldesk.beans;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;

public class ItemDTO {

	@NotNull
	private String kitName;
	@Positive
	private int kitPrice;
	@Positive
	private int kitQuantity;
	@NotNull
	private String kitTheme;
	@NotNull
	private String kitContent;

	public String getKitName() {
		return kitName;
	}

	public void setKitName(String kitName) {
		this.kitName = kitName;
	}

	public int getKitPrice() {
		return kitPrice;
	}

	public void setKitPrice(int kitPrice) {
		this.kitPrice = kitPrice;
	}

	public int getKitQuantity() {
		return kitQuantity;
	}

	public void setKitQuantity(int kitQuantity) {
		this.kitQuantity = kitQuantity;
	}

	public String getKitTheme() {
		return kitTheme;
	}

	public void setKitTheme(String kitTheme) {
		this.kitTheme = kitTheme;
	}

	public String getKitContent() {
		return kitContent;
	}

	public void setKitContent(String kitContent) {
		this.kitContent = kitContent;
	}

	
	
}
