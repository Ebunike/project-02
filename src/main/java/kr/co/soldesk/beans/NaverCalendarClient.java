package kr.co.soldesk.beans;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

/**
 * 네이버 캘린더 API와 통신하기 위한 클라이언트 유틸리티 클래스
 */
@Component
@PropertySource("/WEB-INF/properties/naver_calendar.properties")
public class NaverCalendarClient {
    
    private static final Logger logger = LoggerFactory.getLogger(NaverCalendarClient.class);
    private static final String DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss";
    
    @Value("${naver.calendar.api.url}")
    private String apiUrl;
    
    @Value("${naver.calendar.api.client_id}")
    private String clientId;
    
    @Value("${naver.calendar.api.client_secret}")
    private String clientSecret;
    
    @Value("${naver.calendar.api.redirect_uri}")
    private String redirectUri;
    
    /**
     * OAuth 인증 URL을 생성하는 메서드
     * 
     * @return 네이버 OAuth 인증 URL
     */
    public String getAuthorizationUrl() {
        return "https://nid.naver.com/oauth2.0/authorize"
                + "?response_type=code"
                + "&client_id=" + clientId
                + "&redirect_uri=" + redirectUri
                + "&state=STATE_STRING";
    }
    
    /**
     * 인증 코드로 액세스 토큰을 요청하는 메서드
     * 
     * @param code 인증 코드
     * @return JSON 형태의 응답 (액세스 토큰 포함)
     */
    public String getAccessToken(String code) {
        HttpURLConnection conn = null;
        StringBuilder response = new StringBuilder();
        
        try {
            URL url = new URL("https://nid.naver.com/oauth2.0/token");
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setDoOutput(true);
            
            String params = "grant_type=authorization_code"
                    + "&client_id=" + clientId
                    + "&client_secret=" + clientSecret
                    + "&redirect_uri=" + redirectUri
                    + "&code=" + code
                    + "&state=STATE_STRING";
            
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = params.getBytes("utf-8");
                os.write(input, 0, input.length);
            }
            
            int responseCode = conn.getResponseCode();
            logger.info("네이버 토큰 요청 응답 코드: " + responseCode);
            
            try (BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), "utf-8"))) {
                String line;
                while ((line = br.readLine()) != null) {
                    response.append(line);
                }
            }
            
            logger.info("네이버 토큰 요청 응답: " + response.toString());
            
        } catch (Exception e) {
            logger.error("네이버 토큰 요청 중 오류 발생", e);
            throw new RuntimeException("네이버 토큰 요청 중 오류가 발생했습니다.", e);
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
        
        return response.toString();
    }
    
    /**
     * 액세스 토큰으로 캘린더 이벤트를 생성하는 메서드
     * 
     * @param accessToken 액세스 토큰
     * @param event 생성할 이벤트 정보
     * @return 생성된 이벤트 ID
     */
    public String createCalendarEvent(String accessToken, String calendarId, String scheduleIcalString) {
        HttpURLConnection conn = null;
        StringBuilder response = new StringBuilder();
        
        try {
            URL url = new URL("https://openapi.naver.com/calendar/createSchedule.json");
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);
            conn.setDoOutput(true);
            
            // 요청 데이터 준비
            String postParams = "calendarId=" + calendarId + "&scheduleIcalString=" + URLEncoder.encode(scheduleIcalString, "UTF-8");
            
            // 데이터 전송
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = postParams.getBytes("utf-8");
                os.write(input, 0, input.length);
            }
            
            // 응답 받기
            int responseCode = conn.getResponseCode();
            logger.info("네이버 캘린더 이벤트 생성 응답 코드: " + responseCode);
            
            BufferedReader br;
            if (responseCode >= 200 && responseCode < 300) {
                br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
            } else {
                br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "utf-8"));
            }
            
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
            br.close();
            
            logger.info("네이버 캘린더 이벤트 생성 응답: " + response.toString());
            
            if (responseCode >= 200 && responseCode < 300) {
                JSONObject jsonResponse = new JSONObject(response.toString());
                // 응답에서 일정 ID 추출
                return jsonResponse.optString("id", UUID.randomUUID().toString());
            } else {
                throw new RuntimeException("네이버 캘린더 이벤트 생성 실패: " + response.toString());
            }
            
	        } catch (Exception e) {
	            logger.error("네이버 캘린더 이벤트 생성 중 오류 발생", e);
	            throw new RuntimeException("네이버 캘린더 이벤트 생성 중 오류가 발생했습니다.", e);
	        } finally {
	            if (conn != null) {
	                conn.disconnect();
	            }
	        }
    }
    
    /**
     * 액세스 토큰으로 캘린더 이벤트를 삭제하는 메서드
     * 
     * @param accessToken 액세스 토큰
     * @param calendarId 캘린더 ID
     * @param eventId 삭제할 이벤트 ID
     * @return 성공 여부
     */
    public boolean deleteCalendarEvent(String accessToken, String calendarId, String eventId) {
        HttpURLConnection conn = null;
        
        try {
            URL url = new URL("https://openapi.naver.com/calendar/deleteSchedule.json");
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);
            conn.setDoOutput(true);
            
            // 요청 데이터 준비
            String postParams = "calendarId=" + calendarId + "&scheduleId=" + eventId;
            
            // 데이터 전송
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = postParams.getBytes("utf-8");
                os.write(input, 0, input.length);
            }
            
            // 응답 받기
            int responseCode = conn.getResponseCode();
            logger.info("네이버 캘린더 이벤트 삭제 응답 코드: " + responseCode);
            
            return responseCode >= 200 && responseCode < 300;
            
        } catch (Exception e) {
            logger.error("네이버 캘린더 이벤트 삭제 중 오류 발생", e);
            throw new RuntimeException("네이버 캘린더 이벤트 삭제 중 오류가 발생했습니다.", e);
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }
    
    /**
     * 액세스 토큰으로 캘린더 이벤트를 수정하는 메서드
     * 
     * @param accessToken 액세스 토큰
     * @param event 수정할 이벤트 정보
     * @return 성공 여부
     */
    public boolean updateCalendarEvent(String accessToken, NaverCalendarEventDTO event) {
        HttpURLConnection conn = null;
        
        try {
            URL url = new URL(apiUrl + "/v1/calendars/" + event.getCalendarId() + "/events/" + event.getEventId());
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("PUT");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);
            conn.setDoOutput(true);
            
            // 날짜 포맷 변환
            SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
            String startDateTime = sdf.format(event.getStartDateTime());
            String endDateTime = sdf.format(event.getEndDateTime());
            
            // 요청 데이터 준비
            JSONObject requestData = new JSONObject();
            requestData.put("title", event.getTitle());
            requestData.put("body", event.getBody());
            requestData.put("startDateTime", startDateTime);
            requestData.put("endDateTime", endDateTime);
            requestData.put("location", event.getLocation());
            requestData.put("timeZone", event.getTimeZone());
            requestData.put("isAllDay", event.isAllDay());
            
            if (event.getColor() != null) {
                requestData.put("color", event.getColor());
            }
            
            requestData.put("accessType", event.getAccessType());
            
            // 데이터 전송
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = requestData.toString().getBytes("utf-8");
                os.write(input, 0, input.length);
            }
            
            // 응답 받기
            int responseCode = conn.getResponseCode();
            logger.info("네이버 캘린더 이벤트 수정 응답 코드: " + responseCode);
            
            return responseCode >= 200 && responseCode < 300;
            
        } catch (Exception e) {
            logger.error("네이버 캘린더 이벤트 수정 중 오류 발생", e);
            throw new RuntimeException("네이버 캘린더 이벤트 수정 중 오류가 발생했습니다.", e);
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }
    
    /**
     * 액세스 토큰으로 캘린더 목록을 조회하는 메서드
     * 
     * @param accessToken 액세스 토큰
     * @return JSON 형태의 응답 (캘린더 목록)
     */
    public String getCalendars(String accessToken) {
        HttpURLConnection conn = null;
        StringBuilder response = new StringBuilder();
        
        try {
            URL url = new URL(apiUrl + "/v1/calendars");
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);
            
            // 응답 받기
            int responseCode = conn.getResponseCode();
            logger.info("네이버 캘린더 목록 조회 응답 코드: " + responseCode);
            
            try (BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), "utf-8"))) {
                String line;
                while ((line = br.readLine()) != null) {
                    response.append(line);
                }
            }
            
            logger.info("네이버 캘린더 목록 조회 응답: " + response.toString());
            
            return response.toString();
            
        } catch (Exception e) {
            logger.error("네이버 캘린더 목록 조회 중 오류 발생", e);
            throw new RuntimeException("네이버 캘린더 목록 조회 중 오류가 발생했습니다.", e);
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }
}
