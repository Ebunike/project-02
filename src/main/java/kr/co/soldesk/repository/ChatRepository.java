package kr.co.soldesk.repository;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.ChatRoomBean;
import kr.co.soldesk.mapper.ChatMapper;

@Repository
public class ChatRepository {
	
	@Autowired
	private ChatMapper chatMapper;

    public void insertChatRoom(ChatRoomBean chatRoom) {
    	chatMapper.insertChatRoom(chatRoom);
    }
    public List<ChatRoomBean> getAllChatRooms(){
    	return chatMapper.getAllChatRooms();
    }
    public int countByName(String name) {
    	return chatMapper.countByName(name);
    }
}
