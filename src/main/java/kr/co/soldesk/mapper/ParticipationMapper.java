package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.ParticipationBean;

@Mapper
public interface ParticipationMapper {
    
    /**
     * 참여 등록하기
     */
    @Insert("INSERT INTO participation(id, post_id, member_id, participation_date) " +
            "VALUES(participation_seq.NEXTVAL, #{postId}, #{memberId}, SYSDATE)")
    @SelectKey(statement = "SELECT participation_seq.CURRVAL FROM DUAL", 
              keyProperty = "id", before = false, resultType = int.class)
    void insertParticipation(ParticipationBean participationBean);
    
    /**
     * 특정 회원이 특정 게시글에 참여했는지 확인
     */
    @Select("SELECT COUNT(*) FROM participation WHERE post_id = #{postId} AND member_id = #{memberId}")
    int checkParticipation(@Param("postId") int postId, @Param("memberId") String memberId);
    
    /**
     * 대기자 리스트 확인
     */
    @Select("SELECT COUNT(*) FROM waiting_list WHERE post_id = #{postId} AND member_id = #{memberId}")
    int checkWaitingList(@Param("postId") int postId, @Param("memberId") String memberId);
    
    /**
     * 참여자 수 카운트
     */
    @Select("SELECT COUNT(*) FROM participation WHERE post_id = #{postId}")
    int countParticipants(int postId);
    
    /**
     * 게시글의 현재 참여자 수 업데이트
     */
    @Update("UPDATE posts SET current_participants = #{count} WHERE id = #{postId}")
    void updateCurrentParticipants(@Param("postId") int postId, @Param("count") int count);
    
    /**
     * 특정 게시글의 작성자 아이디 조회
     */
    @Select("SELECT writer_id FROM posts WHERE id = #{postId}")
    String getPostWriterId(@Param("postId") int postId);
    
    /**
     * 특정 게시글의 최대 참여자 수 조회
     */
    @Select("SELECT max_participants FROM posts WHERE id = #{postId}")
    int getMaxParticipants(@Param("postId") int postId);
    
    /**
     * 특정 게시글의 현재 참여자 수 조회
     */
    @Select("SELECT current_participants FROM posts WHERE id = #{postId}")
    int getCurrentParticipants(@Param("postId") int postId);
    
    /**
     * 참여 취소 (삭제)
     */
    @Delete("DELETE FROM participation WHERE post_id = #{postId} AND member_id = #{memberId}")
    void deleteParticipation(@Param("postId") int postId, @Param("memberId") String memberId);
    
    /**
     * 대기자 리스트에 추가
     */
    @Insert("INSERT INTO waiting_list(id, post_id, member_id, registration_date) " +
            "VALUES(waiting_list_seq.NEXTVAL, #{postId}, #{memberId}, SYSDATE)")
    void insertWaitingList(@Param("postId") int postId, @Param("memberId") String memberId);
    
    /**
     * 대기자 리스트에서 삭제
     */
    @Delete("DELETE FROM waiting_list WHERE post_id = #{postId} AND member_id = #{memberId}")
    void deleteFromWaitingList(@Param("postId") int postId, @Param("memberId") String memberId);
    
    /**
     * 첫 번째 대기자 조회
     */
    @Select("SELECT member_id FROM (" +
            "SELECT member_id FROM waiting_list WHERE post_id = #{postId} " +
            "ORDER BY registration_date ASC) WHERE ROWNUM = 1")
    String getFirstWaitingUser(@Param("postId") int postId);
    
    /**
     * 특정 게시글의 참여자 목록 조회
     */
    @Select("SELECT p.id, p.post_id, p.member_id, p.participation_date, m.name as memberName, m.email as memberEmail " +
            "FROM participation p JOIN member m ON p.member_id = m.id " +
            "WHERE p.post_id = #{postId} ORDER BY p.participation_date")
    List<ParticipationBean> getParticipantsByPostId(@Param("postId") int postId);
    
    /**
     * 특정 게시글의 대기자 목록 조회
     */
    @Select("SELECT w.id, w.post_id, w.member_id, w.registration_date, m.name as memberName, m.email as memberEmail " +
            "FROM waiting_list w JOIN member m ON w.member_id = m.id " +
            "WHERE w.post_id = #{postId} ORDER BY w.registration_date")
    List<ParticipationBean> getWaitingListByPostId(@Param("postId") int postId);
    
    /**
     * 게시글의 모든 참여 정보 삭제
     */
    @Delete("DELETE FROM participation WHERE post_id = #{postId}")
    void deleteParticipationsByPostId(int postId);
    
    /**
     * 게시글의 모든 대기자 정보 삭제
     */
    @Delete("DELETE FROM waiting_list WHERE post_id = #{postId}")
    void deleteWaitingListByPostId(int postId);
}