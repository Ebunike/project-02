package kr.co.soldesk.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.soldesk.beans.ItemBean;
import kr.co.soldesk.beans.ItemDTO;
import kr.co.soldesk.beans.KitBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.ThemeBean;
import kr.co.soldesk.service.ItemService;
import kr.co.soldesk.service.ManagerService;

@Controller
@RequestMapping("/manager")
public class ManagerController {

	@Autowired
	private ManagerService managerService;
	
	@Resource(name = "loginMemberBean")
	private MemberBean loginUser;
	
	@GetMapping("/manager_order")
	public String manager_order(Model model) {
		model.addAttribute("loginUser", loginUser);
		
		return "manager/manager_order";
	}
	
	@GetMapping("/manager_sales")
	public String manager_sales(Model model) {
		List<Map<String, Object>> weeklySales = managerService.getWeeklySales();
        List<Map<String, Object>> monthlySales = managerService.getMonthlySales();

        model.addAttribute("weeklySales", weeklySales);
        model.addAttribute("monthlySales", monthlySales);
		model.addAttribute("loginUser", loginUser);
		
		return "manager/manager_sales";
	}
	@GetMapping("manager_product")
	   public String manager_product(Model model) {
	      model.addAttribute("loginUser", loginUser);
	      model.addAttribute("itemList", managerService.getKitList(loginUser.getId()));
	      return "manager/manager_product";
	   }
	
	@GetMapping("/manager_ask")
	public String manager_ask(Model model) {
		model.addAttribute("loginUser", loginUser);
		
		return "manager/manager_ask";
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
}
