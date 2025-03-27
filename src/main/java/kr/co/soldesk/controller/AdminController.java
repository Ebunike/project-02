package kr.co.soldesk.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.soldesk.beans.SellerBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.ProductBean;
import kr.co.soldesk.beans.ReportBean;
import kr.co.soldesk.beans.BannerBean;
import kr.co.soldesk.beans.InquiryBean;
import kr.co.soldesk.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {

   @Autowired
   private AdminService adminService;
   
   @Autowired
   private String uploadPath;
   
   @GetMapping("/adminmain")
   public String adminmain() {
      return "admin/adminmain";
   }
   
   @GetMapping("/inquiry")
   public String suggestion(Model model) {
      List<InquiryBean> inquiry = adminService.getInquiry();
      model.addAttribute("inquiry", inquiry);
      return "admin/inquiry";
   }
   @GetMapping("/viewinquiry")
   public String viewinquiry(@Param("idx") int idx, Model model) {
      InquiryBean oneInquiry = adminService.oneInquiry(idx);
      
      model.addAttribute("oneInquiry",oneInquiry);
      return "admin/viewinquiry";
   }
   @PostMapping("/viewinquiry_pro")
   public String viewinquiry_pro(@RequestParam("reply_content") String reply, @Param("idx") int idx, Model model) {
         
      System.out.println("id: " + idx);
      System.out.println("reply: " + reply);
      adminService.addreply(reply, idx);
      model.addAttribute("idx",idx);

      return "redirect:/admin/viewinquiry?idx="+idx;
   }
   @PostMapping("deleteReply")
   public String deleteReply(@Param("idx") int idx) {
      adminService.deleteReply(idx);
      return "redirect:/admin/viewinquiry?idx="+idx;
   }
   @GetMapping("/management")
   public String management(Model model) {
      List<MemberBean> allMember = adminService.allMember();
      model.addAttribute("allMember",allMember);
      return "admin/management";
   }
   @GetMapping("/notice")
   public String notice() {
      return "admin/notice";
   }
   @GetMapping("/memberinfo")
   public String memberinfo(@Param("id") String id, Model model) {
      MemberBean memberInfo = adminService.oneMember(id);
      String[] keyword = adminService.getkeyword(id);
      memberInfo.setKeyword(keyword);
      System.out.println(memberInfo.getKeyword());
      model.addAttribute("memberInfo",memberInfo);
      return "admin/memberinfo";
   }
   @GetMapping("/delete")
   public String delete(@Param("id") String id) {
      MemberBean memberInfo = adminService.oneMember(id);
      String[] keyword = adminService.getkeyword(id);
      memberInfo.setKeyword(keyword);
      memberInfo.setBirthday("d");
      memberInfo.setBirthyear("d");
      System.out.println(memberInfo.getId() + memberInfo.getPw()+ memberInfo.getAddress() + memberInfo.getAge() + memberInfo.getName() + memberInfo.getGender() + memberInfo.getBirthday() + memberInfo.getBirthyear() + memberInfo.getLogin() + memberInfo.getTel());
      boolean a = adminService.adminSellerDelete(memberInfo);
      System.out.println(a);
      if(a) {
         adminService.delete(memberInfo);
      }
      return "admin/adminmain";
      
   }
   @GetMapping("/benefit")
   public String benefit(Model model) {
      List<InquiryBean> benefit = adminService.getInquiry();
      
      model.addAttribute("benefit", benefit);
      return "admin/benefit";
   }
   @GetMapping("/system")
   public String system(Model model) {
      // 배너 및 상품 데이터 로드
      List<BannerBean> bannerList = adminService.getAllBanners();
      List<ProductBean> productList = adminService.getAllProducts();
      
      model.addAttribute("bannerList", bannerList);
      model.addAttribute("productList", productList);
      
      return "admin/system";
   }
   
   // 배너 관리 기능
   @PostMapping("/add_banner")
   public String addBanner(@RequestParam("banner_name") String name,
                           @RequestParam("banner_link") String link,
                           @RequestParam("banner_img") MultipartFile imgFile,
                           @RequestParam("banner_order") int order,
                           @RequestParam(value = "banner_title", required = false) String title,
                           @RequestParam(value = "banner_subtitle", required = false) String subtitle,
                           HttpServletRequest request) {
       
       BannerBean bean = new BannerBean();
       bean.setBanner_name(name);
       bean.setBanner_link(link);
       bean.setBanner_order(order);
       bean.setIs_active("Y");
       
       // 새로 추가된 타이틀과 서브타이틀
       bean.setBanner_title(title);
       bean.setBanner_subtitle(subtitle);
       
       // 이미지 파일 처리
       String fileName = saveUploadFile(imgFile, "banner");
       bean.setBanner_img(fileName);
       
       adminService.addBanner(bean);
       
       return "redirect:/admin/system";
   }

   @PostMapping("/update_banner")
   public String updateBanner(@RequestParam("banner_idx") int idx,
                              @RequestParam("banner_name") String name,
                              @RequestParam("banner_link") String link,
                              @RequestParam(value = "banner_img", required = false) MultipartFile imgFile,
                              @RequestParam("banner_order") int order,
                              @RequestParam(value = "is_active", required = false, defaultValue = "N") String isActive,
                              @RequestParam(value = "banner_title", required = false) String title,
                              @RequestParam(value = "banner_subtitle", required = false) String subtitle,
                              HttpServletRequest request) {

       BannerBean bean = adminService.getBannerById(idx);
       bean.setBanner_name(name);
       bean.setBanner_link(link);
       bean.setBanner_order(order);
       
       // 새로 추가된 타이틀과 서브타이틀
       bean.setBanner_title(title);
       bean.setBanner_subtitle(subtitle);
       
       // boolean을 Y/N으로 변환
       bean.setIs_active(isActive != null && (isActive.equals("true") || isActive.equals("on") || isActive.equals("Y")) ? "Y" : "N");
       
       // 새 이미지가 업로드된 경우에만 처리
       if(imgFile != null && !imgFile.isEmpty()) {
           // 기존 이미지 파일 삭제
           deleteFile(bean.getBanner_img());
           
           // 새 이미지 파일 저장
           String fileName = saveUploadFile(imgFile, "banner");
           bean.setBanner_img(fileName);
       }
       
       adminService.updateBanner(bean);
       
       return "redirect:/admin/system";
   }
   @GetMapping("/delete_banner")
   public String deleteBanner(@RequestParam("idx") int idx) {
      BannerBean bean = adminService.getBannerById(idx);
      
      // 이미지 파일 삭제
      deleteFile(bean.getBanner_img());
      
      // 데이터베이스에서 삭제
      adminService.deleteBanner(idx);
      
      return "redirect:/admin/system";
   }
   
   // 상품 관리 기능
   @PostMapping("/add_product")
   public String addProduct(@RequestParam("product_name") String name,
                            @RequestParam("product_desc") String desc,
                            @RequestParam("product_link") String link,
                            @RequestParam("product_price") int price,
                            @RequestParam("product_img") MultipartFile imgFile,
                            @RequestParam("product_order") int order,
                            HttpServletRequest request) {
      
      ProductBean bean = new ProductBean();
      bean.setProduct_name(name);
      bean.setProduct_desc(desc);
      bean.setProduct_link(link);
      bean.setProduct_price(price);
      bean.setProduct_order(order);
      bean.setIs_active("Y");
      
      // 이미지 파일 처리
      String fileName = saveUploadFile(imgFile, "product");
      bean.setProduct_img(fileName);
      
      adminService.addProduct(bean);
      
      return "redirect:/admin/system";
   }
   
   @PostMapping("/update_product")
   public String updateProduct(@RequestParam("product_idx") int idx,
                              @RequestParam("product_name") String name,
                              @RequestParam("product_desc") String desc,
                              @RequestParam("product_link") String link,
                              @RequestParam("product_price") int price,
                              @RequestParam(value = "product_img", required = false) MultipartFile imgFile,
                              @RequestParam("product_order") int order,
                              @RequestParam(value = "is_active", required = false, defaultValue = "N") String isActive,
                              HttpServletRequest request) {
       
       ProductBean bean = adminService.getProductById(idx);
       bean.setProduct_name(name);
       bean.setProduct_desc(desc);
       bean.setProduct_link(link);
       bean.setProduct_price(price);
       bean.setProduct_order(order);
       
       // boolean을 Y/N으로 변환
       bean.setIs_active(isActive != null && (isActive.equals("true") || isActive.equals("on") || isActive.equals("Y")) ? "Y" : "N");
       
       // 새 이미지가 업로드된 경우에만 처리
       if(imgFile != null && !imgFile.isEmpty()) {
           // 기존 이미지 파일 삭제
           deleteFile(bean.getProduct_img());
           
           // 새 이미지 파일 저장
           String fileName = saveUploadFile(imgFile, "product");
           bean.setProduct_img(fileName);
       }
       
       adminService.updateProduct(bean);
       
       return "redirect:/admin/system";
   }
   
   @GetMapping("/delete_product")
   public String deleteProduct(@RequestParam("idx") int idx) {
      ProductBean bean = adminService.getProductById(idx);
      
      // 이미지 파일 삭제
      deleteFile(bean.getProduct_img());
      
      // 데이터베이스에서 삭제
      adminService.deleteProduct(idx);
      
      return "redirect:/admin/system";
   }
   
   // 파일 업로드 처리 유틸리티 메서드
   private String saveUploadFile(MultipartFile file, String prefix) {
      String fileName = "";
      
      if(!file.isEmpty()) {
         // 파일 이름 중복 방지를 위해 시간 추가
         String originalFileName = file.getOriginalFilename();
         String fileExt = originalFileName.substring(originalFileName.lastIndexOf("."));
         String uniqueFileName = prefix + "_" + System.currentTimeMillis() + fileExt;
         
         try {
            // 파일 업로드 경로에 저장
            File uploadFile = new File(uploadPath + "/" + uniqueFileName);
            file.transferTo(uploadFile);
            fileName = uniqueFileName;
         } catch(Exception e) {
            e.printStackTrace();
         }
      }
      
      return fileName;
   }
   
   // 파일 삭제 유틸리티 메서드
   private void deleteFile(String fileName) {
      if(fileName != null && !fileName.isEmpty()) {
         File file = new File(uploadPath + "/" + fileName);
         if(file.exists()) {
            file.delete();
         }
      }
   }
   @GetMapping("/salesapproval")
   public String salesapproval(Model model) {
      List<SellerBean> sellerBean = adminService.getSeller();
      List<SellerBean> sellerAwaiterBean = adminService.getSellerAwaiter();
      model.addAttribute("sellerAwaiterBean",sellerAwaiterBean);
      model.addAttribute("sellerBean",sellerBean);      
      return "admin/salesapproval";
   }
   @GetMapping("/salesapproval_pro")
   public String salesapproval_pro(@Param("result") String result, @Param("sellerId") String sellerId) {
      
      System.out.println("컨트롤러: " + sellerId + " / " + result);
      if(result.equals("o")) {
         adminService.approval(sellerId);
      }else if(result.equals("x")) {
         adminService.reject(sellerId);
      }
      return "redirect:/admin/salesapproval";
   }
      
   
}
