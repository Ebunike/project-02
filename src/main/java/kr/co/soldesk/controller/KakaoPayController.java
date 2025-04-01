package kr.co.soldesk.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.PaymentReqDTO;
import kr.co.soldesk.beans.PaymentResDTO;
import kr.co.soldesk.dto.KakaoPayApproveDTO;
import kr.co.soldesk.dto.KakaoPayReadyDTO;
import kr.co.soldesk.service.CartService;
import kr.co.soldesk.service.KakaoPayService;
import kr.co.soldesk.service.PaymentService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/payment/kakao")
public class KakaoPayController {
    
    private static final Logger logger = LoggerFactory.getLogger(KakaoPayController.class);

    @Resource(name = "loginMemberBean")
    private MemberBean loginUser;
    
    @Autowired
    private KakaoPayService kakaoPayService;
    
    @Autowired
    private PaymentService paymentService;
    
    @Autowired CartService cartService;
    
    @GetMapping("/kakaopay")
    public String kakaoPayPage(@ModelAttribute("paymentReq") PaymentReqDTO paymentReq,
                              @RequestParam("totalPrice") int totalPrice,
                              Model model) {
        
        logger.info("카카오페이 결제 페이지 접근 - 총금액: {}", totalPrice);
        model.addAttribute("cartTotalPrice", totalPrice);
        model.addAttribute("loginUser", loginUser);
        return "payment/kakao/kakaopay";
    }
    
    @PostMapping("/ready")
    @ResponseBody
    public ResponseEntity<?> kakaoPayReady(
            @RequestParam("orderId") String orderId,
            @RequestParam("itemName") String itemName,
            @RequestParam("quantity") int quantity,
            @RequestParam("totalAmount") int totalAmount,
            @RequestParam("customerName") String customerName,
            @RequestParam("customerEmail") String customerEmail,
            @RequestParam("customerMobilePhone") String customerMobilePhone,
            @RequestParam(value = "taxFreeAmount", required = false, defaultValue = "0") int taxFreeAmount,
            HttpSession session) {
        
        logger.info("카카오페이 결제 준비 요청 - 주문ID: {}, 상품명: {}, 수량: {}, 금액: {}", 
                    orderId, itemName, quantity, totalAmount);
        
        try {
            KakaoPayReadyDTO kakaoPayReadyDTO = kakaoPayService.kakaoPayReady(
                    orderId, itemName, quantity, totalAmount, taxFreeAmount);
            
            // 결제 승인 요청시 필요한 정보를 세션에 저장
            session.setAttribute("tid", kakaoPayReadyDTO.getTid());
            session.setAttribute("partnerOrderId", kakaoPayReadyDTO.getPartnerOrderId());
            session.setAttribute("partnerUserId", kakaoPayReadyDTO.getPartnerUserId());
            session.setAttribute("itemName", itemName);
            session.setAttribute("quantity", cartService.findCount(loginUser.getId()));
            session.setAttribute("totalAmount", totalAmount);
            session.setAttribute("orderId", orderId);
            
            logger.info("카카오페이 결제 준비 성공 - TID: {}", kakaoPayReadyDTO.getTid());
            
            return ResponseEntity.ok(kakaoPayReadyDTO);
        } catch (Exception e) {
            logger.error("카카오페이 결제 준비 중 오류 발생: {}", e.getMessage(), e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("카카오페이 결제 준비 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    @GetMapping("/success")
    public String kakaoPaySuccess(@RequestParam("pg_token") String pgToken, 
                                HttpSession session, Model model) {
        
        logger.info("카카오페이 결제 성공 - PG Token: {}", pgToken);
        
        String tid = (String) session.getAttribute("tid");
        String partnerOrderId = (String) session.getAttribute("partnerOrderId");
        String partnerUserId = (String) session.getAttribute("partnerUserId");
        String itemName = (String) session.getAttribute("itemName");
        Integer quantity = (Integer) session.getAttribute("quantity");
        Integer totalAmount = (Integer) session.getAttribute("totalAmount");
        PaymentReqDTO paymentBean = new PaymentReqDTO(
        		(String)session.getAttribute("orderId"),
        		totalAmount, null, null, tid, "Kakao_Pay", itemName, 
        		loginUser.getEmail(), loginUser.getName(), loginUser.getTel());
        
        paymentService.toPaymentBean(paymentBean);
        paymentService.savepaymentKey(tid, (String)session.getAttribute("orderId"));
        
        if (tid == null || partnerOrderId == null || partnerUserId == null) {
            logger.error("세션 정보 없음 - 결제 진행 불가");
            return "redirect:/payment/kakao/fail";
        }
        
        try {
            KakaoPayApproveDTO kakaoPayApproveDTO = kakaoPayService.kakaoPayApprove(
                    tid, pgToken, partnerOrderId, partnerUserId);
            model.addAttribute("payInfo", kakaoPayApproveDTO);
            model.addAttribute("quantity", quantity);
            
            paymentService.updateSales((String)session.getAttribute("orderId"));
            
            logger.info("카카오페이 결제 승인 완료 - 결제번호: {}", kakaoPayApproveDTO.getAid());
            
            return "payment/kakao/kakaopaySuccess";
        } catch (Exception e) {
            logger.error("카카오페이 결제 승인 중 오류 발생: {}", e.getMessage(), e);
            return "payment/kakao/cancel_success";
        } finally {
            // 결제 완료 후 세션에서 결제 정보 삭제
            session.removeAttribute("tid");
            session.removeAttribute("partnerOrderId");
            session.removeAttribute("partnerUserId");
            session.removeAttribute("itemName");
            session.removeAttribute("quantity");
            session.removeAttribute("totalAmount");
        }
    }
    
    @GetMapping("/cancel")
    public String kakaoPayCancel() {
        logger.info("카카오페이 결제 취소됨");
        return "payment/kakao/cancel_success";
    }
    
    @GetMapping("/fail")
    public String kakaoPayFail() {
        logger.error("카카오페이 결제 실패");
        return "payment/kakao/payment_fail";
    }
}