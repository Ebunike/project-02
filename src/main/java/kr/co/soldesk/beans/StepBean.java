package kr.co.soldesk.beans;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class StepBean {
    private int StepNumber;  // Step 번호
    private String stepText;  // Step 텍스트
    @JsonIgnore  
    private MultipartFile stepImage;  // Step 이미지 파일
    private String stepImageUrl;
    
    

    public String getStepText() {
        return stepText != null ? stepText : "";  // stepText가 null일 때 기본값 설정
    }

    public void setStepText(String stepText) {
        this.stepText = stepText;
    }

    public MultipartFile getStepImage() {
        return stepImage;
    }

    public void setStepImage(MultipartFile stepImage) {
        this.stepImage = stepImage;
    }

	public String getStepImageUrl() {
		//null값 안들어가게 조정?
		 return stepImageUrl != null ? stepImageUrl : "";
	}

	public void setStepImageUrl(String stepImageUrl) {
		this.stepImageUrl = stepImageUrl;
		
		
	}

	public int getStepNumber() {
		return StepNumber;
	}

	public void setStepNumber(int stepNumber) {
		StepNumber = stepNumber;
	}
}