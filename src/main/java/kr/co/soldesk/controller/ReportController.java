package kr.co.soldesk.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;

import kr.co.soldesk.beans.CommentBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.ReportBean;
import kr.co.soldesk.service.CommentService;
import kr.co.soldesk.service.ReportService;

@Controller
@RequestMapping("/report")
public class ReportController {

    @Autowired
    private ReportService reportService;

    // 로그인한 사용자 정보 (로그인한 사람만 접근 가능하게 하기 위해 사용)
    @Resource(name = "loginMemberBean")
    private MemberBean loginUser;
    
    @Autowired
    private CommentService commentService;

    
    @PostMapping("/addComment")
    public ResponseEntity<String> addComment(
            @RequestParam("report_id") int reportId,
            @RequestParam("comment_content") String commentContent,
            @RequestParam("comment_writer") String commentWriter) {
        
        System.out.println("Report ID: " + reportId);
        System.out.println("Comment Writer: " + commentWriter);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String currentDate = sdf.format(new Date());

        // 댓글 저장
        CommentBean comment = new CommentBean();
        comment.setReport_Id(reportId);
        comment.setComment_Content(commentContent);
        comment.setComment_Writer(commentWriter);  // comment_writer 값을 제대로 받음
        comment.setComment_Date(currentDate);
        commentService.addComment(comment);  // CommentService에서 댓글을 DB에 저장

        return ResponseEntity.ok("댓글이 등록되었습니다.");
    }


    // 게시글 목록 페이지
    @GetMapping("/report_list")
    public String report_list(Model model) {
    	if(loginUser.getLogin().equals("x")) {
	    	  String errorMessage;
	  		try {
	  			errorMessage = URLEncoder.encode("로그인을 먼저 해주세요.", "UTF-8");
	  			 return "redirect:/member/login?error=" + errorMessage;
	  		} catch (UnsupportedEncodingException e) {
	  			
	  			e.printStackTrace();
	  			return "redirect:/?error=알 수 없는 오류가 발생했습니다.";
	  		}
	      }

        List<ReportBean> report_list = reportService.getReportList();
        model.addAttribute("report_list", report_list);
        model.addAttribute("loginUser",loginUser);
        return "report/report_list";
    }

    // 게시글 작성 페이지
    @GetMapping("/report_write")
    public String report_write(@ModelAttribute("reportBean") ReportBean reportBean) {
        if (loginUser.getId() == null) {
            return "redirect:/member/login";
        }
        return "report/report_write";
    }

    // 게시글 작성 처리
    @PostMapping("/report_write_pro")
    public String report_write_pro(@ModelAttribute("reportBean") ReportBean reportBean) {
        if (loginUser.getId() == null) {
            return "redirect:/member/login";
        }

        reportBean.setId(loginUser.getId());
        reportService.createReport(reportBean);
        return "redirect:/report/report_list";
    }

    // 게시글 상세보기
    @GetMapping("/report_detail")
    public String report_detail(@RequestParam("report_id") int reportId, Model model) {
        if (loginUser.getId() == null) {
            return "redirect:/member/login";
        }
        ReportBean report_detail = reportService.getReportById(reportId);
        List<CommentBean> commentBean = commentService.getComment(reportId);
        System.out.println(commentBean.size());
        
        
        model.addAttribute("report", report_detail);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("commentBean", commentBean);
        return "report/report_detail";
    }

    // 게시글 수정 페이지
    @GetMapping("/report_edit")
    public String report_edit(@RequestParam("report_id") int report_id, Model model) {
        if (loginUser.getId() == null) {
            return "redirect:/member/login";
        }

        ReportBean report = reportService.getReportById(report_id);
        

        model.addAttribute("report", report);
        return "report/report_edit";
    }

    // 게시글 수정 처리
    @PostMapping("/report_edit_pro")
    public String report_edit_pro(@ModelAttribute("reportBean") ReportBean reportBean) {

        reportService.updateReport(reportBean);
        return "redirect:/report/report_detail?report_id=" + reportBean.getReport_id();
    }
    @GetMapping("/report_delete")
    public String report_delete(@RequestParam("report_id") int report_id) {
    	reportService.deleteReport(report_id);
    	return "redirect:/report/report_list";
    }
    @GetMapping("/comment_delete")
    public String comment_delete(@RequestParam("comment_id") String comment_id,@RequestParam("report_id") int report_id) {
    	commentService.comment_delete(comment_id,report_id);
    	return "redirect:/report/report_detail?report_id="+report_id;
    }
}
