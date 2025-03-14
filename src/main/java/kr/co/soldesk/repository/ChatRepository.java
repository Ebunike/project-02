package kr.co.soldesk.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.ChatRoomBean;
import kr.co.soldesk.mapper.ChatMapper;

@Repository
public class ChatRepository {
	
	@Autowired
	private ChatMapper chatMapper;

    public void insertChatRoom(ChatRoomBean chatRoom) {
    	try {
    	    chatMapper.insertChatRoom(chatRoom);
    	} catch (Exception e) {
    	    throw new RuntimeException("Failed to insert chat room", e);
    	}

    }
    public List<ChatRoomBean> getAllChatRooms(){
    	return chatMapper.getAllChatRooms();
    }
    public int countByName(String name) {
    	return chatMapper.countByName(name);
    }
    public void createRoom(ChatRoomBean chatRoom) {
    	
    	chatMapper.createRoom(chatRoom);
    }
}
