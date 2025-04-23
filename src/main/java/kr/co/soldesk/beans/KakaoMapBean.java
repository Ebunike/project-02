package kr.co.soldesk.beans;

public class KakaoMapBean {
    
    private int identifier;           // 장소 식별자 (PK)
    private String member_id;         // 회원 ID (FK)
    private String place_name;        // 장소명
    private String address_name;      // 주소
    private String id;                // 카카오맵 장소 ID
    private double x;                 // 경도
    private double y;                 // 위도
    private String marker_type;       // 마커 타입 (카테고리)
    
    // 기본 생성자
    public KakaoMapBean() {
        // 기본 생성자
    }
    
    // 생성자
    public KakaoMapBean(int identifier, String member_id, String place_name, String address_name, 
                  String id, double x, double y, String marker_type) {
        this.identifier = identifier;
        this.member_id = member_id;
        this.place_name = place_name;
        this.address_name = address_name;
        this.id = id;
        this.x = x;
        this.y = y;
        this.marker_type = marker_type;
    }

    // Getter와 Setter 메소드
    public int getIdentifier() {
        return identifier;
    }

    public void setIdentifier(int identifier) {
        this.identifier = identifier;
    }

    public String getMember_id() {
        return member_id;
    }

    public void setMember_id(String member_id) {
        this.member_id = member_id;
    }

    public String getPlace_name() {
        return place_name;
    }

    public void setPlace_name(String place_name) {
        this.place_name = place_name;
    }

    public String getAddress_name() {
        return address_name;
    }

    public void setAddress_name(String address_name) {
        this.address_name = address_name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getX() {
        return x;
    }

    public void setX(double x) {
        this.x = x;
    }

    public double getY() {
        return y;
    }

    public void setY(double y) {
        this.y = y;
    }

    public String getMarker_type() {
        return marker_type;
    }

    public void setMarker_type(String marker_type) {
        this.marker_type = marker_type;
    }

    @Override
    public String toString() {
        return "KakaoMapBean [identifier=" + identifier + ", member_id=" + member_id + ", place_name=" + place_name
                + ", address_name=" + address_name + ", id=" + id + ", x=" + x + ", y=" + y + ", marker_type="
                + marker_type + "]";
    }
}