package kr.co.soldesk.beans;
import java.util.ArrayList;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
public class OpenRecipeBean {
    private int openRecipe_index;
    private String id;
    private int theme_index;
    private String openRecipe_title;
    private String openRecipe_intro;    //한줄 소개 필드 추가함
    private String openRecipe_prepare;    //재료 필드 추가함
    private String openRecipe_content;  // JSON으로 저장
    private String openRecipe_picture;
    private String openRecipe_video;
    private int openRecipe_like;
    private MultipartFile upload_picture;
    
    
    private List<StepBean> stepBeanList = new ArrayList<StepBean>();  // List<StepBean> 추가

    // getter, setter
    public List<StepBean> getStepBeanList() {
        return stepBeanList;
    }

    public void setStepBeanList(List<StepBean> stepBeanList) {
        this.stepBeanList = stepBeanList;
    }
    
    
    
    // ✅ StepBean 리스트를 JSON으로 변환하기 위한 ObjectMapper
    private static final ObjectMapper objectMapper = new ObjectMapper();
   
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
    
    public String getOpenRecipe_intro() {
        return openRecipe_intro;
    }
    
    public void setOpenRecipe_intro(String openRecipe_intro) {
        this.openRecipe_intro = openRecipe_intro;
    }
    
    public String getOpenRecipe_content() {
        return openRecipe_content;
    }
    
    // ✅ List<StepBean>을 JSON 문자열로 변환하여 저장
    public void setOpenRecipe_content(List<StepBean> steps) {
        try {
            this.openRecipe_content = objectMapper.writeValueAsString(steps);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            this.openRecipe_content = "[]";  // 오류 발생 시 빈 배열 저장
        }
    }
    // ✅ JSON 문자열을 다시 List<StepBean>으로 변환
    public List<StepBean> getStepList() {
        // openRecipe_content가 null 또는 비어있다면 빈 리스트 반환
        if (openRecipe_content == null || openRecipe_content.trim().isEmpty()) {
            return new ArrayList<>();
        }
        
        try {
            // JSON 문자열을 List<StepBean>으로 변환
            return objectMapper.readValue(openRecipe_content, objectMapper.getTypeFactory().constructCollectionType(List.class, StepBean.class));
        } catch (JsonMappingException e) {
            System.err.println("JSON 매핑 예외 발생: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();  // 오류 발생 시 빈 리스트 반환
        } catch (JsonProcessingException e) {
            System.err.println("JSON 처리 예외 발생: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();  // 오류 발생 시 빈 리스트 반환
        }
		
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

	public String getOpenRecipe_prepare() {
		return openRecipe_prepare;
	}

	public void setOpenRecipe_prepare(String openRecipe_prepare) {
		this.openRecipe_prepare = openRecipe_prepare;
	}
}
