package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.CartBean;
import kr.co.soldesk.beans.CartItemDTO;

@Mapper
public interface CartMapper {

	@Insert("insert into cart(cart_index, id, item_index, cart_id, cart_quantity, cart_totalAmount) "
			+ "values(cart_seq.nextval, #{id}, #{item_index}, #{cart_id}, #{cart_quantity}, #{cart_totalAmount})")
	void addToCart(CartBean cartBean);
	
	@Select("select item_name from item where item_index = #{item_index}")
	String getItemName(int item_index);
	
	@Select("select item_price from item where item_index = #{item_index}")
	int getItemPrice(int item_index);
	
	@Select("select cart.id, cart.item_index, cart.cart_quantity, item.item_name, item.item_price "
			+ "from cart "
			+ "join item on cart.item_index = item.item_index "
			+ "join member on cart.id = member.id "
			+ "where cart.id = #{id}")
	List<CartItemDTO> getMemberCart(@Param("id") String id);
	
	@Update("UPDATE cart SET cart_quantity = cart_quantity + #{cart_quantity} WHERE item_index = #{item_index}")
	void updateQuantity(@Param("cart_quantity") int cart_quantity, @Param("item_index") int item_index);
	
	@Delete("DELETE FROM cart WHERE item_index = #{item_index}")
	void deleteItem(@Param("item_index")int item_index);
	
	@Update("UPDATE Cart c SET c.cart_totalAmount = :totalAmount WHERE c.id = :id")
	void updateCartTotal(@Param("totalAmount") int totalAmount, @Param("id") String id);
	
	@Select("select cart.id, cart.item_index, cart.cart_quantity, item.item_name, item.item_price, item.item_picture " +
	        "from cart " +
	        "join item on cart.item_index = item.item_index " +
	        "join member on cart.id = member.id " +
	        "where cart.id = #{userId} AND cart.item_index IN (${itemIndexes})")
	List<CartItemDTO> getSelectedCartItems(@Param("userId") String userId, @Param("itemIndexes") String itemIndexes);
	
	
	@Select("select cart_totalAmount from cart")
	List<Integer> getAllTotalAmount();
	
	@Select("select * from cart")
	List<CartBean> getCart();
	
	//검증용 금액 찾기
	@Select("SELECT SUM(cart_totalAmount) FROM Cart WHERE id = #{id}")
	int findAmount(@Param("id") String id);
	
	@Select("SELECT SUM(cart_quantity) FROM Cart WHERE id = #{id}")
	int findCount(String id);
	
	//카트 리셋
	@Delete("DELETE FROM cart WHERE id = #{id}")
	void resetCart(String id);
	
}
