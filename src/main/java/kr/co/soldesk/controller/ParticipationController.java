package kr.co.soldesk.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.ParticipationBean;
import kr.co.soldesk.service.BoardService;
import kr.co.soldesk.service.ParticipationService;

@Controller
@RequestMapping("/participation")
public class ParticipationController {

    @Autowired
    private ParticipationService participationService;
    
    @Autowired
    private BoardService boardService;
    
    @Resource(name="loginMemberBean")
    private MemberBean loginMemberBean;
    
    /**
     * 참여 상태 확인 API
     */
    @PostMapping("/checkStatus")
    @ResponseBody
    public Map<String, Object> checkStatus(@RequestParam("postId") int postId) {
        Map<String, Object> result = new HashMap<>();
        
        // 로그인 확인
        if(loginMemberBean.getId() == null) {
            result.put("error", "로그인이 필요합니다.");
            return result;
        }
        
        // 게시글 작성자 확인
        String writerId = boardService.getWriterId(postId);
        boolean isWriter = writerId.equals(loginMemberBean.getId());
        
        // 참여 여부 확인
        boolean hasParticipated = participationService.hasParticipated(postId, loginMemberBean.getId());
        
        // 대기자 등록 여부 확인
        boolean isWaiting = participationService.isInWaitingList(postId, loginMemberBean.getId());
        
        // 최대 참여자 수 및 현재 참여자 수 확인
        int maxParticipants = participationService.getMaxParticipants(postId);
        int currentParticipants = participationService.getCurrentParticipants(postId);
        boolean isFull = currentParticipants >= maxParticipants;
        
        // 결과 설정
        result.put("isWriter", isWriter);
        result.put("hasParticipated", hasParticipated);
        result.put("isWaiting", isWaiting);
        result.put("isFull", isFull);
        result.put("maxParticipants", maxParticipants);
        result.put("currentParticipants", currentParticipants);
        
        return result;
    }
    
    /**
     * 참여하기 API
     */
    @PostMapping("/participate")
    @ResponseBody
    public String participate(@RequestParam("postId") int postId) {
        // 로그인 확인
        if(loginMemberBean.getId() == null) {
            return "로그인이 필요합니다.";
        }
        
        int result = participationService.participate(postId, loginMemberBean.getId());
        
        switch(result) {
            case 0: return "참여가 완료되었습니다.";
            case 1: return "본인이 작성한 글은 참여할 수 없습니다.";
            case 2: return "이미 참여하셨습니다.";
            case 3: return "최대 참여자 수를 초과하였습니다.";
            default: return "참여 처리 중 오류가 발생했습니다.";
        }
    }
    
    /**
     * 참여 취소 API
     */
    @PostMapping("/cancel")
    @ResponseBody
    public String cancelParticipation(@RequestParam("postId") int postId) {
        // 로그인 확인
        if(loginMemberBean.getId() == null) {
            return "로그인이 필요합니다.";
        }
        
        int result = participationService.cancelParticipation(postId, loginMemberBean.getId());
        
        switch(result) {
            case 0: return "참여가 취소되었습니다.";
            case 1: return "참여하지 않은 상태입니다.";
            case 2: return "참여 취소 중 오류가 발생했습니다.";
            default: return "참여 취소 처리 중 오류가 발생했습니다.";
        }
    }
    
    /**
     * 대기자 등록 API
     */
    @PostMapping("/waitingList/register")
    @ResponseBody
    public String registerWaitingList(@RequestParam("postId") int postId) {
        // 로그인 확인
        if(loginMemberBean.getId() == null) {
            return "로그인이 필요합니다.";
        }
        
        int result = participationService.registerWaitingList(postId, loginMemberBean.getId());
        
        switch(result) {
            case 0: return "대기자로 등록되었습니다.";
            case 1: return "본인이 작성한 글은 참여할 수 없습니다.";
            case 2: return "이미 참여하셨습니다.";
            case 3: return "이미 대기자로 등록되어 있습니다.";
            case 4: return "대기자 등록 중 오류가 발생했습니다.";
            default: return "대기자 등록 처리 중 오류가 발생했습니다.";
        }
    }
    
    /**
     * 대기자 등록 취소 API
     */
    @PostMapping("/waitingList/cancel")
    @ResponseBody
    public String cancelWaitingList(@RequestParam("postId") int postId) {
        // 로그인 확인
        if(loginMemberBean.getId() == null) {
            return "로그인이 필요합니다.";
        }
        
        boolean result = participationService.cancelWaitingList(postId, loginMemberBean.getId());
        
        if(result) {
            return "대기자 등록이 취소되었습니다.";
        } else {
            return "대기자로 등록되어 있지 않습니다.";
        }
    }
    
    /**
     * 참여자 목록 페이지
     */
    @GetMapping("/list")
    public String participantsList(@RequestParam("postId") int postId, Model model) {
        // 참여자 목록
        List<ParticipationBean> participants = participationService.getParticipantsByPostId(postId);
        
        // 대기자 목록
        List<ParticipationBean> waitingList = participationService.getWaitingListByPostId(postId);
        
        // 최대 참여자 수
        int maxParticipants = participationService.getMaxParticipants(postId);
        
        model.addAttribute("postId", postId);
        model.addAttribute("participants", participants);
        model.addAttribute("waitingList", waitingList);
        model.addAttribute("maxParticipants", maxParticipants);
        
        return "participation/list";
    }
}