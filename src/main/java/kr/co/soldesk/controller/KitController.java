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
		List<ItemBean> itemList = itemService.getItem();
		model.addAttribute("itemList", itemList);
		
		return "item/kit/kitMain";
	}
	@GetMapping("/insert_kit")
	public String insert_kit() {

		if(loginUser.getLogin().equals("x") || loginUser.getLogin().equals("b")) {
			return "item/kit/insert_kit_faiure";
		}
		return "item/kit/insert_kit";
	}
	@PostMapping("/insert_kit_pro")
	public String insert_kit_pro(@Valid ItemBean itemBean,@Valid KitBean kitBean,@Valid ThemeBean themeBean,@RequestParam("kitPicture") MultipartFile upload_file, HttpServletRequest request, BindingResult result) {
		if(result.hasErrors()) {
			return "item/kit/insert_kit";
		}
		try {
			System.out.println("ddddddd");
			themeBean.setTheme_name(request.getParameter("kitTheme"));
	        itemBean.setItem_name(request.getParameter("kitName"));
	        System.out.println(itemBean.getItem_name());
	        itemBean.setItem_price(Integer.parseInt(request.getParameter("kitPrice")));
	        itemBean.setItem_quantity(Integer.parseInt(request.getParameter("kitQuantity")));
	        System.out.println(itemBean.getItem_name());
	        if(upload_file == null) {
	        	System.out.println("뭔가 잘못됨");
	        }
	        itemBean.setUpload_file(upload_file);
	        int theme_index = itemService.getTheme_index(themeBean);
	        itemBean.setTheme_index(theme_index);
	        kitBean.setKit_name(request.getParameter("kitName"));
	        
	    } catch (NumberFormatException e) {
	        e.printStackTrace();
	        return "item/kit/insert_kit";
	    }
		itemService.insert_kitItem(itemBean);
        itemService.insert_kit(itemBean, kitBean);
		return "item/kit/insert_kit_success";
	}
}
