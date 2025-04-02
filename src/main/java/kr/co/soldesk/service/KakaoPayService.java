package kr.co.soldesk.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import kr.co.soldesk.dto.KakaoPayApproveDTO;
import kr.co.soldesk.dto.KakaoPayReadyDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class KakaoPayService {
    
    private static final Logger logger = LoggerFactory.getLogger(KakaoPayService.class);
    
    // 카카오페이 API 호스트
    private static final String HOST = "https://open-api.kakaopay.com";
    
    // 테스트용 cid - 단건결제용
    private static final String CID = "TC0ONETIME";
    
    // 테스트 시크릿 키 - 개발자 사이트에서 발급받아야 함
    private String adminKey = "DEV1F1FFD8CAD2BDD0D068AEE560DEF8A6CB3531";
    
    public KakaoPayReadyDTO kakaoPayReady(String orderId, String itemName, int quantity, int totalAmount, int taxFreeAmount) {
        logger.info("카카오페이 결제 준비 - 주문ID: {}, 상품명: {}, 수량: {}, 금액: {}", orderId, itemName, quantity, totalAmount);
        
        RestTemplate restTemplate = new RestTemplate();
        
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "SECRET_KEY " + adminKey);
        headers.setContentType(MediaType.APPLICATION_JSON);
        
        logger.debug("Authorization 헤더: {}", headers.get("Authorization"));
        
        // JSON 요청 본문 생성
        Map<String, Object> requestBody = new HashMap<>();
        String partnerOrderId = (orderId != null && !orderId.isEmpty()) ? 
                               orderId : "PARTNER_ORDER_" + System.currentTimeMillis();
        String partnerUserId = "PARTNER_USER_" + System.currentTimeMillis();
        
        requestBody.put("cid", CID);
        requestBody.put("partner_order_id", partnerOrderId);
        requestBody.put("partner_user_id", partnerUserId);
        requestBody.put("item_name", itemName);
        requestBody.put("quantity", quantity);
        requestBody.put("total_amount", totalAmount);
        requestBody.put("tax_free_amount", taxFreeAmount);
        requestBody.put("approval_url", "http://localhost:9091/Project_hoon/payment/kakao/success");
        requestBody.put("cancel_url", "http://localhost:9091/Project_hoon/payment/kakao/cancel");
        requestBody.put("fail_url", "http://localhost:9091/Project_hoon/payment/kakao/fail");
        
        logger.debug("요청 본문: {}", requestBody);
        
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
        
        try {
            String url = HOST + "/online/v1/payment/ready";
            logger.debug("요청 URL: {}", url);
            
            KakaoPayReadyDTO response = restTemplate.postForObject(url, entity, KakaoPayReadyDTO.class);
            logger.info("카카오페이 결제 준비 성공 - TID: {}", response.getTid());
            
            // 세션에 저장할 정보 반환
            response.setPartnerOrderId(partnerOrderId);
            response.setPartnerUserId(partnerUserId);
            
            return response;
        } catch (Exception e) {
            logger.error("카카오페이 결제 준비 실패: {}", e.getMessage(), e);
            throw e;
        }
    }
    
    public KakaoPayApproveDTO kakaoPayApprove(String tid, String pgToken, String partnerOrderId, String partnerUserId) {
        logger.info("카카오페이 결제 승인 - TID: {}, PG Token: {}", tid, pgToken);
        
        RestTemplate restTemplate = new RestTemplate();
        
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "SECRET_KEY " + adminKey);
        headers.setContentType(MediaType.APPLICATION_JSON);
        
        // JSON 요청 본문 생성
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("cid", CID);
        requestBody.put("tid", tid);
        requestBody.put("partner_order_id", partnerOrderId);
        requestBody.put("partner_user_id", partnerUserId);
        requestBody.put("pg_token", pgToken);
        
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
        
        try {
            String url = HOST + "/online/v1/payment/approve";
            logger.debug("요청 URL: {}", url);
            
            KakaoPayApproveDTO response = restTemplate.postForObject(url, entity, KakaoPayApproveDTO.class);
            logger.info("카카오페이 결제 승인 성공 - 결제번호: {}", response.getAid());
            return response;
        } catch (Exception e) {
            logger.error("카카오페이 결제 승인 실패: {}", e.getMessage(), e);
            throw e;
        }
    }
    
    // KakaoPayService.java 메서드 수정
    public KakaoPayReadyDTO kakaoPayReady(String orderId, String itemName, int quantity, int totalAmount, int taxFreeAmount,
            String approvalUrl, String cancelUrl, String failUrl) {
        logger.info("카카오페이 결제 준비 - 주문ID: {}, 상품명: {}, 수량: {}, 금액: {}", orderId, itemName, quantity, totalAmount);
        
        RestTemplate restTemplate = new RestTemplate();
        
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "SECRET_KEY " + adminKey);
        headers.setContentType(MediaType.APPLICATION_JSON);
        
        logger.debug("Authorization 헤더: {}", headers.get("Authorization"));
        
        // JSON 요청 본문 생성
        Map<String, Object> requestBody = new HashMap<>();
        String partnerOrderId = (orderId != null && !orderId.isEmpty()) ? 
                               orderId : "PARTNER_ORDER_" + System.currentTimeMillis();
        String partnerUserId = "PARTNER_USER_" + System.currentTimeMillis();
        
        requestBody.put("cid", CID);
        requestBody.put("partner_order_id", partnerOrderId);
        requestBody.put("partner_user_id", partnerUserId);
        requestBody.put("item_name", itemName);
        requestBody.put("quantity", quantity);
        requestBody.put("total_amount", totalAmount);
        requestBody.put("tax_free_amount", taxFreeAmount);
        
        // 커스텀 URL 설정 (파라미터로 전달받은 URL 사용)
        requestBody.put("approval_url", approvalUrl);
        requestBody.put("cancel_url", cancelUrl);
        requestBody.put("fail_url", failUrl);
        
        logger.debug("요청 본문: {}", requestBody);
        
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
        
        try {
            String url = HOST + "/online/v1/payment/ready";
            logger.debug("요청 URL: {}", url);
            
            KakaoPayReadyDTO response = restTemplate.postForObject(url, entity, KakaoPayReadyDTO.class);
            logger.info("카카오페이 결제 준비 성공 - TID: {}", response.getTid());
            
            // 세션에 저장할 정보 반환
            response.setPartnerOrderId(partnerOrderId);
            response.setPartnerUserId(partnerUserId);
            
            return response;
        } catch (Exception e) {
            logger.error("카카오페이 결제 준비 실패: {}", e.getMessage(), e);
            throw e;
        }
    }
    
    // 결제 상태 조회
    public Object getPaymentInfo(String tid) {
        logger.info("카카오페이 결제 정보 조회 - TID: {}", tid);
        
        RestTemplate restTemplate = new RestTemplate();
        
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "SECRET_KEY " + adminKey);
        headers.setContentType(MediaType.APPLICATION_JSON);
        
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("cid", CID);
        requestBody.put("tid", tid);
        
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
        
        try {
            String url = HOST + "/online/v1/payment/order";
            logger.debug("요청 URL: {}", url);
            
            Object response = restTemplate.postForObject(url, entity, Object.class);
            logger.info("카카오페이 결제 정보 조회 성공");
            return response;
        } catch (Exception e) {
            logger.error("카카오페이 결제 정보 조회 실패: {}", e.getMessage(), e);
            throw e;
        }
    }
    
    // 결제 취소
    public Object cancelPayment(String tid, int cancelAmount, int cancelTaxFreeAmount) {
        logger.info("카카오페이 결제 취소 - TID: {}, 취소금액: {}", tid, cancelAmount);
        
        RestTemplate restTemplate = new RestTemplate();
        
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "SECRET_KEY " + adminKey);
        headers.setContentType(MediaType.APPLICATION_JSON);
        
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("cid", CID);
        requestBody.put("tid", tid);
        requestBody.put("cancel_amount", cancelAmount);
        requestBody.put("cancel_tax_free_amount", cancelTaxFreeAmount);
        
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
        
        try {
            String url = HOST + "/online/v1/payment/cancel";
            logger.debug("요청 URL: {}", url);
            
            Object response = restTemplate.postForObject(url, entity, Object.class);
            logger.info("카카오페이 결제 취소 성공");
            return response;
        } catch (Exception e) {
            logger.error("카카오페이 결제 취소 실패: {}", e.getMessage(), e);
            throw e;
        }
    }
}