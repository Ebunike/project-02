package kr.co.soldesk.dto;

import lombok.Data;

/**
 * 카카오페이 결제 준비 응답 DTO
 */
@Data
public class KakaoPayReadyDTO {
    private String tid;                  // 결제 고유 번호, 20자
    private String next_redirect_app_url;     // 모바일 앱 결제 페이지 URL
    private String next_redirect_mobile_url;  // 모바일 웹 결제 페이지 URL
    private String next_redirect_pc_url;      // PC 웹 결제 페이지 URL
    private String android_app_scheme;        // 카카오페이 결제 화면으로 이동하는 안드로이드 앱 스킴
    private String ios_app_scheme;            // 카카오페이 결제 화면으로 이동하는 iOS 앱 스킴
    private String created_at;               // 결제 준비 요청 시간
    
    // 컨트롤러에서 세션 저장을 위해 추가 필드
    private String partnerOrderId;           // 가맹점 주문번호 (세션 저장용)
    private String partnerUserId;            // 가맹점 회원 ID (세션 저장용)
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getNext_redirect_app_url() {
		return next_redirect_app_url;
	}
	public void setNext_redirect_app_url(String next_redirect_app_url) {
		this.next_redirect_app_url = next_redirect_app_url;
	}
	public String getNext_redirect_mobile_url() {
		return next_redirect_mobile_url;
	}
	public void setNext_redirect_mobile_url(String next_redirect_mobile_url) {
		this.next_redirect_mobile_url = next_redirect_mobile_url;
	}
	public String getNext_redirect_pc_url() {
		return next_redirect_pc_url;
	}
	public void setNext_redirect_pc_url(String next_redirect_pc_url) {
		this.next_redirect_pc_url = next_redirect_pc_url;
	}
	public String getAndroid_app_scheme() {
		return android_app_scheme;
	}
	public void setAndroid_app_scheme(String android_app_scheme) {
		this.android_app_scheme = android_app_scheme;
	}
	public String getIos_app_scheme() {
		return ios_app_scheme;
	}
	public void setIos_app_scheme(String ios_app_scheme) {
		this.ios_app_scheme = ios_app_scheme;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public String getPartnerOrderId() {
		return partnerOrderId;
	}
	public void setPartnerOrderId(String partnerOrderId) {
		this.partnerOrderId = partnerOrderId;
	}
	public String getPartnerUserId() {
		return partnerUserId;
	}
	public void setPartnerUserId(String partnerUserId) {
		this.partnerUserId = partnerUserId;
	}
    
    
}
