<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리뷰 수정 - ${oneday.oneday_name}</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

    <div class="container">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="review-edit-container">
                    <h2 class="text-center mb-4">리뷰 수정</h2>

                    <div class="oneday-summary mb-4">
                        <div class="row align-items-center">
                            <div class="col-md-3">
                                <img src="<c:url value='/upload/${oneday.oneday_imageUrl}'/>" alt="${oneday.oneday_name}" class="img-fluid rounded">
                            </div>
                            <div class="col-md-9">
                                <h4>${oneday.oneday_name}</h4>
                                <p>
                                    <i class="far fa-calendar-alt"></i>
                                    <fmt:formatDate value="${oneday.oneday_date}" pattern="yyyy-MM-dd HH:mm"/>
                                </p>
                                <p>
                                    <i class="fas fa-map-marker-alt"></i> ${oneday.oneday_location}
                                </p>
                            </div>
                        </div>
                    </div>

                    <form action="<c:url value='/oneday/review/edit'/>" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="review_index" value="${review.review_index}">
                        <input type="hidden" name="oneday_index" value="${review.oneday_index}">

                        <div class="form-group">
                            <label class="form-label">평점</label>
                            <div class="rating-input">
                                <div class="stars">
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${i <= review.rating}">
                                                <i class="fas fa-star rating-star" data-rating="${i}"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="far fa-star rating-star" data-rating="${i}"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                                <input type="hidden" name="rating" id="rating-value" value="${review.rating}">
                                <span class="rating-text ml-2">${review.rating}점</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="content">내용</label>
                            <textarea class="form-control" id="content" name="content" rows="6" required>${review.content}</textarea>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="imageFile">이미지 첨부 (선택사항)</label>
                            <div class="custom-file">
                                <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*">
                            </div>
                            <small class="form-text text-muted">새 이미지를 선택하면 기존 이미지가 교체됩니다.</small>

                            <div id="image-preview" class="mt-2">
                                <c:if test="${not empty review.review_imageUrl}">
                                    <img src="<c:url value='/upload/${review.review_imageUrl}'/>" class="img-fluid review-preview-image">
                                </c:if>
                            </div>
                        </div>

                        <div class="text-center mt-4">
                            <button type="submit" class="btn btn-primary">리뷰 수정</button>
                            <a href="<c:url value='/oneday/review/my-reviews'/>" class="btn btn-secondary ml-2">취소</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>



    <script>
    $(document).ready(function() {
        // 별점 선택 기능
        $('.rating-star').click(function() {
            let rating = $(this).data('rating');
            $('#rating-value').val(rating);
            $('.rating-text').text(rating + '점');

            // 별 아이콘 업데이트
            $('.rating-star').each(function(index) {
                if (index < rating) {
                    $(this).removeClass('far').addClass('fas');
                } else {
                    $(this).removeClass('fas').addClass('far');
                }
            });
        });

        // 이미지 미리보기
        $('#imageFile').change(function() {
            if (this.files && this.files[0]) {
                let reader = new FileReader();
                reader.onload = function(e) {
                    $('#image-preview').html('<img src="' + e.target.result + '" class="img-fluid review-preview-image">');
                }
                reader.readAsDataURL(this.files[0]);
            }
        });
    });
    </script>
</body>
</html>