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
    
    // 댓글 작성
    public void insertComment(CommentBean comment) {
        commentMapper.insertComment(comment);
    }
    
    // 특정 게시글의 댓글 목록 조회
    public List<CommentBean> getCommentsByPostId(int postId) {
        return commentMapper.getCommentsByPostId(postId);
    }
    
    // 댓글 단일 조회
    public CommentBean getCommentById(int id) {
        return commentMapper.getCommentById(id);
    }
    
    // 댓글 수정
    public void updateComment(CommentBean comment) {
        commentMapper.updateComment(comment);
    }
    
    // 댓글 삭제
    public void deleteComment(int id, String writerId) {
        commentMapper.deleteComment(id, writerId);
    }
    
    // 특정 게시글의 모든 댓글 삭제
    public void deleteCommentsByPostId(int postId) {
        commentMapper.deleteCommentsByPostId(postId);
    }
    
    // 특정 게시글의 댓글 수 조회
    public int countCommentsByPostId(int postId) {
        return commentMapper.countCommentsByPostId(postId);
    }
    
    // 리포트 댓글 추가 (기존 코드 호환성)
    public void addComment(CommentBean comment) {
        commentMapper.addComment(comment);
    }
    
    // 리포트 댓글 조회 (기존 코드 호환성)
    public List<CommentBean> getComment(int reportId) {
        return commentMapper.getComment(reportId);
    }
    
    // 리포트 댓글 삭제 (기존 코드 호환성)
    public void comment_delete(String commentId, int reportId) {
        commentMapper.comment_delete(commentId, reportId);
    }
}