package kr.co.soldesk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.ProductBean;
import kr.co.soldesk.beans.ReportBean;
import kr.co.soldesk.beans.SellerBean;
import kr.co.soldesk.beans.BannerBean;
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
	// 배너 관리 기능
		public List<BannerBean> getAllBanners() {
			return adminRepository.getAllBanners();
		}
		
		public BannerBean getBannerById(int idx) {
			return adminRepository.getBannerById(idx);
		}
		
		public void addBanner(BannerBean bean) {
			adminRepository.addBanner(bean);
		}
		
		public void updateBanner(BannerBean bean) {
			adminRepository.updateBanner(bean);
		}
		
		public void deleteBanner(int idx) {
			adminRepository.deleteBanner(idx);
		}
		
		// 상품 관리 기능
		public List<ProductBean> getAllProducts() {
			return adminRepository.getAllProducts();
		}
		
		public ProductBean getProductById(int idx) {
			return adminRepository.getProductById(idx);
		}
		
		public void addProduct(ProductBean bean) {
			adminRepository.addProduct(bean);
		}
		
		public void updateProduct(ProductBean bean) {
			adminRepository.updateProduct(bean);
		}
		
		public void deleteProduct(int idx) {
			adminRepository.deleteProduct(idx);
		}
		// 활성화된 배너만 가져오기 (메인 페이지용)
		public List<BannerBean> getActiveBanners() {
		    return adminRepository.getActiveBanners();
		}

		// 활성화된 상품만 가져오기 (메인 페이지용)
		public List<ProductBean> getActiveProducts() {
		    return adminRepository.getActiveProducts();
		}
		public List<SellerBean> getSeller(){
			return adminRepository.getSeller();
		}
		public List<SellerBean> getSellerAwaiter(){
			return adminRepository.getSellerAwaiter();
		}
		public void approval(String id) {
			adminRepository.approval(id);
		}
		public void reject(String id) {
			adminRepository.reject(id);
		}
		public List<ProductBean> getActiveProductsByCategory(int category_type) {
			return adminRepository.getActiveProductsByCategory(category_type);
		}
}
