package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.OnedayReservationDTO;


/**
 * 원데이 클래스 예약 정보 관련 매퍼 인터페이스
 */
@Mapper
public interface OnedayReservationMapper {
    
    /**
     * 원데이 클래스 예약 정보를 등록하는 메서드
     * 
     * @param reservation 등록할 예약 정보
     * @return 등록된 행 수
     */
    @Insert("INSERT INTO OnedayReservation (reservation_index, oneday_index, member_id, " +
            "reservation_date, reservation_status, participant_count, calendar_event_id) " +
            "VALUES (reservation_seq.NEXTVAL, #{onedayIndex}, #{memberId}, " +
            "SYSDATE, #{reservationStatus}, #{participantCount}, #{calendarEventId})")
    @Options(useGeneratedKeys = true, keyProperty = "reservationIndex", keyColumn = "reservation_index")
    int insertReservation(OnedayReservationDTO reservation);
    
    /**
     * 원데이 클래스 예약 상태를 업데이트하는 메서드
     * 
     * @param reservationIndex 예약 인덱스
     * @param status 변경할 상태
     * @return 수정된 행 수
     */
    @Update("UPDATE OnedayReservation SET reservation_status = #{status} " +
            "WHERE reservation_index = #{reservationIndex}")
    int updateReservationStatus(@Param("reservationIndex") int reservationIndex, @Param("status") String status);
    
    /**
     * 원데이 클래스 예약 정보에 네이버 캘린더 이벤트 ID를 저장하는 메서드
     * 
     * @param reservationIndex 예약 인덱스
     * @param calendarEventId 네이버 캘린더 이벤트 ID
     * @return 수정된 행 수
     */
    @Update("UPDATE OnedayReservation SET calendar_event_id = #{calendarEventId} " +
            "WHERE reservation_index = #{reservationIndex}")
    int updateCalendarEventId(@Param("reservationIndex") int reservationIndex, @Param("calendarEventId") String calendarEventId);
    
    /**
     * 예약 인덱스로 예약 정보를 조회하는 메서드
     * 
     * @param reservationIndex 예약 인덱스
     * @return 예약 정보
     */
    @Select("SELECT r.*, o.oneday_name, o.oneday_date, o.oneday_start, o.oneday_end, " +
            "o.oneday_location, o.oneday_info, m.name as member_name, m.email as member_email, m.tel as member_tel " +
            "FROM OnedayReservation r " +
            "JOIN Oneday o ON r.oneday_index = o.oneday_index " +
            "JOIN Member m ON r.member_id = m.id " +
            "WHERE r.reservation_index = #{reservationIndex}")
    OnedayReservationDTO getReservationByIndex(@Param("reservationIndex") int reservationIndex);
    
    /**
     * 회원 ID로 예약 목록을 조회하는 메서드
     * 
     * @param memberId 회원 ID
     * @return 예약 목록
     */
    @Select("SELECT r.*, o.oneday_name, o.oneday_date, o.oneday_start, o.oneday_end, " +
            "o.oneday_location, o.oneday_info " +
            "FROM OnedayReservation r " +
            "JOIN Oneday o ON r.oneday_index = o.oneday_index " +
            "WHERE r.member_id = #{memberId} " +
            "ORDER BY o.oneday_date DESC")
    List<OnedayReservationDTO> getReservationsByMemberId(@Param("memberId") String memberId);
    
    /**
     * 원데이 클래스 인덱스로 예약 목록을 조회하는 메서드
     * 
     * @param onedayIndex 원데이 클래스 인덱스
     * @return 예약 목록
     */
    @Select("SELECT r.*, m.name as member_name, m.email as member_email, m.tel as member_tel " +
            "FROM OnedayReservation r " +
            "JOIN Member m ON r.member_id = m.id " +
            "WHERE r.oneday_index = #{onedayIndex} " +
            "ORDER BY r.reservation_date")
    List<OnedayReservationDTO> getReservationsByOnedayIndex(@Param("onedayIndex") int onedayIndex);
    
    /**
     * 원데이 클래스의 현재 예약 인원을 조회하는 메서드
     * 
     * @param onedayIndex 원데이 클래스 인덱스
     * @return 현재 예약 인원
     */
    @Select("SELECT COALESCE(SUM(participant_count), 0) " +
            "FROM OnedayReservation " +
            "WHERE oneday_index = #{onedayIndex} " +
            "AND reservation_status != 'CANCELLED'")
    int getCurrentParticipantCount(@Param("onedayIndex") int onedayIndex);
    
    /**
     * 회원이 특정 원데이 클래스를 예약했는지 확인하는 메서드
     * 
     * @param onedayIndex 원데이 클래스 인덱스
     * @param memberId 회원 ID
     * @return 예약 정보 (없으면 null)
     */
    @Select("SELECT * FROM OnedayReservation " +
            "WHERE oneday_index = #{onedayIndex} " +
            "AND member_id = #{memberId} " +
            "AND reservation_status != 'CANCELLED'")
    OnedayReservationDTO checkReservationExists(@Param("onedayIndex") int onedayIndex, @Param("memberId") String memberId);
}
