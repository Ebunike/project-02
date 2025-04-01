package kr.co.soldesk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.CommentBean;
import kr.co.soldesk.repository.CommentRepository;

@Service
public class CommentService {

	@Autowired
	private CommentRepository commentRepository;
	
	public void addComment(CommentBean reportComment) {
        commentRepository.addComment(reportComment); // 댓글 저장
    }
	public List<CommentBean> getComment(int report_id){
    	return commentRepository.getComment(report_id);
    }
	public void comment_delete(String comment_id, int report_id) {
		commentRepository.comment_delete(comment_id,report_id);
	}
}
