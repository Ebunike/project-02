package kr.co.soldesk.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.CartBean;
import kr.co.soldesk.beans.CartItemDTO;
import kr.co.soldesk.mapper.CartMapper;

@Repository
public class CartRepository {

	@Autowired
	private CartMapper cartMapper;
	
	public void addToCart(CartBean cartBean) {
		cartMapper.addToCart(cartBean);
	}
	public String getItemName(int item_index) {
		return cartMapper.getItemName(item_index);
	}
	public List<CartItemDTO> getMemberCart(String id){
		return cartMapper.getMemberCart(id);
	}
	public void updateQuantity(int itemIndex, int number) {
        cartMapper.updateQuantity(number, itemIndex);
    }

    public void deleteItem(int itemIndex) {
        cartMapper.deleteItem(itemIndex);
    }
}
