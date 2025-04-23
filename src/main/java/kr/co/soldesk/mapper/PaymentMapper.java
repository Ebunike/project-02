package kr.co.soldesk.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.MainOrderBean;
import kr.co.soldesk.beans.OrderDetailBean;
import kr.co.soldesk.beans.OrderDetailDTO;
import kr.co.soldesk.beans.PaymentBean;
import kr.co.soldesk.beans.RefundBean;

@Mapper
public interface PaymentMapper {

	
	//결제 정보 등록(paymentKey가 null일 경우 결제 안된거)
	@Insert("insert into Payment "
			+ "(pay_index, "
			+ "order_id, "
			+ "pay_date, "
			+ "pay_amount, "
			+ "pay_method) "
			+ "values(Payment_seq.nextval, "
			+ "#{order_id}, "
			+ "#{pay_date}, "
			+ "#{pay_amount}, "
			+ "#{pay_method})")
	void addPayment(PaymentBean payment);
	
	
	//paymentKey등록
	@Update("UPDATE Payment "
	        + "SET paymentKey = #{paymentKey} "
	        + "WHERE order_id = #{orderId}")
	void savePaymentKey(@Param("paymentKey") String paymentKey, @Param("orderId") String orderId);

	
	
    //환불 정보 등록
    @Insert("INSERT INTO refund "
            + "(refund_index, order_detail_index, refund_reason) "
            + "VALUES (Refund_seq.nextval, #{order_detail_index}, #{refund_reason})")
    void addRefund(RefundBean refund);
	
  //판매자 sales를 amount만큼 올려주기. 관리자 or 판매자 매출 확인용--진행중
  	@Select("SELECT item_index, order_detail_finalPrice FROM order_detail WHERE order_id = #{orderId}")
  	List<OrderDetailBean> getOrderDetails(String orderId);

  	@Select("SELECT seller_index FROM item WHERE item_index = #{item_index}")
  	int getSellerIndex(int item_index);

  	@Update("UPDATE Seller SET sales = sales + #{order_detail_finalPrice} WHERE seller_index = #{seller_index}")
  	void addSales(@Param("seller_index") int seller_index, @Param("order_detail_finalPrice") int order_detail_finalPrice);


    
  	//결제 후 주문목록 가져오기
	//1.메인오더에서 orderId랑 orderDates가져오고.... 
  	@Select("SELECT order_id, order_date FROM MainOrder WHERE id = #{id} ORDER BY order_date DESC")
  	List<MainOrderBean> findOrderIdDates(String id);
  	

  	//2.Order_detail에서 상품별 총가격 등등 가져오고...
 	@Select("SELECT " + 
  	        "od.order_detail_index as orderDetailIndex, " + 
  	        "od.item_index as itemIndex, " + 
  	        "od.order_detail_finalPrice as finalPrice, " + 
  	        "od.order_detail_count as count, " + 
  	        "od.order_detail_status as status, " + 
  	        "od.refund_check as refundCheck " + 
  	        "FROM Order_detail od " + 
  	        "WHERE od.order_id = #{order_id}")
  	List<OrderDetailDTO> findItemIndex(String order_id);


	//3.payment에서 필요한거도 가져오게 paymentBean도 채우고..
	@Select("SELECT " + 
  	        "pay_index, " + 
  	        "order_id, " + 
  	        "pay_date, " + 
  	        "pay_amount, " + 
  	        "pay_method, " + 
  	        "paymentKey " + 
  	        "FROM Payment " + 
  	        "WHERE order_id = #{order_id}")
  	PaymentBean findPayment(String order_id);

	//환불시 refund check 업데이트
	@Update("UPDATE Order_detail SET refund_check = 'refund' WHERE order_detail_index = #{order_detail_index}")
	void updaterefund(@Param("order_detail_index") int order_detail_index);
  	
	//환불시 sales 판매자 매출 줄여줌
 	@Update("UPDATE Seller SET sales = sales - #{cancelAmount} WHERE seller_index = #{seller_index}")
 	void removeSales(@Param("seller_index") int seller_index, @Param("cancelAmount") int cancelAmount);

}
