package kr.co.soldesk.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.soldesk.beans.InquiryBean;
import kr.co.soldesk.beans.ItemBean;
import kr.co.soldesk.beans.ItemDTO;
import kr.co.soldesk.beans.KitBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.ThemeBean;
import kr.co.soldesk.service.AdminService;
import kr.co.soldesk.service.ItemService;
import kr.co.soldesk.service.ManagerService;

@Controller
@RequestMapping("/manager")
public class ManagerController {

	@Autowired
	private ManagerService managerService;
	
	@Autowired
	private AdminService adminService;
	
	@Resource(name = "loginMemberBean")
	private MemberBean loginUser;
	
	@GetMapping("/manager_order")
	public String manager_order(Model model) {
		model.addAttribute("loginUser", loginUser);
		
		return "manager/manager_order";
	}
	

	@GetMapping("manager_product")
	   public String manager_product(Model model) {
	      model.addAttribute("loginUser", loginUser);
	      model.addAttribute("itemList", managerService.getKitList(loginUser.getId()));
	      return "manager/manager_product";
	   }
	
	
	
	@GetMapping("/manager_review")
	public String manager_review(Model model) {
		model.addAttribute("loginUser", loginUser);
		
		return "manager/manager_review";
	}
	
	@GetMapping("/delete_product")
	   public String delete_product(@RequestParam("id") int productId) {
	      managerService.deleteKit(productId);
	      managerService.deleteProduct(productId);
	      
	      return "manager/delete_success";
	   }
	
	
	//판매금액
	@GetMapping("/manager_sales")
		public String showManager_sales(Model model) {
		int sales = managerService.showSales(loginUser.getId());
		model.addAttribute("sales", sales);
		
		return "manager/manager_sales";
		
	}
	
	///판매자 고객 문의
	@GetMapping("/manager_ask")
	public String manager_ask(Model model) {
		model.addAttribute("loginUser", loginUser);
		
		
		List<InquiryBean> inquiryList =
				managerService.getInquiryList();
		
		model.addAttribute("inquiryList", inquiryList);
		
		return "manager/manager_ask";
	}
	
	//고객문의 읽기
	@GetMapping("/viewInquiry")
	public String viewinquiry(@Param("idx") int idx, Model model) {
		InquiryBean oneInquiry = adminService.oneInquiry(idx);
		
		model.addAttribute("oneInquiry",oneInquiry);
		return "manager/viewInquiry";
	}
	
	
}
