package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.co.soldesk.beans.ChatRoomBean;

@Mapper
public interface ChatMapper {

    @Insert("INSERT INTO chat_rooms (id, name, created_at) VALUES (ChatRooms_seq.nextval, #{name}, sysdate)")
    void insertChatRoom(ChatRoomBean chatRoom);
    
    @Select("SELECT * FROM chat_rooms ORDER BY created_at DESC")
    List<ChatRoomBean> getAllChatRooms();
    
    @Select("SELECT COUNT(*) FROM chat_rooms WHERE name = #{name}")
    int countByName(String name);
}
