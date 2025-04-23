package kr.co.soldesk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.KakaoMapBean;
import kr.co.soldesk.mapper.KakaoMapMapper;

@Service
public class KakaoMapService {

    @Autowired
    private KakaoMapMapper kakaoMapMapper;
    
    /**
     * 장소 정보 저장
     */
    public void savePlace(KakaoMapBean placeInfo) {
        kakaoMapMapper.savePlace(placeInfo);
    }
    
    /**
     * 저장된 장소 목록 조회
     */
    public List<KakaoMapBean> getSavedPlaces(String memberId) {
        return kakaoMapMapper.getSavedPlaces(memberId);
    }
    
    /**
     * 장소 삭제
     */
    public void deletePlace(int identifier) {
        kakaoMapMapper.deletePlace(identifier);
    }
    
    /**
     * 카테고리별 장소 목록 조회
     */
    public List<KakaoMapBean> getCategoryPlaces(String memberId, String markerType) {
        return kakaoMapMapper.getCategoryPlaces(memberId, markerType);
    }
    
    /**
     * 주변 장소 검색
     * @param latitude 위도
     * @param longitude 경도
     * @param radius 반경 (미터)
     * @return 검색된 장소 목록
     */
    public List<KakaoMapBean> searchNearbyPlaces(double latitude, double longitude, double radius) {
        // 위도 1도는 약 111km, 경도 1도는 위도에 따라 다름 (cos(latitude)에 비례)
        // 간단한 계산을 위해 보정 계수를 적용
        double latDiff = radius / 111000; // 위도 차이 (도 단위)
        double lngDiff = radius / (111000 * Math.cos(Math.toRadians(latitude))); // 경도 차이 (도 단위)
        
        double minLat = latitude - latDiff;
        double maxLat = latitude + latDiff;
        double minLng = longitude - lngDiff;
        double maxLng = longitude + lngDiff;
        
        return kakaoMapMapper.searchNearbyPlaces(minLat, maxLat, minLng, maxLng);
    }
}