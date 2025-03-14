package kr.co.soldesk.controller;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.soldesk.beans.ReportBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.service.ReportService;

@Controller
@RequestMapping("/report")
public class ReportController {

    @Autowired
    private ReportService reportService;

    // 로그인한 사용자 정보 (로그인한 사람만 접근 가능하게 하기 위해 사용)
    @Resource(name = "loginMemberBean")
    private MemberBean loginUser;

    // 게시글 목록 페이지
    @GetMapping("/report_list")
    public String report_list(Model model) {
        if (loginUser.getId() == null) {
            return "redirect:/member/login";
        }

        List<ReportBean> report_list = reportService.getReportList();
        model.addAttribute("report_list", report_list);
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
    public String report_detail(@RequestParam("report_id") int report_id, Model model) {
        if (loginUser.getId() == null) {
            return "redirect:/member/login";
        }

        ReportBean report_detail = reportService.getReportById(report_id);
        model.addAttribute("report", report_detail);
        model.addAttribute("loginUser", loginUser);
        return "report/report_detail";
    }

    // 게시글 수정 페이지
    @GetMapping("/report_edit")
    public String report_edit(@RequestParam("report_id") int report_id, Model model) {
        if (loginUser.getId() == null) {
            return "redirect:/member/login";
        }

        ReportBean report_edit = reportService.getReportById(report_id);
        
        // 작성자 본인만 수정 가능
        if (!report_edit.getId().equals(loginUser.getId())) {
            return "report/report_list";
        }

        model.addAttribute("report_edit", report_edit);
        return "report/report_edit";
    }

    // 게시글 수정 처리
    @PostMapping("/report_edit_pro")
    public String report_edit_pro(@ModelAttribute("reportBean") ReportBean reportBean) {
        if (loginUser.getId() == null) {
            return "redirect:/member/login";
        }

        // 작성자 본인인지 확인
        ReportBean originalReport = reportService.getReportById(reportBean.getReport_id());
        if (!originalReport.getId().equals(loginUser.getId())) {
            return "report/report_list";
        }

        reportService.updateReport(reportBean);
        return "redirect:/report/report_detail?report_id=" + reportBean.getReport_id();
    }
}
