package kr.co.soldesk.beans;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * 원데이 클래스 정보를 담는 DTO 클래스
 */
public class OnedayDTO {
	
    private int oneday_index;
    private int seller_index;
    private int theme_index;
    private String oneday_name;
    private String oneday_info;
    private String oneday_start;    // 수업 시작 시간
    private String oneday_end;      // 수업 종료 시간
    private int oneday_price;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date oneday_date;       // 수업 날짜
    private int oneday_personnel;   // 최대 인원
    private String oneday_imageUrl;
    private String oneday_location;
    
    // 추가 필드
    //private String sellerName;     // 판매자명
    private String seller_name;     // 판매자명
    private String theme_name;      // 테마명
    private int current_participants; // 현재 예약 인원
    private boolean available;    // 예약 가능 여부

    public int getOneday_index() {
		return oneday_index;
	}

	public void setOneday_index(int oneday_index) {
		this.oneday_index = oneday_index;
	}

	public int getSeller_index() {
		return seller_index;
	}

	public void setSeller_index(int seller_index) {
		this.seller_index = seller_index;
	}

	public int getTheme_index() {
		return theme_index;
	}

	public void setTheme_index(int theme_index) {
		this.theme_index = theme_index;
	}

	public String getOneday_name() {
		return oneday_name;
	}

	public void setOneday_name(String oneday_name) {
		this.oneday_name = oneday_name;
	}

	public String getOneday_info() {
		return oneday_info;
	}

	public void setOneday_info(String oneday_info) {
		this.oneday_info = oneday_info;
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

	public int getOneday_price() {
		return oneday_price;
	}

	public void setOneday_price(int oneday_price) {
		this.oneday_price = oneday_price;
	}

	public Date getOneday_date() {
		return oneday_date;
	}

	public void setOneday_date(Date oneday_date) {
		this.oneday_date = oneday_date;
	}

	public int getOneday_personnel() {
		return oneday_personnel;
	}

	public void setOneday_personnel(int oneday_personnel) {
		this.oneday_personnel = oneday_personnel;
	}

	public String getOneday_imageUrl() {
		return oneday_imageUrl;
	}

	public void setOneday_imageUrl(String oneday_imageUrl) {
		this.oneday_imageUrl = oneday_imageUrl;
	}

	public String getOneday_location() {
		return oneday_location;
	}

	public void setOneday_location(String oneday_location) {
		this.oneday_location = oneday_location;
	}

	public String getSeller_name() {
		return seller_name;
	}

	public void setSeller_name(String seller_name) {
		this.seller_name = seller_name;
	}

	public String getTheme_name() {
		return theme_name;
	}

	public void setTheme_name(String theme_name) {
		this.theme_name = theme_name;
	}

	public int getCurrent_participants() {
		return current_participants;
	}

	public void setCurrent_participants(int current_participants) {
		this.current_participants = current_participants;
	}

	public boolean isAvailable() {
		return available;
	}

	public void setAvailable(boolean available) {
		this.available = available;
	}

	@Override
    public String toString() {
        return "OnedayDTO [onedayIndex=" + oneday_index + ", onedayName=" + oneday_name + ", onedayDate=" + oneday_date
                + ", onedayStart=" + oneday_start + ", onedayEnd=" + oneday_end + ", onedayLocation=" + oneday_location
                + ", onedayPersonnel=" + oneday_personnel + ", currentParticipants=" + current_participants + "]";
    }
}
