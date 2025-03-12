package kr.co.soldesk.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import kr.co.soldesk.beans.ChatMessage;
import kr.co.soldesk.beans.ChatRoomBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.service.ChatService;


//@RequestMapping("/chating") sendMessage메소드도 여기에 있어서 주석처리됨
@Controller
public class ChatController {
	
	@Resource(name = "loginMemberBean")
	private MemberBean loginUser;

    @Autowired
    private ChatService chatService;

    // 채팅방 목록 페이지 반환 (JSP 렌더링)
    @GetMapping("/chating/main")
    public String chatRoomList(Model model) {
        List<ChatRoomBean> rooms = chatService.getAllChatRooms();

        model.addAttribute("rooms", rooms); // DB의 채팅방 가져오기
        return "chat/main"; 
    }
    @GetMapping("/chating/room")
    public String enterChatRoom(@RequestParam("roomId") String roomId, Model model) {
    	model.addAttribute("sender", loginUser.getId());
        model.addAttribute("roomId", roomId);
        return "chat/chatRoom"; // chatRoom.jsp 렌더링
    }
    @MessageMapping("/chat/{roomId}") // 클라이언트에서 "/app/chat/{roomId}"로 보낸 메시지를 처리
    @SendTo("/topic/chat/{roomId}")   // 모든 구독자에게 메시지 전송
    public ChatMessage sendMessage(ChatMessage message) {
        System.out.println("받은 메시지: " + message.getContent());
        return message; // 클라이언트에게 메시지 전송
    }
}
