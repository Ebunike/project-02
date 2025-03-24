package kr.co.soldesk.controller;


import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
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
    public ResponseEntity<ChatRoomBean> createChatRoom(@RequestParam("buyer") String buyer, 
                                 @RequestParam("seller") String seller, 
                                 @RequestParam("title") String name) {
       

       
       if (buyer == null || buyer.isEmpty() || seller == null || seller.isEmpty() || name == null || name.isEmpty()) {
           throw new IllegalArgumentException("Invalid input data");
       }
           String decodedBuyerName;
           String decodedSellerName;
         try {
            decodedBuyerName = URLDecoder.decode(buyer, "UTF-8");
            decodedSellerName = URLDecoder.decode(seller, "UTF-8");

             
               ChatRoomBean room =  chatService.createRoom(decodedBuyerName, decodedSellerName, name);
               return ResponseEntity.ok(room);
         } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            // Return a meaningful error response
              return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ChatRoomBean("Error creating chat room")); 
         }

    }
    
}
