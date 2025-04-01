package kr.co.soldesk.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

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
    
    // 기존 메소드는 그대로 유지
    @GetMapping("/manager_order")
    public String manager_order(Model model) {
        model.addAttribute("loginUser", loginUser);
        return "manager/manager_order";
    }
    
    // sellerawaiter를 위한 새로운 fail 경로 추가
    @GetMapping("/manager_order_fail")
    public String manager_order_fail(Model model) {
        model.addAttribute("loginUser", loginUser);
        return "manager/manager_order_fail";
    }
    
    @GetMapping("/manager_sales_fail")
    public String manager_sales_fail(Model model) {
        model.addAttribute("loginUser", loginUser);
        return "manager/manager_sales_fail";
    }
    
    @GetMapping("manager_product")
    public String manager_product(Model model) {
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("itemList", managerService.getKitList(loginUser.getId()));
        return "manager/manager_product";
    }
    
    @GetMapping("/manager_product_fail")
    public String manager_product_fail(Model model) {
        model.addAttribute("loginUser", loginUser);
        return "manager/manager_product_fail";
    }
    
    @GetMapping("/manager_ask")
    public String manager_ask(Model model) {
        model.addAttribute("loginUser", loginUser);
        return "manager/manager_ask";
    }
    
    @GetMapping("/manager_ask_fail")
    public String manager_ask_fail(Model model) { 
        model.addAttribute("loginUser", loginUser);
        return "manager/manager_ask_fail";
    }
    
    @GetMapping("/manager_review")
    public String manager_review(Model model) {
        model.addAttribute("loginUser", loginUser);
        return "manager/manager_review";
    }
    
    @GetMapping("/manager_review_fail")
    public String manager_review_fail(Model model) {
        model.addAttribute("loginUser", loginUser);
        return "manager/manager_review_fail";
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
  		model.addAttribute(sales);
  		
  		return "manager/manager_sales";
  		
  	}
}