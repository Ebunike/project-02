package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.ReportBean;

@Mapper
public interface ReportMapper {

    // 게시글 목록 가져오기
    @Select("SELECT report_id, id, report_title, report_content, report_views, to_char(report_date, 'yyyy-mm-dd') report_date " +
            "FROM report ORDER BY report_date DESC")
    List<ReportBean> getReportList();

    // 게시글 작성
    /*
    @Insert("INSERT INTO report (id, report_category, report_title, report_content, report_reply, report_read, report_date) " +
            "VALUES (#{reportBean.id}, #{reportBean.report_category}, #{reportBean.report_title}, #{reportBean.report_content}, " +
            "#{reportBean.report_reply}, #{reportBean.report_read}, NOW())")
    void createReport(@Param("reportBean") ReportBean reportBean);*/
    
    @Insert("INSERT INTO report (report_id, id, report_title, report_content, report_views, report_date) " +
    		"VALUES (Report_seq.nextval, #{reportBean.id}, #{reportBean.report_title}, #{reportBean.report_content}, " +
    		"#{reportBean.report_views}, sysdate)")
    void createReport(@Param("reportBean") ReportBean reportBean);

    // 게시글 상세 조회
    @Select("SELECT report_id, id, report_category, report_title, report_content, report_views, report_date " +
            "FROM report WHERE report_id = #{report_id}")
    ReportBean getReportById(@Param("report_id") int report_id);

    // 게시글 수정
    @Update("UPDATE report SET report_title = #{reportBean.report_title}, report_content = #{reportBean.report_content}, " +
            " report_views = #{reportBean.report_views} WHERE report_id = #{reportBean.report_id}")
    void updateReport(@Param("reportBean") ReportBean reportBean);

    // 게시글 삭제
    @Delete("DELETE FROM report WHERE report_id = #{report_id}")
    void deleteReport(@Param("report_id") int report_id);
}
