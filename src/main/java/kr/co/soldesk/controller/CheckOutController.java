package kr.co.soldesk.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class CheckOutController {

	
	@PostMapping("/checkout")
	public ResponseEntity<String> checkout(@RequestBody String requestData) {
	    try {
	        // items 데이터 파싱
	    	// JSON 문자열을 Map으로 변환
	        ObjectMapper objectMapper = new ObjectMapper();
	        Map<String, Object> data = objectMapper.readValue(requestData, new TypeReference<Map<String, Object>>() {});

	        List<Map<String, Object>> items = (List<Map<String, Object>>) data.get("items");
	        int totalAmount = (int) data.get("totalAmount");

	        // 디버깅 로그
	        System.out.println("Received items:");
	        for (Map<String, Object> item : items) {
	            System.out.println("상품 인덱스: " + item.get("itemIndex"));
	            System.out.println("상품명: " + item.get("itemName"));
	            System.out.println("수량: " + item.get("quantity"));
	            System.out.println("개별 상품 합계: " + item.get("total"));
	        }

	        System.out.println("최종 합계 금액: " + totalAmount);

	        // 로직 처리 후 응답 반환
	        return ResponseEntity.ok("결제 처리 완료");
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("결제 처리 중 오류 발생");
	    }
	}



}