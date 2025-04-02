package kr.co.soldesk.beans;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 네이버 캘린더 이벤트 정보를 담는 DTO 클래스
 */
public class NaverCalendarEventDTO {
    private String calendarId;     // 캘린더 ID
    private String eventId;        // 이벤트 ID
    private String title;          // 일정 제목
    private String description;    // 일정 내용
    private Date startDate;        // 시작 날짜
    private Date endDate;          // 종료 날짜
    private String location;       // 장소
    private String timeZone;       // 타임존 (기본값: "Asia/Seoul")
    private boolean isAllDay;      // 종일 일정 여부
    private String color;          // 색상 
    private String accessType;     // 접근 권한 (기본값: "private")
    
    // OnedayService와 호환성을 위한 필드
    private String body;
    private Date startDateTime;
    private Date endDateTime;

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
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public Date getStartDate() {
        return startDate;
    }
    
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
        // startDateTime과 동기화
        this.startDateTime = startDate;
    }
    
    public Date getEndDate() {
        return endDate;
    }
    
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
        // endDateTime과 동기화
        this.endDateTime = endDate;
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
    
    // 호환성을 위한 메서드들
    public String getBody() {
        return description;
    }
    
    public void setBody(String body) {
        this.body = body;
        this.description = body;
    }
    
    public Date getStartDateTime() {
        return startDate != null ? startDate : startDateTime;
    }
    
    public void setStartDateTime(Date startDateTime) {
        this.startDateTime = startDateTime;
        this.startDate = startDateTime;
    }
    
    public Date getEndDateTime() {
        return endDate != null ? endDate : endDateTime;
    }
    
    public void setEndDateTime(Date endDateTime) {
        this.endDateTime = endDateTime;
        this.endDate = endDateTime;
    }
    
    @Override
    public String toString() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return "NaverCalendarEventDTO [calendarId=" + calendarId + ", eventId=" + eventId + ", title=" + title
                + ", description=" + description + ", startDate=" + (startDate != null ? sdf.format(startDate) : "null") 
                + ", endDate=" + (endDate != null ? sdf.format(endDate) : "null") + ", location=" + location + "]";
    }
}