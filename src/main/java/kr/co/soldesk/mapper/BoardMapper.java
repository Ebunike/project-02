package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.PostBean;

public interface BoardMapper {
    
    // 게시글 목록 조회
    @Select("<script>"
          + "SELECT id, title, writer_id, regdate, max_participants, current_participants "
          + "FROM posts "
          + "<where>"
          + "    <if test='category != null and category != \"\"'>"
          + "        EXISTS (SELECT 1 FROM post_map_links WHERE post_id = posts.id AND marker_type = #{category})"
          + "    </if>"
          + "    <if test='searchType != null and searchType == \"title\" and keyword != null and keyword != \"\"'>"
          + "        AND title LIKE '%' || #{keyword} || '%'"
          + "    </if>"
          + "    <if test='searchType != null and searchType == \"content\" and keyword != null and keyword != \"\"'>"
          + "        AND content LIKE '%' || #{keyword} || '%'"
          + "    </if>"
          + "    <if test='searchType != null and searchType == \"writer\" and keyword != null and keyword != \"\"'>"
          + "        AND writer_id IN (SELECT id FROM members WHERE name LIKE '%' || #{keyword} || '%')"
          + "    </if>"
          + "    <if test='searchType != null and searchType == \"all\" and keyword != null and keyword != \"\"'>"
          + "        AND (title LIKE '%' || #{keyword} || '%' OR content LIKE '%' || #{keyword} || '%' "
          + "        OR writer_id IN (SELECT id FROM members WHERE name LIKE '%' || #{keyword} || '%'))"
          + "    </if>"
          + "</where>"
          + "ORDER BY id DESC "
          + "OFFSET #{start} ROWS FETCH NEXT 10 ROWS ONLY"
          + "</script>")
    List<PostBean> getPostList(@Param("start") int start, 
                             @Param("category") String category, 
                             @Param("searchType") String searchType, 
                             @Param("keyword") String keyword);
    
    // 게시글 수 조회
    @Select("<script>"
          + "SELECT COUNT(*) FROM posts "
          + "<where>"
          + "    <if test='category != null and category != \"\"'>"
          + "        EXISTS (SELECT 1 FROM post_map_links WHERE post_id = posts.id AND marker_type = #{category})"
          + "    </if>"
          + "    <if test='searchType != null and searchType == \"title\" and keyword != null and keyword != \"\"'>"
          + "        AND title LIKE '%' || #{keyword} || '%'"
          + "    </if>"
          + "    <if test='searchType != null and searchType == \"content\" and keyword != null and keyword != \"\"'>"
          + "        AND content LIKE '%' || #{keyword} || '%'"
          + "    </if>"
          + "    <if test='searchType != null and searchType == \"writer\" and keyword != null and keyword != \"\"'>"
          + "        AND writer_id IN (SELECT id FROM members WHERE name LIKE '%' || #{keyword} || '%')"
          + "    </if>"
          + "    <if test='searchType != null and searchType == \"all\" and keyword != null and keyword != \"\"'>"
          + "        AND (title LIKE '%' || #{keyword} || '%' OR content LIKE '%' || #{keyword} || '%' "
          + "        OR writer_id IN (SELECT id FROM members WHERE name LIKE '%' || #{keyword} || '%'))"
          + "    </if>"
          + "</where>"
          + "</script>")
    int getPostCount(@Param("category") String category, 
                    @Param("searchType") String searchType, 
                    @Param("keyword") String keyword);
    
    // 게시글 저장
    @SelectKey(statement = "SELECT post_seq.NEXTVAL FROM DUAL", 
              keyProperty = "id", 
              before = true, 
              resultType = int.class)
    @Insert("INSERT INTO posts (id, title, content, writer_id, max_participants, current_participants) "
          + "VALUES (#{id}, #{title}, #{content}, #{writerId}, #{maxParticipants}, 0)")
    void savePost(PostBean postBean);
    
    // 게시글 조회
    @Select("SELECT * FROM posts WHERE id = #{id}")
    PostBean getPost(int id);
    
    // 게시글 수정
    @Update("UPDATE posts SET title = #{title}, content = #{content}, "
          + "max_participants = #{maxParticipants} WHERE id = #{id}")
    void updatePost(PostBean postBean);
    
    // 게시글 삭제
    @Delete("DELETE FROM posts WHERE id = #{id}")
    void deletePost(int id);
    
    @Select("SELECT title FROM posts WHERE id = #{id}")
    String getPostTitle(int id);
}