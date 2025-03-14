package kr.co.soldesk.controller;


import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
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
    @PostMapping("/createRoom")
    public String createChatRoom(@RequestParam("buyer") String buyer, 
                                 @RequestParam("seller") String seller, 
                                 @RequestParam("title") String name, 
                                 Model model) {
    	if (buyer == null || buyer.isEmpty() || seller == null || seller.isEmpty() || name == null || name.isEmpty()) {
    	    throw new IllegalArgumentException("Invalid input data");
    	}
    	


    	try {
        	String decodedBuyerName = URLDecoder.decode(buyer, "UTF-8");
            String decodedSellerName = URLDecoder.decode(seller, "UTF-8");
    		
    	    ChatRoomBean chatRoom = chatService.createRoom(decodedBuyerName, decodedSellerName, name);
    	    
    	    System.out.println("컨트롤러: " + chatRoom.getId());
    	    System.out.println("컨트롤러: " + chatRoom.getName());
    	    
    	    //System.out.println(chatRoom.getBuyer());
    	    
    	    
    	    
    	    model.addAttribute("chatRoom", chatRoom);
    	    Integer id = chatRoom.getId();
    	    if (chatRoom == null || id == null) {
    	        throw new RuntimeException("Failed to create chat room");
    	    }

            //return "redirect:${root}/chat/room/" + chatRoom.getId();
    	    return "redirect:/chat/main?roomId=" + chatRoom.getId();
    	} catch (Exception e) {
    	    e.printStackTrace();
    	    return "error-page"; // 오류 페이지로 이동
    	}
    /*
    @PostMapping("/createRoom")
    public String createChatRoom(@RequestParam("buyer") String buyer, 
                                 @RequestParam("seller") String seller, 
                                 @RequestParam("title") String name, 
                                 Model model) {
    	if (buyer == null || buyer.isEmpty() || seller == null || seller.isEmpty() || name == null || name.isEmpty()) {
    	    throw new IllegalArgumentException("Invalid input data");
    	}
    	


    	try {
    		
        	String decodedBuyerName = URLDecoder.decode(buyer, "UTF-8");
            String decodedSellerName = URLDecoder.decode(seller, "UTF-8");
        	System.out.println("구매자: " + decodedBuyerName);
        	System.out.println("판매자: " + decodedSellerName);
    		
    		
    	    ChatRoomBean chatRoom = chatService.createRoom(buyer, seller, name);
    	    model.addAttribute("chatRoom", chatRoom);
    	    Integer id = chatRoom.getId();
    	    if (chatRoom == null || id == null) {
    	        throw new RuntimeException("Failed to create chat room");
    	    }

            //return "redirect:${root}/chat/room/" + chatRoom.getId();
    	    return "redirect:/chat/room/" + chatRoom.getId();
    	} catch (Exception e) {
    	    e.printStackTrace();
    	    return "error-page"; // 오류 페이지로 이동
    	}

     
    }*/   

    }
    
}
