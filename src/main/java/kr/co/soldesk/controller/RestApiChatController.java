package kr.co.soldesk.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.co.soldesk.beans.ChatRoomBean;
import kr.co.soldesk.service.ChatService;

@RestController
@RequestMapping("/chating")
public class RestApiChatController {

	@Autowired
	private ChatService chatService;
	
    @PostMapping("/create")
    public ResponseEntity<ChatRoomBean> createRoom(@RequestParam String name) {
        ChatRoomBean room = chatService.insertChatRoom(name);
        return ResponseEntity.ok(room);
    }
    
}
