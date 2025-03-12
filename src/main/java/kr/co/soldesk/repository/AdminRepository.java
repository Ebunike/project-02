package kr.co.soldesk.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.ReportBean;
import kr.co.soldesk.mapper.AdminMapper;
@Repository
public class AdminRepository {

	@Autowired
	private AdminMapper adminMapper;
	
		public List<MemberBean> allMember() {
	      return adminMapper.allMember();
	   }
	   public MemberBean oneMember(String id) {
	      return adminMapper.oneMember(id);
	   }
	   public String getkeyword(String id) {
	      return adminMapper.getkeyword(id);
	   }
	   public List<ReportBean> getReport(){
	      return adminMapper.getReport();
	   }
	   public ReportBean oneReport(int id) {
	      return adminMapper.oneReport(id);
	   }
	   public void read(int id) {
		   adminMapper.read(id);
	   }
	   public void addreply(String reply, int id) {
		   adminMapper.addreply(reply,id);
	   }
	   public void deleteReply(int id) {
		   adminMapper.deleteReply(id);
	   }
	   public void sellerdelete(MemberBean memberBean) {
		   adminMapper.sellerdelete(memberBean);
	   }
	   public void delete(MemberBean memberBean) {
		   adminMapper.delete(memberBean);
	   }

}
