package kr.co.soldesk.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.OnedayDTO;
import kr.co.soldesk.beans.OnedayReservationDTO;
import kr.co.soldesk.beans.OnedayReviewDTO;
import kr.co.soldesk.service.OnedayReservationService;
import kr.co.soldesk.service.OnedayReviewService;
import kr.co.soldesk.service.OnedayService;

@Controller
@RequestMapping("/oneday/review")
public class OnedayReviewController {

    private static final Logger logger = LoggerFactory.getLogger(OnedayReviewController.class);

    @Resource(name = "loginMemberBean")
    private MemberBean loginMember;

    @Autowired
    private OnedayReviewService reviewService;

    @Autowired
    private OnedayService onedayService;

    @Autowired
    private OnedayReservationService reservationService;

    @GetMapping("/write/{reservationIndex}")
    public String writeForm(@PathVariable("reservationIndex") int reservationIndex, Model model) {
        logger.info("리뷰 작성 폼 - 예약 인덱스: {}, 회원: {}", reservationIndex, loginMember.getId());

        if (loginMember.getId() == null) {
            return "redirect:/member/login";
        }

        OnedayReservationDTO reservation = reservationService.getReservationByIndex(reservationIndex);

        if (reservation == null || !reservation.getMember_id().equals(loginMember.getId())) {
            logger.error("예약 정보 없음 또는 권한 없음");
            return "redirect:/reservation/list";
        }

        OnedayReviewDTO existingReview = reviewService.getReviewByReservationIndex(reservationIndex);
        if (existingReview != null) {
            logger.error("이미 리뷰가 존재함");
            model.addAttribute("message", "이미 이 클래스에 대한 리뷰를 작성하셨습니다.");
            return "redirect:/reservation/list";
        }

        OnedayDTO oneday = onedayService.getOnedayByIndex(reservation.getOneday_index());

        model.addAttribute("oneday", oneday);
        model.addAttribute("reservation", reservation);
        model.addAttribute("loginMember", loginMember);

        return "review/write";
    }

    @PostMapping("/write")
    public String write(
            @RequestParam("oneday_index") int onedayIndex,
            @RequestParam("reservation_index") int reservationIndex,
            @RequestParam("rating") int rating,
            @RequestParam("content") String content,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            RedirectAttributes redirectAttributes) {

        logger.info("리뷰 등록 처리 - 클래스: {}, 예약: {}, 회원: {}", onedayIndex, reservationIndex, loginMember.getId());

        if (loginMember.getId() == null) {
            return "redirect:/member/login";
        }

        try {
            OnedayReviewDTO review = new OnedayReviewDTO();
            review.setOneday_index(onedayIndex);
            review.setReservation_index(reservationIndex);
            review.setMember_id(loginMember.getId());
            review.setRating(rating);
            review.setContent(content);

            reviewService.addReview(review, imageFile);

            redirectAttributes.addFlashAttribute("message", "리뷰가 성공적으로 등록되었습니다.");
            return "redirect:/oneday/detail/" + onedayIndex;

        } catch (Exception e) {
            logger.error("리뷰 등록 중 오류 발생", e);
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/oneday/review/write/" + reservationIndex;
        }
    }

    @GetMapping("/edit/{reviewIndex}")
    public String editForm(@PathVariable("reviewIndex") int reviewIndex, Model model) {
        logger.info("리뷰 수정 폼 - 리뷰 인덱스: {}, 회원: {}", reviewIndex, loginMember.getId());

        if (loginMember.getId() == null) {
            return "redirect:/member/login";
        }

        OnedayReviewDTO review = reviewService.getReviewByIndex(reviewIndex);

        if (review == null || !review.getMember_id().equals(loginMember.getId())) {
            logger.error("리뷰 정보 없음 또는 권한 없음");
            return "redirect:/reservation/list";
        }

        OnedayDTO oneday = onedayService.getOnedayByIndex(review.getOneday_index());

        model.addAttribute("oneday", oneday);
        model.addAttribute("review", review);
        model.addAttribute("loginMember", loginMember);

        return "review/edit";
    }

    @PostMapping("/edit")
    public String edit(
            @RequestParam("review_index") int reviewIndex,
            @RequestParam("oneday_index") int onedayIndex,
            @RequestParam("rating") int rating,
            @RequestParam("content") String content,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            RedirectAttributes redirectAttributes) {

        logger.info("리뷰 수정 처리 - 리뷰: {}, 회원: {}", reviewIndex, loginMember.getId());

        if (loginMember.getId() == null) {
            return "redirect:/member/login";
        }

        try {
            OnedayReviewDTO review = new OnedayReviewDTO();
            review.setReview_index(reviewIndex);
            review.setOneday_index(onedayIndex);
            review.setMember_id(loginMember.getId());
            review.setRating(rating);
            review.setContent(content);

            reviewService.updateReview(review, imageFile);

            redirectAttributes.addFlashAttribute("message", "리뷰가 성공적으로 수정되었습니다.");
            return "redirect:/oneday/detail/" + onedayIndex;

        } catch (Exception e) {
            logger.error("리뷰 수정 중 오류 발생", e);
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/oneday/review/edit/" + reviewIndex;
        }
    }

    @PostMapping("/delete")
    public String delete(
            @RequestParam("review_index") int reviewIndex,
            @RequestParam("oneday_index") int onedayIndex,
            RedirectAttributes redirectAttributes) {

        logger.info("리뷰 삭제 처리 - 리뷰: {}, 회원: {}", reviewIndex, loginMember.getId());

        if (loginMember.getId() == null) {
            return "redirect:/member/login";
        }

        try {
            boolean result = reviewService.deleteReview(reviewIndex, loginMember.getId());

            if (result) {
                redirectAttributes.addFlashAttribute("message", "리뷰가 성공적으로 삭제되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "리뷰 삭제에 실패했습니다.");
            }

            return "redirect:/oneday/detail/" + onedayIndex;

        } catch (Exception e) {
            logger.error("리뷰 삭제 중 오류 발생", e);
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/oneday/detail/" + onedayIndex;
        }
    }

    @GetMapping("/list/{onedayIndex}")
    @ResponseBody
    public ResponseEntity<?> getReviews(
            @PathVariable("onedayIndex") int onedayIndex,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "5") int size) {

        logger.info("클래스 리뷰 목록 조회 - 클래스: {}, 페이지: {}, 크기: {}", onedayIndex, page, size);

        try {
            List<OnedayReviewDTO> reviews = reviewService.getReviewsByOnedayIndexPaging(onedayIndex, page, size);

            double averageRating = reviewService.getAverageRating(onedayIndex);
            int reviewCount = reviewService.getReviewCount(onedayIndex);

            Map<String, Object> response = new HashMap<>();
            response.put("reviews", reviews);
            response.put("averageRating", averageRating);
            response.put("reviewCount", reviewCount);
            response.put("currentPage", page);
            response.put("totalReviews", reviewCount);
            response.put("totalPages", (int) Math.ceil((double) reviewCount / size));

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            logger.error("리뷰 목록 조회 중 오류 발생", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("리뷰 목록 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    @GetMapping("/my-reviews")
    public String myReviews(Model model) {
        logger.info("내 리뷰 목록 조회 - 회원: {}", loginMember.getId());

        if (loginMember.getId() == null) {
            return "redirect:/member/login";
        }

        List<OnedayReviewDTO> reviews = reviewService.getReviewsByMemberId(loginMember.getId());

        model.addAttribute("reviewList", reviews);
        model.addAttribute("loginMember", loginMember);

        return "review/my_reviews";
    }
}