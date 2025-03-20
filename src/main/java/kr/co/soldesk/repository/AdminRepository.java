package kr.co.soldesk.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.InquiryBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.ReportBean;
import kr.co.soldesk.beans.SellerBean;
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
	   public List<InquiryBean> getInquiry(){
	      return adminMapper.getInquiry();
	   }
	   public InquiryBean oneInquiry(int idx) {
	      return adminMapper.oneInquiry(idx);
	   }
	   public void read(int idx) {
		   adminMapper.read(idx);
	   }
	   public void addreply(String reply, int idx) {
		   adminMapper.addreply(reply,idx);
	   }
	   public void deleteReply(int idx) {
		   adminMapper.deleteReply(idx);
	   }
	   public void sellerdelete(MemberBean memberBean) {
		   adminMapper.sellerdelete(memberBean);
	   }
	   public void delete(MemberBean memberBean) {
		   adminMapper.delete(memberBean);
	   }
	   public List<SellerBean> getSeller(){
		   return adminMapper.getSeller();
	   }
	   public List<SellerBean> getSellerAwaiter(){
		   return adminMapper.getSellerAwaiter();
	   }
	   public void approval(String id) {
		   adminMapper.approval(id);
	   }
	   public void reject(String id) {
		   adminMapper.reject(id);
	   }

}
