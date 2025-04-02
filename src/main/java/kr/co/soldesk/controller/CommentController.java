package kr.co.soldesk.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.soldesk.beans.CommentBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.mapper.MemberMapper;
import kr.co.soldesk.service.CommentService;
import kr.co.soldesk.repository.CommentRepository;

@Controller
@RequestMapping("/comment")
public class CommentController {
    
	@Autowired
	private MemberMapper memberMapper;
	
    @Autowired
    private CommentService commentService;
    
    @Autowired
    private CommentRepository commentRepository;
    
    @Resource(name="loginMemberBean")
    private MemberBean loginMemberBean;
    
    /**
     * 댓글 작성
     */
    @PostMapping("/write")
    @ResponseBody
    public Map<String, Object> writeComment(@RequestParam("postId") int postId,
                                           @RequestParam("content") String content) {
        Map<String, Object> result = new HashMap<>();
        
        // 로그인 확인
        if(loginMemberBean.getId() == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        
        // 댓글 객체 생성
        CommentBean comment = new CommentBean();
        comment.setPost_Id(postId);
        comment.setComment_Content(content);
        comment.setComment_Writer(loginMemberBean.getId());
        
        try {
            // 댓글 저장 - CommentMapper의 insertComment 메소드 호출
            commentRepository.insertComment(comment);
            
            result.put("success", true);
            result.put("commentId", comment.getComment_Id());
            result.put("message", "댓글이 등록되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "댓글 등록 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
        
        return result;
    }
    
    /**
     * 댓글 수정
     */
    @PostMapping("/update")
    @ResponseBody
    public Map<String, Object> updateComment(@RequestParam("id") int commentId,
                                            @RequestParam("content") String content) {
        Map<String, Object> result = new HashMap<>();
        
        // 로그인 확인
        if(loginMemberBean.getId() == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        
        // 댓글 객체 생성
        CommentBean comment = new CommentBean();
        comment.setComment_Id(commentId);
        comment.setComment_Content(content);
        comment.setComment_Writer(loginMemberBean.getId());
        
        boolean updateResult = commentService.updateComment(comment);
        
        if(updateResult) {
            result.put("success", true);
            result.put("message", "댓글이 수정되었습니다.");
        } else {
            result.put("success", false);
            result.put("message", "댓글 수정 권한이 없습니다.");
        }
        
        return result;
    }
    
    /**
     * 댓글 삭제
     */
    @PostMapping("/delete")
    @ResponseBody
    public Map<String, Object> deleteComment(@RequestParam("id") int commentId) {
        Map<String, Object> result = new HashMap<>();
        
        // 로그인 확인
        if(loginMemberBean.getId() == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        
        boolean deleteResult = commentService.deleteComment(commentId, loginMemberBean.getId());
        
        if(deleteResult) {
            result.put("success", true);
            result.put("message", "댓글이 삭제되었습니다.");
        } else {
            result.put("success", false);
            result.put("message", "댓글 삭제 권한이 없습니다.");
        }
        
        return result;
    }
    
    /**
     * 댓글 HTML 조회 (댓글 추가 후 새로고침 없이 표시용)
     */
    /*@GetMapping("/getHtml")
    @ResponseBody
    public String getCommentHtml(@RequestParam("id") int commentId) {
        CommentBean comment = commentRepository.getCommentById(commentId);
        
        if(comment == null) {
            return "";
        }
        
        // 작성자 이름 가져오기
        String writerName = commentService.getMemberName(comment.getComment_Writer());
        comment.setWriterName(writerName);
        
        // 간단한 HTML 형식으로 댓글 반환
        StringBuilder html = new StringBuilder();
        html.append("<div class=\"comment-item\" id=\"comment-").append(comment.getComment_Id()).append("\">");
        html.append("<div class=\"comment-header\">");
        html.append("<div class=\"comment-user\">").append(comment.getWriterName()).append("</div>");
        html.append("<div class=\"comment-time\">방금 전</div>");
        html.append("</div>");
        html.append("<div class=\"comment-body\">").append(comment.getComment_Content()).append("</div>");
        
        if(comment.getComment_Writer().equals(loginMemberBean.getId())) {
            html.append("<div class=\"comment-actions\">");
            html.append("<button class=\"comment-action edit-comment\" data-id=\"").append(comment.getComment_Id()).append("\">");
            html.append("<i class=\"fas fa-edit\"></i> 수정</button>");
            html.append("<button class=\"comment-action delete-comment\" data-id=\"").append(comment.getComment_Id()).append("\">");
            html.append("<i class=\"fas fa-trash\"></i> 삭제</button>");
            html.append("</div>");
        }
        
        html.append("</div>");
        
        return html.toString();
    }*/
    
    @GetMapping("/getHtml")
    @ResponseBody
    public String getCommentHtml(@RequestParam(value = "id", required = false) String idStr) {
        if (idStr == null || idStr.equals("undefined")) {
            return "";
        }
        
        try {
            int commentId = Integer.parseInt(idStr);
            CommentBean comment = commentRepository.getCommentById(commentId);
            
            if (comment == null) {
                return "";
            }
            
            // 작성자 이름 가져오기
            String writerName = memberMapper.getMemberName(comment.getComment_Writer());
            comment.setWriterName(writerName);
            
            StringBuilder html = new StringBuilder();
            html.append("<div class=\"comment-item\" id=\"comment-").append(comment.getComment_Id()).append("\">");
            html.append("<div class=\"comment-header\">");
            html.append("<div class=\"comment-user\">").append(writerName).append("</div>");
            html.append("<div class=\"comment-time\">방금 전</div>");
            html.append("</div>");
            html.append("<div class=\"comment-body\">").append(comment.getComment_Content()).append("</div>");
            
            if (comment.getComment_Writer().equals(loginMemberBean.getId())) {
                html.append("<div class=\"comment-actions\">");
                html.append("<button class=\"comment-action edit-comment\" data-id=\"").append(comment.getComment_Id()).append("\">");
                html.append("<i class=\"fas fa-edit\"></i> 수정</button>");
                html.append("<button class=\"comment-action delete-comment\" data-id=\"").append(comment.getComment_Id()).append("\">");
                html.append("<i class=\"fas fa-trash\"></i> 삭제</button>");
                html.append("</div>");
            }
            
            html.append("</div>");
            
            return html.toString();
        } catch (NumberFormatException e) {
            return "";
        }
    }
}