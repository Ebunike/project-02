package kr.co.soldesk.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.soldesk.beans.CartItemDTO;
import kr.co.soldesk.beans.MainOrderBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.OrderDetailBean;
import kr.co.soldesk.repository.OrderDetailRepository;
import kr.co.soldesk.service.CartService;
import kr.co.soldesk.service.MainOrderService;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	private MainOrderService mainOrderService;
	@Resource(name = "loginMemberBean")
	private MemberBean loginMemberBean;
	@Autowired
	private OrderDetailRepository orderDetailRepository;
	@Autowired
	private CartService cartService;

    @PostMapping("/saveOrder")
    public ResponseEntity<String> saveOrder(@RequestBody Map<String, String> orderData) {
        String orderId = orderData.get("order_id");
        String selectedItems = (String) orderData.get("selectedItems");

        List<CartItemDTO> cartItems;
        
        if (selectedItems != null && !selectedItems.isEmpty()) {
            // 선택된 상품만 가져오기
            String[] itemIndexes = selectedItems.split(",");
            cartItems = cartService.getSelectedCartItems(loginMemberBean.getId(), itemIndexes);
        } else {
            // 모든 장바구니 상품 가져오기
            cartItems = cartService.getMemberCart(loginMemberBean.getId());
        }

        try {
            // MainOrderBean 엔티티 생성 및 저장
        	MainOrderBean newOrder = new MainOrderBean();
            newOrder.setOrder_id(orderId);
            newOrder.setId(loginMemberBean.getId());
            mainOrderService.saveOrder(newOrder); // Service를 통해 DB에 저장
            
            // OrderDetailBean 생성 및 cartItems 리스트 처리
            for (CartItemDTO cartItem : cartItems) {
                OrderDetailBean orderDetailBean = new OrderDetailBean();
                orderDetailBean.setOrder_id(orderId); // 고정된 orderId 설정
                orderDetailBean.setItem_index(cartItem.getItem_index());
                orderDetailBean.setOrder_detail_finalPrice(cartItem.getItem_price() * cartItem.getCart_quantity());
                orderDetailBean.setOrder_detail_count(cartItem.getCart_quantity());

                orderDetailRepository.insertOrderDetail(orderDetailBean); // Repository를 통해 DB에 저장
            }


            
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
