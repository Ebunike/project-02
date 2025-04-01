package kr.co.soldesk.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.CommentBean;
import kr.co.soldesk.mapper.CommentMapper;

@Repository
public class CommentRepository {

	@Autowired
	private CommentMapper commentMapper;
	
	public void addComment(CommentBean reportComment) {
        commentMapper.addComment(reportComment); // 댓글 저장
    }
	public List<CommentBean> getComment(int report_id){
    	return commentMapper.getComment(report_id);
    }
	public void comment_delete(String comment_id, int report_id) {
		commentMapper.comment_delete(comment_id,report_id);
	}
	
}
