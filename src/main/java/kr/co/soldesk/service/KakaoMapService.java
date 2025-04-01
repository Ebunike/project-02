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
    
    // 장소 정보 저장
    public void savePlace(KakaoMapBean kakaoMapBean) {
        kakaoMapMapper.insertPlace(kakaoMapBean);
    }
    
    // 멤버 ID로 저장된 장소 목록 조회
    public List<KakaoMapBean> getSavedPlacesByMemberId(String memberId) {
        return kakaoMapMapper.selectPlacesByMemberId(memberId);
    }
    
    // 특정 장소 정보 조회
    public KakaoMapBean getPlaceByIdentifier(int identifier) {
        return kakaoMapMapper.selectPlaceByIdentifier(identifier);
    }
    
    // 장소 정보 삭제
    public void deletePlace(int identifier) {
        kakaoMapMapper.deletePlace(identifier);
    }
}