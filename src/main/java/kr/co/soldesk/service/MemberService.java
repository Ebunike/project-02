package kr.co.soldesk.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.SellerBean;
import kr.co.soldesk.mapper.MemberMapper;
import kr.co.soldesk.repository.MemberRepository;

@Service
public class MemberService {

   
   @Autowired
   private MemberRepository memberRepository;
   
   @Resource(name = "loginMemberBean")
   private MemberBean loginUser;
   
   public void sellerJoin(SellerBean sellerBean) {
      sellerBean.getKeyword();
      String utae = "";
      int i =0;
      for(String key : sellerBean.getKeyword()) {
         
         utae += key;
         
         if(sellerBean.getKeyword().length - 1 != i++ ) { 
            utae += ", "; 
         }  
      }
      
         memberRepository.memberJoin(sellerBean,utae);
         memberRepository.sellerJoin(sellerBean,utae);
         
      
   }
   public void memberJoin(MemberBean memberBean) {
	   memberBean.getKeyword();
	   String utae = "";
	   int i =0;
	   for(String key : memberBean.getKeyword()) {
		   
		   utae += key;
		   
		   if(memberBean.getKeyword().length - 1 != i++ ) { 
			   utae += ", "; 
		   }  
	   }
	   
	   memberRepository.memberJoin(memberBean,utae);
	   
	   
	   
   }
   public void login(MemberBean memberBean) {
      
      MemberBean member =  memberRepository.login(memberBean);
      if(member != null) {
         loginUser.setId(member.getId());
         loginUser.setPw(member.getPw());
         loginUser.setAge(member.getAge());
         loginUser.setAddress(member.getAddress());
         loginUser.setEmail(member.getEmail());
         loginUser.setGender(member.getGender());
         loginUser.setKeyword(member.getKeyword());
         loginUser.setName(member.getName());
         loginUser.setTel(member.getTel());
         String id = memberRepository.getSeller(member.getId());
         if(id == null) {
               loginUser.setLogin("buyer");   
          }else {
        	  int commit = memberRepository.isCommit(loginUser.getId());
              if(commit == 1) { 
        	  loginUser.setLogin("seller");
              }else if(commit == 0) {
            	  loginUser.setLogin("sellerawaiter");
              }else if(commit == 2) {
            	  loginUser.setLogin("sellerawaiter");
              }
          }
      }
   }
   public MemberBean naverLogin(String email) {
      return memberRepository.naverLogin(email);
   }
   public void modify(MemberBean memberBean) {
      memberRepository.modify(memberBean);
   }
   public void delete(MemberBean memberBean) {
      memberRepository.delete(memberBean);
   }
   public boolean sellerdelete(MemberBean memberBean) {
      if(loginUser.getId().equals(memberBean.getId()) && loginUser.getPw().equals(memberBean.getPw())) {
         memberRepository.sellerdelete(memberBean);   
         return true;
      }else {
         return false;
      }
   }
   public String getPasswordById(String id) {
       return memberRepository.getPasswordById(id);
   }
   public boolean checkId(String id) {
	   String id1 = memberRepository.checkId(id);
	      
	      //반환하는게 아이디가 같으면 false, 다르면 true
	   if(id1 == null) {
	      return true;
	   } else {
	      return false;
	   }
	}
	
	public String findId(MemberBean memberBean) {
	   return memberRepository.findId(memberBean);
	}
	public int findPw(MemberBean memberBean) {
	   return memberRepository.findPw(memberBean);
	}
  
   
}
