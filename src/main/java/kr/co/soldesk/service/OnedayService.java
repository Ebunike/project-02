package kr.co.soldesk.service;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.soldesk.beans.NaverCalendarClient;
import kr.co.soldesk.beans.NaverCalendarEventDTO;
import kr.co.soldesk.beans.OnedayDTO;
import kr.co.soldesk.mapper.MemberMapper;
import kr.co.soldesk.mapper.OnedayMapper;
import kr.co.soldesk.mapper.OnedayReservationMapper;
import kr.co.soldesk.repository.OnedayRepository;



/**
 * 원데이 클래스 관련 비즈니스 로직을 처리하는 서비스 클래스
 */
@Service
public class OnedayService {
    
    @Autowired
    private OnedayMapper onedayMapper;
    
    @Autowired
    private OnedayRepository onedayRepository;
    
    @Autowired
    private OnedayReservationMapper reservationMapper;
    
    @Autowired
    private MemberMapper memberMapper;
    
    @Autowired
    private NaverCalendarClient naverCalendarClient;
    
    @Value("primary")
    private String publicCalendarId;
    
    /**
     * 원데이 클래스를 등록하는 메서드
     * 
     * @param oneday 등록할 원데이 클래스 정보
     * @param sellerToken 판매자의 네이버 캘린더 액세스 토큰
     * @return 등록된 원데이 클래스 정보
     */
    @Transactional
    public OnedayDTO registerOneday(OnedayDTO oneday, String sellerToken) {
        // 원데이 클래스 정보 저장
        int result = onedayRepository.insertOneday(oneday);
        
        if (result > 0) {
            // 네이버 캘린더에 이벤트 등록
        	// 네이버 캘린더에 이벤트 등록
        	try {
        	    // 이벤트 제목
        	    String title = "[원데이 클래스] " + oneday.getOneday_name();
        	    
        	    // 내용 생성
        	    StringBuilder body = new StringBuilder();
        	    body.append("일시: ").append(formatDate(oneday.getOneday_date())).append(" ")
        	        .append(oneday.getOneday_start()).append(" ~ ").append(oneday.getOneday_end()).append("\n")
        	        .append("장소: ").append(oneday.getOneday_location()).append("\n")
        	        .append("수강료: ").append(oneday.getOneday_price()).append("원\n")
        	        .append("정원: ").append(oneday.getOneday_personnel()).append("명\n\n")
        	        .append(oneday.getOneday_info());
        	    
        	    // 시작 및 종료 시간 설정
        	    Calendar calendar = Calendar.getInstance();
        	    calendar.setTime(oneday.getOneday_date());
        	    
        	    // 시작 시간 설정
        	    String[] startTimeParts = oneday.getOneday_start().split(":");
        	    calendar.set(Calendar.HOUR_OF_DAY, Integer.parseInt(startTimeParts[0]));
        	    calendar.set(Calendar.MINUTE, Integer.parseInt(startTimeParts[1]));
        	    calendar.set(Calendar.SECOND, 0);
        	    Date startDateTime = calendar.getTime();
        	    
        	    // 종료 시간 설정
        	    String[] endTimeParts = oneday.getOneday_end().split(":");
        	    calendar.set(Calendar.HOUR_OF_DAY, Integer.parseInt(endTimeParts[0]));
        	    calendar.set(Calendar.MINUTE, Integer.parseInt(endTimeParts[1]));
        	    calendar.set(Calendar.SECOND, 0);
        	    Date endDateTime = calendar.getTime();
        	    
        	    // iCalendar 형식의 일정 생성
        	    String scheduleIcalString = createIcalString(
        	        title, 
        	        body.toString(), 
        	        oneday.getOneday_location(),
        	        startDateTime,
        	        endDateTime
        	    );
        	    
        	    // 네이버 캘린더에 이벤트 생성
        	    String eventId = naverCalendarClient.createCalendarEvent(
        	        sellerToken, 
        	        publicCalendarId, 
        	        scheduleIcalString
        	    );
        	    
        	    // TODO: 생성된 이벤트 ID를 원데이 클래스 테이블에 저장 (테이블 스키마 수정 필요)
        	    
        	    return oneday;
        	} catch (Exception e) {
        	    // 캘린더 이벤트 생성 실패 시에도 원데이 클래스 등록은 유지
        	    e.printStackTrace();
        	    return oneday;
        	}
        }
        
        return null;
    }
    
    /**
     * 원데이 클래스 정보를 조회하는 메서드
     * 
     * @param onedayIndex 원데이 클래스 인덱스
     * @return 원데이 클래스 정보
     */
    public OnedayDTO getOnedayByIndex(int onedayIndex) {
        OnedayDTO oneday = onedayMapper.getOnedayByIndex(onedayIndex);
        
        if (oneday != null) {
            // 예약 가능 여부 설정
            int currentParticipants = oneday.getCurrent_participants();
            boolean isAvailable = currentParticipants < oneday.getOneday_personnel();
            oneday.setAvailable(isAvailable);
        }
        
        return oneday;
    }
    
    /**
     * 판매자가 등록한 원데이 클래스 목록을 조회하는 메서드
     * 
     * @param sellerId 판매자 ID
     * @return 원데이 클래스 목록
     */
    public List<OnedayDTO> getOnedaysBySellerId(String sellerId) {
        // 판매자 인덱스 조회 
        
        int sellerIndex = memberMapper.getSellerIndex(sellerId);
        
        if (sellerIndex > 0) {
            List<OnedayDTO> onedayList = onedayMapper.getOnedaysBySellerIndex(sellerIndex);
            
            // 예약 가능 여부 설정
            for (OnedayDTO oneday : onedayList) {
                boolean isAvailable = oneday.getCurrent_participants() < oneday.getOneday_personnel();
                oneday.setAvailable(isAvailable);
            }
            
            return onedayList;
        }
        
        return null;
    }
    
    /**
     * 테마별 원데이 클래스 목록을 조회하는 메서드
     * 
     * @param themeIndex 테마 인덱스
     * @return 원데이 클래스 목록
     */
    public List<OnedayDTO> getOnedaysByThemeIndex(int themeIndex) {
        List<OnedayDTO> onedayList = onedayMapper.getOnedaysByThemeIndex(themeIndex);
        
        // 예약 가능 여부 설정
        for (OnedayDTO oneday : onedayList) {
            boolean isAvailable = oneday.getCurrent_participants() < oneday.getOneday_personnel();
            oneday.setAvailable(isAvailable);
        }
        
        return onedayList;
    }
    
    /**
     * 최근 등록된 원데이 클래스 목록을 조회하는 메서드
     * 
     * @param limit 조회할 개수
     * @return 원데이 클래스 목록
     */
    public List<OnedayDTO> getRecentOnedays(int limit) {
        List<OnedayDTO> onedayList = onedayMapper.getRecentOnedays(limit);
        
        if(onedayList.size() == 0) {
        	System.out.println("###############없어!!!!!!!1");
        } else {
        	System.out.println("##############있어!!!!!!!!!!!!!");
        }
                
        for(OnedayDTO oneday1 : onedayList) {
        	//System.out.println(oneday1.getCurrentParticipants());
        	System.out.println(oneday1.getSeller_name());
        }
        // 예약 가능 여부 설정
        for (OnedayDTO oneday : onedayList) {
            boolean isAvailable = (oneday.getCurrent_participants() < oneday.getOneday_personnel());
            oneday.setAvailable(isAvailable);
        }
        
        return onedayList;
    }
    
    /**
     * 키워드로 원데이 클래스를 검색하는 메서드
     * 
     * @param keyword 검색 키워드
     * @return 원데이 클래스 목록
     */
    public List<OnedayDTO> searchOnedays(String keyword) {
        List<OnedayDTO> onedayList = onedayMapper.searchOnedays(keyword);
        
        // 예약 가능 여부 설정
        for (OnedayDTO oneday : onedayList) {
            boolean isAvailable = oneday.getCurrent_participants() < oneday.getOneday_personnel();
            oneday.setAvailable(isAvailable);
        }
        
        return onedayList;
    }
    
    /**
     * 날짜를 문자열로 변환하는 메서드
     * 
     * @param date 변환할 날짜
     * @return 문자열로 변환된 날짜 (yyyy-MM-dd)
     */
    private String formatDate(Date date) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(date);
    }
    
    private String createIcalString(String title, String description, String location,
            Date startDateTime, Date endDateTime) throws Exception {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd'T'HHmmss");
			String uid = UUID.randomUUID().toString();
			
			return "BEGIN:VCALENDAR\n" +
			"VERSION:2.0\n" +
			"PRODID:Naver Calendar\n" +
			"CALSCALE:GREGORIAN\n" +
			"BEGIN:VTIMEZONE\n" +
			"TZID:Asia/Seoul\n" +
			"BEGIN:STANDARD\n" +
			"DTSTART:19700101T000000\n" +
			"TZNAME:GMT%2B09:00\n" +
			"TZOFFSETFROM:%2B0900\n" +
			"TZOFFSETTO:%2B0900\n" +
			"END:STANDARD\n" +
			"END:VTIMEZONE\n" +
			"BEGIN:VEVENT\n" +
			"SEQUENCE:0\n" +
			"CLASS:PUBLIC\n" +
			"TRANSP:OPAQUE\n" +
			"UID:" + uid + "\n" +
			"DTSTART;TZID=Asia/Seoul:" + sdf.format(startDateTime) + "\n" +
			"DTEND;TZID=Asia/Seoul:" + sdf.format(endDateTime) + "\n" +
			"SUMMARY:" + URLEncoder.encode(title, "UTF-8") + "\n" +
			"DESCRIPTION:" + URLEncoder.encode(description, "UTF-8") + "\n" +
			"LOCATION:" + URLEncoder.encode(location, "UTF-8") + "\n" +
			"CREATED:" + sdf.format(new Date()) + "Z\n" +
			"LAST-MODIFIED:" + sdf.format(new Date()) + "Z\n" +
			"DTSTAMP:" + sdf.format(new Date()) + "Z\n" +
			"END:VEVENT\n" +
			"END:VCALENDAR";
		}
}
