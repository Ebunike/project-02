<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${oneday.oneday_name}</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>


    <div class="container">
        <div class="row">
            <!-- 클래스 정보 -->
            <div class="col-md-8">
                <div class="oneday-detail">
                    <div class="detail-image">
                        <img src="<c:url value='/upload/${oneday.oneday_imageUrl}'/>" alt="${oneday.oneday_name}">
                    </div>

                    <div class="detail-info">
                        <div class="detail-header">
                            <!-- 상태 표시 -->
                            <c:choose>
                                <c:when test="${oneday.current_participants >= oneday.oneday_max_participants}">
                                    <span class="status-tag status-full">마감</span>
                                </c:when>
                                <c:when test="${oneday.oneday_date < now}">
                                    <span class="status-tag status-closed">종료</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-tag status-open">예약가능</span>
                                </c:otherwise>
                            </c:choose>

                            <h1 class="detail-title">${oneday.oneday_name}</h1>

                            <div class="detail-meta">
                                <div class="detail-meta-item">
                                    <i class="far fa-calendar-alt"></i>
                                    <fmt:formatDate value="${oneday.oneday_date}" pattern="yyyy년 MM월 dd일 HH:mm"/>
                                </div>
                                <div class="detail-meta-item">
                                    <i class="fas fa-map-marker-alt"></i>
                                    ${oneday.oneday_location}
                                </div>
                                <div class="detail-meta-item">
                                    <i class="fas fa-tag"></i>
                                    ${oneday.theme_name}
                                </div>
                                <div class="detail-meta-item">
                                    <i class="fas fa-users"></i>
                                    ${oneday.current_participants}명 / ${oneday.oneday_max_participants}명
                                </div>
                            </div>

                            <div class="detail-price">
                                <fmt:formatNumber value="${oneday.oneday_price}" pattern="#,###"/>원
                            </div>
                        </div>

                        <div class="detail-section">
                            <h3 class="detail-section-title">클래스 소개</h3>
                            <div class="detail-description">${oneday.oneday_description}</div>
                        </div>

                        <div class="detail-section">
                            <h3 class="detail-section-title">준비물</h3>
                            <div class="detail-materials">${oneday.oneday_materials}</div>
                        </div>

                        <div class="detail-section">
                            <h3 class="detail-section-title">진행자 정보</h3>
                            <div class="host-info">
                                <p><strong>이름:</strong> ${oneday.seller_name}</p>
                         
                            </div>
                        </div>

                        <!-- 네이버 캘린더 연동 안내 -->
                        <c:if test="${not isNaverCalendarConnected}">
                            <div class="calendar-notice">
                                <p>
                                    <i class="fas fa-info-circle"></i>
                                    네이버 캘린더에 예약 일정을 추가하려면 <a href="<c:url value='/naver-calendar/auth'/>">네이버 캘린더 연동</a>을 진행해주세요.
                                </p>
                            </div>
                        </c:if>

                        <!-- 리뷰 섹션 -->
                        <div class="review-section">
                            <h3 class="detail-section-title">리뷰</h3>

                            <div id="reviewsContainer">
                                <div class="review-loading">
                                    <p>리뷰를 불러오는 중...</p>
                                </div>
                            </div>

                            <div class="text-center mt-4" id="reviewPagination"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 예약 정보 -->
            <div class="col-md-4">
                <div class="reservation-form">
                    <h3>예약하기</h3>

                    <c:choose>
                        <c:when test="${oneday.oneday_date < now}">
                            <div class="alert alert-secondary">
                                <p>이 클래스는 이미 종료되었습니다.</p>
                            </div>
                        </c:when>
                        <c:when test="${oneday.current_participants >= oneday.oneday_max_participants}">
                            <div class="alert alert-danger">
                                <p>이 클래스는 마감되었습니다.</p>
                            </div>
                        </c:when>
                        <c:when test="${empty loginMember.id}">
                            <div class="alert alert-warning">
                                <p>예약을 위해 <a href="<c:url value='/member/login'/>">로그인</a>이 필요합니다.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <form action="<c:url value='/oneday/payment/prepare/${oneday.oneday_index}'/>" method="get">
                                <div class="form-group">
                                    <label class="form-label" for="count">예약 인원</label>
                                    <select class="form-control" id="count" name="count">
                                        <c:forEach begin="1" end="${oneday.oneday_max_participants - oneday.current_participants}" var="i">
                                            <option value="${i}">${i}명</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="specialRequests">요청사항 (선택)</label>
                                    <textarea class="form-control" id="specialRequests" name="specialRequests" rows="3" placeholder="알레르기, 주차 등 요청사항을 입력해주세요."></textarea>
                                </div>

                                <div class="reservation-total">
                                    <p>총 금액: <span id="totalPrice"><fmt:formatNumber value="${oneday.oneday_price}" pattern="#,###"/>원</span></p>
                                </div>

                                <button type="submit" class="btn btn-primary btn-block">예약하기</button>
                            </form>
                        </c:otherwise>
                    </c:choose>

                    <div class="mt-3">
                        <c:if test="${oneday.seller_index == sellerIndex}">
                            <a href="<c:url value='/oneday/edit/${oneday.oneday_index}'/>" class="btn btn-secondary btn-block mb-2">클래스 수정</a>
                        </c:if>

                        <a href="<c:url value='/oneday/list'/>" class="btn btn-outline-secondary btn-block">목록으로</a>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <script>
    $(document).ready(function() {
        // 가격 계산
        $('#count').on('change', function() {
            const count = $(this).val();
            const price = ${oneday.oneday_price};
            const totalPrice = count * price;
            $('#totalPrice').text(totalPrice.toLocaleString() + '원');
        });

        // 리뷰 목록 로드
        loadReviews(1);

        function loadReviews(page) {
            $.ajax({
                url: '<c:url value="/oneday/review/list/${oneday.oneday_index}"/>',
                data: { page: page },
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    displayReviews(response);
                    displayPagination(response);
                },
                error: function(error) {
                    console.log(error);
                    $('#reviewsContainer').html('<p>리뷰를 불러오는 데 실패했습니다.</p>');
                }
            });
        }

        function displayReviews(response) {
            let html = '';

            if (response.reviews.length === 0) {
                html = '<p class="no-reviews">아직 리뷰가 없습니다.</p>';
            } else {
                html += '<div class="review-stats">';
                html += '<div class="review-average">' + response.averageRating.toFixed(1) + '</div>';
                html += '<div class="review-count"><span>' + response.reviewCount + '</span>개의 리뷰</div>';
                html += '</div>';

                html += '<div class="review-list">';
                response.reviews.forEach(function(review) {
                    html += '<div class="review-card">';
                    html += '<div class="review-header">';
                    html += '<div class="review-user">' + review.member_name + '</div>';

                    const date = new Date(review.register_date);
                    const formattedDate = date.getFullYear() + '-' +
                                         ('0' + (date.getMonth() + 1)).slice(-2) + '-' +
                                         ('0' + date.getDate()).slice(-2);

                    html += '<div class="review-date">' + formattedDate + '</div>';
                    html += '</div>';

                    html += '<div class="review-rating">';
                    for (let i = 1; i <= 5; i++) {
                        if (i <= review.rating) {
                            html += '<i class="fas fa-star star"></i>';
                        } else {
                            html += '<i class="far fa-star empty-star"></i>';
                        }
                    }
                    html += '</div>';

                    html += '<div class="review-content">' + review.content + '</div>';

                    if (review.review_imageUrl) {
                        html += '<div class="review-image-container">';
                        html += '<img src="<c:url value="/upload/"/>' + review.review_imageUrl + '" alt="리뷰 이미지" class="review-image">';
                        html += '</div>';
                    }

                    html += '</div>';
                });
                html += '</div>';
            }

            $('#reviewsContainer').html(html);
        }

        function displayPagination(response) {
            if (response.totalPages <= 1) {
                $('#reviewPagination').empty();
                return;
            }

            let html = '<ul class="pagination">';

            if (response.currentPage > 1) {
                html += '<li class="page-item"><a class="page-link" href="#" data-page="' + (response.currentPage - 1) + '">이전</a></li>';
            }

            for (let i = 1; i <= response.totalPages; i++) {
                if (i === response.currentPage) {
                    html += '<li class="page-item active"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>';
                } else {
                    html += '<li class="page-item"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>';
                }
            }

            if (response.currentPage < response.totalPages) {
                html += '<li class="page-item"><a class="page-link" href="#" data-page="' + (response.currentPage + 1) + '">다음</a></li>';
            }

            html += '</ul>';

            $('#reviewPagination').html(html);

            // 페이지 클릭 이벤트
            $('#reviewPagination').on('click', '.page-link', function(e) {
                e.preventDefault();
                const page = $(this).data('page');
                loadReviews(page);

                // 스크롤 위치 조정
                $('html, body').animate({
                    scrollTop: $('.review-section').offset().top - 100
                }, 500);
            });
        }
    });
    </script>
</body>
</html>