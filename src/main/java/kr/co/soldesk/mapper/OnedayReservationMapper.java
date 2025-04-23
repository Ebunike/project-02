package kr.co.soldesk.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.OnedayReservationDTO;

@Mapper
public interface OnedayReservationMapper {

    //@Select("SELECT * FROM OnedayReservation WHERE reservation_index = #{reservation_index}")
    //OnedayReservationDTO getReservationByIndex(@Param("reservation_index") int reservation_index);

	@Select("SELECT " +
	        "r.reservation_index, " +
	        "r.oneday_index, " +
	        "r.member_id, " +
	        "r.reservation_date, " +
	        "r.reservation_status, " +
	        "r.participant_count, " +
	        "r.calendar_event_id, " +
	        "r.special_requests, " +
	        "o.oneday_name, " +
	        "o.oneday_date, " +
	        "o.oneday_start, " +
	        "o.oneday_end, " +
	        "o.oneday_location, " +
	        "o.oneday_info, " +
	        "o.oneday_price, " +
	        "t.theme_name, " +
	        "m.name AS member_name, " +
	        "m.tel AS member_tel, " +
	        "m.email AS member_email " +
	        "FROM OnedayReservation r " +
	        "JOIN Oneday o ON r.oneday_index = o.oneday_index " +
	        "JOIN Theme t ON o.theme_index = t.theme_index " +
	        "JOIN Member m ON r.member_id = m.id " +
	        "WHERE r.reservation_index = #{reservation_index}")
	OnedayReservationDTO getReservationByIndex(@Param("reservation_index") int reservation_index);
	
    @Select("SELECT " +
            "r.reservation_index, " +
            "r.oneday_index, " +
            "r.member_id, " +
            "r.reservation_date, " +
            "r.reservation_status, " +
            "r.participant_count, " +
            "r.calendar_event_id, " +
            "r.special_requests, " +
            "o.oneday_name, " +
            "o.oneday_date, " +
            "o.oneday_start, " +
            "o.oneday_end, " +
            "o.oneday_location, " +
            "o.oneday_info, " +
            "o.oneday_price " +
            "FROM OnedayReservation r " +
            "JOIN Oneday o ON r.oneday_index = o.oneday_index " +
            "WHERE r.member_id = #{member_id} " +
            "ORDER BY r.reservation_date DESC")
    List<OnedayReservationDTO> getReservationsByMemberId(@Param("member_id") String member_id);

    @Select("SELECT r.*, o.oneday_name, o.oneday_date, o.oneday_price, o.oneday_location " +
            "FROM OnedayReservation r " +
            "JOIN Oneday o ON r.oneday_index = o.oneday_index " +
            "WHERE r.oneday_index = #{oneday_index} " +
            "ORDER BY r.reservation_date DESC")
    List<OnedayReservationDTO> getReservationsByOnedayIndex(@Param("oneday_index") int oneday_index);

    @Select("SELECT COUNT(*) FROM OnedayReservation " +
            "WHERE oneday_index = #{oneday_index} " +
            "AND member_id = #{member_id} " +
            "AND reservation_status != 'CANCELLED'")
    int checkReservationExists(@Param("oneday_index") int oneday_index, @Param("member_id") String member_id);

    @Insert("INSERT INTO OnedayReservation (reservation_index, oneday_index, member_id, participant_count, " +
            "special_requests, reservation_status, reservation_date) " +
            "VALUES (reservation_seq.NEXTVAL, #{oneday_index}, #{member_id}, #{participant_count}, " +
            "#{special_requests, jdbcType=VARCHAR}, #{reservation_status, jdbcType=VARCHAR}, SYSDATE)")
    @Options(useGeneratedKeys = true, keyProperty = "reservation_index", keyColumn = "reservation_index")
    int insertReservation(OnedayReservationDTO reservation);

    @Update("UPDATE OnedayReservation SET reservation_status = 'CANCELLED', cancel_date = SYSDATE " +
            "WHERE reservation_index = #{reservation_index} AND member_id = #{member_id}")
    int cancelReservation(@Param("reservation_index") int reservation_index, @Param("member_id") String member_id);

    @Update("UPDATE OnedayReservation SET reservation_status = 'COMPLETED' " +
            "WHERE oneday_index IN (SELECT oneday_index FROM Oneday WHERE oneday_date < SYSDATE) " +
            "AND reservation_status = 'CONFIRMED'")
    int updatePastClassesToCompleted();

    @Update("UPDATE OnedayReservation SET reservation_status = 'LOCKED' " +
            "WHERE oneday_index IN (SELECT oneday_index FROM Oneday WHERE oneday_date BETWEEN SYSDATE AND SYSDATE + 1) " +
            "AND reservation_status = 'CONFIRMED'")
    int lockSoonStartingClasses();

    /*@Select("SELECT COALESCE(SUM(participant_count), 0) " +
            "FROM OnedayReservation " +
            "WHERE oneday_index = #{onedayIndex} " +
            "AND reservation_status != 'CANCELLED'")
    int getCurrentParticipantCount(@Param("onedayIndex") int onedayIndex);*/

    @Select("SELECT COALESCE(SUM(participant_count), 0) " +
            "FROM OnedayReservation " +
            "WHERE oneday_index = #{oneday_index} " +
            "AND reservation_status NOT IN ('CANCELED', 'REFUNDED')")
    int getCurrentParticipantCount(@Param("oneday_index") int oneday_index);
    
    @Select("SELECT COUNT(*) FROM OnedayReservation " +
            "WHERE oneday_index = #{oneday_index} " +
            "AND reservation_status != 'CANCELLED'")
    int getReservationCount(@Param("oneday_index") int oneday_index);

    @Delete("DELETE FROM OnedayReservation WHERE reservation_index = #{reservation_index}")
    int deleteReservation(@Param("reservation_index") int reservation_index);
    
    @Update("UPDATE OnedayReservation SET reservation_status = #{status} " +
            "WHERE reservation_index = #{reservation_index}")
    int updateReservationStatus(@Param("reservation_index") int reservation_index, @Param("status") String status);

    @Update("UPDATE OnedayReservation SET cancel_date = #{cancelDate} " +
            "WHERE reservation_index = #{reservation_index}")
    int updateCancelDate(@Param("reservation_index") int reservation_index, @Param("cancelDate") Date cancelDate);
}