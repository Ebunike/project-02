package kr.co.soldesk.service;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.OpenRecipeBean;
import kr.co.soldesk.repository.OpenRecipeRepository;


@Service
public class OpenRecipeService {

	@Autowired
	private OpenRecipeRepository openRecipeRepository;
	
	@Resource(name = "loginMemberBean")
	private MemberBean loginMember;
	
	

	//레시피 쓰기
	public void addOpenRecipe(OpenRecipeBean writeRecipe) {
		
		writeRecipe.setId(loginMember.getId());
		
		MultipartFile upload_picture = writeRecipe.getUpload_picture();
		
		if(upload_picture.getSize() >0) {
			String file_name = saveUploadPicture(upload_picture);
			System.out.println("서비스(파일이름): " + file_name);
			if (file_name == null) {
			    System.out.println("파일 이름이 NULL입니다.");
			} else {
				System.out.println(file_name);
			    writeRecipe.setOpenRecipe_picture(file_name);
			    openRecipeRepository.addRecipe(writeRecipe);
			}
		}
		openRecipeRepository.addRecipe(writeRecipe);
	}

	//사진 파일 저장+String으로 변환
	private String saveUploadPicture(MultipartFile upload_picture) {
		String file_name = System.currentTimeMillis() + "_" +
				FilenameUtils.getBaseName(upload_picture.getOriginalFilename())+ "." +
				FilenameUtils.getExtension(upload_picture.getOriginalFilename());
		try {
			upload_picture.transferTo(new File("C:/Users/soldesk/Documents/workspace-sts-3.9.18.RELEASE/Project_hoon/src/main/webapp/upload/" + file_name));
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("파일이 안들어옴");
		}
		return file_name;
	}
	
	
	
	//좋아요 순서대로 레시피 가져오기
	public List<OpenRecipeBean> getLikeRecipe(int theme_index){
		
		return openRecipeRepository.getLikeRecipe(theme_index);
	}
	
	//레시피 상세페이지 가져오기
	public OpenRecipeBean getRecipe(int openRecipe_index) {
		return openRecipeRepository.getRecipe(openRecipe_index);
	}
	
	//수정하기
	public void modifyRecipe(OpenRecipeBean modifyRecipe) {
		
		MultipartFile upload_picture = modifyRecipe.getUpload_picture();
		
		if(upload_picture.getSize() > 0) {
			String picture_name = saveUploadPicture(upload_picture);
			modifyRecipe.setOpenRecipe_picture(picture_name);
		}
	
		openRecipeRepository.modifyRecipe(modifyRecipe);
	}
	
	public void deleteRecipe(int openRecipe_index) {
		openRecipeRepository.deleteRecipe(openRecipe_index);
	}
	
}
