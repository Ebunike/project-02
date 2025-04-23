package kr.co.soldesk.service;

import javax.servlet.http.HttpSession;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.NaverCalendarClient;

@Service
@PropertySource("/WEB-INF/properties/naver_calendar.properties")
public class NaverCalendarService {
    
    private static final Logger logger = LoggerFactory.getLogger(NaverCalendarService.class);
    private static final String TOKEN_SESSION_KEY = "${naver.calendar.session.key}";
    
    @Autowired
    private NaverCalendarClient naverCalendarClient;
    
    @Value("${naver.calendar.api.default_calendar_id}")
    private String defaultCalendarId;
    
    /**
     * 네이버 캘린더 인증 URL을 가져오는 메서드
     */
    public String getAuthorizationUrl() {
        return naverCalendarClient.getAuthorizationUrl();
    }
    
    /**
     * 인증 코드로 액세스 토큰을 요청하고 세션에 저장하는 메서드
     */
    public boolean getAccessToken(String code, HttpSession session) {
        try {
            String tokenResponse = naverCalendarClient.getAccessToken(code);
            logger.info("토큰 응답: {}", tokenResponse);
            
            JSONObject jsonResponse = new JSONObject(tokenResponse);
            
            if (jsonResponse.has("access_token")) {
                String accessToken = jsonResponse.getString("access_token");
                String refreshToken = jsonResponse.optString("refresh_token", null);
                
                // 토큰 저장
                session.setAttribute(TOKEN_SESSION_KEY, accessToken);
                
                // 리프레시 토큰도 있다면 저장
                if (refreshToken != null) {
                    session.setAttribute("naverCalendarRefreshToken", refreshToken);
                }
                
                // 토큰 유효성 검사는 선택적으로 수행
                boolean isTokenValid = naverCalendarClient.validateToken(accessToken);
                
                if (!isTokenValid) {
                    logger.warn("토큰 유효성 검증 실패");
                    // 필요하다면 추가 처리 (예: 리프레시 토큰으로 재발급 시도)
                }
                
                return true;
            } else {
                logger.error("액세스 토큰이 응답에 없습니다.");
                return false;
            }
        } catch (Exception e) {
            logger.error("토큰 처리 중 오류 발생", e);
            return false;
        }
    }
    
    /**
     * 세션에서 액세스 토큰을 가져오는 메서드
     */
    public String getAccessTokenFromSession(HttpSession session) { 
        return (String) session.getAttribute(TOKEN_SESSION_KEY);
    }
    
    /**
     * 세션에서 토큰 정보를 제거하는 메서드
     */
    public void removeTokenFromSession(HttpSession session) {
        session.removeAttribute(TOKEN_SESSION_KEY);
    }
    
    /**
     * 기본 캘린더 ID를 가져오는 메서드
     */
    public String getDefaultCalendarId() {
        return defaultCalendarId != null ? defaultCalendarId : "primary";
    }
    
    /**
     * 액세스 토큰의 유효성을 검사하는 메서드
     */
    public boolean isValidToken(String accessToken) {
        if (accessToken == null || accessToken.isEmpty()) {
            return false;
        }
        
        return naverCalendarClient.validateToken(accessToken);
    }
}
