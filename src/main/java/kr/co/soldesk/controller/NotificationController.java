package kr.co.soldesk.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.NotificationBean;
import kr.co.soldesk.service.NotificationService;

@Controller
@RequestMapping("/notification")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;
    
    @Resource(name="loginMemberBean")
    private MemberBean loginMemberBean;
    
    /**
     * 알림 목록 페이지
     */
    @GetMapping("/list")
    public String notificationList(Model model) {
        // 로그인 확인
        if(loginMemberBean.getId() == null) {
            return "redirect:/member/login";
        }
        
        // 모든 알림 목록
        List<NotificationBean> notifications = notificationService.getUserNotifications(loginMemberBean.getId());
        
        // 읽지 않은 알림 수
        int unreadCount = notificationService.countUnreadNotifications(loginMemberBean.getId());
        
        model.addAttribute("notifications", notifications);
        model.addAttribute("unreadCount", unreadCount);
        
        return "notification/list";
    }
    
    /**
     * 읽지 않은 알림 목록 API
     */
    @GetMapping("/unreadList")
    @ResponseBody
    public List<NotificationBean> getUnreadNotifications() {
        // 로그인 확인
        if(loginMemberBean.getId() == null) {
            return null;
        }
        
        return notificationService.getUnreadNotifications(loginMemberBean.getId());
    }
    
    /**
     * 읽지 않은 알림 수 조회 API
     */
    @GetMapping("/unreadCount")
    @ResponseBody
    public int getUnreadCount() {
        // 로그인 확인
        if(loginMemberBean.getId() == null) {
            return 0;
        }
        
        return notificationService.countUnreadNotifications(loginMemberBean.getId());
    }
    
    /**
     * 알림 읽음 처리 API
     */
    @PostMapping("/markAsRead")
    @ResponseBody
    public String markAsRead(@RequestParam("notificationId") int notificationId) {
        // 로그인 확인
        if(loginMemberBean.getId() == null) {
            return "로그인이 필요합니다.";
        }
        
        notificationService.markAsRead(notificationId);
        return "success";
    }
    
    /**
     * 모든 알림 읽음 처리 API
     */
    @PostMapping("/markAllAsRead")
    @ResponseBody
    public String markAllAsRead() {
        // 로그인 확인
        if(loginMemberBean.getId() == null) {
            return "로그인이 필요합니다.";
        }
        
        notificationService.markAllAsRead(loginMemberBean.getId());
        return "success";
    }
    
    /**
     * 알림 삭제 API
     */
    @PostMapping("/delete")
    @ResponseBody
    public String deleteNotification(@RequestParam("notificationId") int notificationId) {
        // 로그인 확인
        if(loginMemberBean.getId() == null) {
            return "로그인이 필요합니다.";
        }
        
        boolean result = notificationService.deleteNotification(notificationId, loginMemberBean.getId());
        
        if(result) {
            return "success";
        } else {
            return "해당 알림을 삭제할 권한이 없습니다.";
        }
    }
    
    /**
     * 모든 알림 삭제 API
     */
    @PostMapping("/deleteAll")
    @ResponseBody
    public String deleteAllNotifications() {
        // 로그인 확인
        if(loginMemberBean.getId() == null) {
            return "로그인이 필요합니다.";
        }
        
        notificationService.deleteAllNotifications(loginMemberBean.getId());
        return "success";
    }
}