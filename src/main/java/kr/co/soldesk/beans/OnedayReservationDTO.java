
package kr.co.soldesk.beans;

import java.util.Date;

/**
 * 원데이 클래스 예약 정보를 담는 DTO 클래스
 */
public class OnedayReservationDTO {
    private int reservation_index;
    private int oneday_index;
    private String member_id;
    private Date reservation_date;
    private String reservation_status;
    private int participant_count;
    private String calendar_event_id;
    private String special_requests;
    
    // 원데이 클래스 정보 (조인 시 사용)
    private String oneday_name;
    private Date oneday_date;
    private String oneday_start;
    private String oneday_end;
    private String oneday_location;
    private String oneday_info;
    private int oneday_price;
    
    // 멤버 정보 (조인 시 사용)
    private String member_name;
    private String member_email;
    private String member_tel;
    
    private String theme_name;
    
    
    public String getTheme_name() {
		return theme_name;
	}

	public void setTheme_name(String theme_name) {
		this.theme_name = theme_name;
	}

	public int getOneday_price() {
		return oneday_price;
	}

	public void setOneday_price(int oneday_price) {
		this.oneday_price = oneday_price;
	}

	public int getReservation_index() {
        return reservation_index;
    }
    
    public void setReservation_index(int reservation_index) {
        this.reservation_index = reservation_index;
    }
    
    public int getOneday_index() {
        return oneday_index;
    }
    
    public void setOneday_index(int oneday_index) {
        this.oneday_index = oneday_index;
    }
    
    public String getMember_id() {
        return member_id;
    }
    
    public void setMember_id(String member_id) {
        this.member_id = member_id;
    }
    
    public Date getReservation_date() {
        return reservation_date;
    }
    
    public void setReservation_date(Date reservation_date) {
        this.reservation_date = reservation_date;
    }
    
    public String getReservation_status() {
        return reservation_status;
    }
    
    public void setReservation_status(String reservation_status) {
        this.reservation_status = reservation_status;
    }
    
    public int getParticipant_count() {
        return participant_count;
    }
    
    public void setParticipant_count(int participant_count) {
        this.participant_count = participant_count;
    }
    
    public String getCalendar_event_id() {
        return calendar_event_id;
    }
    
    public void setCalendar_event_id(String calendar_event_id) {
        this.calendar_event_id = calendar_event_id;
    }
    
    public String getSpecial_requests() {
        return special_requests;
    }
    
    public void setSpecial_requests(String special_requests) {
        this.special_requests = special_requests;
    }
    
    public String getOneday_name() {
        return oneday_name;
    }
    
    public void setOneday_name(String oneday_name) {
        this.oneday_name = oneday_name;
    }
    
    public Date getOneday_date() {
        return oneday_date;
    }
    
    public void setOneday_date(Date oneday_date) {
        this.oneday_date = oneday_date;
    }
    
    public String getOneday_start() {
        return oneday_start;
    }
    
    public void setOneday_start(String oneday_start) {
        this.oneday_start = oneday_start;
    }
    
    public String getOneday_end() {
        return oneday_end;
    }
    
    public void setOneday_end(String oneday_end) {
        this.oneday_end = oneday_end;
    }
    
    public String getOneday_location() {
        return oneday_location;
    }
    
    public void setOneday_location(String oneday_location) {
        this.oneday_location = oneday_location;
    }
    
    public String getOneday_info() {
        return oneday_info;
    }
    
    public void setOneday_info(String oneday_info) {
        this.oneday_info = oneday_info;
    }
    
    public String getMember_name() {
        return member_name;
    }
    
    public void setMember_name(String member_name) {
        this.member_name = member_name;
    }
    
    public String getMember_email() {
        return member_email;
    }
    
    public void setMember_email(String member_email) {
        this.member_email = member_email;
    }
    
    public String getMember_tel() {
        return member_tel;
    }
    
    public void setMember_tel(String member_tel) {
        this.member_tel = member_tel;
    }

    @Override
    public String toString() {
        return "OnedayReservationDTO [reservation_index=" + reservation_index 
                + ", oneday_index=" + oneday_index
                + ", member_id=" + member_id 
                + ", reservation_date=" + reservation_date 
                + ", reservation_status=" + reservation_status 
                + ", participant_count=" + participant_count 
                + ", calendar_event_id=" + calendar_event_id
                + ", special_requests=" + special_requests 
                + ", oneday_name=" + oneday_name + "]";
    }
}