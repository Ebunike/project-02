package kr.co.soldesk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.soldesk.beans.ParticipationBean;
import kr.co.soldesk.mapper.ParticipationMapper;

@Service
public class ParticipationService {
    
    @Autowired
    private ParticipationMapper participationMapper;
    
    @Autowired
    private NotificationService notificationService;
    
    /**
     * 참여하기 처리 메소드
     * @param postId 게시글 ID
     * @param memberId 회원 ID
     * @return 처리 결과 코드 (0: 성공, 1: 작성자 본인, 2: 이미 참여함, 3: 최대 참여자 수 초과)
     */
    @Transactional
    public int participate(int postId, String memberId) {
        // 작성자 본인인지 확인
        String writerId = participationMapper.getPostWriterId(postId);
        if (writerId.equals(memberId)) {
            return 1; // 작성자 본인
        }
        
        // 이미 참여한 회원인지 확인
        int alreadyParticipated = participationMapper.checkParticipation(postId, memberId);
        if (alreadyParticipated > 0) {
            return 2; // 이미 참여함
        }
        
        // 최대 참여자 수 확인
        int maxParticipants = participationMapper.getMaxParticipants(postId);
        int currentParticipants = participationMapper.getCurrentParticipants(postId);
        
        if (currentParticipants >= maxParticipants) {
            return 3; // 최대 참여자 수 초과
        }
        
        // 참여 등록
        ParticipationBean participationBean = new ParticipationBean();
        participationBean.setPostId(postId);
        participationBean.setMemberId(memberId);
        
        participationMapper.insertParticipation(participationBean);
        
        // 현재 참여자 수 업데이트
        participationMapper.updateCurrentParticipants(postId, currentParticipants + 1);
        
        // 게시글 작성자에게 알림 전송
        notificationService.createParticipationNotification(memberId, postId);
        
        // 참여자 수가 가득 찼는지 확인하고 알림 전송
        if (currentParticipants + 1 >= maxParticipants) {
            notificationService.createFullCapacityNotification(postId);
        }
        
        return 0; // 성공
    }
    
    /**
     * 참여 취소 처리 메소드
     * @param postId 게시글 ID
     * @param memberId 회원 ID
     * @return 처리 결과 코드 (0: 성공, 1: 참여하지 않은 상태, 2: 내부 오류)
     */
    @Transactional
    public int cancelParticipation(int postId, String memberId) {
        // 참여 상태 확인
        int participated = participationMapper.checkParticipation(postId, memberId);
        if (participated == 0) {
            return 1; // 참여하지 않은 상태
        }
        
        try {
            // 참여 삭제
            participationMapper.deleteParticipation(postId, memberId);
            
            // 현재 참여자 수 감소
            int currentParticipants = participationMapper.getCurrentParticipants(postId);
            participationMapper.updateCurrentParticipants(postId, currentParticipants - 1);
            
            // 대기자가 있는 경우 첫 번째 대기자를 참여자로 등록
            String waitingUserId = participationMapper.getFirstWaitingUser(postId);
            if (waitingUserId != null) {
                // 대기자의 참여 등록
                ParticipationBean participationBean = new ParticipationBean();
                participationBean.setPostId(postId);
                participationBean.setMemberId(waitingUserId);
                
                participationMapper.insertParticipation(participationBean);
                
                // 현재 참여자 수 업데이트 (취소했다가 다시 증가)
                participationMapper.updateCurrentParticipants(postId, currentParticipants);
                
                // 대기자 목록에서 제거
                participationMapper.deleteFromWaitingList(postId, waitingUserId);
                
                // 대기자에게 참여 가능 알림 전송
                notificationService.createParticipationAvailableNotification(postId, waitingUserId);
            }
            
            return 0; // 성공
        } catch (Exception e) {
            e.printStackTrace();
            return 2; // 내부 오류
        }
    }
    
    /**
     * 대기자 등록 메소드
     * @param postId 게시글 ID
     * @param memberId 회원 ID
     * @return 처리 결과 코드 (0: 성공, 1: 작성자 본인, 2: 이미 참여중, 3: 이미 대기중, 4: 내부 오류)
     */
    @Transactional
    public int registerWaitingList(int postId, String memberId) {
        // 작성자 본인인지 확인
        String writerId = participationMapper.getPostWriterId(postId);
        if (writerId.equals(memberId)) {
            return 1; // 작성자 본인
        }
        
        // 이미 참여한 회원인지 확인
        int alreadyParticipated = participationMapper.checkParticipation(postId, memberId);
        if (alreadyParticipated > 0) {
            return 2; // 이미 참여중
        }
        
        // 이미 대기자 목록에 있는지 확인
        int alreadyWaiting = participationMapper.checkWaitingList(postId, memberId);
        if (alreadyWaiting > 0) {
            return 3; // 이미 대기중
        }
        
        try {
            // 대기자 등록
            participationMapper.insertWaitingList(postId, memberId);
            return 0; // 성공
        } catch (Exception e) {
            e.printStackTrace();
            return 4; // 내부 오류
        }
    }
    
    /**
     * 대기자 등록 취소 메소드
     * @param postId 게시글 ID
     * @param memberId 회원 ID
     * @return 성공 여부
     */
    @Transactional
    public boolean cancelWaitingList(int postId, String memberId) {
        // 대기자 등록 여부 확인
        int waiting = participationMapper.checkWaitingList(postId, memberId);
        if (waiting == 0) {
            return false; // 대기자로 등록되어 있지 않음
        }
        
        // 대기자 목록에서 제거
        participationMapper.deleteFromWaitingList(postId, memberId);
        return true;
    }
    
    /**
     * 참여 여부 확인
     * @param postId 게시글 ID
     * @param memberId 회원 ID
     * @return 참여 여부
     */
    public boolean hasParticipated(int postId, String memberId) {
        return participationMapper.checkParticipation(postId, memberId) > 0;
    }
    
    /**
     * 대기자 등록 여부 확인
     * @param postId 게시글 ID
     * @param memberId 회원 ID
     * @return 대기자 등록 여부
     */
    public boolean isInWaitingList(int postId, String memberId) {
        return participationMapper.checkWaitingList(postId, memberId) > 0;
    }
    
    /**
     * 최대 참여자 수 조회
     * @param postId 게시글 ID
     * @return 최대 참여자 수
     */
    public int getMaxParticipants(int postId) {
        return participationMapper.getMaxParticipants(postId);
    }
    
    /**
     * 현재 참여자 수 조회
     * @param postId 게시글 ID
     * @return 현재 참여자 수
     */
    public int getCurrentParticipants(int postId) {
        return participationMapper.getCurrentParticipants(postId);
    }
    
    /**
     * 참여자 목록 조회
     * @param postId 게시글 ID
     * @return 참여자 목록
     */
    public List<ParticipationBean> getParticipantsByPostId(int postId) {
        return participationMapper.getParticipantsByPostId(postId);
    }
    
    /**
     * 대기자 목록 조회
     * @param postId 게시글 ID
     * @return 대기자 목록
     */
    public List<ParticipationBean> getWaitingListByPostId(int postId) {
        return participationMapper.getWaitingListByPostId(postId);
    }
    
    // 참여 여부 확인 메소드 추가
    public boolean checkParticipation(int postId, String memberId) {
        return participationMapper.checkParticipation(postId, memberId) > 0;
    }
    
    // 대기자 목록 확인 메소드 추가
    public boolean checkWaitingList(int postId, String memberId) {
        return participationMapper.checkWaitingList(postId, memberId) > 0;
    }
    
    // 참여자 수 카운트 메소드 추가
    public int countParticipants(int postId) {
        return participationMapper.countParticipants(postId);
    }
    
    // 게시글의 모든 참여 정보 삭제 메소드 추가
    @Transactional
    public void deleteParticipationsByPostId(int postId) {
        participationMapper.deleteParticipationsByPostId(postId);
        participationMapper.deleteWaitingListByPostId(postId);
    }
}