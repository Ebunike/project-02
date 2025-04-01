package kr.co.soldesk.service;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.NaverCalendarClient;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * 네이버 캘린더 API 연동을 관리하는 서비스 클래스
 */
@Service
public class NaverCalendarService {
    
    private static final Logger logger = LoggerFactory.getLogger(NaverCalendarService.class);
    
    @Autowired
    private NaverCalendarClient naverCalendarClient;
    
    @Value("naverCalendarToken")
    private String sessionKey;
    
    /**
     * 네이버 인증 URL을 반환하는 메서드
     * 
     * @return 네이버 인증 URL
     */
    public String getAuthorizationUrl() {
        return naverCalendarClient.getAuthorizationUrl();
    }
    
    /**
     * 인증 코드로 액세스 토큰을 획득하는 메서드
     * 
     * @param code 인증 코드
     * @param session HTTP 세션
     * @return 성공 여부
     */
    public boolean getAccessToken(String code, HttpSession session) {
        try {
            // 액세스 토큰 요청
            String response = naverCalendarClient.getAccessToken(code);
            
            // JSON 응답 파싱
            JSONObject jsonResponse = new JSONObject(response);
            
            if (jsonResponse.has("access_token")) {
                String accessToken = jsonResponse.getString("access_token");
                String refreshToken = jsonResponse.getString("refresh_token");
                String tokenType = jsonResponse.getString("token_type");
                long expiresIn = jsonResponse.getLong("expires_in");
                
                // 토큰 정보를 세션에 저장
                Map<String, Object> tokenInfo = new HashMap<>();
                tokenInfo.put("accessToken", accessToken);
                tokenInfo.put("refreshToken", refreshToken);
                tokenInfo.put("tokenType", tokenType);
                tokenInfo.put("expiresIn", expiresIn);
                tokenInfo.put("issuedAt", System.currentTimeMillis());
                
                session.setAttribute(sessionKey, tokenInfo);
                
                logger.info("네이버 캘린더 액세스 토큰 획득 성공");
                return true;
            } else {
                logger.error("네이버 캘린더 액세스 토큰 획득 실패: " + response);
                return false;
            }
        } catch (Exception e) {
            logger.error("네이버 캘린더 액세스 토큰 획득 중 오류 발생", e);
            return false;
        }
    }
    
    /**
     * 세션에서 액세스 토큰을 가져오는 메서드
     * 
     * @param session HTTP 세션
     * @return 액세스 토큰 (없으면 null)
     */
    public String getAccessTokenFromSession(HttpSession session) {
        @SuppressWarnings("unchecked")
        Map<String, Object> tokenInfo = (Map<String, Object>) session.getAttribute(sessionKey);
        
        if (tokenInfo != null && tokenInfo.containsKey("accessToken")) {
            // 토큰 만료 여부 확인
            long issuedAt = (long) tokenInfo.get("issuedAt");
            long expiresIn = (long) tokenInfo.get("expiresIn") * 1000; // 초 -> 밀리초
            long now = System.currentTimeMillis();
            
            if (now < issuedAt + expiresIn) {
                return (String) tokenInfo.get("accessToken");
            } else {
                logger.info("네이버 캘린더 액세스 토큰 만료됨");
                // TODO: 리프레시 토큰으로 액세스 토큰 갱신 로직 필요
                return null;
            }
        }
        
        return null;
    }
    
    /**
     * 세션에서 토큰 정보를 제거하는 메서드 (로그아웃)
     * 
     * @param session HTTP 세션
     */
    public void removeTokenFromSession(HttpSession session) {
        session.removeAttribute(sessionKey);
    }
    
    /**
     * 네이버 캘린더 캘린더 목록을 조회하는 메서드
     * 
     * @param accessToken 액세스 토큰
     * @return 캘린더 목록 (JSON 문자열)
     */
    public String getCalendars(String accessToken) {
        return naverCalendarClient.getCalendars(accessToken);
    }
}
