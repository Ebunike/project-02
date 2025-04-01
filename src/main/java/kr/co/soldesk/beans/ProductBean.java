package kr.co.soldesk.beans;

public class ProductBean {
    private int product_idx;
    private String product_name;
    private String product_desc;
    private String product_img;
    private String product_link;
    private int product_price;
    private int product_order;
    private String is_active;
    private int category_type;
    
    public int getCategory_type() {
		return category_type;
	}

	public void setCategory_type(int category_type) {
		this.category_type = category_type;
	}
    
    public int getProduct_idx() {
        return product_idx;
    }
    
    public void setProduct_idx(int product_idx) {
        this.product_idx = product_idx;
    }
    
    public String getProduct_name() {
        return product_name;
    }
    
    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }
    
    public String getProduct_desc() {
        return product_desc;
    }
    
    public void setProduct_desc(String product_desc) {
        this.product_desc = product_desc;
    }
    
    public String getProduct_img() {
        return product_img;
    }
    
    public void setProduct_img(String product_img) {
        this.product_img = product_img;
    }
    
    public String getProduct_link() {
        return product_link;
    }
    
    public void setProduct_link(String product_link) {
        this.product_link = product_link;
    }
    
    public int getProduct_price() {
        return product_price;
    }
    
    public void setProduct_price(int product_price) {
        this.product_price = product_price;
    }
    
    public int getProduct_order() {
        return product_order;
    }
    
    public void setProduct_order(int product_order) {
        this.product_order = product_order;
    }

	public String getIs_active() {
		return is_active;
	}

	public void setIs_active(String is_active) {
		this.is_active = is_active;
	}
    
   
}