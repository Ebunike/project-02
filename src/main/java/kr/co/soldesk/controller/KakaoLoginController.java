package kr.co.soldesk.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.co.soldesk.beans.KakaoLoginBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.SellerBean;
import kr.co.soldesk.service.MemberService;

@Controller
@RequestMapping("/login")
public class KakaoLoginController {
	private static final Logger log = LoggerFactory.getLogger(KakaoLoginBean.class);
	
	@Autowired
	private SellerBean sellerBean1;
	
	@Autowired
	private MemberService memberService;
	
	private final String kakaoApiKey = "9a17de118b1675247f3cd0e91ab90456";
	private final String kakaoRedirectUri = "http://localhost:9091/Project_hoon/login/kakao";
	
	@RequestMapping("/kakao")
	public String kakaoLogin(@RequestParam("code") String code, Model model) {
		String accessToken = getAccessToken(code);
		
		if(accessToken == null) {
			model.addAttribute("error", "카카오 로그인 실패: 액세스 토큰을 발급하지 못했습니다.");
			return "login/error";
		}
		
		Map<String, Object> userInfo = getUserInfo(accessToken);
		
		if(userInfo == null) {
			model.addAttribute("error", "사용자 정보 조회 실패");
			return "login/error";
		}
		
		String name = (String)userInfo.get("name");
		String email = (String)userInfo.get("email");
		
		sellerBean1.setName(name);
		sellerBean1.setEmail(email);
		
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
	
	

	public String getAccessToken(String code) {
		String accessToken ="";
		String refreshToken = "";
		String reqUrl = "https://kauth.kakao.com/oauth/token";
		
		try {
			URL url = new URL(reqUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true);
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=").append(kakaoApiKey);
			sb.append("&redirect_uri=").append(kakaoRedirectUri);
			sb.append("&code=").append(code);
			
			bw.write(sb.toString());
			bw.flush();
			
			int responseCode = conn.getResponseCode();
			log.info("[KakaoApi.getAccessToken] responseCode = {}", responseCode);
			
			BufferedReader br;
			if(responseCode >= 200 && responseCode < 300) {
				br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
			
			String line = "";
	        StringBuilder responseSb = new StringBuilder();
	        while((line = br.readLine()) != null){
	            responseSb.append(line);
	        }
	        String result = responseSb.toString();
	        log.info("responseBody = {}", result);

	        JsonParser parser = new JsonParser();
	        JsonElement element = parser.parse(result);
	        accessToken = element.getAsJsonObject().get("access_token").getAsString();
	        refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();

	        br.close();
	        bw.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return accessToken;
	}
	
	public HashMap<String, Object> getUserInfo(String accessToken) {
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		String reqUrl = "https://kapi.kakao.com/v2/user/me";
		try {
			 URL url  = new URL(reqUrl);
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setRequestMethod("POST");
		        conn.setRequestProperty("Authorization", "Bearer " + accessToken);
		        conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		        int responseCode = conn.getResponseCode();
		        log.info("[KakaoApi.getUserInfo] responseCode : {}",  responseCode);

		        BufferedReader br;
		        if (responseCode >= 200 && responseCode <= 300) {
		            br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		        } else {
		            br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		        }

		        String line = "";
		        StringBuilder responseSb = new StringBuilder();
		        while((line = br.readLine()) != null){
		            responseSb.append(line);
		        }
		        String result = responseSb.toString();
		        log.info("responseBody = {}", result);

		        JsonParser parser = new JsonParser();
		        JsonElement element = parser.parse(result);

		        //JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
		        JsonObject kakaoAccount = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
		        
				
				String birthday = Optional.ofNullable(kakaoAccount.getAsJsonObject().get("birthday"))
									.map(JsonElement::getAsString) .orElse("생일x"); 
				String age_range = Optional.ofNullable(kakaoAccount.getAsJsonObject().get("age_range"))
									.map(JsonElement::getAsString).orElse("연령대x");
				 
		        //String nickname = properties.getAsJsonObject().get("nickname").getAsString();
		        String email = kakaoAccount.getAsJsonObject().get("email").getAsString();
		        String name = kakaoAccount.getAsJsonObject().get("name").getAsString();
				/*
				 * String gender = kakaoAccount.getAsJsonObject().get("gender").getAsString();
				 * String number =
				 * kakaoAccount.getAsJsonObject().get("phone_number").getAsString(); String
				 * birthyear = kakaoAccount.getAsJsonObject().get("birthyear").getAsString();
				 */
		        //String birthday = kakaoAccount.getAsJsonObject().get("birthday").getAsString();
		        //String age_range = kakaoAccount.getAsJsonObject().get("age_range").getAsString();
		        //userInfo.put("nickname", nickname);
		        userInfo.put("email", email);
		        userInfo.put("name", name);
				/*
				 * userInfo.put("gender", gender); userInfo.put("phone_number", number);
				 * userInfo.put("birthyear", birthyear); userInfo.put("birthday", birthday);
				 * userInfo.put("age_range", age_range); userInfo.put(accessToken, number);
				 */
		        
		        br.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userInfo;
	}
	
	public void kakaoLogout(String accessToken) {
			String reqUrl = "https://kapi.kakao.com/v1/user/logout";
	 
		    try{
		        URL url = new URL(reqUrl);
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setRequestMethod("POST");
		        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

		        int responseCode = conn.getResponseCode();
		        log.info("[KakaoApi.kakaoLogout] responseCode : {}",  responseCode);

		        BufferedReader br;
		        if (responseCode >= 200 && responseCode <= 300) {
		            br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		        } else {
		            br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		        }

		        String line = "";
		        StringBuilder responseSb = new StringBuilder();
		        while((line = br.readLine()) != null){
		            responseSb.append(line);
		        }
		        String result = responseSb.toString();
		        log.info("kakao logout - responseBody = {}", result);
		    } catch (Exception e) {
		    	e.printStackTrace();
		    }
	}
}
