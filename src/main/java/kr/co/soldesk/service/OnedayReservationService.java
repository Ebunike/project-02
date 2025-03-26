package kr.co.soldesk.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.NaverCalendarClient;
import kr.co.soldesk.beans.NaverCalendarEventDTO;
import kr.co.soldesk.beans.OnedayDTO;
import kr.co.soldesk.beans.OnedayReservationDTO;
import kr.co.soldesk.mapper.OnedayMapper;
import kr.co.soldesk.mapper.OnedayReservationMapper;


/**
 * 원데이 클래스 예약 관련 비즈니스 로직을 처리하는 서비스 클래스
 */
@Service
public class OnedayReservationService {
    
	@Resource(name = "loginMemberBean")
	private MemberBean member;
	
    @Autowired
    private OnedayMapper onedayMapper;
    
    @Autowired
    private OnedayReservationMapper reservationMapper;
    
    @Autowired
    private NaverCalendarClient naverCalendarClient;
    
    /**
     * 원데이 클래스를 예약하는 메서드
     * 
     * @param reservation 예약 정보
     * @param member 회원 정보
     * @param userToken 회원의 네이버 캘린더 액세스 토큰
     * @return 예약 정보
     */
    @Transactional
    public OnedayReservationDTO reserveOneday(OnedayReservationDTO reservation, String userToken) {
        // 원데이 클래스 정보 조회
        OnedayDTO oneday = onedayMapper.getOnedayByIndex(reservation.getOneday_index());
        
        if (oneday == null) {
            throw new RuntimeException("존재하지 않는 원데이 클래스입니다.");
        }
        
        // 예약 가능 여부 확인
        int currentParticipants = reservationMapper.getCurrentParticipantCount(oneday.getOneday_index());
        if (currentParticipants + reservation.getParticipant_count() > oneday.getOneday_personnel()) {
            throw new RuntimeException("정원이 초과되어 예약할 수 없습니다.");
        }
        
        // 이미 예약한 경우 확인
        OnedayReservationDTO existingReservation = reservationMapper.checkReservationExists(  
                oneday.getOneday_index(), member.getId());
        if (existingReservation != null) {
            throw new RuntimeException("이미 예약한 클래스입니다.");
        }
        
        // 예약 정보 설정
        reservation.setMember_id(member.getId());
        reservation.setReservation_status("CONFIRMED");
        
        // 네이버 캘린더에 이벤트 등록
        String calendarEventId = null;
        try {
            // 이벤트 정보 세팅
            NaverCalendarEventDTO event = new NaverCalendarEventDTO();
            event.setCalendarId("primary");  // 기본 캘린더
            event.setTitle("[원데이 클래스 예약] " + oneday.getOneday_name());
            
            // 내용 생성
            StringBuilder body = new StringBuilder();
            body.append("일시: ").append(formatDate(oneday.getOneday_date())).append(" ")
                .append(oneday.getOneday_start()).append(" ~ ").append(oneday.getOneday_end()).append("\n")
                .append("장소: ").append(oneday.getOneday_location()).append("\n")
                .append("수강료: ").append(oneday.getOneday_price()).append("원\n")
                .append("예약 인원: ").append(reservation.getParticipant_count()).append("명\n\n")
                .append(oneday.getOneday_info());
            
            event.setBody(body.toString());
            
            // 시작 및 종료 시간 설정
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(oneday.getOneday_date());
            
            // 시작 시간 설정
            String[] startTimeParts = oneday.getOneday_start().split(":");
            calendar.set(Calendar.HOUR_OF_DAY, Integer.parseInt(startTimeParts[0]));
            calendar.set(Calendar.MINUTE, Integer.parseInt(startTimeParts[1]));
            calendar.set(Calendar.SECOND, 0);
            event.setStartDateTime(calendar.getTime());
            
            // 종료 시간 설정
            String[] endTimeParts = oneday.getOneday_end().split(":");
            calendar.set(Calendar.HOUR_OF_DAY, Integer.parseInt(endTimeParts[0]));
            calendar.set(Calendar.MINUTE, Integer.parseInt(endTimeParts[1]));
            calendar.set(Calendar.SECOND, 0);
            event.setEndDateTime(calendar.getTime());
            
            event.setLocation(oneday.getOneday_location());
            event.setColor("#FF9F60");  // 예약 색상 (주황색)
            
            // 네이버 캘린더에 이벤트 생성
            calendarEventId = naverCalendarClient.createCalendarEvent(userToken, event);
            
            // 생성된 이벤트 ID 저장
            reservation.setCalendar_event_id(calendarEventId);
            
        } catch (Exception e) {
            // 캘린더 이벤트 생성 실패 시에도 예약은 진행
            e.printStackTrace();
        }
        
        // 예약 정보 저장
        int result = reservationMapper.insertReservation(reservation);
        
        if (result > 0) {
            return reservation;
        } else {
            // 예약 실패 시 생성된 캘린더 이벤트 삭제
            if (calendarEventId != null) {
                try {
                    naverCalendarClient.deleteCalendarEvent(userToken, "primary", calendarEventId);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            
            throw new RuntimeException("예약 등록에 실패했습니다.");
        }
    }
    
    /**
     * 원데이 클래스 예약을 취소하는 메서드
     * 
     * @param reservationIndex 예약 인덱스
     * @param memberId 회원 ID
     * @param userToken 회원의 네이버 캘린더 액세스 토큰
     * @return 성공 여부
     */
    @Transactional
    public boolean cancelReservation(int reservationIndex, String memberId, String userToken) {
        // 예약 정보 조회
        OnedayReservationDTO reservation = reservationMapper.getReservationByIndex(reservationIndex);
        
        // 예약 정보 확인
        if (reservation == null) {
            throw new RuntimeException("존재하지 않는 예약입니다.");
        }
        
        // 예약자 확인
        if (!reservation.getMember_id().equals(memberId)) {
            throw new RuntimeException("예약 취소 권한이 없습니다.");
        }
        
        // 이미 취소된 예약인지 확인
        if ("CANCELLED".equals(reservation.getReservation_status())) {
            throw new RuntimeException("이미 취소된 예약입니다.");
        }
        
        // 예약 상태 변경
        int result = reservationMapper.updateReservationStatus(reservationIndex, "CANCELLED");
        
        if (result > 0) {
            // 네이버 캘린더 이벤트 삭제
            if (reservation.getCalendar_event_id() != null) {
                try {
                    naverCalendarClient.deleteCalendarEvent(userToken, "primary", reservation.getCalendar_event_id());
                } catch (Exception e) {
                    // 캘린더 이벤트 삭제 실패 시에도 예약 취소는 진행
                    e.printStackTrace();
                }
            }
            
            return true;
        }
        
        return false;
    }
    

/**
 * 예약 상태를 업데이트하는 메서드
 * 
 * @param reservationIndex 예약 인덱스
 * @param status 변경할 상태
 * @return 성공 여부
 */
    public boolean updateReservationStatus(int reservationIndex, String status) {
    // 예약 정보 조회
	    OnedayReservationDTO reservation = reservationMapper.getReservationByIndex(reservationIndex);
	    
	    // 예약 정보 확인
	    if (reservation == null) {
	        return false;
	    }
	    
	    // 이미 취소된 예약인 경우, 상태가 다르면 업데이트
	    if ("CANCELLED".equals(reservation.getReservation_status()) && !status.equals(reservation.getReservation_status())) {
	        return false;
	    }
	    
	    // 예약 상태 변경
	    int result = reservationMapper.updateReservationStatus(reservationIndex, status);
    
	    return result > 0;
   }
    
    /**
     * 회원 ID로 예약 목록을 조회하는 메서드
     * 
     * @param memberId 회원 ID
     * @return 예약 목록
     */
    public List<OnedayReservationDTO> getReservationsByMemberId(String memberId) {
        return reservationMapper.getReservationsByMemberId(memberId);
    }
    
    /**
     * 원데이 클래스 인덱스로 예약 목록을 조회하는 메서드
     * 
     * @param onedayIndex 원데이 클래스 인덱스
     * @return 예약 목록
     */
    public List<OnedayReservationDTO> getReservationsByOnedayIndex(int onedayIndex) {
        return reservationMapper.getReservationsByOnedayIndex(onedayIndex);
    }
    
    /**
     * 예약 정보를 조회하는 메서드
     * 
     * @param reservationIndex 예약 인덱스
     * @return 예약 정보
     */
    public OnedayReservationDTO getReservationByIndex(int reservationIndex) {
        return reservationMapper.getReservationByIndex(reservationIndex);
    }
    
    /**
     * 날짜를 문자열로 변환하는 메서드
     * 
     * @param date 변환할 날짜
     * @return 문자열로 변환된 날짜 (yyyy-MM-dd)
     */
    private String formatDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(date);
    }
}