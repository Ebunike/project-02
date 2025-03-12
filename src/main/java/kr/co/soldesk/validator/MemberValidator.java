package kr.co.soldesk.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import kr.co.soldesk.beans.MemberBean;

public class MemberValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return MemberBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MemberBean memberBean =(MemberBean) target;
		String beanName = errors.getObjectName();
		
		if(beanName.equals("sellerBean")) {
			
		}
		if(memberBean.isIdExist()==false) {
			errors.rejectValue("id", "DontCheckId");
		}
	}

}
