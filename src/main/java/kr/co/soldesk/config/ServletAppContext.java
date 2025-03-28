package kr.co.soldesk.config;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.intercepter.TopMenuInterceptor;
import kr.co.soldesk.service.TopMenuService;




@Configuration
@EnableWebMvc
@ComponentScan(basePackages = {"kr.co.soldesk.controller", 
		"kr.co.soldesk.exception"})
public class ServletAppContext implements WebMvcConfigurer{
	
	@Bean
	public StandardServletMultipartResolver multipartResolver() {
		return new StandardServletMultipartResolver();
	}
	@Resource(name = "loginMemberBean")
	private MemberBean loginUser;
	
	@Autowired
	private TopMenuService menuService;
	
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		WebMvcConfigurer.super.configureViewResolvers(registry);
		registry.jsp("/WEB-INF/views/", ".jsp");
	}
	/*
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		
		//registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
		
		registry.addResourceHandler("/upload/**")
			.addResourceLocations("file:/D:/soldesk/workspace/Project_hoon/src/main/webapp/upload/");
	}*/
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {

		registry.addResourceHandler("/upload/**")
		.addResourceLocations("file:/C:/Users/soldesk/git/project-02/src/main/webapp/upload/");
		
		registry.addResourceHandler("/resources/**")
        .addResourceLocations("/resources/");
	}
	
	

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		TopMenuInterceptor topMenuInterceptor = new TopMenuInterceptor(menuService, loginUser);
		InterceptorRegistration reg1 = registry.addInterceptor(topMenuInterceptor);
		reg1.addPathPatterns("/**");
	}
	//에러메시지 프로퍼티 등록
	@Bean
	public ReloadableResourceBundleMessageSource messageSource() {
		ReloadableResourceBundleMessageSource res = 
				new ReloadableResourceBundleMessageSource();
		res.setBasename("/WEB-INF/properties/error_message");
		//res.setDefaultEncoding("UTF-8");
		return res;
	}
	@Bean
	public String uploadPath() {
	    return "C:/Users/soldesk/git/project-02/src/main/webapp/upload/";
	}
	
	
	
}
