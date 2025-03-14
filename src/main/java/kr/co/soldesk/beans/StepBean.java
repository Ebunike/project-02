package kr.co.soldesk.beans;

import org.springframework.web.multipart.MultipartFile;

public class StepBean {
    private int stepNumber;  // 단계 번호
    private String description;// 단계 설명
    private String imageUrl; // 관련 이미지

    private MultipartFile upload_image;
    
 // 기본 생성자
    public StepBean() {}

    // 생성자
    public StepBean(int stepNumber, String description, String imageUrl) {
        this.stepNumber = stepNumber;
        this.description = description;
        this.imageUrl = imageUrl;
    }

    // Getter & Setter
    public int getStepNumber() { return stepNumber; }
    public void setStepNumber(int stepNumber) { this.stepNumber = stepNumber; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    
    
	public MultipartFile getUpload_image() {
		return upload_image;
	}

	public void setUpload_image(MultipartFile upload_image) {
		this.upload_image = upload_image;
	}
}