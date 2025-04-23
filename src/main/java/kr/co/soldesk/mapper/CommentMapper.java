package kr.co.soldesk.mapper;
import java.util.List;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import kr.co.soldesk.beans.CommentBean;

@Mapper
public interface CommentMapper {
    // 댓글 작성 (게시글용)
	@Insert("INSERT INTO comments (id, post_id, content, writer_id, regdate) " +
	        "VALUES (comment_seq.nextval, #{post_Id}, #{comment_Content}, #{comment_Writer}, SYSDATE)")
	@SelectKey(statement = "SELECT comment_seq.CURRVAL FROM DUAL", 
	          keyProperty = "comment_Id", before = false, resultType = int.class)
	void insertComment(CommentBean comment);
    
    // 특정 게시글의 댓글 목록 조회
    //@Select("SELECT * FROM comments WHERE post_id = #{postId} ORDER BY comment_date ASC")
    //List<CommentBean> getCommentsByPostId(int postId);
    
    @Select("SELECT id as comment_Id, post_id, writer_id as comment_Writer, content as comment_Content, regdate as comment_Date FROM comments WHERE post_id = #{postId} ORDER BY regdate ASC")
    List<CommentBean> getCommentsByPostId(int postId);
    
    // 댓글 단일 조회
    @Select("SELECT id as comment_Id, post_id, writer_id as comment_Writer, content as comment_Content, regdate as comment_Date FROM comments WHERE id = #{id}")
    CommentBean getCommentById(int id);
    
    // 댓글 수정
    @Update("UPDATE comments SET comment_content = #{comment_Content} " +
            "WHERE comment_id = #{comment_Id} AND comment_writer = #{comment_Writer}")
    void updateComment(CommentBean comment);
    
    // 댓글 삭제
    @Delete("DELETE FROM comments WHERE id = #{id} AND writer_id = #{writerId}")
    void deleteComment(@Param("id") int id, @Param("writerId") String writerId);
    
    // 특정 게시글의 모든 댓글 삭제
    @Delete("DELETE FROM comments WHERE post_id = #{postId}")
    void deleteCommentsByPostId(int postId);
    
    // 특정 게시글의 댓글 수 조회
    @Select("SELECT COUNT(*) FROM comments WHERE post_id = #{postId}")
    int countCommentsByPostId(int postId);
    
    // 리포트 댓글 추가 (기존 코드 호환성)
    @Insert("INSERT INTO report_comment (comment_id, report_id, comment_content, comment_writer, comment_date) " +
            "VALUES (report_comment_seq.nextval, #{report_Id}, #{comment_Content}, #{comment_Writer}, SYSDATE)")
    void addComment(CommentBean comment);
    
    // 리포트 댓글 조회 (기존 코드 호환성)
    @Select("SELECT * FROM report_comment WHERE report_id = #{report_id}")
    List<CommentBean> getComment(int report_id);
    
    // 리포트 댓글 삭제 (기존 코드 호환성)
    @Delete("DELETE FROM report_comment WHERE report_id=#{report_id} AND comment_id=#{comment_id}")
    void comment_delete(@Param("comment_id") String comment_id, @Param("report_id") int report_id);
}