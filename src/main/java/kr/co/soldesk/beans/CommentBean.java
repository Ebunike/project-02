package kr.co.soldesk.beans;

public class CommentBean {

	private int comment_Id;        // 댓글 ID
    private int report_Id;         // 연결된 보고서 ID
    private String comment_Content; // 댓글 내용
    private String comment_Writer;  // 댓글 작성자의 ID
    private String comment_Date;
    
	public int getComment_Id() {
		return comment_Id;
	}
	public void setComment_Id(int comment_Id) {
		this.comment_Id = comment_Id;
	}
	public int getReport_Id() {
		return report_Id;
	}
	public void setReport_Id(int report_Id) {
		this.report_Id = report_Id;
	}
	public String getComment_Content() {
		return comment_Content;
	}
	public void setComment_Content(String comment_Content) {
		this.comment_Content = comment_Content;
	}
	public String getComment_Writer() {
		return comment_Writer;
	}
	public void setComment_Writer(String comment_Writer) {
		this.comment_Writer = comment_Writer;
	}
	public String getComment_Date() {
		return comment_Date;
	}
	public void setComment_Date(String comment_Date) {
		this.comment_Date = comment_Date;
	}
    
    
}