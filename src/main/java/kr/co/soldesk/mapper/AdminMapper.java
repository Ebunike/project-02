package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.ReportBean;

@Mapper
public interface AdminMapper {

	
	   @Select("select * from member")
	   public List<MemberBean> allMember();
	   
	   @Select("select * from member where id=#{id}")
	   public MemberBean oneMember(String id);
	   
	   @Select("select keyword from member where id=#{id}")
	   public String getkeyword(String id);
	   
	   @Select("select * from report")
	   public List<ReportBean> getReport();
	   
	   @Select("select * from report where report_id=#{id}")
	   public ReportBean oneReport(int id);
	   
	   @Update("UPDATE report SET report_reply = #{reply} where report_id = #{id}")
	   public void addreply(@Param("reply") String reply,@Param("id") int id);
	   
	   @Update("update report set report_reply = null where report_id = #{id}")
	   public void deleteReply(int id);
	   
	   @Update("update report set report_read ='읽음' where report_id = #{id}")
	   public void read(int id);
	   
	   @Delete("delete from seller where id=#{id}")
	   public void sellerdelete(MemberBean memberBean);
	   
	   @Delete("delete from member where id=#{id} and pw=#{pw}")
	   public void delete(MemberBean memberBean);

}
