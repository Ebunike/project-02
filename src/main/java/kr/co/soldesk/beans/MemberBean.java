package kr.co.soldesk.beans;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class MemberBean {
   
	@NotEmpty(message = "아이디는 필수 입력사항입니다.")
    @Size(min = 4, max = 20, message = "아이디는 4자 이상 20자 이하로 입력해주세요.")
    @Pattern(regexp = "[A-Za-z0-9]*", message = "아이디는 영어와 숫자만 사용 가능합니다.")
    private String id;

	@NotEmpty(message = "비밀번호는 필수 입력사항입니다.")
    @Size(min = 4, max = 20, message = "비밀번호는 4자 이상 20자 이하로 입력해주세요. ")
    @Pattern(regexp = "[A-Za-z0-9]*", message = "비밀번호는 영어와 숫자만 사용 가능합니다.")
    private String pw;

	@NotEmpty(message = "이름은 필수 입력사항입니다.")
    @Size(min = 2, max = 5, message = "이름은 2글자 이상 5글자 이하로 입력해주세요.")
    @Pattern(regexp = "[가-힣]*", message = "이름은 한글만 사용 가능합니다.")
    private String name;

    @NotEmpty(message = "주소는 필수 항목입니다.")
    private String address;

    @Email(message = "유효한 이메일 주소를 입력해 주세요.")
    @NotEmpty(message = "이메일은 필수 항목입니다.")
    private String email;
    
    @Size(min = 11, max = 11, message = "올바른 전화번호가 맞는지 다시 확인해주세요")
    @NotEmpty(message = "전화번호는 필수 입력사항입니다.")
    private String tel;

    @NotNull(message = "나이는 필수 입력사항입니다.")
    @DecimalMin(value = "18", inclusive = false, message = "나이는 18세 이상만 가입 가능합니다.")
    private int age;
    @NotEmpty(message = "성별을 선택해주세요.")
   private String gender;
   @NotEmpty(message = "최소 1개의 키워드를 선택해주세요.")
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
	
