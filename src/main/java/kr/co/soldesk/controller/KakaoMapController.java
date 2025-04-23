package kr.co.soldesk.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.KakaoMapBean;
import kr.co.soldesk.service.KakaoMapService;

@Controller
@RequestMapping("/kakaomap")
public class KakaoMapController {

    @Autowired
    private KakaoMapService kakaoMapService;
    
    @Resource(name="loginMemberBean")
    private MemberBean loginMemberBean;
    
    /**
     * 카카오맵 메인 페이지 이동
     */
    @GetMapping("/main")
    public String kakaoMapMain(Model model) {
        model.addAttribute("loginMember", loginMemberBean);
        model.addAttribute("loginMemberBean", loginMemberBean);
        return "kakaomap/kakaomap_info";
    }
    
    /**
     * 장소 저장 API
     */
    @PostMapping("/savePlace") 
    @ResponseBody
    public ResponseEntity<?> savePlace(@RequestBody KakaoMapBean placeInfo) {
        try {
            kakaoMapService.savePlace(placeInfo);
            return new ResponseEntity<>("장소가 성공적으로 저장되었습니다.", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("장소 저장 중 오류가 발생했습니다: " + e.getMessage(), 
                                     HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * 저장된 장소 목록 조회 API
     */
    @GetMapping("/getSavedPlaces")
    @ResponseBody
    public List<KakaoMapBean> getSavedPlaces(@RequestParam("memberId") String memberId) {
        return kakaoMapService.getSavedPlaces(memberId);
    }
    
    /**
     * 장소 삭제 API
     */
    @PostMapping("/deletePlace")
    @ResponseBody
    public ResponseEntity<?> deletePlace(@RequestParam("identifier") int identifier) {
        try {
            kakaoMapService.deletePlace(identifier);
            return new ResponseEntity<>("장소가 성공적으로 삭제되었습니다.", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("장소 삭제 중 오류가 발생했습니다: " + e.getMessage(), 
                                     HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * 카테고리별 장소 목록 조회 API
     */
    @GetMapping("/getCategoryPlaces")
    @ResponseBody
    public List<KakaoMapBean> getCategoryPlaces(@RequestParam("memberId") String memberId, 
                                              @RequestParam("markerType") String markerType) {
        return kakaoMapService.getCategoryPlaces(memberId, markerType);
    }
    
    /**
     * 주변 장소 검색 API
     */
    @GetMapping("/searchNearbyPlaces")
    @ResponseBody
    public ResponseEntity<?> searchNearbyPlaces(
            @RequestParam("latitude") double latitude,
            @RequestParam("longitude") double longitude,
            @RequestParam(value="radius", defaultValue="1000") double radius) {
        try {
            List<KakaoMapBean> places = kakaoMapService.searchNearbyPlaces(latitude, longitude, radius);
            return new ResponseEntity<>(places, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("주변 장소 검색 중 오류가 발생했습니다: " + e.getMessage(), 
                                     HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @GetMapping("/locationPicker")
    public String locationPicker(Model model) {
        return "kakaomap/locationPicker";
    }
}