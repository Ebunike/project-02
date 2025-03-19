package kr.co.soldesk.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.SellerBean;
import kr.co.soldesk.service.MemberService;

@Controller
@RequestMapping("/login")
public class GoogleLoginController {

    @Autowired
    private SellerBean sellerBean1;
    
    @Autowired
    private MemberService memberService;

    private final String CLIENT_ID = "698222345372-4bdaro205t56cs6r3lfvq1ia8u0lsvr8.apps.googleusercontent.com"; 
    private final String CLIENT_SECRET = "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"; 
    private final String REDIRECT_URI = "http://localhost:9091/Project_hoon/login/google"; 

    // 구글 로그인 후 액세스 토큰을 가져오는 메서드
    @RequestMapping("/google")
    public String googleLogin(@RequestParam("code") String code, Model model) {

        String accessToken = getAccessToken(code);
        
        if (accessToken == null) {
            model.addAttribute("error", "구글 로그인 실패: 액세스 토큰을 발급받지 못했습니다.");
            return "login/error";  
        }

        String userInfo = getUserInfo(accessToken);

        if (userInfo == null) {
            model.addAttribute("error", "사용자 정보 조회 실패");
            return "login/error";  
        }

        try {
            JSONObject userJson = new JSONObject(userInfo);
            

            String name = userJson.getString("name");
            String email = userJson.getString("email");

           
            sellerBean1.setName(name);
            sellerBean1.setEmail(email);
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "사용자 정보 파싱 오류");
            return "login/error";  
        }

        MemberBean member = memberService.naverLogin(sellerBean1.getEmail());
		if(member == null) {
			model.addAttribute("email", sellerBean1.getEmail());
			model.addAttribute("name", sellerBean1.getName());
			return "member/joinmain";
		}else {
			memberService.login(member);
			return "member/login_success";
		}
    }

    // 액세스 토큰을 발급받는 메서드
    private String getAccessToken(String code) {
        String tokenUrl = "https://oauth2.googleapis.com/token";
        String params = "code=" + code +
                        "&client_id=" + CLIENT_ID +
                        "&client_secret=" + CLIENT_SECRET +
                        "&redirect_uri=" + REDIRECT_URI +
                        "&grant_type=authorization_code";

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

    // 사용자 정보를 가져오는 메서드
    private String getUserInfo(String accessToken) {
        String userInfoUrl = "https://www.googleapis.com/oauth2/v3/userinfo";
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
            System.out.println(response.toString());
            return response.toString();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
       
    }
