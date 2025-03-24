package kr.co.soldesk.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

import javax.annotation.Resource;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.SellerBean;
import kr.co.soldesk.service.MemberService;

@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    private MemberService memberService;

    @Resource(name = "naverInfo")
    private SellerBean sellerBean1;

    private final String CLIENT_ID = "_7r1lFqIcHDabyPs6PkX"; 
    private final String CLIENT_SECRET = "nMjyfsnSqk"; 
    private final String REDIRECT_URI = "http://localhost:9091/Project_hoon/login/naver"; 

    // 네이버 로그인
    @RequestMapping("/naver")
    public String naverLogin(@RequestParam("code") String code, @RequestParam("state") String state, Model model) {
        
        // 액세스 토큰 발급
        String accessToken = getAccessTokenFromNaver(code, state);
        
        if (accessToken == null) {
            model.addAttribute("error", "네이버 로그인 실패: 액세스 토큰을 발급받지 못했습니다.");
            return "login/error";  
        }

        // 사용자 정보 조회
        String userInfo = getUserInfoFromNaver(accessToken);

        if (userInfo == null) {
            model.addAttribute("error", "사용자 정보 조회 실패");
            return "login/error";  
        }

        try {
            JSONObject userJson = new JSONObject(userInfo);
            
            // 응답 JSON에서 email과 name만 추출
            JSONObject response = userJson.getJSONObject("response");
            String name = response.getString("name");
            String email = response.getString("email");

            // SellerBean에 email과 name만 세팅
            sellerBean1.setEmail(email);
            sellerBean1.setName(name);

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "사용자 정보 파싱 오류");
            return "login/error";  
        }

        // 로그인 후 처리 후 바로 리턴
        MemberBean member = memberService.naverLogin(sellerBean1.getEmail());

        if (member == null) {
            model.addAttribute("email", sellerBean1.getEmail());
            model.addAttribute("name", sellerBean1.getName());
            model.addAttribute("api", "api");  // api 값이 있을 경우에만 사용
            return "member/joinmain";  // 회원가입 페이지로 이동
        } else {
            memberService.login(member);  // 이미 회원이면 로그인
            return "member/login_success";  // 로그인 성공 페이지로 이동
        }
    }

    // 네이버에서 액세스 토큰을 발급받는 메서드
    private String getAccessTokenFromNaver(String code, String state) {
        String tokenUrl = "https://nid.naver.com/oauth2.0/token";
        String params = "grant_type=authorization_code&client_id=" + CLIENT_ID +
                        "&client_secret=" + CLIENT_SECRET +
                        "&code=" + code +
                        "&state=" + state +
                        "&redirect_uri=" + REDIRECT_URI;

        return getAccessToken(tokenUrl, params);
    }

    // 네이버 사용자 정보를 가져오는 메서드
    private String getUserInfoFromNaver(String accessToken) {
        String userInfoUrl = "https://openapi.naver.com/v1/nid/me";
        try {
            URL url = new URL(userInfoUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

            if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
                return null;
            }

            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }

            return response.toString();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // 공통적인 액세스 토큰 발급 메서드
    private String getAccessToken(String tokenUrl, String params) {
        try {
            URL url = new URL(tokenUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

            conn.getOutputStream().write(params.getBytes(StandardCharsets.UTF_8));

            if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
                return null;
            }

            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }

            JSONObject jsonResponse = new JSONObject(response.toString());
            return jsonResponse.getString("access_token");

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
