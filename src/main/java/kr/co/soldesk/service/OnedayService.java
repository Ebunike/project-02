package kr.co.soldesk.service;

import java.util.Date;
import java.util.List;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.soldesk.beans.NaverCalendarClient;
import kr.co.soldesk.beans.NaverCalendarEventDTO;
import kr.co.soldesk.beans.OnedayDTO;
import kr.co.soldesk.exception.OnedayException;
import kr.co.soldesk.mapper.OnedayMapper;
import kr.co.soldesk.mapper.OnedayReservationMapper;

@Service
public class OnedayService {

    private static final Logger logger = LoggerFactory.getLogger(OnedayService.class);

    @Autowired
    private OnedayMapper onedayMapper;

    @Autowired
    private OnedayReservationMapper reservationMapper;

    @Autowired
    private NaverCalendarClient naverCalendarClient;

    public List<OnedayDTO> getRecentOnedays(int limit) {
        try {
            return onedayMapper.getRecentOnedays(limit);
        } catch (Exception e) {
            logger.error("최근 원데이 클래스 목록 조회 중 오류 발생", e);
            throw new OnedayException("클래스 목록을 불러오는 중 오류가 발생했습니다.");
        }
    }

    public List<OnedayDTO> getUpcomingOnedays() {
        try {
            return onedayMapper.getUpcomingOnedays();
        } catch (Exception e) {
            logger.error("예정된 원데이 클래스 목록 조회 중 오류 발생", e);
            throw new OnedayException("클래스 목록을 불러오는 중 오류가 발생했습니다.");
        }
    }

    public OnedayDTO getOnedayByIndex(int oneday_index) {
        try {
            logger.info("원데이 클래스 상세 조회 - 인덱스: {}", oneday_index);
            
            OnedayDTO oneday = onedayMapper.getOnedayByIndex(oneday_index);
            
            if (oneday == null) {
                logger.warn("원데이 클래스 없음 - 인덱스: {}", oneday_index);
                return null;
            }
            
            // 현재 참가자 수 확인
            int currentParticipants = reservationMapper.getCurrentParticipantCount(oneday_index);
            logger.info("현재 참가자 수: {}, 최대 인원: {}", currentParticipants, oneday.getOneday_max_participants());
            oneday.setCurrent_participants(currentParticipants);
            
            // 가용 여부 설정
            oneday.setAvailable(currentParticipants < oneday.getOneday_max_participants());
            
            logger.info("원데이 클래스 상세 조회 완료: {}", oneday);
            return oneday;
        } catch (Exception e) {
            logger.error("원데이 클래스 상세 조회 중 오류 발생 - 인덱스: {}", oneday_index, e);
            throw new OnedayException("클래스 정보를 불러오는 중 오류가 발생했습니다.");
        }
    }

    public List<OnedayDTO> getOnedaysByThemeIndex(int theme_index) {
        try {
            return onedayMapper.getOnedaysByThemeIndex(theme_index);
        } catch (Exception e) {
            logger.error("테마별 원데이 클래스 목록 조회 중 오류 발생 - 테마: {}", theme_index, e);
            throw new OnedayException("클래스 목록을 불러오는 중 오류가 발생했습니다.");
        }
    }

    public List<OnedayDTO> getOnedaysBySellerId(String seller_id) {
        try {
            List<OnedayDTO> onedayList = onedayMapper.getOnedaysBySellerId(seller_id);
            
            // 각 클래스에 대해 현재 참가자 수와 가용 여부 계산
            for (OnedayDTO oneday : onedayList) {
                int currentParticipants = reservationMapper.getCurrentParticipantCount(oneday.getOneday_index());
                oneday.setCurrent_participants(currentParticipants);
                
                // oneday_personnel 대신 oneday_max_participants 사용
                int maxParticipants = oneday.getOneday_max_participants() > 0 ? 
                                       oneday.getOneday_max_participants() : oneday.getOneday_personnel();
                
                // available 속성 설정 (현재 참가자 수 < 최대 인원)
                oneday.setAvailable(currentParticipants < maxParticipants);
            }
            
            return onedayList;
        } catch (Exception e) {
            logger.error("판매자별 원데이 클래스 목록 조회 중 오류 발생 - 판매자: {}", seller_id, e);
            throw new OnedayException("클래스 목록을 불러오는 중 오류가 발생했습니다.");
        }
    }

    public List<OnedayDTO> searchOnedays(String keyword) {
        try {
            return onedayMapper.searchOnedays(keyword);
        } catch (Exception e) {
            logger.error("원데이 클래스 검색 중 오류 발생 - 키워드: {}", keyword, e);
            throw new OnedayException("클래스 검색 중 오류가 발생했습니다.");
        }
    }

    @Transactional
    public OnedayDTO registerOneday(OnedayDTO oneday, String accessToken) {
    	logger.info("원데이 클래스 등록 시작 - 이름: {}, 판매자: {}", oneday.getOneday_name(), oneday.getSeller_index());

        try {
            // 네이버 캘린더 이벤트 생성
        	if (oneday.getOneday_max_participants() <= 0 && oneday.getOneday_personnel() > 0) {
                oneday.setOneday_max_participants(oneday.getOneday_personnel());
                logger.info("정원 설정: personnel({})값을 max_participants에 복사", oneday.getOneday_personnel());
            }
        	NaverCalendarEventDTO event = new NaverCalendarEventDTO();
            event.setCalendarId("primary");
            event.setTitle("[원데이클래스] " + oneday.getOneday_name());
            event.setDescription(oneday.getOneday_description());
            event.setLocation(oneday.getOneday_location());

            // 시작 및 종료 시간 설정
            Date startDate = oneday.getOneday_date();

            long durationMillis = oneday.getOneday_duration() * 60 * 60 * 1000L; // 시간을 밀리초로 변환
            Date endDate = new Date(startDate.getTime() + durationMillis);

            event.setStartDateTime(startDate);
            event.setEndDateTime(endDate);

            // 네이버 캘린더에 이벤트 추가
            String eventResponse = naverCalendarClient.createCalendarEvent(accessToken, event);
            logger.info("네이버 캘린더 이벤트 응답: {}", eventResponse);

            // 응답에서 이벤트 ID 추출
            JSONObject jsonResponse = new JSONObject(eventResponse);
            String calendarId = jsonResponse.optString("id", "");

			
			if (!calendarId.isEmpty()) { 
				  oneday.setNaver_calendar_id(calendarId);
				  logger.info("네이버 캘린더 이벤트 생성 성공 - ID: {}", calendarId); 
			} else {
			  logger.warn("네이버 캘린더 이벤트 ID를 찾을 수 없음"); 
			}
			 

            // 데이터베이스에 클래스 정보 저장
            int result = onedayMapper.insertOneday(oneday);

            if (result > 0) {
                logger.info("원데이 클래스 등록 성공 - 인덱스: {}", oneday.getOneday_index());
                return getOnedayByIndex(oneday.getOneday_index());
            } else {
                logger.error("원데이 클래스 등록 실패");
                throw new OnedayException("클래스 등록에 실패했습니다.");
            }

        } catch (Exception e) {
            logger.error("원데이 클래스 등록 중 오류 발생", e);
            throw new OnedayException("클래스 등록 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    @Transactional
    public boolean updateOneday(OnedayDTO oneday) {
        logger.info("원데이 클래스 수정 시작 - 인덱스: {}, 이름: {}", oneday.getOneday_index(), oneday.getOneday_name());

        try {
            int result = onedayMapper.updateOneday(oneday);

            if (result > 0) {
                logger.info("원데이 클래스 수정 성공 - 인덱스: {}", oneday.getOneday_index());
                return true;
            } else {
                logger.error("원데이 클래스 수정 실패 - 인덱스: {}", oneday.getOneday_index());
                return false;
            }

        } catch (Exception e) {
            logger.error("원데이 클래스 수정 중 오류 발생 - 인덱스: {}", oneday.getOneday_index(), e);
            throw new OnedayException("클래스 수정 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    @Transactional
    public boolean deleteOneday(int oneday_index) {
        logger.info("원데이 클래스 삭제 시작 - 인덱스: {}", oneday_index);

        try {
            int result = onedayMapper.deleteOneday(oneday_index);

            if (result > 0) {
                logger.info("원데이 클래스 삭제 성공 - 인덱스: {}", oneday_index);
                return true;
            } else {
                logger.error("원데이 클래스 삭제 실패 - 인덱스: {}", oneday_index);
                return false;
            }

        } catch (Exception e) {
            logger.error("원데이 클래스 삭제 중 오류 발생 - 인덱스: {}", oneday_index, e);
            throw new OnedayException("클래스 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    // 페이지네이션을 위한 메서드
    public List<OnedayDTO> getOnedaysWithPagination(int page, int limit) {
        int offset = (page - 1) * limit;

        try {
            return onedayMapper.getOnedaysWithPagination(offset, limit);
        } catch (Exception e) {
            logger.error("페이지네이션 원데이 클래스 목록 조회 중 오류 발생 - 페이지: {}, 개수: {}", page, limit, e);
            throw new OnedayException("클래스 목록을 불러오는 중 오류가 발생했습니다.");
        }
    }

    public int getTotalOnedayCount() {
        try {
            return onedayMapper.getTotalOnedayCount();
        } catch (Exception e) {
            logger.error("전체 원데이 클래스 수 조회 중 오류 발생", e);
            throw new OnedayException("클래스 개수를 조회하는 중 오류가 발생했습니다.");
        }
    }

    public List<OnedayDTO> getOnedaysByThemeIndexWithPagination(int themeIndex, int page, int limit) {
        int offset = (page - 1) * limit;

        try {
            return onedayMapper.getOnedaysByThemeIndexWithPagination(themeIndex, offset, limit);
        } catch (Exception e) {
            logger.error("테마별 페이지네이션 원데이 클래스 목록 조회 중 오류 발생 - 테마: {}, 페이지: {}", themeIndex, page, e);
            throw new OnedayException("클래스 목록을 불러오는 중 오류가 발생했습니다.");
        }
    }

    public int getTotalOnedayCountByTheme(int themeIndex) {
        try {
            return onedayMapper.getTotalOnedayCountByTheme(themeIndex);
        } catch (Exception e) {
            logger.error("테마별 원데이 클래스 수 조회 중 오류 발생 - 테마: {}", themeIndex, e);
            throw new OnedayException("클래스 개수를 조회하는 중 오류가 발생했습니다.");
        }
    }

    @Transactional
    public int updateFullClassesStatus() {
        try {
            return onedayMapper.updateFullClassesStatus();
        } catch (Exception e) {
            logger.error("만석 클래스 상태 업데이트 중 오류 발생", e);
            throw new OnedayException("클래스 상태 업데이트 중 오류가 발생했습니다.");
        }
    }
}