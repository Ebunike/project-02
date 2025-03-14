package kr.co.soldesk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.ReportBean;
import kr.co.soldesk.beans.InquiryBean;
import kr.co.soldesk.repository.AdminRepository;

@Service
public class AdminService {

	
		@Autowired
		private AdminRepository adminRepository;
		
		public List<MemberBean> allMember() {
	      return adminRepository.allMember();
	   }
	   public MemberBean oneMember(String id) {
	      return adminRepository.oneMember(id);
	   }
	   public String[] getkeyword(String id) {
	      String[] keyword = adminRepository.getkeyword(id).split(",");
	      return keyword;
	   }
	   @Transactional
	   public List<InquiryBean> getInquiry(){
	      return adminRepository.getInquiry();
	   }
	   @Transactional
	   public InquiryBean oneInquiry(int id) {
		   adminRepository.read(id);
	      return adminRepository.oneInquiry(id);
	   }
	   @Transactional
	   public void addreply(String reply, int id) {
	      
		   adminRepository.addreply(reply,id);
	   }
	   public void deleteReply(int id) {
		   adminRepository.deleteReply(id);
	   }
	   public boolean adminSellerDelete(MemberBean memberBean) {
		   adminRepository.sellerdelete(memberBean);
		      return true;
		   }
	   public void delete(MemberBean memberBean) {
		   adminRepository.delete(memberBean);
		      
		   }
	   
}
