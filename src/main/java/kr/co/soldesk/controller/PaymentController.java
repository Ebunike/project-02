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
	public String forpayment_pro(@ModelAttribute("paymentReq") PaymentReqDTO paymentReq,Model model) throws Exception {
		PaymentResDTO paymentRes = paymentService.requestPayments(paymentReq);
		model.addAttribute("paymentRes",paymentRes);
		
		return "payment/payments";
	}
	

	/*
	 * @GetMapping("/forpayment") public String
	 * forpayment(@ModelAttribute("paymentReq") PaymentReqDTO paymentReq) {
	 * 
	 * return "payment/forpayment"; }
	 * 
	 * // 결제 요청을 위한 메서드
	 * 
	 * @PostMapping("/payment") public String payment_pro(@Valid PaymentReqDTO
	 * paymentReq, BindingResult result, Model model) throws Exception {
	 * 
	 * 
	 * if(result.hasErrors()) { return "payment/forpayment"; } try { PaymentResDTO
	 * paymentRes = paymentService.requestPayments(paymentReq);
	 * model.addAttribute("paymentRes", paymentRes);
	 * 
	 * return "payment/payment";
	 * 
	 * 
	 * } catch(Exception e) {
	 * 
	 * e.printStackTrace();
	 * 
	 * }throw new Exception("토스가 요청을 안받아줌");
	 * 
	 * 
	 * }
	 */
	@GetMapping("/success")
	public String paymentSuccess(@RequestParam(name = "orderId", required = true) String orderId,
			@RequestParam(name = "paymentKey", required = true) String paymentKey,
			@RequestParam(name = "amount", required = true) int amount) {

		try {
			paymentService.verifyRequest(paymentKey, orderId, amount);
			paymentService.requestFinalPayment(paymentKey, orderId, amount);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "payment/success";
	}

	@GetMapping("/payment/fail")
	public String paymentFail() {

		return "payment/fail";
	}
	
	//결제 환불메서드 진행중
	
	/*
	 * 
	 * 
	 * @PostMapping("/cancel") public String
	 * paymentcancel(@RequestParam(name="paramentKey", required = true) String
	 * paymentkey,
	 * 
	 * @RequestParam(name="cancelReason", required = true) String cancelReason) {
	 * 
	 * paymentService.requestPaymentCancel(paymentKey, cancelReason)
	 * 
	 * return "payment/cancel_success"; }
	 */
	
}
