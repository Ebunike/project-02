package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.co.soldesk.beans.CommentBean;

@Mapper
public interface CommentMapper {

	 @Insert("INSERT INTO report_comment (comment_id, report_id, comment_content, comment_writer, comment_date) " +
	            "VALUES (report_comment_seq.nextval, #{report_Id}, #{comment_Content}, #{comment_Writer}, SYSDATE)")
	    void addComment(CommentBean comment);
        
	 @Select("select * from report_comment where report_id = #{report_id}")
	 List<CommentBean> getComment(int report_id);
    
	 @Delete("delete from report_comment where report_id=#{report_id} and comment_id=#{comment_id}")
	 void comment_delete(@Param("comment_id") String comment_id,@Param("report_id") int report_id);
}


