package kr.co.soldesk.service;

import java.io.File;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.ChatMessage;
import kr.co.soldesk.beans.ChatRoomBean;
import kr.co.soldesk.repository.ChatRepository;

@Service
public class ChatService {
 
   @Autowired
   private ChatRepository chatRepository;

   public ChatRoomBean insertChatRoom(String name) {

      if (chatRepository.countByName(name) > 0) {
         throw new IllegalArgumentException("이미 존재하는 채팅방입니다");
      }
      ChatRoomBean room = new ChatRoomBean(name);
      chatRepository.insertChatRoom(room);
      return room;
   }
   public ChatRoomBean createRoom(String buyer, String seller, String name) {
      
      ChatRoomBean chatRoom = new ChatRoomBean();
       chatRoom.setBuyer(buyer);
       chatRoom.setSeller(seller);
       chatRoom.setName(name); // 제목 설정
       
       
       chatRepository.createRoom(chatRoom);
       return chatRoom;
       
   }



   public List<ChatRoomBean> getAllChatRooms() {
      return chatRepository.getAllChatRooms();
   }
   
   public void saveChat(String roodId, ChatMessage message) {
      
      try {
         File file = new File("chat.json");
         Map<Integer, List<ChatMessage>> chatData;
         
         
      } catch (Exception e) {
         e.printStackTrace();
      }
      
   }
   

}
