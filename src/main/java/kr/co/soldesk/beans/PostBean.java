package kr.co.soldesk.beans;

import java.util.Date;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

public class PostBean {
    
    // 게시글 ID
    private int id;
    
    // 게시글 제목
    @NotEmpty(message = "제목을 입력해주세요")
    private String title;
    
    // 게시글 내용
    @NotEmpty(message = "내용을 입력해주세요")
    private String content;
    
    // 작성자 ID
    private String writerId;
    
    // 작성자 이름 (표시용)
    private String writerName;
    
    // 작성일
    private Date regdate;
    
    // 최대 참여자 수
    @NotNull(message = "최대 참여자 수를 입력해주세요")
    @Min(value = 1, message = "최대 참여자 수는 1명 이상이어야 합니다")
    private Integer maxParticipants;
    
    // 현재 참여자 수
    private int currentParticipants;
    
    // 위치 정보 (지도 연동)
    private Double latitude;
    private Double longitude;
    private String address;
    
    // 마커 타입 (카테고리)
    private String markerType;
    
    // 기본 생성자
    public PostBean() {
        this.regdate = new Date();
        this.maxParticipants = 10;
        this.currentParticipants = 0;
    }
    
    // Getter와 Setter
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
    public String getWriterId() {
        return writerId;
    }
    
    public void setWriterId(String writerId) {
        this.writerId = writerId;
    }
    
    public String getWriterName() {
        return writerName;
    }
    
    public void setWriterName(String writerName) {
        this.writerName = writerName;
    }
    
    public Date getRegdate() {
        return regdate;
    }
    
    public void setRegdate(Date regdate) {
        this.regdate = regdate;
    }
    
    public Integer getMaxParticipants() {
        return maxParticipants;
    }
    
    public void setMaxParticipants(Integer maxParticipants) {
        this.maxParticipants = maxParticipants;
    }
    
    public int getCurrentParticipants() {
        return currentParticipants;
    }
    
    public void setCurrentParticipants(int currentParticipants) {
        this.currentParticipants = currentParticipants;
    }
    
    public Double getLatitude() {
        return latitude;
    }
    
    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }
    
    public Double getLongitude() {
        return longitude;
    }
    
    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getMarkerType() {
        return markerType;
    }
    
    public void setMarkerType(String markerType) {
        this.markerType = markerType;
    }
}