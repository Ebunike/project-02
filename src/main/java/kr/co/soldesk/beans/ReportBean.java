package kr.co.soldesk.beans;


public class ReportBean {

    private int report_id;            
    private String id;                
    private String report_category;   
    private String report_title;    
    private String report_content;  
    private String report_reply;     
    private int report_views;      
    //private Date report_date;     
    private String report_date;     
    
    public ReportBean() {
    	report_views = 0;
    }
    
	public int getReport_views() {
		return report_views;
	}

	public void setReport_views(int report_views) {
		this.report_views = report_views;
	}

	public int getReport_id() {
        return report_id;
    }

    public void setReport_id(int report_id) {
        this.report_id = report_id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getReport_category() {
        return report_category;
    }

    public void setReport_category(String report_category) {
        this.report_category = report_category;
    }

    public String getReport_title() {
        return report_title;
    }

    public void setReport_title(String report_title) {
        this.report_title = report_title;
    }

    public String getReport_content() {
        return report_content;
    }

    public void setReport_content(String report_content) {
        this.report_content = report_content;
    }

    public String getReport_reply() {
        return report_reply;
    }

    public void setReport_reply(String report_reply) {
        this.report_reply = report_reply;
    }

    
    /*
    public Date getReport_date() {
        return report_date;
    }

    public void setReport_date(Date report_date) {
        this.report_date = report_date;
    }*/

	public String getReport_date() {
		return report_date;
	}

	public void setReport_date(String report_date) {
		this.report_date = report_date;
	}
    
}