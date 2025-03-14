package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.InquiryBean;
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
	   
	   @Select("select * from inquiry")
	   public List<InquiryBean> getInquiry();
	   
	   @Select("select * from inquiry where inquiry_idx=#{idx}")
	   public InquiryBean oneInquiry(int idx);
	   
	   @Update("UPDATE inquiry SET inquiry_reply = #{reply} where inquiry_idx = #{idx}")
	   public void addreply(@Param("reply") String reply,@Param("idx") int idx);
	   
	   @Update("update inquiry set inquiry_reply = null where inquiry_idx = #{idx}")
	   public void deleteReply(int idx);
	   
	   @Update("update inquiry set inquiry_read ='읽음' where inquiry_idx = #{idx}")
	   public void read(int idx);
	   
	   @Delete("delete from seller where id=#{id}")
	   public void sellerdelete(MemberBean memberBean);
	   
	   @Delete("delete from member where id=#{id} and pw=#{pw}")
	   public void delete(MemberBean memberBean);

}
