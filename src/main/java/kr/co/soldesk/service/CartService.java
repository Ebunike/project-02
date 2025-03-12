package kr.co.soldesk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.CartBean;
import kr.co.soldesk.beans.CartItemDTO;
import kr.co.soldesk.repository.CartRepository;

@Service
public class CartService {

	@Autowired
	private CartRepository cartRepository;
	
	public void addToCart(CartBean cartBean) {
		cartRepository.addToCart(cartBean);
	}
	public String getItemName(int item_index) {
		return cartRepository.getItemName(item_index);
	}
	public List<CartItemDTO> getMemberCart(String id){
		return cartRepository.getMemberCart(id);
	}
	public void increaseQuantity(int itemIndex) {
        cartRepository.updateQuantity(itemIndex, 1); // 수량 증가
    }

    public void decreaseQuantity(int itemIndex) {
        cartRepository.updateQuantity(itemIndex, -1); // 수량 감소
    }

    public void removeItem(int itemIndex) {
        cartRepository.deleteItem(itemIndex); // 아이템 삭제
    }
}
