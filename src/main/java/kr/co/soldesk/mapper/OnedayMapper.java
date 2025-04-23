package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.OnedayDTO;

@Mapper
public interface OnedayMapper {

	@Select("SELECT o.*, t.theme_name, m.name AS seller_name " +
	        "FROM Oneday o " +
	        "LEFT JOIN Theme t ON o.theme_index = t.theme_index " +
	        "LEFT JOIN Seller s ON o.seller_index = s.seller_index " +
	        "LEFT JOIN Member m ON s.id = m.id " +
	        "WHERE o.oneday_index = #{oneday_index}")
	OnedayDTO getOnedayByIndex(@Param("oneday_index") int oneday_index);
	
    @Select("SELECT o.*, t.theme_name, " +
            "COALESCE((SELECT SUM(participant_count) FROM OnedayReservation WHERE oneday_index = o.oneday_index AND reservation_status != 'CANCELLED'), 0) AS current_participants, " +
            "COALESCE((SELECT AVG(rating) FROM OnedayReview WHERE oneday_index = o.oneday_index), 0) AS average_rating, " +
            "COALESCE((SELECT COUNT(*) FROM OnedayReview WHERE oneday_index = o.oneday_index), 0) AS review_count " +
            "FROM Oneday o " +
            "JOIN Theme t ON o.theme_index = t.theme_index " +
            "WHERE o.oneday_date >= SYSDATE " +
            "ORDER BY o.oneday_date")
    List<OnedayDTO> getUpcomingOnedays();

    @Select("SELECT o.*, t.theme_name, " +
            "COALESCE((SELECT SUM(participant_count) FROM OnedayReservation WHERE oneday_index = o.oneday_index AND reservation_status != 'CANCELLED'), 0) AS current_participants, " +
            "COALESCE((SELECT AVG(rating) FROM OnedayReview WHERE oneday_index = o.oneday_index), 0) AS average_rating, " +
            "COALESCE((SELECT COUNT(*) FROM OnedayReview WHERE oneday_index = o.oneday_index), 0) AS review_count " +
            "FROM Oneday o " +
            "JOIN Theme t ON o.theme_index = t.theme_index " +
            "WHERE o.oneday_date >= SYSDATE " +
            "ORDER BY o.oneday_date " +
            "FETCH FIRST #{limit} ROWS ONLY")
    List<OnedayDTO> getRecentOnedays(@Param("limit") int limit);

    @Select("SELECT o.*, t.theme_name, " +
            "COALESCE((SELECT SUM(participant_count) FROM OnedayReservation WHERE oneday_index = o.oneday_index AND reservation_status != 'CANCELLED'), 0) AS current_participants, " +
            "COALESCE((SELECT AVG(rating) FROM OnedayReview WHERE oneday_index = o.oneday_index), 0) AS average_rating, " +
            "COALESCE((SELECT COUNT(*) FROM OnedayReview WHERE oneday_index = o.oneday_index), 0) AS review_count " +
            "FROM Oneday o " +
            "JOIN Theme t ON o.theme_index = t.theme_index " +
            "WHERE o.theme_index = #{theme_index} " +
            "ORDER BY o.oneday_date")
    List<OnedayDTO> getOnedaysByThemeIndex(@Param("theme_index") int theme_index);

    @Select("SELECT o.*, t.theme_name, " +
            "COALESCE((SELECT SUM(participant_count) FROM OnedayReservation WHERE oneday_index = o.oneday_index AND reservation_status != 'CANCELLED'), 0) AS current_participants, " +
            "COALESCE((SELECT AVG(rating) FROM OnedayReview WHERE oneday_index = o.oneday_index), 0) AS average_rating, " +
            "COALESCE((SELECT COUNT(*) FROM OnedayReview WHERE oneday_index = o.oneday_index), 0) AS review_count " +
            "FROM Oneday o " +
            "JOIN Theme t ON o.theme_index = t.theme_index " +
            "WHERE o.seller_index = (SELECT seller_index FROM Seller WHERE id = #{seller_id}) " +
            "ORDER BY o.oneday_date DESC")
    List<OnedayDTO> getOnedaysBySellerId(@Param("seller_id") String seller_id);

    @Select("SELECT o.*, t.theme_name, " +
            "COALESCE((SELECT SUM(participant_count) FROM OnedayReservation WHERE oneday_index = o.oneday_index AND reservation_status != 'CANCELLED'), 0) AS current_participants, " +
            "COALESCE((SELECT AVG(rating) FROM OnedayReview WHERE oneday_index = o.oneday_index), 0) AS average_rating, " +
            "COALESCE((SELECT COUNT(*) FROM OnedayReview WHERE oneday_index = o.oneday_index), 0) AS review_count " +
            "FROM Oneday o " +
            "JOIN Theme t ON o.theme_index = t.theme_index " +
            "WHERE UPPER(o.oneday_name) LIKE '%' || UPPER(#{keyword}) || '%' " +
            "OR UPPER(o.oneday_description) LIKE '%' || UPPER(#{keyword}) || '%' " +
            "OR UPPER(t.theme_name) LIKE '%' || UPPER(#{keyword}) || '%' " +
            "ORDER BY o.oneday_date")
    List<OnedayDTO> searchOnedays(@Param("keyword") String keyword);

    @Insert("INSERT INTO Oneday (oneday_index, seller_index, theme_index, oneday_name, oneday_info, " +
            "oneday_start, oneday_end, oneday_price, oneday_date, oneday_personnel, " +
            "oneday_imageUrl, oneday_location, oneday_status, oneday_description, oneday_materials, " +
            "oneday_duration, oneday_max_participants, naver_calendar_id) " +
            "VALUES (oneday_seq.NEXTVAL, #{seller_index}, #{theme_index}, #{oneday_name}, #{oneday_info, jdbcType=VARCHAR}, " +
            "#{oneday_start, jdbcType=VARCHAR}, #{oneday_end, jdbcType=VARCHAR}, #{oneday_price}, #{oneday_date}, #{oneday_personnel}, " +
            "#{oneday_imageUrl, jdbcType=VARCHAR}, #{oneday_location, jdbcType=VARCHAR}, #{oneday_status, jdbcType=VARCHAR}, " +
            "#{oneday_description, jdbcType=VARCHAR}, #{oneday_materials, jdbcType=VARCHAR}, " +
            "#{oneday_duration}, #{oneday_max_participants}, #{naver_calendar_id, jdbcType=VARCHAR})")
    @Options(useGeneratedKeys = true, keyProperty = "oneday_index", keyColumn = "oneday_index")
    int insertOneday(OnedayDTO oneday);

    @Update("UPDATE Oneday SET " +
            "theme_index = #{theme_index}, " +
            "oneday_name = #{oneday_name}, " +
            "oneday_price = #{oneday_price}, " +
            "oneday_max_participants = #{oneday_max_participants}, " +
            "oneday_date = #{oneday_date}, " +
            "oneday_duration = #{oneday_duration}, " +
            "oneday_location = #{oneday_location}, " +
            "oneday_description = #{oneday_description}, " +
            "oneday_materials = #{oneday_materials}, " +
            "oneday_imageUrl = #{oneday_imageUrl} " +
            "WHERE oneday_index = #{oneday_index}")
    int updateOneday(OnedayDTO oneday);

    @Delete("DELETE FROM Oneday WHERE oneday_index = #{oneday_index}")
    int deleteOneday(@Param("oneday_index") int oneday_index);

    // 페이지네이션을 위한 추가 메서드들
    @Select("SELECT o.*, t.theme_name, " +
            "COALESCE((SELECT SUM(participant_count) FROM OnedayReservation WHERE oneday_index = o.oneday_index AND reservation_status != 'CANCELLED'), 0) AS current_participants, " +
            "COALESCE((SELECT AVG(rating) FROM OnedayReview WHERE oneday_index = o.oneday_index), 0) AS average_rating, " +
            "COALESCE((SELECT COUNT(*) FROM OnedayReview WHERE oneday_index = o.oneday_index), 0) AS review_count " +
            "FROM Oneday o " +
            "JOIN Theme t ON o.theme_index = t.theme_index " +
            "WHERE o.oneday_date >= SYSDATE " +
            "ORDER BY o.oneday_date " +
            "OFFSET #{offset} ROWS FETCH NEXT #{limit} ROWS ONLY")
    List<OnedayDTO> getOnedaysWithPagination(@Param("offset") int offset, @Param("limit") int limit);

    @Select("SELECT COUNT(*) FROM Oneday WHERE oneday_date >= SYSDATE")
    int getTotalOnedayCount();

    @Select("SELECT o.*, t.theme_name, " +
            "COALESCE((SELECT SUM(participant_count) FROM OnedayReservation WHERE oneday_index = o.oneday_index AND reservation_status != 'CANCELLED'), 0) AS current_participants, " +
            "COALESCE((SELECT AVG(rating) FROM OnedayReview WHERE oneday_index = o.oneday_index), 0) AS average_rating, " +
            "COALESCE((SELECT COUNT(*) FROM OnedayReview WHERE oneday_index = o.oneday_index), 0) AS review_count " +
            "FROM Oneday o " +
            "JOIN Theme t ON o.theme_index = t.theme_index " +
            "WHERE o.oneday_date >= SYSDATE AND t.theme_index = #{themeIndex} " +
            "ORDER BY o.oneday_date " +
            "OFFSET #{offset} ROWS FETCH NEXT #{limit} ROWS ONLY")
    List<OnedayDTO> getOnedaysByThemeIndexWithPagination(
            @Param("themeIndex") int themeIndex,
            @Param("offset") int offset,
            @Param("limit") int limit);

    @Select("SELECT COUNT(*) FROM Oneday WHERE oneday_date >= SYSDATE AND theme_index = #{themeIndex}")
    int getTotalOnedayCountByTheme(@Param("themeIndex") int themeIndex);

    @Update("UPDATE Oneday SET oneday_status = 'FULL' " +
            "WHERE oneday_index IN (" +
            "    SELECT o.oneday_index FROM Oneday o " +
            "    WHERE COALESCE((SELECT SUM(participant_count) FROM OnedayReservation " +
            "                    WHERE oneday_index = o.oneday_index AND reservation_status != 'CANCELLED'), 0) >= o.oneday_max_participants" +
            ") AND oneday_status != 'FULL'")
    int updateFullClassesStatus();

    @Update("UPDATE Oneday SET oneday_status = 'OPEN' " +
            "WHERE oneday_index IN (" +
            "    SELECT o.oneday_index FROM Oneday o " +
            "    WHERE COALESCE((SELECT SUM(participant_count) FROM OnedayReservation " +
            "                    WHERE oneday_index = o.oneday_index AND reservation_status != 'CANCELLED'), 0) < o.oneday_max_participants" +
            ") AND oneday_status = 'FULL' AND oneday_date > SYSDATE")
    int updateAvailableClassesStatus();
}