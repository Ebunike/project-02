package kr.co.soldesk.beans;

import org.springframework.web.multipart.MultipartFile;

public class OpenRecipeBean {
    private int openRecipe_index;
    private String id;
    private int theme_index;
    private String openRecipe_title;
    private String openRecipe_content;
    private String openRecipe_picture;
    private String openRecipe_video;
    private int openRecipe_like;
    
	private MultipartFile upload_picture;
    
    
	public MultipartFile getUpload_picture() {
		return upload_picture;
	}
	public void setUpload_picture(MultipartFile upload_picture) {
		this.upload_picture = upload_picture;
	}
	public int getOpenRecipe_index() {
		return openRecipe_index;
	}
	public void setOpenRecipe_index(int openRecipe_index) {
		this.openRecipe_index = openRecipe_index;
	}
	public int getTheme_index() {
		return theme_index;
	}
	public void setTheme_index(int theme_index) {
		this.theme_index = theme_index;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOpenRecipe_title() {
		return openRecipe_title;
	}
	public void setOpenRecipe_title(String openRecipe_title) {
		this.openRecipe_title = openRecipe_title;
	}
	public String getOpenRecipe_content() {
		return openRecipe_content;
	}
	public void setOpenRecipe_content(String openRecipe_content) {
		this.openRecipe_content = openRecipe_content;
	}
	public String getOpenRecipe_picture() {
		return openRecipe_picture;
	}
	public void setOpenRecipe_picture(String openRecipe_picture) {
		this.openRecipe_picture = openRecipe_picture;
	}
	public String getOpenRecipe_video() {
		return openRecipe_video;
	}
	public void setOpenRecipe_video(String openRecipe_video) {
		this.openRecipe_video = openRecipe_video;
	}
	public int getOpenRecipe_like() {
		return openRecipe_like;
	}
	public void setOpenRecipe_like(int openRecipe_like) {
		this.openRecipe_like = openRecipe_like;
	}
    
   
}
