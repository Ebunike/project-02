package kr.co.soldesk.repository;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.ReportBean;
import kr.co.soldesk.mapper.ReportMapper;

@Repository
public class ReportRepository {

    @Autowired
    private ReportMapper reportMapper;

    // 게시글 목록 가져오기
    public List<ReportBean> getReportList() {
        return reportMapper.getReportList();
    }
    // 게시글 작성
    public void createReport(ReportBean reportBean) {
    	//System.out.println("리포: " + reportBean.getReport_category());
        reportMapper.createReport(reportBean);
    }
    // 게시글 상세 조회
    public ReportBean getReportById(int report_id) {
        return reportMapper.getReportById(report_id);
    }
    // 게시글 수정
    public void updateReport(ReportBean reportBean) {
        reportMapper.updateReport(reportBean);
    }
    public void deleteReport(int report_id) {
    	reportMapper.deleteReport(report_id);
    }
    
}
