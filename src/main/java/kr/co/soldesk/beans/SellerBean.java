package kr.co.soldesk.beans;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class SellerBean extends MemberBean{

	private int seller_index;
    @NotEmpty(message = "상호명은 필수 입력 사항입니다.")
    private String company_name;
    @Size(min = 10, max = 10, message = "사업자 등록 번호는 10글자입니다.")
    private String company_num;
    
    
    
	public int getSeller_index() {
		return seller_index;
	}
	public void setSeller_index(int seller_index) {
		this.seller_index = seller_index;
	}
	
	public String getCompany_name() {
		return company_name;
	}
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	public String getCompany_num() {
		return company_num;
	}
	public void setCompany_num(String company_num) {
		this.company_num = company_num;
	}
    
    
}
