package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.BannerBean;
import kr.co.soldesk.beans.InquiryBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.ProductBean;
import kr.co.soldesk.beans.ReportBean;
import kr.co.soldesk.beans.SellerBean;

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
	   
	// 배너 관리 기능
		@Select("SELECT * FROM banner_table ORDER BY banner_order ASC")
		List<BannerBean> getAllBanners();
		
		@Select("SELECT * FROM banner_table WHERE banner_idx = #{idx}")
		BannerBean getBannerById(int idx);
		
		@Insert("INSERT INTO banner_table (banner_idx, banner_name, banner_img, banner_link, banner_order, is_active) VALUES (banner_seq.NEXTVAL, #{banner_name}, #{banner_img}, #{banner_link}, #{banner_order}, 'Y')")
		void addBanner(BannerBean bean);
		
		@Update("UPDATE banner_table SET banner_name = #{banner_name}, banner_img = #{banner_img}, banner_link = #{banner_link}, banner_order = #{banner_order}, is_active = #{is_active} WHERE banner_idx = #{banner_idx}")
		void updateBanner(BannerBean bean);
		
		@Delete("DELETE FROM banner_table WHERE banner_idx = #{idx}")
		void deleteBanner(int idx);

		   @Select("select * from seller where is_commit=1")
		   public List<SellerBean> getSeller();

		   @Select("select * from seller where is_commit=0")
		   public List<SellerBean> getSellerAwaiter();
		   
		   @Update("update seller set is_commit = 1 where id=#{id}")
		   public void approval(String id); 
		   @Update("update seller set is_commit = 2 where id=#{id}")
		   public void reject(String id); 
		
		// 상품 관리 기능
		@Select("SELECT * FROM product_table ORDER BY product_order ASC")
		List<ProductBean> getAllProducts();
		
		@Select("SELECT * FROM product_table WHERE product_idx = #{idx}")
		ProductBean getProductById(int idx);
		
		// 상품 추가 쿼리 수정 - product_idx 필드를 추가하고 시퀀스 사용
		@Insert("INSERT INTO product_table (product_idx, product_name, product_desc, product_img, product_link, product_price, product_order, is_active) VALUES (product_seq.NEXTVAL, #{product_name}, #{product_desc}, #{product_img}, #{product_link}, #{product_price}, #{product_order}, 'Y')")
		void addProduct(ProductBean bean);
		
		@Update("UPDATE product_table SET product_name = #{product_name}, product_desc = #{product_desc}, product_img = #{product_img}, product_link = #{product_link}, product_price = #{product_price}, product_order = #{product_order}, is_active = #{is_active} WHERE product_idx = #{product_idx}")
		void updateProduct(ProductBean bean);
		
		@Delete("DELETE FROM product_table WHERE product_idx = #{idx}")
		void deleteProduct(int idx);
		
		// 메인 페이지용 활성화된 배너 목록 조회
		@Select("SELECT * FROM banner_table WHERE is_active = 'Y' ORDER BY banner_order ASC")
		List<BannerBean> getActiveBanners();
		
		// 메인 페이지용 활성화된 상품 목록 조회
		@Select("SELECT * FROM product_table WHERE is_active = 'Y' ORDER BY product_order ASC")
		List<ProductBean> getActiveProducts();
	}