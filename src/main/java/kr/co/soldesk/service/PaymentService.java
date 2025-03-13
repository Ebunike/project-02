package kr.co.soldesk.service;


import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.ConstructorArgs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.PaymentBean;
import kr.co.soldesk.beans.PaymentReqDTO;
import kr.co.soldesk.beans.PaymentResDTO;
import kr.co.soldesk.repository.PaymentRepository;

@Service
public class PaymentService {
	
	@Autowired
	private PaymentRepository paymentRepository;



	@Resource(name = "loginMemberBean")
	private MemberBean loginMemberBean;
	
	//�佺�� ������û������ ���� �ѹ� Ȯ���ϴ°�
	public PaymentResDTO requestPayments(PaymentReqDTO paymentReq) throws Exception {
		int amount = paymentReq.getAmount();
		String pay_method = paymentReq.getPay_Method();
		String customerEmail = paymentReq.getCustomerEmail();
		String orderName = paymentReq.getOrderName();//orderName����������...
		//�� orderName�� ��������..? orderId�� �����ؾ��ϴ°� �ƴѰ�..??
		
		if(amount != 3000) /*3000��ſ� order�� ���� get�ؼ� ���� amount��*/  
		{
			throw new Exception("amount�� �ȸ���");
		}
		if(!pay_method.equals("CARD") && !pay_method.equals("ī��"))
		{
			throw new Exception("pay_method�� �ȸ���");
		}
		//orderName�̵� orderId�� �굵 �������� ����غ���

		
		//PaymentBean���� ����� ����
		try {
			//PaymentService payService = new PaymentService();
			PaymentBean payment = new PaymentBean();
			//payment = payService.toPaymentBean(paymentReq);
			payment = toPaymentBean(paymentReq);
			System.out.println(payment.getPay_index() + "�����");
			
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("PaymentBean���� �����ϱ� ����");
		}

		//�佺�� ��û���� ResDTO��ü ����
		PaymentResDTO paymentRes = new PaymentResDTO();
		
		paymentRes.setAmount(amount);
		paymentRes.setCustomerEmail(customerEmail);
		paymentRes.setCustomerName(paymentReq.getCustomerName());
		paymentRes.setFailUrl("");
		paymentRes.setSuccessUrl(paymentReq.getSuccessUrl());
		paymentRes.setOrderId(paymentReq.getOrderId());
		paymentRes.setOrderName(orderName);
		paymentRes.setPay_Method(pay_method);
		paymentRes.setPaymentKey(null);
		paymentRes.setPaySuccessYn("Y");
		
		
		return paymentRes;
		
		
	
		
		
	}
	
	
	//PaymentReqDTO�� PaymentBean���� �ٲٴ°�. DB�������.
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
		
		
		  // 1. paymentReq�� null���� Ȯ��
	    if (paymentReq == null) {
	        throw new NullPointerException("PaymentReqDTO�� null�Դϴ�!");
	    }
	    
	    System.out.println("PaymentReqDTO Ȯ��: " + paymentReq);
	    
	    // 2. �ʵ� ���� null���� Ȯ��
	    System.out.println("Amount: " + paymentReq.getAmount());
	    System.out.println("Pay Method: " + paymentReq.getPay_Method());
	    System.out.println("Order ID: " + paymentReq.getOrderId());
	    
	    PaymentBean payment = new PaymentBean();
	    
	    payment.setPay_amount(paymentReq.getAmount());
	    payment.setPay_method(paymentReq.getPay_Method());
	    payment.setOrder_id(paymentReq.getOrderId());
	    payment.setPay_date(new Date());
	    
	    // 3. paymentRepository�� null���� Ȯ��
	    if (paymentRepository == null) {
	        throw new NullPointerException("paymentRepository�� null�Դϴ�!");
	    }
	    
	    System.out.println("�׽�Ʈ: " + payment.getOrder_id());
	    
	    paymentRepository.addPayment(payment);
	    return payment;
		
	}
	
	//PaymentRes�ް� �佺 ���� ���� ���� �����ϴ� �޼���. �̰Ŵ� cart���� ����� ����ͼ� �ϴ��� �ؾ��ҵ�. 
	public void verifyRequest(String paymentKey, String orderId, int amount) throws Exception {
	/*    // paymentRepository.findByOrderId(orderId)�� Optional ��� null�� ��ȯ�ϴ� ������� ����
	    PaymentBean payment = paymentRepository.findByOrderId(orderId);

	    if (payment != null) { // �ֹ��� �����ϸ�
	        // ���� ��
	        if (payment.getAmount() == amount) {
	            payment.setPaymentKey(paymentKey); // ������ ��ġ�ϸ� paymentKey ����
	        } else {
	            throw new IllegalArgumentException("���ݰ��� ��� �ȸ���"); // ������ ���� ������ ���� ����
	        }
	    } else {
	        throw new NoSuchElementException("�𸣰ڴ� ����"); // �ֹ��� ã�� �� ������ ���� ����
	}*/
	
		
	}
	
    public String requestFinalPayment(String paymentKey, String orderId, int amount) {
        try {
            // ��û ������ ���޵� paymentKey, orderId, amount �� ����
            String requestBody = String.format("{\"paymentKey\":\"%s\",\"amount\":%d,\"orderId\":\"%s\"}",
                                                paymentKey, amount, orderId);

            // HttpRequest ����
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("https://api.tosspayments.com/v1/payments/confirm"))
                    .header("Authorization", "Basic dGVzdF9za196WExrS0V5cE5BcldtbzUwblgzbG1lYXhZRzVSOg==")
                    .header("Content-Type", "application/json")
                    .method("POST", HttpRequest.BodyPublishers.ofString(requestBody))
                    .build();

            // HTTP ��û ������
            HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());

            // ���� ��� ��ȯ
            return response.body();
        } catch (Exception e) {
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
    }
	//ȯ�� �޼��� ������
    /*
	 * public String requestPaymentCancel(String paymentKey, String cancelReason) {
	 * HttpRequest request = HttpRequest.newBuilder() .uri(URI.create(
	 * "https://api.tosspayments.com/v1/payments/5EnNZRJGvaBX7zk2yd8ydw26XvwXkLrx9POLqKQjmAw4b0e1/cancel"
	 * )) .header("Authorization",
	 * "Basic dGVzdF9za192Wm5qRUplUVZ4TkVnTW5aazJtOThQbU9vQk4wOg==")
	 * .header("Content-Type", "application/json") .method("POST",
	 * HttpRequest.BodyPublishers.ofString("{\"cancelReason\":\"������ ����\"}"))
	 * .build(); HttpResponse<String> response =
	 * HttpClient.newHttpClient().send(request,
	 * HttpResponse.BodyHandlers.ofString()); System.out.println(response.body()); }
	 */
}