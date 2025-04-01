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
    // 장소 정보 저장
    @Insert("INSERT INTO KakaoMaps (identifier, member_id, address_name, id, place_name, x, y) " +
            "VALUES (#{kakaoMapBean.identifier}, #{kakaoMapBean.member_id}, #{kakaoMapBean.address_name}, " +
            "#{kakaoMapBean.id}, #{kakaoMapBean.place_name}, #{kakaoMapBean.x}, #{kakaoMapBean.y})")
    @SelectKey(statement = "SELECT kakomaps_seq.NEXTVAL FROM DUAL", keyProperty = "kakaoMapBean.identifier", 
               before = true, resultType = int.class)
    void insertPlace(@Param("kakaoMapBean") KakaoMapBean kakaoMapBean);
    
    // 멤버 ID로 저장된 장소 목록 조회
    @Select("SELECT identifier, member_id, address_name, id, place_name, x, y " +
            "FROM KakaoMaps WHERE member_id = #{member_id} ORDER BY identifier DESC")
    List<KakaoMapBean> selectPlacesByMemberId(@Param("member_id") String memberId);
    
    // 특정 장소 정보 조회
    @Select("SELECT identifier, member_id, address_name, id, place_name, x, y " +
            "FROM KakaoMaps WHERE identifier = #{identifier}")
    KakaoMapBean selectPlaceByIdentifier(@Param("identifier") int identifier);
    
    // 장소 정보 삭제
    @Delete("DELETE FROM KakaoMaps WHERE identifier = #{identifier}")
    void deletePlace(@Param("identifier") int identifier);
}