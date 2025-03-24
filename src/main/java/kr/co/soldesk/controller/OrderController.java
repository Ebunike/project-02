package kr.co.soldesk.controller;

import java.time.LocalDate;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.soldesk.beans.MainOrderBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.service.MainOrderService;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	private MainOrderService mainOrderService;
	@Resource(name = "loginMemberBean")
	private MemberBean loginMemberBean;

    @PostMapping("/saveOrder")
    public ResponseEntity<String> saveOrder(@RequestBody Map<String, String> orderData) {
        String orderId = orderData.get("order_id");

        try {
            // MainOrderBean 엔티티 생성 및 저장
        	MainOrderBean newOrder = new MainOrderBean();
            newOrder.setOrder_id(orderId);
            newOrder.setId(loginMemberBean.getId());
            mainOrderService.saveOrder(newOrder); // Repository를 통해 DB에 저장

            return ResponseEntity.ok("주문이 성공적으로 저장되었습니다!");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to save: " + e.getMessage());
        }
    }
    @PostMapping("/cancelPayment")
    public ResponseEntity<String> cancelPayment(@RequestBody Map<String, String> requestData) {
        try {
            String orderId = requestData.get("order_id");
            
            mainOrderService.deleteOrder(orderId);
            
            return ResponseEntity.ok("결제가 취소되었습니다. 주문 ID: " + orderId);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to cancel payment: " + e.getMessage());
        }
    }

}
