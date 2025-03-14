package kr.co.soldesk.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.soldesk.beans.PaymentReqDTO;
import kr.co.soldesk.beans.PaymentResDTO;
import kr.co.soldesk.beans.RefundBean;
import kr.co.soldesk.service.PaymentService;

@Controller
@RequestMapping("/payment")
public class PaymentController {

	@Autowired
	private PaymentService paymentService;

	// 임시 메서드. 결제할 정보 보내주는거.
	// 이후 결제하기 누르면 Order거쳐서 @ModelAttribute에 PaymentReqDTO paymetReq로하게 바꿔야함.
	// *장바구니에서 결제하기누르면 POST해주기
	@GetMapping("/forpayment")
	public String forpayment(@ModelAttribute("paymentReq") PaymentReqDTO paymentReq, Model model) {
		return "payment/forpayment";
	}
	
	@PostMapping("/forpayment_pro")
	public String forpayment_pro(@ModelAttribute("paymentReq") PaymentReqDTO paymentReq, Model model) throws Exception {
		
		System.out.println("��Ʈ�ѷ�");
		
		PaymentResDTO paymentRes = paymentService.requestPayments(paymentReq);
		model.addAttribute("paymentRes", paymentRes);

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
			//paymentService.verifyRequest(paymentKey, orderId, amount);
			//최종승인 요청
			paymentService.requestFinalPayment(paymentKey, orderId, amount);
			System.out.println(paymentKey);
			//paymentKey도 DB에 저장
	       //paymentService.savepaymentKey(paymentKey,orderId);

	        model.addAttribute("paymentKey", paymentKey);
	        
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

	
	
	// 결제 환불메서드 진행중

	//@PostMapping("/cancel") 
	@GetMapping("/cancel") 
	public String paymentcancel(@RequestParam(name="paymentKey", required = true) String paymentKey,
				@RequestParam(name="cancelReason", required = true) String cancelReason,
				@RequestParam(name="cancelAmount") int cancelAmount) {
		
		System.out.println("서비스쪽 " + paymentKey);
		
			
		//환불요청
		boolean cancelReq_result = paymentService.requestPaymentCancel(paymentKey, cancelReason, cancelAmount);
		
		//환불 정보 저장
		if(cancelReq_result) {

			RefundBean refund = new RefundBean();
			refund.setRefund_reason(cancelReason);
			
			//order_detail_index는 구매목록에서 버튼누르면 보내주도록해야함. 임시
			refund.setOrder_detail_index(1);
			
			paymentService.addRefund(refund);
		}
		
		 return "payment/cancel_success"; 
		 }
	

}
