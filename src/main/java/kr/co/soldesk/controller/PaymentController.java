package kr.co.soldesk.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.soldesk.beans.CartBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.PaymentReqDTO;
import kr.co.soldesk.beans.PaymentResDTO;
import kr.co.soldesk.beans.RefundBean;
import kr.co.soldesk.service.CartService;
import kr.co.soldesk.service.PaymentService;

@Controller
@RequestMapping("/payment")
public class PaymentController {

	private String secretKey = "";
	
	
	@Autowired
	private PaymentService paymentService;
	@Autowired
	private CartService cartService;
	
	
	@Resource(name="loginMemberBean")
	private MemberBean loginMember;
	
	

	// 임시 메서드. 결제할 정보 보내주는거.
	// 이후 결제하기 누르면 Order거쳐서 @ModelAttribute에 PaymentReqDTO paymetReq로하게 바꿔야함.
	// *장바구니에서 결제하기누르면 POST해주기
	
	@GetMapping("/forpayment")
	public String forpayment(@ModelAttribute("paymentReq") PaymentReqDTO paymentReq, Model model) {
		
		List<CartBean> list = cartService.getCart();
    	model.addAttribute("allCart", list);
    	int totalPrice = cartService.getAllTotalAmount();
    	model.addAttribute("cartTotalPrice", totalPrice);
		model.addAttribute("loginUser", loginMember);
		return "payment/forpayment";
	}
	
	//여기 종학님하고 다른데
	@PostMapping("/forpayment_pro")
	public String forpayment_pro(@ModelAttribute("paymentReq") PaymentReqDTO paymentReq, Model model) throws Exception {
		
		
		PaymentResDTO paymentRes = paymentService.requestPayments(paymentReq);
		model.addAttribute("paymentRes", paymentRes);

		if (paymentRes.getPay_Method().equals("VIRTUAL_ACCOUNT")) {
		    return "payment/account_payments";
		} else if (paymentRes.getPay_Method().equals("CARD")) {
		    return "payment/payments";
		}
		return "payment/payments"; 
	}

	//토스가 결제요청 받으면 보내주는 URL + 결제 승인까지한 후 success로
	@GetMapping("/success")
	public String paymentSuccess(@RequestParam(name = "orderId", required = true) String orderId,
			@RequestParam(name = "paymentKey", required = true) String paymentKey,
			@RequestParam(name = "amount", required = true) int amount, Model model) {

		
		System.out.println("success: " + paymentKey);
		
		try {
			//최종 승인 요청 보내기전 검증->진행중
			
			//amount 총 금액 검증
			int cartAmount = cartService.findAmount(loginMember.getId());
			
			if(amount != cartAmount) {
			
			}
			
			
			//최종승인 요청
			String result = paymentService.requestFinalPayment(paymentKey, orderId, amount);
			System.out.println(paymentKey);
			//paymentKey도 DB에 저장
	       //paymentService.savepaymentKey(paymentKey,orderId);
			System.out.println(result);
			
	        model.addAttribute("paymentKey", paymentKey);
	        model.addAttribute("result", result);
	        
	        //판매자 sales를 amount만큼 올려주기. 관리자 or 판매자 매출처리
	        
			/*
			 * try { paymentService.updateSales(orderId);
			 * System.out.println("판매자 매출 업뎃 성공"); } catch (Exception e) {
			 * System.out.println("매출이 안감"); e.printStackTrace(); }
			 */
	        
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "payment/forpayment";
	    }


		return "payment/success";
	}

	@GetMapping("/payment/fail")
	public String paymentFail() {

		return "payment/fail";
	}

	
	
	//@PostMapping("/cancel") 
	@GetMapping("/cancel") 
	public String paymentcancel(@RequestParam(name="paymentKey", required = true) String paymentKey,
				@RequestParam(name="cancelReason", required = true) String cancelReason,
				@RequestParam(name="cancelAmount") int cancelAmount, Model model) {
		
		System.out.println("서비스쪽 " + paymentKey);
		
			
		//환불요청
		String cancelReq_result = paymentService.requestPaymentCancel(paymentKey, cancelReason, cancelAmount);
		
		model.addAttribute("a",cancelReq_result);
		
		//환불 정보 저장
		if(true) {

			RefundBean refund = new RefundBean();
			refund.setRefund_reason(cancelReason);
			
			//order_detail_index는 구매목록에서 버튼누르면 보내주도록해야함. 임시
			refund.setOrder_detail_index(1);
			
			paymentService.addRefund(refund);
		}
		
		 return "payment/cancel_success"; 
		 }
	
	
	@GetMapping("/account_finished_page")
	public String account_finished_page(Model model) {
		
		model.addAttribute("secret",secretKey);
		
		return "payment/account_finished_page";
	}
	
	@PostMapping("/account_finished")
	public String account_finished(@RequestBody String payload, Model model) {
        try {
            // JSON 데이터를 파싱
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(payload);

            // 필요한 데이터 추출
            String secret = jsonNode.get("secret").asText();
            String status = jsonNode.get("status").asText();
            String orderId = jsonNode.get("orderId").asText();

            System.out.println("웹훅 수신: orderId=" + orderId + ", status=" + status + ", secret=" + secret);

            // 여기서 secret 값 검증 후 처리 (DB 저장, 상태 업데이트 등)
            
            model.addAttribute("secret", secret);
            secretKey = secret;
            
        	return "payment/account_finished_page";

        } catch (Exception e) {
            e.printStackTrace();
        	return "payment/forpayment";
        }
	}

}
