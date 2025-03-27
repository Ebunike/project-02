package kr.co.soldesk.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kr.co.soldesk.beans.CartBean;
import kr.co.soldesk.beans.CartItemDTO;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.service.CartService;

@RestController
@RequestMapping("/cart")
public class CartController {
	
	@Resource(name = "loginMemberBean")
	private MemberBean loginUser;
	@Autowired
	private CartService cartService;

	
	@GetMapping("/my_cart")
	public ModelAndView cartMain(Model model) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("cart/my_cart");
		List<CartItemDTO> list =  cartService.getMemberCart(loginUser.getId());
		model.addAttribute("cartItems", list);
		
		return mav;
	}
	@GetMapping("/my_pay")
    public ModelAndView myPay(@RequestParam(value = "items", required = false) String selectedItems, Model model) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("cart/my_pay");
        
        List<CartItemDTO> cartItems;
        
        if (selectedItems != null && !selectedItems.isEmpty()) {
            // 선택된 상품만 가져오기
            String[] itemIndexes = selectedItems.split(",");
            cartItems = cartService.getSelectedCartItems(loginUser.getId(), itemIndexes);
        } else {
            // 모든 장바구니 상품 가져오기
            cartItems = cartService.getMemberCart(loginUser.getId());
        }
        
        model.addAttribute("cartItems", cartItems);
        
        // 총 금액 계산
        int totalAmount = 0;
        for (CartItemDTO item : cartItems) {
            totalAmount += item.getItem_price() * item.getCart_quantity();
        }
        model.addAttribute("totalAmount", totalAmount);
        
        return mav;
    }
	@PostMapping("/addToCart")
   	@ResponseBody
      public ResponseEntity<String> addToCart(@RequestBody Map<String, Object> payload){
         try {
            int item_index = Integer.parseInt(payload.get("item_index").toString());
            List<CartItemDTO> existingCart =  cartService.getMemberCart(loginUser.getId());
            boolean itemExists = existingCart.stream().anyMatch(cartItem -> cartItem.getItem_index() == item_index);
            if (itemExists) {
               //추후 메시치 출력 수정 필요
                return ResponseEntity.status(HttpStatus.CONFLICT).contentType(MediaType.TEXT_PLAIN).body("This item already added");
            }

            CartBean cartBean = new CartBean();
            cartBean.setId(loginUser.getId());
            cartBean.setItem_index(item_index);
            cartBean.setCart_id(cartService.getItemName(item_index));
            cartBean.setCart_quantity(1);
            cartBean.setCart_totalAmount(cartService.getItemPrice(item_index));
            cartService.addToCart(cartBean);
            
            
              return ResponseEntity.ok("추가 되었습니다");
              
          } catch (Exception e) {
              e.printStackTrace();
              return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("에러 발생");
          }
         
      }
	
	@PostMapping("/increase")
    @ResponseBody
    public void increaseQuantity(@RequestParam("itemIndex") int itemIndex) {
        cartService.increaseQuantity(itemIndex); // 수량 증가
    }

    @PostMapping("/decrease")
    @ResponseBody
    public void decreaseQuantity(@RequestParam("itemIndex") int itemIndex) {
        cartService.decreaseQuantity(itemIndex); // 수량 감소
    }

    @PostMapping("/remove")
    @ResponseBody
    public void removeItem(@RequestParam("itemIndex") int itemIndex) {
        cartService.removeItem(itemIndex); // 아이템 삭제
    }
    
    @PostMapping("/updateTotal")
    @ResponseBody
    public ResponseEntity<String> updateCartTotal(@RequestParam("totalAmount") int totalAmount) {
        try {
           String id = loginUser.getId();
            // DB에 합계를 업데이트하는 서비스 호출
            cartService.updateCartTotal(totalAmount, id);
            return ResponseEntity.ok("Total amount updated successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating total amount");
        }
    }
    
    
    

}
