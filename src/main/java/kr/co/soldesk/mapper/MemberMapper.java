package kr.co.soldesk.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.SellerBean;

@Mapper
public interface MemberMapper {

   
   @Insert("insert into member values(#{memberBean.id},#{memberBean.pw},#{memberBean.name},#{memberBean.address},#{memberBean.email},#{memberBean.tel},#{memberBean.age},#{memberBean.gender},#{utae})")
   void memberJoin(@Param("memberBean") MemberBean memberBean, @Param("utae") String utae);
   
   @Insert("insert into seller values(seller_seq.nextval,#{sellerBean.id},#{sellerBean.company_name},#{sellerBean.company_num})")
   void sellerJoin(@Param("sellerBean") SellerBean sellerBean, @Param("utae") String utae);
   
   @Select("select * from member where id=#{id} and pw=#{pw}")
   MemberBean login(MemberBean memberBean);
   
   @Select("select m.id from member m ,seller s where m.id=s.id and m.id=#{id}")
   String getSeller(String id);	
   
   @Select("select id,pw from member where email=#{email}")
   MemberBean naverLogin(String email);
   
   @Update("UPDATE member SET address = #{address},tel=#{tel},pw=#{pw} where id=#{id}")
   public void modify(MemberBean memberBean);
   
   @Delete("delete from seller where id=#{id}")
   public void sellerdelete(MemberBean memberBean);
   
   @Delete("delete from member where id=#{id} and pw=#{pw}")
   public void delete(MemberBean memberBean);
   
   @Select("SELECT pw FROM member WHERE id = #{id}")
   String getPasswordById(String id);
   
   @Select("select id from Member where id = #{id}")
   String checkId(@Param("id") String id);
}   
