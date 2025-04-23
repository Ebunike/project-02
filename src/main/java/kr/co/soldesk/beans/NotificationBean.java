package kr.co.soldesk.beans;

import java.util.Date;

public class NotificationBean {
    private int id;
    private String userId;          // 알림 수신자 ID
    private String senderId;        // 알림 발신자 ID (선택적)
    private int postId;             // 관련 게시글 ID (선택적)
    private String content;         // 알림 내용
    private String notificationType; // 알림 유형 (PARTICIPATION, COMMENT, SYSTEM 등)
    private boolean isRead;         // 읽음 여부
    private Date createdAt;         // 생성 시간

    // 생성자
    public NotificationBean() {
        this.isRead = false;
        this.createdAt = new Date();
    }

    // Getter 및 Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getSenderId() {
        return senderId;
    }

    public void setSenderId(String senderId) {
        this.senderId = senderId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getNotificationType() {
        return notificationType;
    }

    public void setNotificationType(String notificationType) {
        this.notificationType = notificationType;
    }

    public boolean isRead() {
        return isRead;
    }

    public void setRead(boolean isRead) {
        this.isRead = isRead;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}