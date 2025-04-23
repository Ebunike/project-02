package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.OnedayReviewDTO;

@Mapper
public interface OnedayReviewMapper {

    @Insert("INSERT INTO OnedayReview (review_index, oneday_index, reservation_index, member_id, " +
            "rating, content, review_imageUrl, register_date) " +
            "VALUES (review_seq.NEXTVAL, #{oneday_index}, #{reservation_index}, #{member_id}, " +
            "#{rating}, #{content}, #{review_imageUrl}, SYSDATE)")
    @Options(useGeneratedKeys = true, keyProperty = "review_index", keyColumn = "review_index")
    int insertReview(OnedayReviewDTO review);

    @Update("UPDATE OnedayReview SET rating = #{rating}, content = #{content}, " +
            "review_imageUrl = #{review_imageUrl}, update_date = SYSDATE " +
            "WHERE review_index = #{review_index} AND member_id = #{member_id}")
    int updateReview(OnedayReviewDTO review);

    @Delete("DELETE FROM OnedayReview WHERE review_index = #{review_index} AND member_id = #{member_id}")
    int deleteReview(@Param("review_index") int review_index, @Param("member_id") String member_id);

    @Select("SELECT r.*, m.name AS member_name, o.oneday_name " +
            "FROM OnedayReview r " +
            "JOIN Member m ON r.member_id = m.id " +
            "JOIN Oneday o ON r.oneday_index = o.oneday_index " +
            "WHERE r.review_index = #{review_index}")
    OnedayReviewDTO getReviewByIndex(@Param("review_index") int review_index);

    @Select("SELECT r.*, m.name AS member_name " +
            "FROM OnedayReview r " +
            "JOIN Member m ON r.member_id = m.id " +
            "WHERE r.oneday_index = #{oneday_index} " +
            "ORDER BY r.register_date DESC")
    List<OnedayReviewDTO> getReviewsByOnedayIndex(@Param("oneday_index") int oneday_index);

    @Select("SELECT r.*, o.oneday_name " +
            "FROM OnedayReview r " +
            "JOIN Oneday o ON r.oneday_index = o.oneday_index " +
            "WHERE r.member_id = #{member_id} " +
            "ORDER BY r.register_date DESC")
    List<OnedayReviewDTO> getReviewsByMemberId(@Param("member_id") String member_id);

    @Select("SELECT * FROM OnedayReview WHERE reservation_index = #{reservation_index}")
    OnedayReviewDTO getReviewByReservationIndex(@Param("reservation_index") int reservation_index);

    @Select("SELECT COALESCE(AVG(rating), 0) FROM OnedayReview WHERE oneday_index = #{oneday_index}")
    double getAverageRating(@Param("oneday_index") int oneday_index);

    @Select("SELECT COUNT(*) FROM OnedayReview WHERE oneday_index = #{oneday_index}")
    int getReviewCount(@Param("oneday_index") int oneday_index);

    @Select("SELECT r.*, m.name AS member_name " +
            "FROM (" +
            "  SELECT ROW_NUMBER() OVER (ORDER BY register_date DESC) AS rnum, review_index " +
            "  FROM OnedayReview " +
            "  WHERE oneday_index = #{oneday_index}" +
            ") ranked " +
            "JOIN OnedayReview r ON ranked.review_index = r.review_index " +
            "JOIN Member m ON r.member_id = m.id " +
            "WHERE ranked.rnum BETWEEN #{start} AND #{start} + #{count} - 1 " +
            "ORDER BY r.register_date DESC")
    List<OnedayReviewDTO> getReviewsByOnedayIndexPaging(
            @Param("oneday_index") int oneday_index,
            @Param("start") int start,
            @Param("count") int count);
}