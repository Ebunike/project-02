package kr.co.soldesk.beans;
import java.util.Date;

public class CommentBean {
    private int comment_Id;        // 댓글 ID
    private int post_Id;           // 연결된 게시글 ID
    private int report_Id;         // 연결된 리포트 ID (기존 코드 호환성)
    private String comment_Content; // 댓글 내용
    private String comment_Writer;  // 댓글 작성자의 ID
    private String writerName;      // 댓글 작성자 이름 (표시용)
    private String comment_Date;    // 댓글 작성 날짜
    
    public int getComment_Id() {
        return comment_Id;
    }
    
    public void setComment_Id(int comment_Id) {
        this.comment_Id = comment_Id;
    }
    
    public int getPost_Id() {
        return post_Id;
    }
    
    public void setPost_Id(int post_Id) {
        this.post_Id = post_Id;
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
    
    public String getWriterName() {
        return writerName;
    }
    
    public void setWriterName(String writerName) {
        this.writerName = writerName;
    }
    
    public String getComment_Date() {
        return comment_Date;
    }
    
    public void setComment_Date(String comment_Date) {
        this.comment_Date = comment_Date;
    }
    
    // CommentService 클래스에서 사용하는 메소드 (필드 이름 호환성을 위해)
    public int getId() {
        return comment_Id;
    }
    
    public void setId(int id) {
        this.comment_Id = id;
    }
    
    public int getPostId() {
        return post_Id;
    }
    
    public void setPostId(int postId) {
        this.post_Id = postId;
    }
    
    public String getContent() {
        return comment_Content;
    }
    
    public void setContent(String content) {
        this.comment_Content = content;
    }
    
    public String getWriterId() {
        return comment_Writer;
    }
    
    public void setWriterId(String writerId) {
        this.comment_Writer = writerId;
    }
}