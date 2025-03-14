package kr.co.soldesk.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

    //임시 메서드. 결제할 정보 보내주는거.     
    //이후 결제하기 누르면 Order거쳐서 @ModelAttribute에 PaymentReqDTO paymetReq로하게 바꿔야함. *장바구니에서 결제하기누르면 POST해주기
    @GetMapping("/forpayment")
    public String forpay(Model model) {
    	
    	PaymentReqDTO paymentReq = new PaymentReqDTO();
    	model.addAttribute("paymentReq", paymentReq);//이거 왜있어야하지 난 forpayment에서 @ModelAttribute로 보내준거같은데
    	
    	return "payment/forpayment";
    }
    
    
    // 결제 요청을 위한 메서드
    @PostMapping("/payment")
	public String payment( Model model, @ModelAttribute PaymentReqDTO paymentReq) throws Exception {
		
		/* try { */
			PaymentResDTO paymentRes = paymentService.requestPayments(paymentReq); 
			model.addAttribute("paymentRes",paymentRes);
			
			return "payment/payment";
			  
		  /*} catch(Exception e) {
		 
			  e.printStackTrace(); 
		 
		  }throw new Exception("토스가 요청을 안받아줌");
*/
    }


        @GetMapping("/success")
        public String paymentSuccess(@RequestParam(name = "orderId", required = true)String orderId,
					@RequestParam(name = "paymentKey", required = true)String paymentKey,
					@RequestParam(name = "amount", required = true)int amount ) {

					try{
					paymentService.verifyRequest(paymentKey, orderId, amount);
					paymentService.requestFinalPayment(paymentKey, orderId, amount);
					
					}catch(Exception e) {
					e.printStackTrace();
					}		

					return "payment/success";
        }

        
        
        @GetMapping("/payment/fail")
        public String paymentFail() {
          
          
            return "payment/fail"; 
        }
    }
