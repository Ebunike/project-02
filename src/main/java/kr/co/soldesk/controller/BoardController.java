package kr.co.soldesk.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.soldesk.beans.CommentBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.PageBean;
import kr.co.soldesk.beans.ParticipationBean;
import kr.co.soldesk.beans.PostBean;
import kr.co.soldesk.service.BoardService;
import kr.co.soldesk.service.CommentService;
import kr.co.soldesk.service.ParticipationService;
import kr.co.soldesk.service.PostMapLinkService;

@Controller
@RequestMapping("/board")
public class BoardController {
    
    @Autowired
    private BoardService boardService;
    
    @Autowired
    private CommentService commentService;
    
    @Autowired
    private ParticipationService participationService;
    
    @Autowired
    private PostMapLinkService postMapLinkService;
    
    @Resource(name = "loginMemberBean")
    private MemberBean loginMember;
    
    // 게시판 메인 페이지
    @GetMapping("/main")
    public String main(@RequestParam(value = "page", defaultValue = "1") int page,
                       @RequestParam(value = "category", required = false) String category,
                       @RequestParam(value = "searchType", required = false) String searchType,
                       @RequestParam(value = "keyword", required = false) String keyword,
                       Model model) {
        
    	model.addAttribute("loginMemberBean", loginMember);
        // 페이지 계산을 위한 게시글 수
        int totalPosts = boardService.getPostCount(category, searchType, keyword);
        
        // 페이지 계산
        PageBean pageBean = new PageBean(page, totalPosts, 10, 5);
        model.addAttribute("pageBean", pageBean);
        
        // 게시글 목록 조회
        List<PostBean> posts = boardService.getPostList(page, category, searchType, keyword);
        model.addAttribute("posts", posts);
        
        // 게시글 목록에 작성자 이름 추가
        for (PostBean post : posts) {
            post.setWriterName(boardService.getMemberName(post.getWriterId()));
            
            // 참여자 수 업데이트
            int currentParticipants = participationService.countParticipants(post.getId());
            post.setCurrentParticipants(currentParticipants);
            
            // 카테고리(마커 타입) 설정
            String markerType = postMapLinkService.getMarkerTypeByPostId(post.getId());
            post.setMarkerType(markerType);
        }
        
        model.addAttribute("currentPage", page);
        //model.addAttribute("totalPages", pageBean.getPageCount());
        model.addAttribute("category", category);
        model.addAttribute("searchType", searchType);
        model.addAttribute("keyword", keyword);
        
        return "board/main";
    }
    
    // 게시글 작성 페이지
    @GetMapping("/write")
    public String write(@ModelAttribute("postBean") PostBean postBean,
    		Model model) {
        // 로그인 체크
        if (loginMember.getLogin().equals("x")) {
            return "redirect:/member/login";
        }
        
        // 최대 참여자 수 기본값 설정
        postBean.setMaxParticipants(10);
        model.addAttribute("loginMemberBean", loginMember);
        return "board/write";
    }
    
    // 게시글 작성 처리
    @PostMapping("/writeProc")
    public String writeProc(@Valid @ModelAttribute("postBean") PostBean postBean,
                           BindingResult result) {
        // 로그인 체크
        if (loginMember.getLogin().equals("x")) {
            return "redirect:/member/login";
        }
        
        if (result.hasErrors()) {
            return "board/write";
        }
        
        // 작성자 ID 설정
        postBean.setWriterId(loginMember.getId());
        
        // 게시글 저장
        int postId = boardService.savePost(postBean);
        
        // 위치 정보가 있는 경우 지도와 연결
        if (postBean.getLatitude() != null && postBean.getLongitude() != null) {
            postMapLinkService.savePostMapLink(postId, postBean.getLatitude(), postBean.getLongitude(),
                                              postBean.getAddress(), postBean.getMarkerType());
        }
        
        return "redirect:/board/read?id=" + postId;
    }
    
    // 게시글 상세 페이지
    @GetMapping(value = "/read", produces = "text/html; charset=UTF-8")
    public String read(@RequestParam("id") int id, Model model, HttpServletRequest request) throws UnsupportedEncodingException {
        // 게시글 정보 조회
    	request.setCharacterEncoding("UTF-8");
        PostBean post = boardService.getPost(id);
        if (post == null) {
            return "redirect:/board/main";
        }
        
        // 작성자 이름 설정
        post.setWriterName(boardService.getMemberName(post.getWriterId()));
        
        // 참여자 수 업데이트
        int currentParticipants = participationService.countParticipants(id);
        post.setCurrentParticipants(currentParticipants);
        
        // 위치 정보 조회
        if (postMapLinkService.hasPostMapLink(id)) {
            PostBean postMapInfo = postMapLinkService.getPostMapLink(id);
            post.setLatitude(postMapInfo.getLatitude());
            post.setLongitude(postMapInfo.getLongitude());
            post.setAddress(postMapInfo.getAddress());
            post.setMarkerType(postMapInfo.getMarkerType());
        }
        
        // 댓글 목록 조회
        List<CommentBean> comments = commentService.getCommentsByPostId(id);
        
        // 댓글 작성자 이름 설정
        for (CommentBean comment : comments) {
            comment.setWriterName(boardService.getMemberName(comment.getWriterId()));
        }
        
        // 참여자 목록 조회
        List<ParticipationBean> participants = participationService.getParticipantsByPostId(id);
        
        // 로그인한 사용자의 참여 여부 확인
        boolean isParticipating = false;
        boolean isWaiting = false;
        
        if (!loginMember.getLogin().equals("x")) {
            isParticipating = participationService.checkParticipation(id, loginMember.getId());
            isWaiting = participationService.checkWaitingList(id, loginMember.getId());
        }
        
        model.addAttribute("post", post);
        model.addAttribute("comments", comments);
        model.addAttribute("participants", participants);
        model.addAttribute("isParticipating", isParticipating);
        model.addAttribute("isWaiting", isWaiting);
        model.addAttribute("loginMemberBean", loginMember);
        
        return "board/read";
    }
    
    // 게시글 수정 페이지
    @GetMapping("/modify")
    public String modify(@RequestParam("id") int id, 
                        @ModelAttribute("postBean") PostBean postBean,
                        Model model) {
        // 로그인 체크
        if (loginMember.getLogin().equals("x")) {
            return "redirect:/member/login";
        }
        
        // 게시글 정보 조회
        PostBean original = boardService.getPost(id);
        
        // 게시글이 없거나 작성자가 아닌 경우
        if (original == null || !original.getWriterId().equals(loginMember.getId())) {
            return "redirect:/board/main";
        }
        
        // 폼에 데이터 설정
        postBean.setId(original.getId());
        postBean.setTitle(original.getTitle());
        postBean.setContent(original.getContent());
        postBean.setMaxParticipants(original.getMaxParticipants());
        postBean.setWriterId(original.getWriterId());
        
        // 위치 정보 조회
        if (postMapLinkService.hasPostMapLink(id)) {
            PostBean postMapInfo = postMapLinkService.getPostMapLink(id);
            postBean.setLatitude(postMapInfo.getLatitude());
            postBean.setLongitude(postMapInfo.getLongitude());
            postBean.setAddress(postMapInfo.getAddress());
            postBean.setMarkerType(postMapInfo.getMarkerType());
        }
        model.addAttribute("loginMemberBean", loginMember);
        
        return "board/modify";
    }
    
    // 게시글 수정 처리
    @PostMapping("/modifyProc")
    public String modifyProc(@Valid @ModelAttribute("postBean") PostBean postBean,
                            BindingResult result) {
        // 로그인 체크
        if (loginMember.getLogin().equals("x")) {
            return "redirect:/member/login";
        }
        
        if (result.hasErrors()) {
            return "board/modify";
        }
        
        // 원본 게시글 조회
        PostBean original = boardService.getPost(postBean.getId());
        
        // 게시글이 없거나 작성자가 아닌 경우
        if (original == null || !original.getWriterId().equals(loginMember.getId())) {
            return "redirect:/board/main";
        }
        
        // 작성자 ID 설정
        postBean.setWriterId(loginMember.getId());
        
        // 게시글 수정
        boardService.updatePost(postBean);
        
        // 위치 정보 업데이트
        if (postBean.getLatitude() != null && postBean.getLongitude() != null) {
            if (postMapLinkService.hasPostMapLink(postBean.getId())) {
                postMapLinkService.updatePostMapLink(postBean.getId(), postBean.getLatitude(), 
                                                  postBean.getLongitude(), postBean.getAddress(), 
                                                  postBean.getMarkerType());
            } else {
                postMapLinkService.savePostMapLink(postBean.getId(), postBean.getLatitude(), 
                                                 postBean.getLongitude(), postBean.getAddress(), 
                                                 postBean.getMarkerType());
            }
        } else if (postMapLinkService.hasPostMapLink(postBean.getId())) {
            // 위치 정보 삭제
            postMapLinkService.deletePostMapLink(postBean.getId());
        }
        
        return "redirect:/board/read?id=" + postBean.getId();
    }
    
    // 게시글 삭제
    @PostMapping("/delete")
    @ResponseBody
    public String delete(@RequestParam("id") int id, Model model) {
        // 로그인 체크
        if (loginMember.getLogin().equals("x")) {
            return "로그인이 필요합니다.";
        }
        model.addAttribute("loginMemberBean", loginMember);
        // 게시글 정보 조회
        PostBean post = boardService.getPost(id);
        
        // 게시글이 없거나 작성자가 아닌 경우
        if (post == null || !post.getWriterId().equals(loginMember.getId())) {
            return "권한이 없습니다.";
        }
        
        // 게시글에 연결된 데이터 삭제
        commentService.deleteCommentsByPostId(id);
        participationService.deleteParticipationsByPostId(id);
        
        // 위치 정보 삭제
        if (postMapLinkService.hasPostMapLink(id)) {
            postMapLinkService.deletePostMapLink(id);
        }
        
        // 게시글 삭제
        boardService.deletePost(id);
        
        return "success";
    }
    
    // 이미지 업로드
    @PostMapping("/uploadImage")
    @ResponseBody
    public String uploadImage(@RequestParam("file") MultipartFile file) {
        // 이미지 파일 저장 및 URL 반환
        String imageUrl = boardService.saveImage(file);
        return "{\"url\": \"" + imageUrl + "\"}";
    }
}