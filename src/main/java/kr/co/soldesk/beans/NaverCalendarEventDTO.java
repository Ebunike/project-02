package kr.co.soldesk.beans;

import java.util.Date;

/**
 * 네이버 캘린더 이벤트 정보를 담는 DTO 클래스
 */
public class NaverCalendarEventDTO {
    private String calendarId;     // 캘린더 ID
    private String eventId;        // 이벤트 ID
    private String title;          // 일정 제목
    private String body;           // 일정 내용
    private Date startDateTime;    // 시작 일시
    private Date endDateTime;      // 종료 일시
    private String location;       // 장소
    private String timeZone;       // 타임존 (기본값: "Asia/Seoul")
    private boolean isAllDay;      // 종일 일정 여부
    private String color;          // 색상 
    private String accessType;     // 접근 권한 (기본값: "private")
    
    public NaverCalendarEventDTO() {
        this.timeZone = "Asia/Seoul";
        this.isAllDay = false;
        this.accessType = "private";
    }
    
    public String getCalendarId() {
        return calendarId;
    }
    
    public void setCalendarId(String calendarId) {
        this.calendarId = calendarId;
    }
    
    public String getEventId() {
        return eventId;
    }
    
    public void setEventId(String eventId) {
        this.eventId = eventId;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getBody() {
        return body;
    }
    
    public void setBody(String body) {
        this.body = body;
    }
    
    public Date getStartDateTime() {
        return startDateTime;
    }
    
    public void setStartDateTime(Date startDateTime) {
        this.startDateTime = startDateTime;
    }
    
    public Date getEndDateTime() {
        return endDateTime;
    }
    
    public void setEndDateTime(Date endDateTime) {
        this.endDateTime = endDateTime;
    }
    
    public String getLocation() {
        return location;
    }
    
    public void setLocation(String location) {
        this.location = location;
    }
    
    public String getTimeZone() {
        return timeZone;
    }
    
    public void setTimeZone(String timeZone) {
        this.timeZone = timeZone;
    }
    
    public boolean isAllDay() {
        return isAllDay;
    }
    
    public void setAllDay(boolean isAllDay) {
        this.isAllDay = isAllDay;
    }
    
    public String getColor() {
        return color;
    }
    
    public void setColor(String color) {
        this.color = color;
    }
    
    public String getAccessType() {
        return accessType;
    }
    
    public void setAccessType(String accessType) {
        this.accessType = accessType;
    }
}
