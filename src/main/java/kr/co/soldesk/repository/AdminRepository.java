package kr.co.soldesk.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.BannerBean;
import kr.co.soldesk.beans.InquiryBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.ProductBean;
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
	   // 배너 관리 기능
	   public List<BannerBean> getAllBanners() {
			return adminMapper.getAllBanners();
		}
		
	   public BannerBean getBannerById(int idx) {
			return adminMapper.getBannerById(idx);
		}
		
		public void addBanner(BannerBean bean) {
				adminMapper.addBanner(bean);
			}
			
		public void updateBanner(BannerBean bean) {
				adminMapper.updateBanner(bean);
			}
			
		public void deleteBanner(int idx) {
				adminMapper.deleteBanner(idx);
			}
			
			// 상품 관리 기능
		public List<ProductBean> getAllProducts() {
				return adminMapper.getAllProducts();
			}
			
		public ProductBean getProductById(int idx) {
				return adminMapper.getProductById(idx);
			}
			
		public void addProduct(ProductBean bean) {
				adminMapper.addProduct(bean);
			}
			
		public void updateProduct(ProductBean bean) {
				adminMapper.updateProduct(bean);
			}
			
		public void deleteProduct(int idx) {
				adminMapper.deleteProduct(idx);
			}
		// 활성화된 배너만 가져오기
		public List<BannerBean> getActiveBanners() {
		    return adminMapper.getActiveBanners();
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

		// 활성화된 상품만 가져오기
		public List<ProductBean> getActiveProducts() {
		    return adminMapper.getActiveProducts();
		}
		public List<ProductBean> getActiveProductsByCategory(int category_type) {
		    return adminMapper.getActiveProductsByCategory(category_type);
		}

}
