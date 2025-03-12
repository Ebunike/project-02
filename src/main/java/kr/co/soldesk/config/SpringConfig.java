package kr.co.soldesk.config;

import javax.servlet.FilterRegistration;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.DispatcherServlet;

public class SpringConfig implements WebApplicationInitializer{

	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
		
		AnnotationConfigWebApplicationContext servletAppContext = 
				new AnnotationConfigWebApplicationContext();
		servletAppContext.register(ServletAppContext.class);
		
		DispatcherServlet dispatcherServlet = 
			new DispatcherServlet(servletAppContext);
		ServletRegistration.Dynamic servlet = 
				servletContext.addServlet("dispatcher", dispatcherServlet);
		servlet.setLoadOnStartup(1);
		servlet.addMapping("/");
//=================================================================================
		AnnotationConfigWebApplicationContext rootAppContext = 
				new AnnotationConfigWebApplicationContext();
		rootAppContext.register(RootAppContext.class);
		
		ContextLoaderListener listener = 
				new ContextLoaderListener(rootAppContext);
		servletContext.addListener(listener);
//=================================================================================
		FilterRegistration.Dynamic filter = 
				servletContext.addFilter("encodingFilter", CharacterEncodingFilter.class);
		filter.setInitParameter("encoding", "UTF-8");
		filter.addMappingForServletNames(null, false, "dispatcher");
		
		//=================================================================================
		MultipartConfigElement mulElement = 
				new MultipartConfigElement(null, 52428800, 524288000, 0);
		//52428800: 업로드 파일의 용량(50MB)
		//524288000: 전체 용량(500MB)
		servlet.setMultipartConfig(mulElement);
	}
	
}
