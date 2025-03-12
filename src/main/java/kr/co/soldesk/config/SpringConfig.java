package kr.co.soldesk.config;

import javax.servlet.FilterRegistration;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.DispatcherServlet;

public class SpringConfig implements WebApplicationInitializer{

	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
		
		AnnotationConfigWebApplicationContext servletAppContext = new AnnotationConfigWebApplicationContext();
		servletAppContext.register(ServletAppContext.class);
		servletAppContext.register(WebSocketConfig.class);
		// 서블릿 컨테이너에서 웹소켓 관리
		
		DispatcherServlet dispatcherServlet = new DispatcherServlet(servletAppContext);
		ServletRegistration.Dynamic servlet = servletContext.addServlet("dispatcher", dispatcherServlet);
		servlet.setLoadOnStartup(1);
		servlet.addMapping("/");
//=================================================================================
		AnnotationConfigWebApplicationContext rootAppContext = new AnnotationConfigWebApplicationContext();
		rootAppContext.register(RootAppContext.class);
		
		ContextLoaderListener listener = new ContextLoaderListener(rootAppContext);
		servletContext.addListener(listener);
//=================================================================================
		FilterRegistration.Dynamic filter = servletContext.addFilter("encodingFilter", CharacterEncodingFilter.class);
		filter.setInitParameter("encoding", "UTF-8");
		filter.addMappingForServletNames(null, false, "dispatcher");
		
		//=================================================================================
		MultipartConfigElement mulElement = new MultipartConfigElement(null, 52428800, 524288000, 0);
		//null: 사용자 입력한 내용을 임시기억할 톰켓에서 제공하는 서버의 임시 기억장소
		//52428800: 업로드 파일 용량을 50MB로 설정
		//524288000: 전체용량 500MB로 설정
		//0: 파일의 임계값(자동저장)
		servlet.setMultipartConfig(mulElement);
		dispatcherServlet.setThrowExceptionIfNoHandlerFound(true);//404
	}
	
}
