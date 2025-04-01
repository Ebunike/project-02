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

    @Select("SELECT TO_CHAR(sale_date, 'YYYY-MM-DD') AS sale_date, SUM(total_amount) AS total_amount " +
            "FROM sales " +
            "WHERE sale_date BETWEEN TRUNC(SYSDATE, 'D') + 1 AND TRUNC(SYSDATE, 'D') + 7 " +
            "GROUP BY sale_date " +
            "ORDER BY sale_date")
    List<Map<String, Object>> getWeeklySales();

    @Select("SELECT TO_CHAR(sale_date, 'YYYY-MM') AS month, TO_CHAR(sale_date, 'IW') AS week, SUM(total_amount) AS total_amount " +
            "FROM sales " +
            "WHERE TO_CHAR(sale_date, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM') " +
            "GROUP BY TO_CHAR(sale_date, 'YYYY-MM'), TO_CHAR(sale_date, 'IW') " +
            "ORDER BY TO_CHAR(sale_date, 'YYYY-MM'), TO_CHAR(sale_date, 'IW')")
    List<Map<String, Object>> getMonthlySales();
    
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
