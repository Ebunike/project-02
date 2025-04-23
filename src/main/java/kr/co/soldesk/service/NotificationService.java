package kr.co.soldesk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.NotificationBean;
import kr.co.soldesk.mapper.NotificationMapper;
import kr.co.soldesk.mapper.ParticipationMapper;
import kr.co.soldesk.mapper.BoardMapper;

@Service
public class NotificationService {

    @Autowired
    private NotificationMapper notificationMapper;
    
    @Autowired
    private ParticipationMapper participationMapper;
    
    @Autowired
    private BoardMapper boardMapper;
    
    /**
     * 새로운 알림 생성
     */
    public void createNotification(NotificationBean notification) {
        notificationMapper.insertNotification(notification);
    }
    
    /**
     * 참여 알림 생성 - 게시글 작성자에게 새 참여자 알림
     */
    public void createParticipationNotification(String participantId, int postId) {
        // 게시글 작성자 ID 조회
        String writerId = participationMapper.getPostWriterId(postId);
        
        // 게시글 제목 조회
        String postTitle = boardMapper.getPostTitle(postId);
        
        // 알림 내용 생성
        String content = participantId + "님이 '" + postTitle + "' 글에 참여했습니다.";
        
        // 알림 객체 생성
        NotificationBean notification = new NotificationBean();
        notification.setUserId(writerId);
        notification.setSenderId(participantId);
        notification.setPostId(postId);
        notification.setContent(content);
        notification.setNotificationType("PARTICIPATION");
        notification.setRead(false);
        
        // 알림 저장
        createNotification(notification);
    }
    
    /**
     * 참여 인원 가득참 알림 - 관심 있는 사용자들에게 알림
     */
    public void createFullCapacityNotification(int postId) {
        // 게시글 제목 조회
        String postTitle = boardMapper.getPostTitle(postId);
        
        // 해당 게시글에 관심을 표시한 사용자 목록 조회
        List<String> interestedUsers = notificationMapper.getInterestedUsersByPostId(postId);
        
        // 각 사용자에게 알림 생성
        for (String userId : interestedUsers) {
            NotificationBean notification = new NotificationBean();
            notification.setUserId(userId);
            notification.setPostId(postId);
            notification.setContent("'" + postTitle + "' 글의 참여 인원이 가득 찼습니다.");
            notification.setNotificationType("SYSTEM");
            notification.setRead(false);
            
            createNotification(notification);
        }
    }
    
    /**
     * 참여 가능 알림 - 대기자에게 참여 가능 알림
     */
    public void createParticipationAvailableNotification(int postId, String waitingUserId) {
        // 게시글 제목 조회
        String postTitle = boardMapper.getPostTitle(postId);
        
        // 대기자에게 알림 생성
        NotificationBean notification = new NotificationBean();
        notification.setUserId(waitingUserId);
        notification.setPostId(postId);
        notification.setContent("'" + postTitle + "' 글에 참여할 수 있게 되었습니다.");
        notification.setNotificationType("PARTICIPATION_AVAILABLE");
        notification.setRead(false);
        
        createNotification(notification);
    }
    
    /**
     * 사용자의 모든 알림 조회
     */
    public List<NotificationBean> getUserNotifications(String userId) {
        return notificationMapper.getNotificationsByUserId(userId);
    }
    
    /**
     * 사용자의 읽지 않은 알림 조회
     */
    public List<NotificationBean> getUnreadNotifications(String userId) {
        return notificationMapper.getUnreadNotificationsByUserId(userId);
    }
    
    /**
     * 알림 읽음 상태로 변경
     */
    public void markAsRead(int notificationId) {
        notificationMapper.markAsRead(notificationId);
    }
    
    /**
     * 사용자의 모든 알림 읽음 상태로 변경
     */
    public void markAllAsRead(String userId) {
        notificationMapper.markAllAsRead(userId);
    }
    
    /**
     * 읽지 않은 알림 수 조회
     */
    public int countUnreadNotifications(String userId) {
        return notificationMapper.countUnreadNotifications(userId);
    }
    
    /**
     * 알림 삭제
     */
    public boolean deleteNotification(int notificationId, String userId) {
        // 알림이 해당 사용자의 것인지 확인
        NotificationBean notification = notificationMapper.getNotificationById(notificationId);
        if (notification != null && notification.getUserId().equals(userId)) {
            notificationMapper.deleteNotification(notificationId);
            return true;
        }
        return false;
    }
    
    /**
     * 모든 알림 삭제
     */
    public void deleteAllNotifications(String userId) {
        notificationMapper.deleteAllNotificationsByUserId(userId);
    }
}