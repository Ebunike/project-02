package kr.co.soldesk.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.service.TopMenuService;

public class TopMenuInterceptor implements HandlerInterceptor{

	private TopMenuService menuService;
	
	private MemberBean loginMemberBean;
	
	public TopMenuInterceptor(TopMenuService menuService, MemberBean loginMemberBean) {
		this.menuService = menuService;
		this.loginMemberBean = loginMemberBean; 
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		request.setAttribute("loginUser", loginMemberBean);
		return true;
	}
}
