package kr.co.soldesk.controller;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.SellerBean;
import kr.co.soldesk.service.AdminService;
import kr.co.soldesk.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private AdminService adminService;
	
	@Resource(name = "loginMemberBean")
	private MemberBean loginUser;
	
	@GetMapping("/joinmain")
	public String joinmain(@Param("eamil") String email, @Param("name") String name, Model model) {
		model.addAttribute("email",email);
		model.addAttribute("name",name);
		return "member/joinmain";
	}
	
	@GetMapping("/memberjoin")
	public String memberJoin(@Param("eamil") String email, @Param("name") String name,@ModelAttribute("memberBean") MemberBean memberBean) {
		memberBean.setName(name);
		memberBean.setEmail(email);
		
		return "member/memberjoin";
	}
	@GetMapping("/sellerjoin")
	public String sellerJoin(@Param("eamil") String email, @Param("name") String name,@ModelAttribute("sellerBean") SellerBean sellerBean) {
		sellerBean.setName(name);
		sellerBean.setEmail(email);
		return "member/sellerjoin";
	}
	@PostMapping("/sellerjoin_pro")
	public String sellerjoin_pro(@Valid @ModelAttribute("sellerBean") SellerBean sellerBean,BindingResult result,Model model) {
		
		System.out.println(sellerBean.getId());
		
			if (result.hasErrors()) {
				System.out.println(sellerBean.getId());
		         return "member/sellerjoin";
		      }
			
		memberService.sellerJoin(sellerBean);
		model.addAttribute("memberType","seller");
		return "member/join_success";
	}
	@PostMapping("/memberjoin_pro")
	public String memberjoin_pro(@Valid @ModelAttribute("memberBean") MemberBean memberBean,BindingResult result,Model model) {
		
		
		if (result.hasErrors()) {
			return "member/memberjoin";
		}
		memberService.memberJoin(memberBean);
		model.addAttribute("memberType","buyer");
		return "member/join_success";
	}
	@GetMapping("/login")
	public String login(@ModelAttribute("loginUser") MemberBean memberBean) {
		return "member/login";
	}
	@PostMapping("/login_pro")
	public String login_pro(@ModelAttribute("loginUser") MemberBean memberBean) {
		
		memberService.login(memberBean);
		
		if(!loginUser.getLogin().equals("x")) {		
			if(memberBean.getId().equals("admin")) {
	            return "admin/adminmain";
	            
	         }
			
			return "member/login_success";
		}else {
			
			return "member/login_fail";
		}
	}
	@GetMapping("/home")
	public String home(Model model) {
		model.addAttribute("loginUser",loginUser);
		return "member/home";
	}
	@GetMapping("/logout")
	public String logout() {
		loginUser.setLogin("x");
		return "member/logout";
		//return "redirect:/";
	}
	@GetMapping("/my_info")
	public String my_info() {
		String[] keyword = adminService.getkeyword(loginUser.getId());
		loginUser.setKeyword(keyword);
		
		return "member/my_info";
	}
	@GetMapping("/modify_user")
	public String modify_user(@ModelAttribute ("modifyMember")
	MemberBean modifyMember) {
		
		 modifyMember.setId(loginUser.getId());
	     modifyMember.setName(loginUser.getName());
	     modifyMember.setAddress(loginUser.getAddress());
	     modifyMember.setEmail(loginUser.getEmail());
	     modifyMember.setTel(loginUser.getTel());

		
		return "member/modify_user";
	}
	@PostMapping("modify_user_pro") 
	public String modify_user_pro(@ModelAttribute("modifyMember")
		MemberBean modifyMember) {
	 
		memberService.modify(modifyMember);
		
		loginUser.setAddress(modifyMember.getAddress());
	    loginUser.setPw(modifyMember.getPw());
	    loginUser.setTel(modifyMember.getTel());
	    
	      return "member/modify_success";
	}
	@PostMapping("/checkPassword")
    @ResponseBody
    public String checkPassword(@RequestParam String password) {
        if (loginUser == null || loginUser.getId() == null) {
            return "fail";
        }

        String storedPassword = memberService.getPasswordById(loginUser.getId());

        if (storedPassword != null && storedPassword.equals(password)) {
            return "success";
        } else {
            return "fail";
        }
    }
	@GetMapping("member_delete")
	public String member_delete(@ModelAttribute("deleteMember") MemberBean deleteMember) {
		deleteMember.setName(loginUser.getName());
		return "member/member_delete";
	}
	@PostMapping("member_delete_pro")
	public String member_delete_pro(@RequestParam("pw") String pw, @RequestParam(value = "id", required = false) String id) {
	    System.out.println("💡 삭제 요청됨!");
	    System.out.println("삭제 요청된 ID (요청 값): " + id);
	    System.out.println("삭제 요청된 PW: " + pw);

	    System.out.println("최종 삭제할 ID: " + id);

	    // 삭제 요청 객체 생성
	    MemberBean deleteMember = new MemberBean();
		    deleteMember.setId(id);
		    deleteMember.setPw(pw);

	    boolean sellerdelete = memberService.sellerdelete(deleteMember);
	    
	    if (sellerdelete) {
	        System.out.println("✅ 회원 삭제 성공!");
	        memberService.delete(deleteMember);
	        loginUser.setLogin("x");
	        return "redirect:/member/member_delete";
	    } else {
	        System.out.println("❌ 회원 삭제 실패: 비밀번호 불일치");
	        return "redirect:/member/my_info";
	    }
	}
	
	
}
