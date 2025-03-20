package kr.co.soldesk.controller;


import java.util.List;

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



@Controller
@RequestMapping("/item/kit")
public class KitController {
	
	@Autowired
	private ItemService itemService;
	
	@Resource(name = "loginMemberBean")
	private MemberBean loginUser;

	@GetMapping("/kitMain")
	public String kitMain(Model model) {
		List<ItemBean> itemList = itemService.getAllKit();
		model.addAttribute("itemList", itemList);
		
		return "item/kit/kitMain";
	}
	@GetMapping("/insert_kit")
	public String insert_kit(Model model) {

		if(loginUser.getLogin().equals("x") || loginUser.getLogin().equals("buyer")) {
			return "item/kit/insert_kit_failure";
		}else if(loginUser.getLogin().equals("sellerawaiter")) {
			model.addAttribute("memberType","sellerawaiter");
			return "item/kit/insert_kit_failure";
		}else
		return "item/kit/insert_kit";
	}
	@PostMapping("/insert_kit_pro")
	public String insert_kit_pro(@Valid ItemDTO itemDTO, BindingResult result,@RequestParam("kitPicture") MultipartFile upload_file, HttpServletRequest request) {
		
		
		ThemeBean themeBean = new ThemeBean();
		ItemBean itemBean = new ItemBean();
		KitBean kitBean = new KitBean();
		
		
		if(result.hasErrors()) {
			return "item/kit/insert_kit";
		}
		try {
			themeBean.setTheme_name(request.getParameter("kitTheme"));
			String name = request.getParameter("kitName");
			System.out.println("테스트: " + name);
	        itemBean.setItem_name(name);
	        itemBean.setItem_price(Integer.parseInt(request.getParameter("kitPrice")));
	        itemBean.setItem_quantity(Integer.parseInt(request.getParameter("kitQuantity")));
	        itemBean.setItem_info(request.getParameter("kitContent"));
	        itemBean.setUpload_file(upload_file);
	        int theme_index = itemService.getTheme_index(themeBean);
	        itemBean.setTheme_index(theme_index);
	        kitBean.setKit_name(name);
	        
	    } catch (NumberFormatException e) {
	        e.printStackTrace();
	        return "item/kit/insert_kit";
	    }
		itemService.insert_kitItem(itemBean);
        itemService.insert_kit(itemBean, kitBean);
		return "item/kit/insert_kit_success";
	}
	
	@GetMapping("/kit_detail")
	public String kit_datail(@RequestParam("item_index") int item_index, Model model) {
		ItemBean itemBean = itemService.getItem(item_index);
		String sellerName = itemService.getSellerName(itemBean.getSeller_index());
		model.addAttribute("item", itemBean);
		model.addAttribute("sellerName", sellerName);
		model.addAttribute("loginUser", loginUser);
		return "item/kit/kit_detail";
	}
}
