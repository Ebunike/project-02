package kr.co.soldesk.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import kr.co.soldesk.service.OnedayReservationService;

@Configuration
@EnableScheduling
public class SchedulerConfig {

    private static final Logger logger = LoggerFactory.getLogger(SchedulerConfig.class);

    @Autowired
    private OnedayReservationService reservationService;

    /**
     * 매일 자정에 실행되어 클래스 예약 상태를 업데이트합니다.
     * - 클래스 일자가 지난 예약은 'COMPLETED' 상태로 변경
     * - 클래스 시작 24시간 전에는 취소가 불가능하도록 설정
     */
    @Scheduled(cron = "0 0 0 * * ?") // 매일 자정에 실행
    public void updateReservationStatus() {
        logger.info("예약 상태 자동 업데이트 작업 시작");

        try {
            int completedCount = reservationService.updatePastClassesToCompleted();
            logger.info("완료 상태로 변경된 예약 수: {}", completedCount);

            int lockedCount = reservationService.lockSoonStartingClasses();
            logger.info("취소 불가 상태로 변경된 예약 수: {}", lockedCount);

        } catch (Exception e) {
            logger.error("예약 상태 업데이트 중 오류 발생", e);
        }
    }

    /**
     * 매시간 실행되어 만석이 된 클래스의 상태를 업데이트합니다.
     */
    @Scheduled(cron = "0 0 * * * ?") // 매시간 실행
    public void updateClassesAvailability() {
        logger.info("클래스 가용성 자동 업데이트 작업 시작");

        try {
            int updatedCount = reservationService.updateFullClassesStatus();
            logger.info("상태 업데이트된 클래스 수: {}", updatedCount);

        } catch (Exception e) {
            logger.error("클래스 가용성 업데이트 중 오류 발생", e);
        }
    }
}