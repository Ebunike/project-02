package kr.co.soldesk.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.co.soldesk.beans.InquiryBean;
import kr.co.soldesk.beans.ItemBean;

import java.util.List;
import java.util.Map;

@Mapper
public interface ManagerMapper {
    
    @Select("SELECT * FROM Item i, Theme t "
            + "WHERE (SELECT seller_index FROM Member m, Seller s WHERE m.id = s.id AND #{userId} = m.id) = i.seller_index AND "
            + "t.theme_index = i.theme_index AND t.theme_code = 1")
      List<ItemBean> getKitList(String userId);
    
    @Delete("DELETE FROM Item WHERE item_index = #{productId}")
    void deleteProduct(int productId);

    @Delete("DELETE FROM Kit WHERE item_index = #{productId}")
    void deleteKit(int productId);
    //판매금액 보여줌
    @Select("SELECT sales FROM Seller WHERE id = #{id}")
    int showSales(String id);
    
   //고객문의
    @Select("SELECT * FROM Inquiry WHERE inquiry_category = 'order'")
    List<InquiryBean> getInquiryList();
}
