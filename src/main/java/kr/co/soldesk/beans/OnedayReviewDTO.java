package kr.co.soldesk.beans;

import java.util.Date;

public class OnedayReviewDTO {

    private int review_index;           // 리뷰 인덱스
    private int oneday_index;           // 원데이 클래스 인덱스
    private int reservation_index;      // 예약 인덱스
    private String member_id;           // 회원 ID
    private int rating;                 // 평점 (1-5)
    private String content;             // 리뷰 내용
    private String review_imageUrl;     // 리뷰 이미지 URL
    private Date register_date;         // 등록일
    private Date update_date;           // 수정일

    // 조인 시 사용될 필드
    private String member_name;         // 회원 이름
    private String oneday_name;         // 클래스명

    public int getReview_index() {
        return review_index;
    }

    public void setReview_index(int review_index) {
        this.review_index = review_index;
    }

    public int getOneday_index() {
        return oneday_index;
    }

    public void setOneday_index(int oneday_index) {
        this.oneday_index = oneday_index;
    }

    public int getReservation_index() {
        return reservation_index;
    }

    public void setReservation_index(int reservation_index) {
        this.reservation_index = reservation_index;
    }

    public String getMember_id() {
        return member_id;
    }

    public void setMember_id(String member_id) {
        this.member_id = member_id;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getReview_imageUrl() {
        return review_imageUrl;
    }

    public void setReview_imageUrl(String review_imageUrl) {
        this.review_imageUrl = review_imageUrl;
    }

    public Date getRegister_date() {
        return register_date;
    }

    public void setRegister_date(Date register_date) {
        this.register_date = register_date;
    }

    public Date getUpdate_date() {
        return update_date;
    }

    public void setUpdate_date(Date update_date) {
        this.update_date = update_date;
    }

    public String getMember_name() {
        return member_name;
    }

    public void setMember_name(String member_name) {
        this.member_name = member_name;
    }

    public String getOneday_name() {
        return oneday_name;
    }

    public void setOneday_name(String oneday_name) {
        this.oneday_name = oneday_name;
    }

    @Override
    public String toString() {
        return "OnedayReviewDTO [review_index=" + review_index + ", oneday_index=" + oneday_index
                + ", reservation_index=" + reservation_index + ", member_id=" + member_id + ", rating="
                + rating + ", content=" + content + ", register_date=" + register_date + "]";
    }
}