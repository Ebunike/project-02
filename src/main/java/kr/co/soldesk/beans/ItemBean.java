package kr.co.soldesk.beans;


import org.springframework.web.multipart.MultipartFile;

public class ItemBean {

   private int item_index;
   
   private int theme_index;
   
   private int seller_index;
   
   private String item_name;
   
   private int item_price;
   
   private int item_quantity;
   
   private int item_like;
   
   private float item_avgRating;
   
   private String item_picture;
   
   private String item_info;
   
   private MultipartFile upload_file;
   
   public int getItem_index() {
      return item_index;
   }
   public void setItem_index(int item_index) {
      this.item_index = item_index;
   }
   public int getTheme_index() {
      return theme_index;
   }
   public void setTheme_index(int theme_index) {
      this.theme_index = theme_index;
   }
   public int getSeller_index() {
      return seller_index;
   }
   public void setSeller_index(int seller_index) {
      this.seller_index = seller_index;
   }
   public String getItem_name() {
      return item_name;
   }
   public void setItem_name(String item_name) {
      this.item_name = item_name;
   }
   public int getItem_price() {
      return item_price;
   }
   public void setItem_price(int item_price) {
      this.item_price = item_price;
   }
   public int getItem_quantity() {
      return item_quantity;
   }
   public void setItem_quantity(int item_quantity) {
      this.item_quantity = item_quantity;
   }
   public int getItem_like() {
      return item_like;
   }
   public void setItem_like(int item_like) {
      this.item_like = item_like;
   }
   public float getItem_avgRating() {
      return item_avgRating;
   }
   public void setItem_avgRating(float item_avgRating) {
      this.item_avgRating = item_avgRating;
   }
   public String getItem_picture() {
      return item_picture;
   }
   public void setItem_picture(String item_picture) {
      this.item_picture = item_picture;
   }
   public String getItem_info() {
      return item_info;
   }
   public void setItem_info(String item_info) {
      this.item_info = item_info;
   }
   public MultipartFile getUpload_file() {
      return upload_file;
   }
   public void setUpload_file(MultipartFile upload_file) {
      this.upload_file = upload_file;
   }
}
