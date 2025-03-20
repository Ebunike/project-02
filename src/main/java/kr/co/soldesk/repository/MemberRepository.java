package kr.co.soldesk.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.SellerBean;
import kr.co.soldesk.mapper.MemberMapper;


@Repository
public class MemberRepository {

   @Autowired
   private MemberMapper memberMapper;
   
   public void sellerJoin(SellerBean sellerBean,String utae) {
      memberMapper.sellerJoin(sellerBean, utae);
   }
   public void memberJoin(MemberBean memberBean,String utae) {
      memberMapper.memberJoin(memberBean, utae);
   }
   public MemberBean login(MemberBean memberBean) {
      return memberMapper.login(memberBean);
   }
   public String getSeller(String id) {
         return memberMapper.getSeller(id);
      }
   public MemberBean naverLogin(String email) {
      return memberMapper.naverLogin(email);
   }
   public void modify(MemberBean memberBean) {
      memberMapper.modify(memberBean);
   }
   public void delete(MemberBean memberBean) {
      memberMapper.delete(memberBean);
   }
   public void sellerdelete(MemberBean memberBean) {
      memberMapper.sellerdelete(memberBean);
   }
   public String getPasswordById(String id) {
       return memberMapper.getPasswordById(id);
   }
   public String checkId(String id) {
	      return memberMapper.checkId(id);
	   }
   public int isCommit(String id) {
	   return memberMapper.isCommit(id);
   }
}
