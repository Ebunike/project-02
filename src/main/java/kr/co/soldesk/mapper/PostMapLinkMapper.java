package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.Delete;

import kr.co.soldesk.beans.PostMapLinkBean;

@Mapper
public interface PostMapLinkMapper {

    // 게시글-지도 연결 정보 저장
    @Insert("INSERT INTO post_map_links(id, post_id, map_id, latitude, longitude, address, marker_type) " +
            "VALUES(#{postMapLink.id}, #{postMapLink.postId}, #{postMapLink.mapId}, " +
            "#{postMapLink.latitude}, #{postMapLink.longitude}, #{postMapLink.address}, #{postMapLink.markerType})")
    @SelectKey(statement = "SELECT post_map_links_seq.NEXTVAL FROM DUAL",
            keyProperty = "postMapLink.id", before = true, resultType = int.class)
    void insertPostMapLink(@Param("postMapLink") PostMapLinkBean postMapLink);

    // 특정 게시글에 연결된 지도 정보 조회
    @Select("SELECT * FROM post_map_links WHERE post_id = #{postId}")
    List<PostMapLinkBean> getMapLinksByPostId(@Param("postId") int postId);

    // 특정 지도 마커에 연결된 게시글 ID 목록 조회
    @Select("SELECT post_id FROM post_map_links WHERE map_id = #{mapId}")
    List<Integer> getPostIdsByMapId(@Param("mapId") String mapId);

    // 카테고리별 지도 마커에 연결된 게시글 ID 목록 조회
    @Select("SELECT post_id FROM post_map_links WHERE marker_type = #{markerType}")
    List<Integer> getPostIdsByMarkerType(@Param("markerType") String markerType);

    // 특정 위치 반경 내의 게시글 ID 목록 조회 (Oracle의 경우)
    @Select("SELECT post_id FROM post_map_links " +
            "WHERE (latitude BETWEEN #{lat} - (#{radius}/111000) AND #{lat} + (#{radius}/111000)) " +
            "AND (longitude BETWEEN #{lng} - (#{radius}/(111000 * COS(RADIANS(#{lat})))) " +
            "AND #{lng} + (#{radius}/(111000 * COS(RADIANS(#{lat})))))")
    List<Integer> getPostIdsWithinRadius(@Param("lat") double latitude, @Param("lng") double longitude,
                                         @Param("radius") double radiusInMeters);

    // 게시글-지도 연결 정보 업데이트
    @Update("UPDATE post_map_links SET map_id = #{postMapLink.mapId}, " +
            "latitude = #{postMapLink.latitude}, longitude = #{postMapLink.longitude}, " +
            "address = #{postMapLink.address}, marker_type = #{postMapLink.markerType} " +
            "WHERE id = #{postMapLink.id}")
    void updatePostMapLink(@Param("postMapLink") PostMapLinkBean postMapLink);

    // 게시글-지도 연결 정보 삭제
    @Delete("DELETE FROM post_map_links WHERE id = #{id}")
    void deletePostMapLink(@Param("id") int id);

    // 특정 게시글의 모든 지도 연결 정보 삭제
    @Delete("DELETE FROM post_map_links WHERE post_id = #{postId}")
    void deleteAllMapLinksByPostId(@Param("postId") int postId);
}