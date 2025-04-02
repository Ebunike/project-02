package kr.co.soldesk.service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.co.soldesk.beans.OnedayReservationDTO;
import kr.co.soldesk.beans.OnedayReviewDTO;
import kr.co.soldesk.mapper.OnedayReservationMapper;
import kr.co.soldesk.mapper.OnedayReviewMapper;

@Service
public class OnedayReviewService {

    private static final Logger logger = LoggerFactory.getLogger(OnedayReviewService.class);

    @Value("${uploadPath}")
    private String uploadPath;

    @Autowired
    private OnedayReviewMapper reviewMapper;

    @Autowired
    private OnedayReservationMapper reservationMapper;

    @Transactional
    public OnedayReviewDTO addReview(OnedayReviewDTO review, MultipartFile imageFile) {
        logger.info("리뷰 등록 - 클래스: {}, 회원: {}", review.getOneday_index(), review.getMember_id());

        try {
            OnedayReservationDTO reservation = reservationMapper.getReservationByIndex(review.getReservation_index());

            if (reservation == null || !reservation.getMember_id().equals(review.getMember_id())) {
                logger.error("예약 정보 없음 또는 권한 없음");
                throw new RuntimeException("예약 정보가 없거나 리뷰 작성 권한이 없습니다.");
            }

            OnedayReviewDTO existingReview = reviewMapper.getReviewByReservationIndex(review.getReservation_index());
            if (existingReview != null) {
                logger.error("이미 리뷰가 존재함");
                throw new RuntimeException("이미 이 예약에 대한 리뷰를 작성하셨습니다.");
            }

            if (imageFile != null && !imageFile.isEmpty()) {
                String imageUrl = saveReviewImage(imageFile);
                review.setReview_imageUrl(imageUrl);
            }

            int result = reviewMapper.insertReview(review);

            if (result > 0) {
                logger.info("리뷰 등록 성공 - 인덱스: {}", review.getReview_index());
                return reviewMapper.getReviewByIndex(review.getReview_index());
            } else {
                logger.error("리뷰 등록 실패");
                throw new RuntimeException("리뷰 등록에 실패했습니다.");
            }

        } catch (Exception e) {
            logger.error("리뷰 등록 중 오류 발생", e);
            throw new RuntimeException("리뷰 등록 중 오류가 발생했습니다: " + e.getMessage(), e);
        }
    }

    @Transactional
    public OnedayReviewDTO updateReview(OnedayReviewDTO review, MultipartFile imageFile) {
        logger.info("리뷰 수정 - 인덱스: {}, 회원: {}", review.getReview_index(), review.getMember_id());

        try {
            OnedayReviewDTO existingReview = reviewMapper.getReviewByIndex(review.getReview_index());

            if (existingReview == null || !existingReview.getMember_id().equals(review.getMember_id())) {
                logger.error("리뷰 정보 없음 또는 권한 없음");
                throw new RuntimeException("리뷰 정보가 없거나 수정 권한이 없습니다.");
            }

            if (imageFile != null && !imageFile.isEmpty()) {
                if (existingReview.getReview_imageUrl() != null && !existingReview.getReview_imageUrl().isEmpty()) {
                    deleteReviewImage(existingReview.getReview_imageUrl());
                }

                String imageUrl = saveReviewImage(imageFile);
                review.setReview_imageUrl(imageUrl);
            } else {
                review.setReview_imageUrl(existingReview.getReview_imageUrl());
            }

            int result = reviewMapper.updateReview(review);

            if (result > 0) {
                logger.info("리뷰 수정 성공 - 인덱스: {}", review.getReview_index());
                return reviewMapper.getReviewByIndex(review.getReview_index());
            } else {
                logger.error("리뷰 수정 실패");
                throw new RuntimeException("리뷰 수정에 실패했습니다.");
            }

        } catch (Exception e) {
            logger.error("리뷰 수정 중 오류 발생", e);
            throw new RuntimeException("리뷰 수정 중 오류가 발생했습니다: " + e.getMessage(), e);
        }
    }

    @Transactional
    public boolean deleteReview(int review_index, String member_id) {
        logger.info("리뷰 삭제 - 인덱스: {}, 회원: {}", review_index, member_id);

        try {
            OnedayReviewDTO existingReview = reviewMapper.getReviewByIndex(review_index);

            if (existingReview == null || !existingReview.getMember_id().equals(member_id)) {
                logger.error("리뷰 정보 없음 또는 권한 없음");
                throw new RuntimeException("리뷰 정보가 없거나 삭제 권한이 없습니다.");
            }

            if (existingReview.getReview_imageUrl() != null && !existingReview.getReview_imageUrl().isEmpty()) {
                deleteReviewImage(existingReview.getReview_imageUrl());
            }

            int result = reviewMapper.deleteReview(review_index, member_id);

            if (result > 0) {
                logger.info("리뷰 삭제 성공 - 인덱스: {}", review_index);
                return true;
            } else {
                logger.error("리뷰 삭제 실패");
                return false;
            }

        } catch (Exception e) {
            logger.error("리뷰 삭제 중 오류 발생", e);
            throw new RuntimeException("리뷰 삭제 중 오류가 발생했습니다: " + e.getMessage(), e);
        }
    }

    public List<OnedayReviewDTO> getReviewsByOnedayIndex(int oneday_index) {
        return reviewMapper.getReviewsByOnedayIndex(oneday_index);
    }

    public List<OnedayReviewDTO> getReviewsByOnedayIndexPaging(int oneday_index, int page, int pageSize) {
        int start = (page - 1) * pageSize + 1;
        return reviewMapper.getReviewsByOnedayIndexPaging(oneday_index, start, pageSize);
    }

    public List<OnedayReviewDTO> getReviewsByMemberId(String member_id) {
        return reviewMapper.getReviewsByMemberId(member_id);
    }

    public OnedayReviewDTO getReviewByIndex(int review_index) {
        return reviewMapper.getReviewByIndex(review_index);
    }

    public OnedayReviewDTO getReviewByReservationIndex(int reservation_index) {
        return reviewMapper.getReviewByReservationIndex(reservation_index);
    }

    public double getAverageRating(int oneday_index) {
        return reviewMapper.getAverageRating(oneday_index);
    }

    public int getReviewCount(int oneday_index) {
        return reviewMapper.getReviewCount(oneday_index);
    }

    private String saveReviewImage(MultipartFile imageFile) throws Exception {
        String originalFilename = imageFile.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String newFilename = "review_" + UUID.randomUUID().toString() + extension;

        String uploadDir = uploadPath != null ? uploadPath : "C:/soldesk/workspace/Project_hoon/src/main/webapp/upload";
        File reviewDir = new File(uploadDir + "/review");

        if (!reviewDir.exists()) {
            reviewDir.mkdirs();
        }

        File destFile = new File(reviewDir, newFilename);
        imageFile.transferTo(destFile);

        return "review/" + newFilename;
    }

    private void deleteReviewImage(String imageUrl) {
        if (imageUrl == null || imageUrl.isEmpty()) {
            return;
        }

        try {
            String uploadDir = uploadPath != null ? uploadPath : "C:/soldesk/workspace/Project_hoon/src/main/webapp/upload";
            File imageFile = new File(uploadDir, imageUrl);

            if (imageFile.exists()) {
                imageFile.delete();
                logger.info("이미지 파일 삭제 성공: {}", imageFile.getAbsolutePath());
            }
        } catch (Exception e) {
            logger.error("이미지 파일 삭제 중 오류 발생", e);
        }
    }
}