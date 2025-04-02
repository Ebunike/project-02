package kr.co.soldesk.service;

import java.util.Date;
import java.util.List;
import java.util.Set;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.soldesk.beans.NaverCalendarClient;
import kr.co.soldesk.beans.NaverCalendarEventDTO;
import kr.co.soldesk.beans.OnedayDTO;
import kr.co.soldesk.beans.OnedayReservationDTO;
import kr.co.soldesk.exception.ReservationException;
import kr.co.soldesk.mapper.OnedayMapper;
import kr.co.soldesk.mapper.OnedayReservationMapper;

@Service
public class OnedayReservationService {

    private static final Logger logger = LoggerFactory.getLogger(OnedayReservationService.class);

    @Autowired
    private OnedayReservationMapper reservationMapper;

    @Autowired
    private OnedayMapper onedayMapper;

    @Autowired
    private NaverCalendarClient naverCalendarClient;

    public OnedayReservationDTO getReservationByIndex(int reservation_index) {
        logger.info("예약 정보 조회 - 인덱스: {}", reservation_index);

        try {
            return reservationMapper.getReservationByIndex(reservation_index);
        } catch (Exception e) {
            logger.error("예약 정보 조회 중 오류 발생 - 인덱스: {}", reservation_index, e);
            throw new ReservationException("예약 정보를 불러오는 중 오류가 발생했습니다.");
        }
    }

    public List<OnedayReservationDTO> getReservationsByMemberId(String member_id) {
        logger.info("회원별 예약 목록 조회 - 회원: {}", member_id);

        try {
            return reservationMapper.getReservationsByMemberId(member_id);
        } catch (Exception e) {
            logger.error("회원별 예약 목록 조회 중 오류 발생 - 회원: {}", member_id, e);
            throw new ReservationException("예약 목록을 불러오는 중 오류가 발생했습니다.");
        }
    }

    public List<OnedayReservationDTO> getReservationsByOnedayIndex(int oneday_index) {
        logger.info("클래스별 예약 목록 조회 - 클래스: {}", oneday_index);

        try {
            return reservationMapper.getReservationsByOnedayIndex(oneday_index);
        } catch (Exception e) {
            logger.error("클래스별 예약 목록 조회 중 오류 발생 - 클래스: {}", oneday_index, e);
            throw new ReservationException("예약 목록을 불러오는 중 오류가 발생했습니다.");
        }
    }

    public int getCurrentParticipantCount(int oneday_index) {
        logger.info("현재 참가자 수 조회 - 클래스: {}", oneday_index);

        try {
            return reservationMapper.getCurrentParticipantCount(oneday_index);
        } catch (Exception e) {
            logger.error("현재 참가자 수 조회 중 오류 발생 - 클래스: {}", oneday_index, e);
            throw new ReservationException("참가자 수 조회 중 오류가 발생했습니다.");
        }
    }

    @Transactional
    public OnedayReservationDTO reserveOneday(OnedayReservationDTO reservation, String accessToken) {
    	logger.info("예약 시작 - 데이터: {}", reservation.toString());
    	
        try {
            // 클래스 정보 조회
            OnedayDTO oneday = onedayMapper.getOnedayByIndex(reservation.getOneday_index());
            
            if (oneday == null) {
                logger.error("존재하지 않는 클래스 - 인덱스: {}", reservation.getOneday_index());
                throw new RuntimeException("존재하지 않는 클래스입니다.");
            }
            
            // 현재 참가자 수 확인
            int currentParticipants = reservationMapper.getCurrentParticipantCount(reservation.getOneday_index());
            logger.info("현재 참가자 수: {}, 최대 인원: {}", currentParticipants, oneday.getOneday_max_participants());
            
            // 예약 가능 여부 확인
            if (currentParticipants + reservation.getParticipant_count() > oneday.getOneday_max_participants()) {
                logger.error("정원 초과 - 현재: {}, 요청: {}, 최대: {}", 
                        currentParticipants, reservation.getParticipant_count(), oneday.getOneday_max_participants());
                throw new RuntimeException("정원이 초과되어 예약할 수 없습니다.");
            }
            
            // 실제 DB 삽입 시도
            logger.info("DB 삽입 시도 - oneday_index: {}, member_id: {}, participant_count: {}, special_requests: {}, status: {}",
                    reservation.getOneday_index(), reservation.getMember_id(), 
                    reservation.getParticipant_count(), reservation.getSpecial_requests(),
                    reservation.getReservation_status());
                    
            int result = reservationMapper.insertReservation(reservation);
            logger.info("삽입 결과: {}, 생성된 ID: {}", result, reservation.getReservation_index());
            
            if (result > 0) {
                logger.info("예약 성공 - 인덱스: {}", reservation.getReservation_index());
                
                // 예약 정보 다시 조회하여 반환 (모든 정보 포함)
                OnedayReservationDTO savedReservation = reservationMapper.getReservationByIndex(reservation.getReservation_index());
                logger.info("저장된 예약 정보: {}", savedReservation);
                
                return savedReservation;
            } else {
                logger.error("예약 삽입 실패 - 결과: {}", result);
                throw new RuntimeException("예약에 실패했습니다.");
            }
        } catch (Exception e) {
            logger.error("예약 처리 중 오류 발생", e);
            throw new RuntimeException("예약 처리 중 오류가 발생했습니다: " + e.getMessage(), e);
        }
    }


    @Transactional
    public boolean cancelReservation(int reservation_index, String member_id, String accessToken) {
        logger.info("예약 취소 시작 - 예약: {}, 회원: {}", reservation_index, member_id);

        try {
            OnedayReservationDTO reservation = reservationMapper.getReservationByIndex(reservation_index);

            if (reservation == null) {
                logger.error("존재하지 않는 예약 - 인덱스: {}", reservation_index);
                throw new ReservationException("존재하지 않는 예약입니다.");
            }

            if (!reservation.getMember_id().equals(member_id)) {
                logger.error("예약 취소 권한 없음 - 예약 회원: {}, 요청 회원: {}",
                        reservation.getMember_id(), member_id);
                throw new ReservationException("예약 취소 권한이 없습니다.");
            }

            int result = reservationMapper.cancelReservation(reservation_index, member_id);

            if (result > 0) {
                logger.info("예약 취소 성공 - 인덱스: {}", reservation_index);

                // 클래스 상태 업데이트 (만석 -> 예약가능으로 변경)
                try {
                    onedayMapper.updateAvailableClassesStatus();
                } catch (Exception e) {
                    logger.warn("클래스 상태 업데이트 실패", e);
                }

                // 네이버 캘린더 이벤트 삭제 (미구현 - 필요시 추가)

                return true;
            } else {
                logger.error("예약 취소 실패 - 인덱스: {}", reservation_index);
                return false;
            }

        } catch (ReservationException e) {
            throw e;
        } catch (Exception e) {
            logger.error("예약 취소 처리 중 오류 발생", e);
            throw new ReservationException("예약 취소 처리 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    @Transactional
    public int updatePastClassesToCompleted() {
        logger.info("지난 클래스 예약 상태 자동 업데이트 시작");

        try {
            int result = reservationMapper.updatePastClassesToCompleted();
            logger.info("완료 상태로 변경된 예약 수: {}", result);
            return result;
        } catch (Exception e) {
            logger.error("지난 클래스 예약 상태 업데이트 중 오류 발생", e);
            throw new ReservationException("예약 상태 업데이트 중 오류가 발생했습니다.");
        }
    }

    @Transactional
    public int lockSoonStartingClasses() {
        logger.info("곧 시작하는 클래스 예약 취소 불가 설정 시작");

        try {
            int result = reservationMapper.lockSoonStartingClasses();
            logger.info("취소 불가 상태로 변경된 예약 수: {}", result);
            return result;
        } catch (Exception e) {
            logger.error("예약 취소 불가 설정 중 오류 발생", e);
            throw new ReservationException("예약 상태 업데이트 중 오류가 발생했습니다.");
        }
    }

    @Transactional
    public int updateFullClassesStatus() {
        logger.info("클래스 가용성 상태 업데이트 시작");

        try {
            int fullUpdated = onedayMapper.updateFullClassesStatus();
            int availableUpdated = onedayMapper.updateAvailableClassesStatus();

            logger.info("만석으로 변경된 클래스 수: {}, 예약가능으로 변경된 클래스 수: {}",
                    fullUpdated, availableUpdated);

            return fullUpdated + availableUpdated;
        } catch (Exception e) {
            logger.error("클래스 가용성 상태 업데이트 중 오류 발생", e);
            throw new ReservationException("클래스 상태 업데이트 중 오류가 발생했습니다.");
        }
    }
    
    @Transactional
    public boolean updateReservationStatus(int reservation_index, String status) {
        logger.info("예약 상태 업데이트 - 예약: {}, 상태: {}", reservation_index, status);
        
        try {
            // 유효한 상태인지 확인
            if (!isValidStatus(status)) {
                logger.error("유효하지 않은 예약 상태 - 상태: {}", status);
                throw new ReservationException("유효하지 않은 예약 상태입니다.");
            }
            
            // 예약 정보 조회
            OnedayReservationDTO reservation = reservationMapper.getReservationByIndex(reservation_index);
            
            if (reservation == null) {
                logger.error("존재하지 않는 예약 - 인덱스: {}", reservation_index);
                throw new ReservationException("존재하지 않는 예약입니다.");
            }
            
            // 상태 업데이트
            int result = reservationMapper.updateReservationStatus(reservation_index, status);
            
            if (result > 0) {
                logger.info("예약 상태 업데이트 성공 - 인덱스: {}, 상태: {}", reservation_index, status);
                
                // 취소 상태로 변경된 경우 취소 날짜 업데이트
                if ("CANCELLED".equals(status)) {
                    reservationMapper.updateCancelDate(reservation_index, new Date());
                }
                
                // 클래스 상태 업데이트 (만석 상태 확인)
                if ("CANCELLED".equals(status)) {
                    onedayMapper.updateAvailableClassesStatus();
                }
                
                return true;
            } else {
                logger.error("예약 상태 업데이트 실패 - 인덱스: {}", reservation_index);
                return false;
            }
            
        } catch (ReservationException e) {
            throw e;
        } catch (Exception e) {
            logger.error("예약 상태 업데이트 중 오류 발생", e);
            throw new ReservationException("예약 상태 업데이트 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 예약 상태가 유효한지 확인하는 메서드
     * 
     * @param status 확인할 상태
     * @return 유효 여부
     */
    private boolean isValidStatus(String status) {
        return "CONFIRMED".equals(status) ||
               "CANCELLED".equals(status) ||
               "COMPLETED".equals(status) ||
               "LOCKED".equals(status) ||
               "ATTENDED".equals(status) ||
               "NO_SHOW".equals(status);  // NO_SHOW 상태 추가
    }
}