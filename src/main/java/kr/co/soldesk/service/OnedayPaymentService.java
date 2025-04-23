package kr.co.soldesk.service;

import java.net.URLEncoder;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.soldesk.beans.OnedayDTO;
import kr.co.soldesk.beans.OnedayReservationDTO;
import kr.co.soldesk.beans.PaymentBean;
import kr.co.soldesk.dto.KakaoPayApproveDTO;
import kr.co.soldesk.dto.KakaoPayReadyDTO;
import kr.co.soldesk.mapper.OnedayMapper;
import kr.co.soldesk.mapper.PaymentMapper;

@Service
public class OnedayPaymentService {

    private static final Logger logger = LoggerFactory.getLogger(OnedayPaymentService.class);

    @Autowired
    private KakaoPayService kakaoPayService;

    @Autowired
    private OnedayReservationService reservationService;

    @Autowired
    private OnedayMapper onedayMapper;

    @Autowired
    private PaymentMapper paymentMapper;

    /**
     * 카카오페이 결제 준비
     */
    public KakaoPayReadyDTO prepareKakaoPayment(OnedayDTO onedayDTO, OnedayReservationDTO reservationDTO, HttpSession session) {
        try {
            logger.info("카카오페이 결제 준비 - 클래스: {}, 예약자: {}", onedayDTO.getOneday_name(), reservationDTO.getMember_id());
            
            String orderId = "OD" + UUID.randomUUID().toString().substring(0, 10);
            int totalAmount = onedayDTO.getOneday_price() * reservationDTO.getParticipant_count();
            String itemName = onedayDTO.getOneday_name() + " 원데이 클래스";
            
            // 성공 URL에 파라미터 추가
            String successUrl = "http://localhost:9091/Project_hoon/oneday/payment/kakaopay/success";
            successUrl += "?onedayIndex=" + onedayDTO.getOneday_index();
            successUrl += "&count=" + reservationDTO.getParticipant_count();
            if (reservationDTO.getSpecial_requests() != null && !reservationDTO.getSpecial_requests().isEmpty()) {
                successUrl += "&specialRequests=" + URLEncoder.encode(reservationDTO.getSpecial_requests(), "UTF-8");
            }
            
            String cancelUrl = "http://localhost:9091/Project_hoon/oneday/payment/kakaopay/cancel";
            String failUrl = "http://localhost:9091/Project_hoon/oneday/payment/kakaopay/fail";
            
            // 카카오페이 서비스 호출 시 수정된 URL 전달
            KakaoPayReadyDTO response = kakaoPayService.kakaoPayReady(
                    orderId, 
                    itemName, 
                    reservationDTO.getParticipant_count(), 
                    totalAmount, 
                    0,
                    successUrl,  // 수정된 성공 URL
                    cancelUrl,
                    failUrl
            );
            
            session.setAttribute("onedayIndex", onedayDTO.getOneday_index());
            session.setAttribute("participantCount", reservationDTO.getParticipant_count());
            session.setAttribute("specialRequests", reservationDTO.getSpecial_requests());
            session.setAttribute("totalAmount", totalAmount);
            session.setAttribute("tid", response.getTid());
            session.setAttribute("partnerOrderId", response.getPartnerOrderId());
            session.setAttribute("partnerUserId", response.getPartnerUserId());
            
            // 로그로 확인
            logger.info("세션에 저장된 정보: onedayIndex={}, participantCount={}, tid={}",
                onedayDTO.getOneday_index(), reservationDTO.getParticipant_count(), response.getTid());
                
            return response;
        } catch (Exception e) {
            logger.error("카카오페이 결제 준비 중 오류 발생", e);
            throw new RuntimeException("카카오페이 결제 준비 중 오류가 발생했습니다.", e);
        }
    }

    @Transactional
    public OnedayReservationDTO completeKakaoPayment(String pgToken, HttpSession session, String memberId) {
        logger.info("카카오페이 결제 완료 처리 - 회원: {}", memberId);
        
        String tid = (String) session.getAttribute("tid");
        String partnerOrderId = (String) session.getAttribute("partnerOrderId");
        String partnerUserId = (String) session.getAttribute("partnerUserId");
        Integer onedayIndex = (Integer) session.getAttribute("onedayIndex");
        Integer participantCount = (Integer) session.getAttribute("participantCount");
        String specialRequests = (String) session.getAttribute("specialRequests");
        
        if (tid == null || partnerOrderId == null || partnerUserId == null || onedayIndex == null || participantCount == null) {
            logger.error("세션 정보 없음 - 결제 진행 불가");
            throw new RuntimeException("결제 정보가 유효하지 않습니다. 다시 시도해주세요.");
        }
        
        try {
            // 결제 승인 요청 - 파라미터 4개 전달 (tid, pgToken, partnerOrderId, partnerUserId)
            KakaoPayApproveDTO approveResponse = kakaoPayService.kakaoPayApprove(tid, pgToken, partnerOrderId, partnerUserId);
            
            logger.info("카카오페이 결제 승인 완료 - 결제번호: {}", approveResponse.getAid());
            
            // 예약 정보 생성
            OnedayReservationDTO reservation = new OnedayReservationDTO();
            reservation.setOneday_index(onedayIndex);
            reservation.setMember_id(memberId);
            reservation.setParticipant_count(participantCount);
            reservation.setSpecial_requests(specialRequests);
            reservation.setReservation_status("CONFIRMED");
            
            // 네이버 캘린더 토큰
            String accessToken = (String) session.getAttribute("naverAccessToken");
            
            // 예약 처리
            OnedayReservationDTO reservedClass = reservationService.reserveOneday(reservation, accessToken);
            
            // 세션에서 데이터 제거
            session.removeAttribute("tid");
            session.removeAttribute("partnerOrderId");
            session.removeAttribute("partnerUserId");
            session.removeAttribute("onedayIndex");
            session.removeAttribute("participantCount");
            session.removeAttribute("specialRequests");
            session.removeAttribute("totalAmount");
            
            return reservedClass;
        } catch (Exception e) {
            logger.error("카카오페이 결제 완료 처리 중 오류 발생", e);
            throw new RuntimeException("결제 완료 처리 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    @Transactional
    public boolean cancelPayment(int reservationIndex, String memberId, String accessToken) {
        logger.info("결제 취소 처리 - 예약: {}, 회원: {}", reservationIndex, memberId);

        OnedayReservationDTO reservation = reservationService.getReservationByIndex(reservationIndex);

        if (reservation == null || !reservation.getMember_id().equals(memberId)) {
            logger.error("예약 정보 없음 또는 권한 없음");
            throw new RuntimeException("예약 정보가 없거나 취소 권한이 없습니다.");
        }

        boolean cancelResult = reservationService.cancelReservation(reservationIndex, memberId, accessToken);

        if (cancelResult) {
            logger.info("예약 취소 성공 - 환불 처리 필요");
        }

        return cancelResult;
    }
}