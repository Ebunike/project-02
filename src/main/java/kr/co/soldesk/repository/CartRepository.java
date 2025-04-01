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
	public int getItemPrice(int item_index) {
		return cartMapper.getItemPrice(item_index);
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
    public void updateCartTotal(int totalAmount, String id) {
    	cartMapper.updateCartTotal(totalAmount, id);
    }
    public List<CartItemDTO> getSelectedCartItems(String userId, String[] itemIndexes) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < itemIndexes.length; i++) {
            sb.append(itemIndexes[i]);
            if (i < itemIndexes.length - 1) {
                sb.append(",");
            }
        }
        return cartMapper.getSelectedCartItems(userId, sb.toString());
    }
    
    public List<Integer> getAllTotalAmount() {
    	return cartMapper.getAllTotalAmount();
    }
    
    public List<CartBean> getCart(){
    	return cartMapper.getCart();
    }
    
    public int findAmount(String id) {
    	return cartMapper.findAmount(id);
    }
	public int findCount(String id) {
		// TODO Auto-generated method stub
		return cartMapper.findCount(id);
	}
	
	   //카트 리셋
    public void resetCart(String id) {
    	cartMapper.resetCart(id);
    }
}
