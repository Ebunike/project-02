package kr.co.soldesk.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.ReportBean;
import kr.co.soldesk.repository.ReportRepository;

@Service
public class ReportService {

    @Autowired
    private ReportRepository reportRepository;

    // 게시글 목록 조회
    public List<ReportBean> getReportList() {
        return reportRepository.getReportList();
    }
    // 게시글 작성
    public void createReport(ReportBean reportBean) {
        reportRepository.createReport(reportBean);
    }
    // 게시글 상세 조회
    public ReportBean getReportById(int report_id) {
        return reportRepository.getReportById(report_id);
    }
    // 게시글 수정
    public void updateReport(ReportBean reportBean) {
        reportRepository.updateReport(reportBean);
    }
    
    public void deleteReport(int report_id) {
    	reportRepository.deleteReport(report_id);
    }
    
}
