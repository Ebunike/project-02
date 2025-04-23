package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;

import kr.co.soldesk.beans.KakaoMapBean;

@Mapper
public interface KakaoMapMapper {

    /**
     * 장소 정보 저장
     */
    @Insert("INSERT INTO saved_places (identifier, member_id, place_name, address_name, x, y, marker_type) " +
            "VALUES (#{placeInfo.identifier}, #{placeInfo.member_id}, #{placeInfo.place_name}, " +
            "#{placeInfo.address_name}, #{placeInfo.x}, #{placeInfo.y}, #{placeInfo.marker_type})")
    @SelectKey(statement = "SELECT place_seq.NEXTVAL FROM DUAL", 
              keyProperty = "placeInfo.identifier", before = true, resultType = int.class)
    void savePlace(@Param("placeInfo") KakaoMapBean placeInfo);
    
    /**
     * 저장된 장소 목록 조회
     */
    @Select("SELECT * FROM saved_places WHERE member_id = #{memberId} ORDER BY identifier DESC")
    List<KakaoMapBean> getSavedPlaces(@Param("memberId") String memberId);
    
    /**
     * 장소 삭제
     */
    @Delete("DELETE FROM saved_places WHERE identifier = #{identifier}")
    void deletePlace(@Param("identifier") int identifier);
    
    /**
     * 카테고리별 장소 목록 조회
     */
    @Select("SELECT * FROM saved_places WHERE member_id = #{memberId} AND marker_type = #{markerType} " +
            "ORDER BY identifier DESC")
    List<KakaoMapBean> getCategoryPlaces(@Param("memberId") String memberId, 
                                   @Param("markerType") String markerType);
    
    /**
     * 주변 장소 검색
     */
    @Select("SELECT * FROM saved_places " +
            "WHERE y BETWEEN #{minLat} AND #{maxLat} " +
            "AND x BETWEEN #{minLng} AND #{maxLng}")
    List<KakaoMapBean> searchNearbyPlaces(@Param("minLat") double minLat, 
                                   @Param("maxLat") double maxLat,
                                   @Param("minLng") double minLng,
                                   @Param("maxLng") double maxLng);
}