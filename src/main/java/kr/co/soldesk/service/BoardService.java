package kr.co.soldesk.service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.soldesk.beans.PostBean;
import kr.co.soldesk.mapper.BoardMapper;
import kr.co.soldesk.mapper.MemberMapper;

@Service
public class BoardService {
    
    @Autowired
    private BoardMapper boardMapper;
    
    @Autowired
    private MemberMapper memberMapper;
    
    @Value("${file.upload.path}")
    private String uploadPath;
    
    @Value("${file.upload.url}")
    private String uploadUrl;
    
    // 게시글 목록 조회
    public List<PostBean> getPostList(int page, String category, String searchType, String keyword) {
        int start = (page - 1) * 10;
        return boardMapper.getPostList(start, category, searchType, keyword);
    }
    
    // 게시글 수 조회
    public int getPostCount(String category, String searchType, String keyword) {
        return boardMapper.getPostCount(category, searchType, keyword);
    }
    
    // 게시글 저장
    public int savePost(PostBean postBean) {
        boardMapper.savePost(postBean);
        return postBean.getId();
    }
    
    // 게시글 조회
    public PostBean getPost(int id) {
        return boardMapper.getPost(id);
    }
    
    // 게시글 수정
    public void updatePost(PostBean postBean) {
        boardMapper.updatePost(postBean);
    }
    
    // 게시글 삭제
    public void deletePost(int id) {
        boardMapper.deletePost(id);
    }
    
    // 회원 이름 조회
    public String getMemberName(String id) {
        return memberMapper.getMemberName(id);
    }
    
    // 이미지 파일 저장
    public String saveImage(MultipartFile file) {
        if (file.isEmpty()) {
            return "";
        }
        
        try {
            // 원본 파일명
            String originFilename = file.getOriginalFilename();
            
            // 파일 확장자
            String extension = originFilename.substring(originFilename.lastIndexOf("."));
            
            // 저장할 파일명 (UUID로 생성)
            String savedFilename = UUID.randomUUID().toString() + extension;
            
            // 저장 경로 생성
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // 파일 저장
            File destFile = new File(uploadDir + File.separator + savedFilename);
            file.transferTo(destFile);
            
            // URL 반환
            return uploadUrl + savedFilename;
            
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }
    
    // 게시글 작성자 ID 조회 메소드 추가
    public String getWriterId(int postId) {
        PostBean post = boardMapper.getPost(postId);
        return post != null ? post.getWriterId() : null;
    }
    
    // 게시글 제목 조회 메소드 추가
    public String getPostTitle(int postId) {
        return boardMapper.getPostTitle(postId);
    }
    
    // 참여자 수 카운트 메소드 추가 (ParticipationService에서 사용될 수 있음)
    public int countParticipants(int postId) {
        // 실제 구현은 ParticipationMapper나 별도의 메소드로 처리해야 할 수 있음
        // 여기서는 임시로 0을 반환
        return 0;
    }
    
    // 게시글 삭제 시 관련 데이터 처리를 위한 메소드
    public void deleteParticipationsByPostId(int postId) {
        // 실제 구현은 ParticipationMapper에서 처리
    }
}