package kr.co.soldesk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.PostBean;
import kr.co.soldesk.beans.PostMapLinkBean;
import kr.co.soldesk.mapper.PostMapLinkMapper;

@Service
public class PostMapLinkService {
    
    @Autowired
    private PostMapLinkMapper postMapLinkMapper;
    
    /**
     * 게시글과 지도 마커를 연결
     * @param postMapLink 게시글-지도 연결 정보
     */
    public void createPostMapLink(PostMapLinkBean postMapLink) {
        postMapLinkMapper.insertPostMapLink(postMapLink);
    }
    
    /**
     * 특정 게시글에 연결된 모든 지도 정보 조회
     * @param postId 게시글 ID
     * @return 연결된 지도 마커 정보 목록
     */
    public List<PostMapLinkBean> getMapLinksByPostId(int postId) {
        return postMapLinkMapper.getMapLinksByPostId(postId);
    }
    
    /**
     * 특정 지도 마커에 연결된 모든 게시글 ID 조회
     * @param mapId 지도 마커 ID
     * @return 연결된 게시글 ID 목록
     */
    public List<Integer> getPostIdsByMapId(String mapId) {
        return postMapLinkMapper.getPostIdsByMapId(mapId);
    }
    
    /**
     * 특정 카테고리의 지도 마커에 연결된 모든 게시글 ID 조회
     * @param markerType 마커 카테고리 유형
     * @return 연결된 게시글 ID 목록
     */
    public List<Integer> getPostIdsByMarkerType(String markerType) {
        return postMapLinkMapper.getPostIdsByMarkerType(markerType);
    }
    
    /**
     * 특정 위치 반경 내의 모든 게시글 ID 조회
     * @param latitude 위도
     * @param longitude 경도
     * @param radiusInMeters 반경 (미터 단위)
     * @return 반경 내 게시글 ID 목록
     */
    public List<Integer> getPostIdsWithinRadius(double latitude, double longitude, double radiusInMeters) {
        return postMapLinkMapper.getPostIdsWithinRadius(latitude, longitude, radiusInMeters);
    }
    
    /**
     * 게시글-지도 연결 정보 업데이트
     * @param postMapLink 업데이트할 연결 정보
     */
    public void updatePostMapLink(PostMapLinkBean postMapLink) {
        postMapLinkMapper.updatePostMapLink(postMapLink);
    }
    
    /**
     * 게시글-지도 연결 정보 삭제
     * @param id 연결 정보 ID
     */
    public void deletePostMapLink(int postId) {
        postMapLinkMapper.deleteAllMapLinksByPostId(postId);
    }
    
    /**
     * 게시글의 모든 지도 연결 정보 삭제
     * @param postId 게시글 ID
     */
    public void deleteAllMapLinksByPostId(int postId) {
        postMapLinkMapper.deleteAllMapLinksByPostId(postId);
    }
    
    /**
     * 카카오맵 마커 ID로 게시글-지도 연결 생성
     * @param postId 게시글 ID
     * @param mapId 카카오맵 마커 ID
     * @param latitude 위도
     * @param longitude 경도
     * @param address 주소
     * @param markerType 마커 유형
     */
    public void createFromKakaoMapMarker(int postId, String mapId, double latitude,
                                         double longitude, String address, String markerType) {
        PostMapLinkBean postMapLink = new PostMapLinkBean();
        postMapLink.setPostId(postId);
        postMapLink.setMapId(mapId);
        postMapLink.setLatitude(latitude);
        postMapLink.setLongitude(longitude);
        postMapLink.setAddress(address);
        postMapLink.setMarkerType(markerType);
        createPostMapLink(postMapLink);
    }
    
    /**
     * 게시글과 위치 정보 연결 (지도에서 위치 선택 시)
     * @param postId 게시글 ID
     * @param latitude 위도
     * @param longitude 경도
     * @param address 주소
     * @param markerType 마커 유형
     */
    public void savePostMapLink(int postId, Double latitude, Double longitude, String address, String markerType) {
        // 임의의 맵 ID 생성 (현재 시간 + 게시글 ID)
        String mapId = "map_" + System.currentTimeMillis() + "_" + postId;
        
        createFromKakaoMapMarker(postId, mapId, latitude, longitude, address, markerType);
    }
    
    /**
     * 게시글의 위치 정보 업데이트
     * @param postId 게시글 ID
     * @param latitude 위도
     * @param longitude 경도
     * @param address 주소
     * @param markerType 마커 유형
     */
    public void updatePostMapLink(int postId, Double latitude, Double longitude, String address, String markerType) {
        // 기존 연결 정보 조회
        List<PostMapLinkBean> links = postMapLinkMapper.getMapLinksByPostId(postId);
        
        if (links != null && !links.isEmpty()) {
            // 첫 번째 연결 정보 업데이트
            PostMapLinkBean link = links.get(0);
            link.setLatitude(latitude);
            link.setLongitude(longitude);
            link.setAddress(address);
            link.setMarkerType(markerType);
            
            postMapLinkMapper.updatePostMapLink(link);
        } else {
            // 연결 정보가 없으면 새로 생성
            savePostMapLink(postId, latitude, longitude, address, markerType);
        }
    }
    
    /**
     * 게시글에 위치 정보가 연결되어 있는지 확인
     * @param postId 게시글 ID
     * @return 위치 정보 연결 여부
     */
    public boolean hasPostMapLink(int postId) {
        List<PostMapLinkBean> links = postMapLinkMapper.getMapLinksByPostId(postId);
        return links != null && !links.isEmpty();
    }
    
    /**
     * 게시글의 위치 정보 조회 (PostBean 형태로 반환)
     * @param postId 게시글 ID
     * @return 위치 정보가 포함된 PostBean 객체
     */
    public PostBean getPostMapLink(int postId) {
        List<PostMapLinkBean> links = postMapLinkMapper.getMapLinksByPostId(postId);
        
        if (links != null && !links.isEmpty()) {
            PostMapLinkBean link = links.get(0);
            
            PostBean postBean = new PostBean();
            postBean.setId(postId);
            postBean.setLatitude(link.getLatitude());
            postBean.setLongitude(link.getLongitude());
            postBean.setAddress(link.getAddress());
            postBean.setMarkerType(link.getMarkerType());
            
            return postBean;
        }
        
        return null;
    }
    
    /**
     * 게시글의 마커 타입(카테고리) 조회
     * @param postId 게시글 ID
     * @return 마커 타입(카테고리)
     */
    public String getMarkerTypeByPostId(int postId) {
        List<PostMapLinkBean> links = postMapLinkMapper.getMapLinksByPostId(postId);
        
        if (links != null && !links.isEmpty()) {
            return links.get(0).getMarkerType();
        }
        
        return null;
    }
    
    /**
     * 게시글의 위치 정보 삭제
     * @param postId 게시글 ID
     */

}