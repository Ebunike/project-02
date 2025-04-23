package kr.co.soldesk.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.PostMapLinkBean;
import kr.co.soldesk.service.PostMapLinkService;

@Controller
@RequestMapping("/postmap")
public class PostMapLinkController {

    @Autowired
    private PostMapLinkService postMapLinkService;
    
    @Resource(name="loginMemberBean")
    private MemberBean loginMember;
    
    /**
     * 게시글-지도 마커 연결 생성 API
     * @param postMapLink 게시글-지도 연결 정보
     * @return 처리 결과 ResponseEntity
     */
    @PostMapping("/link")
    @ResponseBody
    public ResponseEntity<?> createPostMapLink(@RequestBody PostMapLinkBean postMapLink) {
        try {
            postMapLinkService.createPostMapLink(postMapLink);
            return new ResponseEntity<>("장소가 게시글에 성공적으로 연결되었습니다.", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("장소 연결 중 오류가 발생했습니다: " + e.getMessage(), 
                                      HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * 카카오맵 마커와 게시글 연결 생성 API
     * @param postId 게시글 ID
     * @param mapId 카카오맵 마커 ID
     * @param latitude 위도
     * @param longitude 경도
     * @param address 주소
     * @param markerType 마커 유형
     * @return 처리 결과 ResponseEntity
     */
    @PostMapping("/linkFromKakaoMap")
    @ResponseBody
    public ResponseEntity<?> linkFromKakaoMap(
            @RequestParam("postId") int postId,
            @RequestParam("mapId") String mapId,
            @RequestParam("latitude") double latitude,
            @RequestParam("longitude") double longitude,
            @RequestParam("address") String address,
            @RequestParam("markerType") String markerType) {
        try {
            postMapLinkService.createFromKakaoMapMarker(postId, mapId, latitude, longitude, address, markerType);
            return new ResponseEntity<>("카카오맵 장소가 게시글에 성공적으로 연결되었습니다.", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("장소 연결 중 오류가 발생했습니다: " + e.getMessage(), 
                                      HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * 게시글에 연결된 지도 정보 조회 API
     * @param postId 게시글 ID
     * @return 지도 마커 정보 목록 ResponseEntity
     */
    @GetMapping("/postLinks/{postId}")
    @ResponseBody
    public ResponseEntity<?> getMapLinksByPostId(@PathVariable("postId") int postId) {
        try {
            List<PostMapLinkBean> mapLinks = postMapLinkService.getMapLinksByPostId(postId);
            return new ResponseEntity<>(mapLinks, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("정보 조회 중 오류가 발생했습니다: " + e.getMessage(), 
                                      HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * 지도 마커에 연결된 게시글 ID 목록 조회 API
     * @param mapId 지도 마커 ID
     * @return 게시글 ID 목록 ResponseEntity
     */
    @GetMapping("/mapLinks/{mapId}")
    @ResponseBody
    public ResponseEntity<?> getPostIdsByMapId(@PathVariable("mapId") String mapId) {
        try {
            List<Integer> postIds = postMapLinkService.getPostIdsByMapId(mapId);
            return new ResponseEntity<>(postIds, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("정보 조회 중 오류가 발생했습니다: " + e.getMessage(), 
                                      HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * 카테고리별 마커에 연결된 게시글 ID 목록 조회 API
     * @param markerType 마커 카테고리 유형
     * @return 게시글 ID 목록 ResponseEntity
     */
    @GetMapping("/categoryLinks/{markerType}")
    @ResponseBody
    public ResponseEntity<?> getPostIdsByMarkerType(@PathVariable("markerType") String markerType) {
        try {
            List<Integer> postIds = postMapLinkService.getPostIdsByMarkerType(markerType);
            return new ResponseEntity<>(postIds, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("정보 조회 중 오류가 발생했습니다: " + e.getMessage(), 
                                      HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * 반경 내 게시글 ID 목록 조회 API
     * @param latitude 위도
     * @param longitude 경도
     * @param radius 반경 (미터 단위)
     * @return 게시글 ID 목록 ResponseEntity
     */
    @GetMapping("/nearby")
    @ResponseBody
    public ResponseEntity<?> getPostIdsWithinRadius(
            @RequestParam("latitude") double latitude,
            @RequestParam("longitude") double longitude,
            @RequestParam("radius") double radius) {
        try {
            List<Integer> postIds = postMapLinkService.getPostIdsWithinRadius(latitude, longitude, radius);
            return new ResponseEntity<>(postIds, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("정보 조회 중 오류가 발생했습니다: " + e.getMessage(), 
                                      HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * 게시글-지도 연결 삭제 API
     * @param id 연결 정보 ID
     * @return 처리 결과 ResponseEntity
     */
    @PostMapping("/delete/{id}")
    @ResponseBody
    public ResponseEntity<?> deletePostMapLink(@PathVariable("id") int id) {
        try {
            postMapLinkService.deletePostMapLink(id);
            return new ResponseEntity<>("연결이 성공적으로 삭제되었습니다.", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("삭제 중 오류가 발생했습니다: " + e.getMessage(), 
                                      HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}