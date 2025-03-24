package kr.co.soldesk.service;


import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.PaymentBean;
import kr.co.soldesk.beans.PaymentReqDTO;
import kr.co.soldesk.beans.PaymentResDTO;
import kr.co.soldesk.beans.RefundBean;
import kr.co.soldesk.repository.CartRepository;
import kr.co.soldesk.repository.OpenRecipeRepository;
import kr.co.soldesk.repository.PaymentRepository;

@Service
public class PaymentService {
	
	@Autowired
	private PaymentRepository paymentRepository;

	@Resource(name = "loginMemberBean")
	private MemberBean loginMemberBean;
	
	@Autowired
	private CartRepository cartRepository;
	
	//토스에 결제요청보내기 전에 한번 확인하는거
	public PaymentResDTO requestPayments(PaymentReqDTO paymentReq) throws Exception {
		int amount = paymentReq.getAmount();
		String pay_method = paymentReq.getPay_Method();
		String customerEmail = paymentReq.getCustomerEmail();
		String orderName = paymentReq.getOrderName();//orderName어케정하지...
		
		
		//PaymentBean으로 만들고 저장
		try {
			//PaymentService payService = new PaymentService();
			PaymentBean payment = new PaymentBean();
			//payment = payService.toPaymentBean(paymentReq);
			payment = toPaymentBean(paymentReq);
			System.out.println(payment.getPay_index() + "저장됨");
			
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("PaymentBean으로 저장하기 실패");
		}

		//토스에 요청보낼 ResDTO객체 생성
		PaymentResDTO paymentRes = new PaymentResDTO();
		
		paymentRes.setAmount(amount);
		paymentRes.setCustomerEmail(customerEmail);
		paymentRes.setCustomerName(paymentReq.getCustomerName());
		paymentRes.setFailUrl(paymentReq.getFailUrl());
		paymentRes.setSuccessUrl(paymentReq.getSuccessUrl());
		paymentRes.setOrderId(paymentReq.getOrderId());
		paymentRes.setOrderName(orderName);
		paymentRes.setPay_Method(pay_method);
		paymentRes.setPaymentKey(null);
		paymentRes.setPaySuccessYn("Y");
		
		
		return paymentRes;
		
		
	
		
		
	}
	
	
	//PaymentReqDTO를 PaymentBean으로 바꾸는거. DB저장까지.
	public PaymentBean toPaymentBean(PaymentReqDTO paymentReq) {
		
		/*
		 * PaymentBean payment = new PaymentBean();
		 * 
		 * payment.setPay_amount(paymentReq.getAmount());
		 * payment.setPay_method(paymentReq.getPay_Method());
		 * payment.setOrder_id(paymentReq.getOrderId()); payment.setPay_date(new
		 * Date());
		 * 
		 * 
		 * paymentRepository.addPayment(payment);
		 * 
		 * 
		 * return payment;
		 */
		
		
		  // 1. paymentReq가 null인지 확인
	    if (paymentReq == null) {
	        throw new NullPointerException("PaymentReqDTO가 null입니다!");
	    }
	    
	    System.out.println("PaymentReqDTO 확인: " + paymentReq);
	    
	    // 2. 필드 값이 null인지 확인
	    System.out.println("Amount: " + paymentReq.getAmount());
	    System.out.println("Pay Method: " + paymentReq.getPay_Method());
	    System.out.println("Order ID: " + paymentReq.getOrderId());
	    
	    PaymentBean payment = new PaymentBean();
	    
	    payment.setPay_amount(paymentReq.getAmount());
	    payment.setPay_method(paymentReq.getPay_Method());
	    payment.setOrder_id(paymentReq.getOrderId());
	    payment.setPay_date(new Date());
	    
	    // 3. paymentRepository가 null인지 확인
	    if (paymentRepository == null) {
	        throw new NullPointerException("paymentRepository가 null입니다!");
	    }
	    
	    System.out.println("테스트: " + payment.getOrder_id());
	    
	    paymentRepository.addPayment(payment);
	    return payment;
		
	}
	
	//PaymentRes받고 토스 최종 승인 전에 검증하는 메서드. 이거는 cart에서 제대로 끌고와서 하던가 해야할듯. 
	public void verifyRequest(String paymentKey, String orderId, int amount) throws Exception {
	  
		//amount 총 금액 검증
		int cartAmount = cartRepository.findAmount(loginMemberBean.getId());
		
		if (amount != cartAmount) {
		    throw new RuntimeException("금액이 일치하지 않습니다");
		}
	}
		
		
	
	//토스에 최종 승인 요청
	public String requestFinalPayment(String paymentKey, String orderId, int amount) {
	    try {
	        // 토스 결제 승인 API URL
	        URI uri = URI.create("https://api.tosspayments.com/v1/payments/confirm");

	        // 인증 정보 (테스트 시크릿 키를 Base64 인코딩)
	        String secretKey = "test_sk_vZnjEJeQVxNEgMnZk2m98PmOoBN0:";
	        
	        // Base64 인코딩
	        String encodedAuth = Base64.getEncoder().encodeToString((secretKey + ":").getBytes(StandardCharsets.UTF_8));

	        // JSON 요청 바디 생성
	        String jsonPayload = String.format("{\"paymentKey\":\"%s\",\"orderId\":\"%s\",\"amount\":%d}", 
	                                           paymentKey, orderId, amount);

	        // HTTP 요청 생성
	        HttpRequest request = HttpRequest.newBuilder()
	            .uri(uri)
	            .header("Authorization", "Basic " + encodedAuth)
	            .header("Content-Type", "application/json")
	            .POST(HttpRequest.BodyPublishers.ofString(jsonPayload))
	            .build();

	        // HTTP 요청 전송 및 응답 받기
	        HttpClient client = HttpClient.newHttpClient();
	        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

	        // 응답 출력
	        return response.body();

	    } catch (Exception e) {
	        throw new RuntimeException("토스 결제 승인 요청 중 오류 발생", e);
	    }
	}
    
    //DB에 paymentKey도 저장
    public void savepaymentKey(String paymentKey,String orderId) {
    	paymentRepository.savepaymentKey(paymentKey,orderId);
    	
    }
    
  
    //환불요청
    public String requestPaymentCancel(String paymentKey, String cancelReason, int cancelAmount) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel")) // paymentKey 삽입
                .header("Authorization", "Basic dGVzdF9za192Wm5qRUplUVZ4TkVnTW5aazJtOThQbU9vQk4wOg==")
                .header("Content-Type", "application/json")
                .method("POST", HttpRequest.BodyPublishers.ofString(
                        "{\"cancelReason\":\"" + cancelReason + "\",\"cancelAmount\":" + cancelAmount + "}"
                    ))
                .build();
            
            HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            System.out.println(response.body());
            
            
            return response.body();
            
        } catch (Exception e) {
            e.printStackTrace();
            return "ㅠㅠ";
        }
    }
    
	/*
	 * //어떤물품 환불할지 알수있게 order_detail_index꺼내오기 
	 * public String getOrderDetail() {
	 * paymentRepository.getOrderDetail() }
	 */
    
    
    
    
    //환불 정보 저장
    public void addRefund(RefundBean refund) {
    	paymentRepository.addRefund(refund);
    	
    }
    
}