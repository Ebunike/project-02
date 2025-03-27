package kr.co.soldesk.beans;

public class KakaoMapBean {

	private int identifier;
    private String member_id;
    private String address_name;
    private String id; 
    private String place_name;
    private String x;
    private String y;
    
    
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
   public String getPlace_name() {
      return place_name;
   }
   public void setPlace_name(String place_name) {
      this.place_name = place_name;
   }
   public String getX() {
      return x;
   }
   public void setX(String x) {
      this.x = x;
   }
   public String getY() {
      return y;
   }
   public void setY(String y) {
      this.y = y;
   }
    
}
