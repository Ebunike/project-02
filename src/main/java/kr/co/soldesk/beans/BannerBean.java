package kr.co.soldesk.beans;

public class BannerBean {
    private int banner_idx;
    private String banner_name;
    private String banner_img;
    private String banner_link;
    private int banner_order;
    private String is_active;
    
    public int getBanner_idx() {
        return banner_idx;
    }
    
    public void setBanner_idx(int banner_idx) {
        this.banner_idx = banner_idx;
    }
    
    public String getBanner_name() {
        return banner_name;
    }
    
    public void setBanner_name(String banner_name) {
        this.banner_name = banner_name;
    }
    
    public String getBanner_img() {
        return banner_img;
    }
    
    public void setBanner_img(String banner_img) {
        this.banner_img = banner_img;
    }
    
    public String getBanner_link() {
        return banner_link;
    }
    
    public void setBanner_link(String banner_link) {
        this.banner_link = banner_link;
    }
    
    public int getBanner_order() {
        return banner_order;
    }
    
    public void setBanner_order(int banner_order) {
        this.banner_order = banner_order;
    }

	public String getIs_active() {
		return is_active;
	}

	public void setIs_active(String is_active) {
		this.is_active = is_active;
	}
    
  
}