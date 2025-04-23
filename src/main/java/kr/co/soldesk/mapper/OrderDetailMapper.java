package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.OrderDetailBean;

@Mapper
public interface OrderDetailMapper {

	 /**
     * 주문 상세 정보를 저장하는 메서드
     * 
     * @param orderDetail 저장할 주문 상세 정보
     * @return 저장된 행의 수
     */
		/*
		 * insertOrderDetail은 현재 orderController에서 선택구매한 상품을 저장하기위한 메소드로 사용되고 있음 이 용도외엔
		 * 작동되는지 확인이 어려우므로 주의요망
		 */
    @Insert("INSERT INTO Order_detail (order_detail_index, order_id, item_index, " +
            "order_detail_finalPrice, order_detail_count, order_detail_status, refund_check) " +
            "VALUES (order_detail_seq.NEXTVAL, #{order_id}, #{item_index}, " +
            "#{order_detail_finalPrice}, #{order_detail_count}, null, 'false')")
    @Options(useGeneratedKeys = true, keyProperty = "order_detail_index", keyColumn = "order_detail_index")
    int insertOrderDetail(OrderDetailBean orderDetail);
    
    /**
     * 주문 ID로 주문 상세 목록을 조회하는 메서드
     * 
     * @param orderId 주문 ID
     * @return 주문 상세 목록
     */
    @Select("SELECT od.*, i.item_name, i.item_picture " +
            "FROM Order_detail od " +
            "JOIN Item i ON od.item_index = i.item_index " +
            "WHERE od.order_id = #{orderId}")
    List<OrderDetailBean> getOrderDetailsByOrderId(@Param("orderId") String orderId);
    
    /**
     * 주문 상세 인덱스로 주문 상세 정보를 조회하는 메서드
     * 
     * @param orderDetailIndex 주문 상세 인덱스
     * @return 주문 상세 정보를 담은 OrderDetailDTO
     */
    @Select("SELECT od.*, i.item_name, i.item_picture " +
            "FROM Order_detail od " +
            "JOIN Item i ON od.item_index = i.item_index " +
            "WHERE od.order_detail_index = #{orderDetailIndex}")
    OrderDetailBean getOrderDetailByIndex(@Param("orderDetailIndex") int orderDetailIndex);
    
    /**
     * 주문 상세 상태를 업데이트하는 메서드
     * 
     * @param orderDetailIndex 주문 상세 인덱스
     * @param status 변경할 상태
     * @return 수정된 행의 수
     */
    @Update("UPDATE Order_detail SET order_detail_status = #{status} WHERE order_detail_index = #{orderDetailIndex}")
    int updateOrderDetailStatus(@Param("orderDetailIndex") int orderDetailIndex, @Param("status") String status);
	
	
    @Delete("delete from order_detail where order_id = #{orderId}")
	void deleteOrderDetail(String orderId);
    
    // seller index찾아오기
    @Select("SELECT i.seller_index " +
            "FROM Order_detail od " +
            "JOIN Item i ON od.item_index = i.item_index " +
            "WHERE od.order_detail_index = #{order_detail_index}")
    int getSeller(@Param("order_detail_index") int order_detail_index);
    

}
