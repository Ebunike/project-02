package kr.co.soldesk.mapper;



import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.OnedayDTO;


/**
 * 원데이 클래스 정보 관련 매퍼 인터페이스
 */
@Mapper
public interface OnedayMapper {
    
    /**
     * 원데이 클래스 정보를 등록하는 메서드
     * 
     * @param oneday 등록할 원데이 클래스 정보
     * @return 등록된 행 수
     */
    @Insert("INSERT INTO Oneday (oneday_index, seller_index, theme_index, oneday_name, " +
            "oneday_info, oneday_start, oneday_end, oneday_price, oneday_date, " +
            "oneday_personnel, oneday_imageUrl, oneday_location) " +
            "VALUES (oneday_seq.NEXTVAL, #{seller_index}, #{theme_index}, #{oneday_name}, " +
            "#{oneday_info}, #{oneday_start}, #{oneday_end}, #{oneday_price}, #{oneday_date}, " +
            "#{oneday_personnel}, #{oneday_imageUrl}, #{oneday_location})")
    @Options(useGeneratedKeys = true, keyProperty = "oneday_index", keyColumn = "oneday_index")
    void insertOneday(OnedayDTO oneday);
    
    /**
     * 원데이 클래스 정보를 수정하는 메서드
     * 
     * @param oneday 수정할 원데이 클래스 정보
     * @return 수정된 행 수
     */
    @Update("UPDATE Oneday SET theme_index = #{theme_index}, oneday_name = #{oneday_name}, " +
            "oneday_info = #{oneday_info}, oneday_start = #{oneday_start}, oneday_end = #{oneday_end}, " +
            "oneday_price = #{oneday_price}, oneday_date = #{oneday_date}, oneday_personnel = #{oneday_personnel}, " +
            "oneday_imageUrl = #{oneday_imageUrl}, oneday_location = #{oneday_location} " +
            "WHERE oneday_index = #{oneday_index}")
    int updateOneday(OnedayDTO oneday);
    
    /**
     * 원데이 클래스 정보를 조회하는 메서드
     * 
     * @param onedayIndex 조회할 원데이 클래스 인덱스
     * @return 원데이 클래스 정보
     */
    @Select("SELECT o.*, t.theme_name, s.id AS seller_id, m.name AS seller_name, " +
            "(SELECT COUNT(*) FROM OnedayReservation r WHERE r.oneday_index = o.oneday_index AND r.reservation_status != 'CANCELLED') AS current_participants " +
            "FROM Oneday o " +
            "JOIN Theme t ON o.theme_index = t.theme_index " +
            "JOIN Seller s ON o.seller_index = s.seller_index " +
            "JOIN Member m ON s.id = m.id " +
            "WHERE o.oneday_index = #{onedayIndex}")
    OnedayDTO getOnedayByIndex(@Param("onedayIndex") int onedayIndex);
    
    /**
     * 판매자가 등록한 원데이 클래스 목록을 조회하는 메서드
     * 
     * @param sellerIndex 판매자 인덱스
     * @return 원데이 클래스 목록
     */
    @Select("SELECT o.*, t.theme_name, " +
            "(SELECT COUNT(*) FROM OnedayReservation r WHERE r.oneday_index = o.oneday_index AND r.reservation_status != 'CANCELLED') AS current_participants " +
            "FROM Oneday o " +
            "JOIN Theme t ON o.theme_index = t.theme_index " +
            "WHERE o.seller_index = #{sellerIndex} " +
            "ORDER BY o.oneday_date DESC")
    List<OnedayDTO> getOnedaysBySellerIndex(@Param("sellerIndex") int sellerIndex);
    
    /**
     * 테마별 원데이 클래스 목록을 조회하는 메서드
     * 
     * @param themeIndex 테마 인덱스
     * @return 원데이 클래스 목록
     */
    @Select("SELECT o.*, t.theme_name, s.id AS seller_id, m.name AS seller_name, " +
            "(SELECT COUNT(*) FROM OnedayReservation r WHERE r.oneday_index = o.oneday_index AND r.reservation_status != 'CANCELLED') AS current_participants " +
            "FROM Oneday o " +
            "JOIN Theme t ON o.theme_index = t.theme_index " +
            "JOIN Seller s ON o.seller_index = s.seller_index " +
            "JOIN Member m ON s.id = m.id " +
            "WHERE o.theme_index = #{themeIndex} " +
            "ORDER BY o.oneday_date")
    List<OnedayDTO> getOnedaysByThemeIndex(@Param("themeIndex") int themeIndex);
    
    /**
     * 최근 등록된 원데이 클래스 목록을 조회하는 메서드
     * 
     * @param limit 조회할 개수
     * @return 원데이 클래스 목록
     */
    @Select("SELECT o.*, t.theme_name, s.id AS seller_id, m.name AS seller_name, " +
            "(SELECT COUNT(*) FROM OnedayReservation r WHERE r.oneday_index = o.oneday_index AND r.reservation_status != 'CANCELLED') AS current_participants " +
            "FROM Oneday o " +
            "JOIN Theme t ON o.theme_index = t.theme_index AND t.theme_code = 2 " +
            "JOIN Seller s ON o.seller_index = s.seller_index " +
            "JOIN Member m ON s.id = m.id " +
            "WHERE o.oneday_date >= SYSDATE " +
            "ORDER BY o.oneday_date " +
            "FETCH FIRST #{limit} ROWS ONLY")
    List<OnedayDTO> getRecentOnedays(@Param("limit") int limit);
    
    /**
     * 키워드로 원데이 클래스를 검색하는 메서드
     * 
     * @param keyword 검색 키워드
     * @return 원데이 클래스 목록
     */
    @Select("SELECT o.*, t.theme_name, s.id AS seller_id, m.name AS seller_name, " +
            "(SELECT COUNT(*) FROM OnedayReservation r WHERE r.oneday_index = o.oneday_index AND r.reservation_status != 'CANCELLED') AS current_participants " +
            "FROM Oneday o " +
            "JOIN Theme t ON o.theme_index = t.theme_index " +
            "JOIN Seller s ON o.seller_index = s.seller_index " +
            "JOIN Member m ON s.id = m.id " +
            "WHERE o.oneday_name LIKE '%' || #{keyword} || '%' " +
            "OR o.oneday_info LIKE '%' || #{keyword} || '%' " +
            "OR t.theme_name LIKE '%' || #{keyword} || '%' " +
            "ORDER BY o.oneday_date")
    List<OnedayDTO> searchOnedays(@Param("keyword") String keyword);
}
