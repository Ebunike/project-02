package kr.co.soldesk.service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.soldesk.beans.CommentBean;
import kr.co.soldesk.mapper.CommentMapper;
import kr.co.soldesk.mapper.MemberMapper;
import kr.co.soldesk.repository.CommentRepository;

@Service
public class CommentService {
    
    @Autowired
    private CommentMapper commentMapper;
    
    @Autowired
    private MemberMapper memberMapper;
    
    @Autowired
    private CommentRepository commentRepository;
    
    // 리포트 댓글 추가 (기존 코드 호환성)
    public void addComment(CommentBean reportComment) {
        commentRepository.addComment(reportComment);
    }
    
    // 리포트 댓글 조회 (기존 코드 호환성)
    public List<CommentBean> getComment(int report_id) {
        return commentRepository.getComment(report_id);
    }
    
    // 리포트 댓글 삭제 (기존 코드 호환성)
    public void comment_delete(String comment_id, int report_id) {
        commentRepository.comment_delete(comment_id, report_id);
    }
    
    // 게시글 댓글 작성
	/*
	 * public int addComment(CommentBean comment) { return
	 * commentRepository.insertComment(comment); }
	 */
    
    // 특정 게시글의 댓글 목록 조회
    public List<CommentBean> getCommentsByPostId(int postId) {
        List<CommentBean> comments = commentRepository.getCommentsByPostId(postId);
        
        // 댓글 작성자 이름 설정
        for (CommentBean comment : comments) {
            String writerName = memberMapper.getMemberName(comment.getComment_Writer());
            comment.setWriterName(writerName);
        }
        
        return comments;
    }
    
    // 댓글 수정
    public boolean updateComment(CommentBean comment) {
        commentRepository.updateComment(comment);
        return true;
    }
    
    // 댓글 삭제
    public boolean deleteComment(int commentId, String userId) {
        CommentBean comment = commentRepository.getCommentById(commentId);
        if (comment != null && comment.getComment_Writer().equals(userId)) {
            commentRepository.deleteComment(commentId, userId);
            return true;
        }
        return false;
    }
    
    // 특정 게시글의 모든 댓글 삭제
    public void deleteCommentsByPostId(int postId) {
        commentRepository.deleteCommentsByPostId(postId);
    }
    
    // 특정 게시글의 댓글 수 조회
    public int countCommentsByPostId(int postId) {
        return commentRepository.countCommentsByPostId(postId);
    }
    
    public String getMemberName(String id) {
        return memberMapper.getMemberName(id);
    }
}