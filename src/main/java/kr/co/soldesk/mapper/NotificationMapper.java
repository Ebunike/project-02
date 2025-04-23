package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.NotificationBean;

@Mapper
public interface NotificationMapper {
    
    /**
     * 알림 저장
     */
    @Insert("INSERT INTO notifications(id, user_id, sender_id, post_id, content, notification_type, is_read, created_at) " +
            "VALUES(#{notification.id}, #{notification.userId}, #{notification.senderId}, #{notification.postId}, " +
            "#{notification.content}, #{notification.notificationType}, #{notification.read}, SYSDATE)")
    @SelectKey(statement = "SELECT notification_seq.NEXTVAL FROM DUAL", 
              keyProperty = "notification.id", before = true, resultType = int.class)
    void insertNotification(@Param("notification") NotificationBean notification);
    
    /**
     * 특정 사용자의 모든 알림 조회 (최신순)
     */
    @Select("SELECT * FROM notifications WHERE user_id = #{userId} ORDER BY created_at DESC")
    List<NotificationBean> getNotificationsByUserId(@Param("userId") String userId);
    
    /**
     * 특정 사용자의 읽지 않은 알림 조회
     */
    @Select("SELECT * FROM notifications WHERE user_id = #{userId} AND is_read = 0 ORDER BY created_at DESC")
    List<NotificationBean> getUnreadNotificationsByUserId(@Param("userId") String userId);
    
    /**
     * 특정 알림 조회
     */
    @Select("SELECT * FROM notifications WHERE id = #{notificationId}")
    NotificationBean getNotificationById(@Param("notificationId") int notificationId);
    
    /**
     * 알림 읽음 상태로 변경
     */
    @Update("UPDATE notifications SET is_read = 1 WHERE id = #{notificationId}")
    void markAsRead(@Param("notificationId") int notificationId);
    
    /**
     * 특정 사용자의 모든 알림 읽음 상태로 변경
     */
    @Update("UPDATE notifications SET is_read = 1 WHERE user_id = #{userId}")
    void markAllAsRead(@Param("userId") String userId);
    
    /**
     * 알림 수 조회 (읽지 않은 알림)
     */
    @Select("SELECT COUNT(*) FROM notifications WHERE user_id = #{userId} AND is_read = 0")
    int countUnreadNotifications(@Param("userId") String userId);
    
    /**
     * 특정 게시글에 관심을 표시한 사용자 목록 조회 (참여자 + 대기자)
     */
    @Select("SELECT DISTINCT member_id FROM participation WHERE post_id = #{postId} " +
            "UNION " +
            "SELECT DISTINCT member_id FROM waiting_list WHERE post_id = #{postId}")
    List<String> getInterestedUsersByPostId(@Param("postId") int postId);

    
    /**
     * 특정 알림 삭제
     */
    @Delete("DELETE FROM notifications WHERE id = #{notificationId}")
    void deleteNotification(@Param("notificationId") int notificationId);
    
    /**
     * 특정 사용자의 모든 알림 삭제
     */
    @Delete("DELETE FROM notifications WHERE user_id = #{userId}")
    void deleteAllNotificationsByUserId(@Param("userId") String userId);
    

}