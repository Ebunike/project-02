package kr.co.soldesk.beans;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class MemberBean {
   
   @Size(min=4, max=20)
   @Pattern(regexp = "[A-zA=Z0-9]*")//영어와 숫자만 허용
   protected String id;
   @Size(min=4, max=20)
   @Pattern(regexp = "[A-zA=Z0-9]*")//영어와 숫자만 허용
   protected String pw;
   @Size(min = 2, max = 5)
   @Pattern(regexp = "[기-힣]*")
   protected String name;
   @NotNull
   protected String address;
   @NotNull
   protected String email;
   @NotNull
   protected String tel;
   @DecimalMin(value = "18", inclusive = false)
   private int age;
   private String gender;
   private String[] keyword;
   private String login;
   private String birthyear;
   private String birthday;
   
   private boolean idExist;
   
    //수정필요
    private String user;
    public String getUser() {
      return user;
   }
   public void setUser(String user) {
      this.user = user;
   }
   
   public MemberBean() {
      idExist = false;
      login = "x";
	}
	   
	public boolean isIdExist() {
	   return idExist;
	}
	public void setIdExist(boolean idExist) {
	   this.idExist = idExist;
	}
	public String getId() {
	   return id;
	}
	public void setId(String id) {
	   this.id = id;
	}
	public String getPw() {
	   return pw;
	}
	public void setPw(String pw) {
	   this.pw = pw;
	}
	public String getName() {
	   return name;
	}
	public void setName(String name) {
	   this.name = name;
	}
	public String getAddress() {
	   return address;
	}
	public void setAddress(String address) {
	   this.address = address;
	}
	public String getEmail() {
	   return email;
	}
	public void setEmail(String email) {
	   this.email = email;
	}
	public String getTel() {
	   return tel;
	}
	public void setTel(String tel) {
	   this.tel = tel;
	}
	public int getAge() {
	   return age;
	}
	public void setAge(int age) {
	   this.age = age;
	}
	public String getGender() {
	   return gender;
	}
	public void setGender(String gender) {
	   this.gender = gender;
	}
	public String[] getKeyword() {
	   return keyword;
	}
	public void setKeyword(String[] keyword) {
	   this.keyword = keyword;
	}
	public String getLogin() {
	   return login;
	}
	public void setLogin(String login) {
	   this.login = login;
	}
	public String getBirthyear() {
	   return birthyear;
	}
	public void setBirthyear(String birthyear) {
	   this.birthyear = birthyear;
	}
	public String getBirthday() {
	   return birthday;
	}
	public void setBirthday(String birthday) {
	   this.birthday = birthday;
	}
	   
	    
	   
	   
	   
	}
	
