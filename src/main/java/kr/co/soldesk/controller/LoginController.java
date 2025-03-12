package kr.co.soldesk.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

import javax.annotation.Resource;
import javax.annotation.processing.SupportedSourceVersion;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.annotation.SessionScope;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.NaverBean;
import kr.co.soldesk.beans.SellerBean;
import kr.co.soldesk.service.MemberService;

import org.springframework.ui.Model;

@Controller
@RequestMapping("/login")
public class LoginController {

   @Autowired
   private MemberService memberService;
   
   @Resource(name="naverInfo")
   private SellerBean sellerBean1;
   
   
    private final String CLIENT_ID = "_7r1lFqIcHDabyPs6PkX"; 
    private final String CLIENT_SECRET = "nMjyfsnSqk"; 
    private final String REDIRECT_URI = "http://localhost:9091/pratice/login/naver"; 


    @RequestMapping("/naver")
    public String naverLogin(@RequestParam("code") String code, @RequestParam("state") String state,Model model) {
        
        String accessToken = getAccessToken(code, state);
        
        if (accessToken == null) {
            model.addAttribute("error", "네이버 로그인 실패: 액세스 토큰을 발급받지 못했습니다.");
            return "login/error";  
        }

        String userInfo = getUserInfo(accessToken);

        if (userInfo == null) {
            model.addAttribute("error", "사용자 정보 조회 실패");
            return "login/error";  
        }

        try {
            JSONObject userJson = new JSONObject(userInfo);
            
            JSONObject response = userJson.getJSONObject("response");
            System.out.println(response);
            
               String id = response.getString("id");
                String name = response.getString("name");
                String email = response.getString("email");
                String mobile = response.getString("mobile");
                String birthyear = response.optString("birthyear","출생년도x");
                String birthday = response.optString("birthday","생일x");
                String gender = response.getString("gender");
                int age = response.optInt("age",0);
               
                System.out.println(email);
                System.out.println(birthday);
                sellerBean1.setAge(age);
                sellerBean1.setBirthday(birthday);
                sellerBean1.setBirthyear(birthyear);
                sellerBean1.setEmail(email);
                sellerBean1.setGender(gender);
                sellerBean1.setId(id);
                sellerBean1.setName(name);
                sellerBean1.setTel(mobile);
                
               
                
               
            
            } catch (Exception e) {
                e.printStackTrace();
                model.addAttribute("error", "사용자 정보 파싱 오류");
                return "login/error";  
            }
           return "redirect:/login/naver_join";
           
               
            
            
            
    }

    private String getAccessToken(String code, String state) {
        String tokenUrl = "https://nid.naver.com/oauth2.0/token";
        String params = "grant_type=authorization_code&client_id=" + CLIENT_ID +
                        "&client_secret=" + CLIENT_SECRET +
                        "&code=" + code +
                        "&state=" + state +
                        "&redirect_uri=" + REDIRECT_URI;

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

    
    private String getUserInfo(String accessToken) {
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

            System.out.println("응답 내용: " + response.toString());
            return response.toString();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    @RequestMapping("naver_join")
    public String naverjoin(@ModelAttribute("sellerBean") SellerBean sellerBean,@ModelAttribute("LoginUser") MemberBean memberBean) {
       if(sellerBean1.getGender().equals("M")) {
          sellerBean1.setGender("남성");
       }else if(sellerBean1.getGender().equals("F")) {
          sellerBean1.setGender("여성");
       }
       MemberBean member = memberService.naverLogin(sellerBean1.getEmail());
       if(member==null) {
          sellerBean.setName(sellerBean1.getName());
           sellerBean.setAge(sellerBean1.getAge());
           sellerBean.setBirthday(sellerBean1.getBirthday());
           sellerBean.setBirthyear(sellerBean1.getBirthyear());
           sellerBean.setEmail(sellerBean1.getEmail());
           sellerBean.setGender(sellerBean1.getGender());
           sellerBean.setTel(sellerBean1.getTel());
           
           System.out.println(sellerBean.getName());
           return "login/naver_join";
       }else {
          memberBean.setName(sellerBean1.getName());
          memberBean.setAge(sellerBean1.getAge());
          memberBean.setBirthday(sellerBean1.getBirthday());
          memberBean.setBirthyear(sellerBean1.getBirthyear());
          memberBean.setEmail(sellerBean1.getEmail());
          memberBean.setGender(sellerBean1.getGender());
          memberBean.setTel(sellerBean1.getTel());
          member = memberService.naverLogin(memberBean.getEmail());
          memberService.login(member);
          
          return "member/login_success";
       }
       
    }
    

}
