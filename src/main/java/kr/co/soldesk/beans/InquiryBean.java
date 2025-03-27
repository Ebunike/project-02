package kr.co.soldesk.beans;

public class InquiryBean {
	
	private int inquiry_idx;
    private String id;
    private String inquiry_category;
    private String inquiry_title;
    private String inquiry_content;
    private String inquiry_reply;
    private String inquiry_read;
    private String inquiry_replyer;
    private String inquiry_date;
    
    public InquiryBean() {
    	inquiry_read = "답변 대기중";
    }
    
	public String getInquiry_date() {
		return inquiry_date;
	}

	public void setInquiry_date(String inquiry_date) {
		this.inquiry_date = inquiry_date;
	}

	public int getInquiry_idx() {
		return inquiry_idx;
	}
	public void setInquiry_idx(int inquiry_idx) {
		this.inquiry_idx = inquiry_idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getInquiry_category() {
		return inquiry_category;
	}
	public void setInquiry_category(String inquiry_category) {
		this.inquiry_category = inquiry_category;
	}
	public String getInquiry_title() {
		return inquiry_title;
	}
	public void setInquiry_title(String inquiry_title) {
		this.inquiry_title = inquiry_title;
	}
	public String getInquiry_content() {
		return inquiry_content;
	}
	public void setInquiry_content(String inquiry_content) {
		this.inquiry_content = inquiry_content;
	}
	public String getInquiry_reply() {
		return inquiry_reply;
	}
	public void setInquiry_reply(String inquiry_reply) {
		this.inquiry_reply = inquiry_reply;
	}
	public String getInquiry_read() {
		return inquiry_read;
	}
	public void setInquiry_read(String inquiry_read) {
		this.inquiry_read = inquiry_read;
	}
	public String getInquiry_replyer() {
		return inquiry_replyer;
	}
	public void setInquiry_replyer(String inquiry_replyer) {
		this.inquiry_replyer = inquiry_replyer;
	}
    
    
}
