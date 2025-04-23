package kr.co.soldesk.service;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.OpenRecipeBean;
import kr.co.soldesk.beans.PageBean;
import kr.co.soldesk.beans.StepBean;
import kr.co.soldesk.beans.UserLikesBean;
import kr.co.soldesk.mapper.OpenRecipeMapper;
import kr.co.soldesk.repository.OpenRecipeRepository;
import kr.co.soldesk.repository.UserLikesDao;


@Service
public class OpenRecipeService {

	@Autowired
	private OpenRecipeRepository openRecipeRepository;
	
	@Resource(name = "loginMemberBean")
	private MemberBean loginMember;
	
	private int page_listcnt = 20;//데이터베이스에서 출력할 게시글의 개수

	private int page_paginationcnt = 10;//페이지의 개수
	

	//레시피 쓰기
	public void addOpenRecipe(OpenRecipeBean writeRecipe) {
		
		writeRecipe.setId(loginMember.getId());
		
		MultipartFile upload_picture = writeRecipe.getUpload_picture();
		
		if(upload_picture.getSize() >0) {
			String file_name = saveUploadPicture(upload_picture);
			System.out.println("서비스(파일이름): " + file_name);
			if (file_name == null) {
			    System.out.println("완성사진이 NULL입니다.");
			} else {
				System.out.println(file_name);
			    writeRecipe.setOpenRecipe_picture(file_name);
			    openRecipeRepository.addRecipe(writeRecipe);
			}
		}

	}
	
	
	//스텝 사진 등록
	public void addStep(StepBean stepBean) {
		
		
		MultipartFile upload_image = stepBean.getStepImage();
		
		if(upload_image.getSize() >0) {
			String image_url = saveUploadPicture(upload_image);
			if(image_url == null) {
				System.out.println("이미지가 없어?");
			}else {
				System.out.println("이미지 저장"+image_url);
				stepBean.setStepImageUrl(image_url);
			
			}
		}
		
	}
	
	
	
	

	//사진 파일 저장+String으로 변환
	private String saveUploadPicture(MultipartFile upload_picture) {
		String file_name = System.currentTimeMillis() + "_" +
				FilenameUtils.getBaseName(upload_picture.getOriginalFilename())+ "." +
				FilenameUtils.getExtension(upload_picture.getOriginalFilename());
		try {
			upload_picture.transferTo(new File("C:/Users/illum/git/project-02/src/main/webapp/upload/" + file_name));
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("파일이 안들어옴");
		}
		return file_name;
	}
	
	 // 좋아요 처리
	 @Autowired
	 private UserLikesDao userLikesDao; // UserLikesDao
	
	public int processLike(UserLikesBean userLikesBean) {
        
        // 이미 좋아요한 기록이 있는지 확인
        UserLikesBean existingLike = userLikesDao.findLike(userLikesBean);

        if (existingLike == null) {
            // 좋아요 기록이 없으면 추가
            userLikesBean.setLikes_status("true");
            userLikesDao.addLike(userLikesBean); // UserLikes 테이블에 추가

            // OpenRecipe 테이블에서 좋아요 수 증가
            openRecipeRepository.increaseLike(userLikesBean.getOpenRecipe_index());
        } else {
            // 이미 좋아요한 상태이면 상태를 취소로 변경 (선택 사항)
            if ("true".equals(existingLike.getLikes_status())) {
                userLikesDao.removeLike(userLikesBean); // UserLikes 테이블에서 삭제

                // OpenRecipe 테이블에서 좋아요 수 감소
                openRecipeRepository.decreaseLike(userLikesBean.getOpenRecipe_index());
            }
        }

        // 업데이트된 좋아요 수 반환
        return openRecipeRepository.getCurrentLikeCount(userLikesBean.getOpenRecipe_index());
    }
	
	//테마별로 좋아요 순서대로 레시피 가져오기
		public List<OpenRecipeBean> getLikeRecipe(int theme_index, int page){
			
			int start = (page - 1)*page_listcnt;
			// page=1이면 0, page=2면 10, page=3이면 20...

			RowBounds rowBounds = new RowBounds(start, page_listcnt);
			return openRecipeRepository.getLikeRecipe(theme_index, rowBounds);
		}
	
	
	
	//모든 좋아요 순서대로 레시피 가져오기
		public List<OpenRecipeBean> getAllLikeRecipe(int page){
		
			int start = (page - 1)*page_listcnt;
			// page=1이면 0, page=2면 10, page=3이면 20...

			RowBounds rowBounds = new RowBounds(start, page_listcnt);
		
			return openRecipeRepository.getAllLikeRecipe(rowBounds);
		}
		
	//페이징 처리. 지금 페이지 페이지 담아오기	
		public PageBean getContentPage(int theme_index, int currentPage) {
			
			int content_cnt = openRecipeRepository.getContentCnt(theme_index);
			
			PageBean pageBean = new PageBean(content_cnt, currentPage, page_listcnt, page_paginationcnt);
			
			return pageBean;
			
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
	
	//레시피 삭제
	public void deleteRecipe(int openRecipe_index) {
		openRecipeRepository.deleteLikes(openRecipe_index);
		openRecipeRepository.deleteRecipe(openRecipe_index);
	}
	
	 
	
}
