<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 상세보기</title>
<!-- Google Fonts - 한글 폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<style type="text/css">
    /* 기본 스타일 */
    body {
        background-color: #f5f7fa;
        font-family: 'Noto Sans KR', sans-serif;
        color: #333;
        line-height: 1.6;
    }
    
    /* 상단 메뉴 */
    .top_menu {
        width: 100%;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        position: sticky;
        top: 0;
        z-index: 100;
        background-color: #fff;
    }
    
    /* 본문 래퍼 */
    .content_wrapper {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: flex-start;
        min-height: calc(100vh - 160px);
        padding: 40px 20px;
    }
    
    /* 게시글 컨테이너 */
    .report_container {
        width: 800px;
        max-width: 90%;
        background: white;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        margin-bottom: 30px;
        border: none;
        transition: all 0.3s ease;
    }
    
    /* 게시글 제목 영역 */
    .title_box {
        border-bottom: 2px solid #e9ecef;
        margin-bottom: 20px;
        padding-bottom: 15px;
        position: relative;
    }
    
    .title_box h2 {
        font-weight: 700;
        font-size: 24px;
        color: #333;
        margin-bottom: 0;
        word-break: break-word;
    }
    
    /* 작성자, 날짜 정보 영역 */
    .report_info {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        flex-wrap: wrap;
        padding: 10px 0;
        border-bottom: 1px solid #e9ecef;
    }
    
    .author_info, .date_info {
        display: flex;
        align-items: center;
    }
    
    .author_info i, .date_info i {
        margin-right: 8px;
        color: #6c757d;
    }
    
    .author_info span, .date_info span {
        font-size: 15px;
        color: #6c757d;
    }
    
    /* 게시글 내용 영역 */
    .content_area {
        margin-bottom: 30px;
    }
    
    .content_label {
        font-size: 16px;
        font-weight: 500;
        margin-bottom: 10px;
        color: #495057;
    }
    
    .report_content {
        width: 100%;
        min-height: 300px;
        padding: 20px;
        border: 1px solid #e9ecef;
        border-radius: 8px;
        resize: none;
        background-color: #f8f9fa;
        color: #212529;
        line-height: 1.8;
        font-size: 16px;
    }
    
    /* 버튼 영역 */
    .action_buttons {
        display: flex;
        justify-content: center;
        margin-bottom: 30px;
    }
    
    .action_button {
        border: none;
        background: none;
        cursor: pointer;
        padding: 10px 15px;
        border-radius: 8px;
        display: flex;
        flex-direction: column;
        align-items: center;
        margin: 0 15px;
        transition: all 0.2s;
    }
    
    .action_button:hover {
        background-color: #f1f3f5;
        transform: translateY(-2px);
    }
    
    .action_button img {
        width: 30px;
        height: 30px;
        margin-bottom: 5px;
        object-fit: contain;
    }
    
    .action_button span {
        font-size: 14px;
        color: #6c757d;
    }
    
    /* 페이지 이동 버튼 */
    .nav_buttons {
        display: flex;
        justify-content: space-between;
        width: 800px;
        max-width: 90%;
        margin-bottom: 40px;
    }
    
    .list_button {
        background-color: #f8f9fa;
        color: #495057;
        border: 1px solid #dee2e6;
        padding: 8px 20px;
        border-radius: 6px;
        font-weight: 500;
        font-size: 15px;
        transition: all 0.2s;
    }
    
    .list_button:hover {
        background-color: #e9ecef;
        color: #212529;
    }
    
    /* 댓글 영역 */
    .comments_section {
        width: 800px;
        max-width: 90%;
        margin-bottom: 40px;
    }
    
    .comments_header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    
    .comments_title {
        font-size: 18px;
        font-weight: 700;
        color: #495057;
        display: flex;
        align-items: center;
    }
    
    .comments_title i {
        margin-right: 10px;
        color: #6c757d;
    }
    
    .comments_count {
        background-color: #4dabf7;
        color: white;
        padding: 3px 8px;
        border-radius: 12px;
        font-size: 14px;
        margin-left: 10px;
    }
    
    .comment_item {
        background-color: white;
        padding: 20px;
        border-radius: 10px;
        margin-bottom: 15px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
        border-left: 4px solid #4dabf7;
    }
    
    .comment_header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }
    
    .comment_author {
        font-weight: 600;
        font-size: 15px;
        color: #495057;
    }
    
    .comment_date {
        font-size: 13px;
        color: #adb5bd;
    }
    
    .comment_content {
        font-size: 15px;
        color: #495057;
        line-height: 1.6;
    }
    
    /* 댓글 작성 폼 */
    .comment_form {
        background-color: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
        margin-top: 20px;
    }
    
    .comment_form_header {
        font-size: 16px;
        font-weight: 600;
        margin-bottom: 15px;
        color: #495057;
    }
    
    .comment_textarea {
        width: 100%;
        height: 100px;
        padding: 15px;
        border: 1px solid #dee2e6;
        border-radius: 6px;
        margin-bottom: 15px;
        resize: none;
        font-family: 'Noto Sans KR', sans-serif;
        font-size: 15px;
    }
    
    .comment_textarea:focus {
        outline: none;
        border-color: #4dabf7;
        box-shadow: 0 0 0 3px rgba(77, 171, 247, 0.2);
    }
    
    .comment_submit {
        background-color: #4dabf7;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 6px;
        font-weight: 500;
        font-size: 15px;
        cursor: pointer;
        transition: all 0.2s;
        float: right;
    }
    
    .comment_submit:hover {
        background-color: #3b8ac4;
    }
    
    /* 반응형 스타일 */
    @media (max-width: 768px) {
        .report_container, .comments_section, .nav_buttons {
            width: 100%;
            max-width: 100%;
        }
        
        .title_box h2 {
            font-size: 20px;
        }
        
        .action_buttons {
            flex-wrap: wrap;
        }
    }
</style>
<script type="text/javascript">
    $(document).ready(function() {
        // 댓글 제출 이벤트 핸들러
        $("#commentForm").submit(function(e) {
            e.preventDefault();
            
            const commentContent = $("#commentContent").val().trim();
            if (commentContent === "") {
                alert("댓글 내용을 입력해주세요.");
                return;
            }
            
            // 실제로는 AJAX로 서버에 댓글을 저장하는 로직이 필요
            // 여기서는 간단하게 댓글을 화면에 추가하는 방식으로 구현
            
            const commentDate = new Date().toLocaleDateString('ko-KR', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit',
                hour: '2-digit',
                minute: '2-digit'
            });
            
            const commentHtml = `
                <div class="comment_item">
                    <div class="comment_header">
                        <div class="comment_author">${'${loginUser.id}'}</div>
                        <div class="comment_date">${commentDate}</div>
                    </div>
                    <div class="comment_content">${commentContent}</div>
                </div>
            `;
            
            $("#commentsContainer").append(commentHtml);
            
            // 댓글 카운트 증가
            const currentCount = parseInt($("#commentCount").text());
            $("#commentCount").text(currentCount + 1);
            
            // 폼 초기화
            $("#commentContent").val("");
        });
        
        // 좋아요/싫어요 버튼 이벤트
        $(".action_button").click(function() {
            const action = $(this).data("action");
            const countElement = $(this).find(".count");
            const currentCount = parseInt(countElement.text());
            
            // 실제로는 AJAX로 서버에 좋아요/싫어요를 저장하는 로직이 필요
            // 여기서는 간단하게 카운트를 증가시키는 방식으로 구현
            countElement.text(currentCount + 1);
        });
    });
</script>
</head>
<body>
    <!-- 상단 메뉴 부분 -->
    <div class="top_menu">
        <c:import url="/WEB-INF/views/include/top_menu.jsp" />
    </div>
    
    <div class="content_wrapper">
        <!-- 게시글 컨테이너 -->
        <div class="report_container">
            <!-- 제목 영역 -->
            <div class="title_box">
                <h2>${report.report_title}</h2>
            </div>
            
            <!-- 작성자 및 날짜 정보 -->
            <div class="report_info">
                <div class="author_info">
                    <i class="fas fa-user"></i>
                    <span>${report.id}</span>
                </div>
                <div class="date_info">
                    <i class="far fa-calendar-alt"></i>
                    <span>${report.report_date}</span>
                </div>
            </div>
            
            <!-- 내용 영역 -->
            <div class="content_area">
                <div class="content_label">내용</div>
                <textarea id="report_content" class="report_content" disabled>${report.report_content}</textarea>
            </div>
        </div>
        
        <!-- 목록 버튼 -->
        <div class="nav_buttons">
            <button class="list_button" onclick="location.href='${root}/report/report_list'">
                <i class="fas fa-list"></i> 목록으로
            </button>
        </div>
        
        <!-- 댓글 섹션 -->
        <div class="comments_section">
            <div class="comments_header">
                <div class="comments_title">
                    <i class="far fa-comments"></i> 댓글
                    <span class="comments_count" id="commentCount">0</span>
                </div>
            </div>
            
            <!-- 댓글 목록 -->
            <div id="commentsContainer">
                <!-- 댓글 아이템들이 여기에 동적으로 추가됨 -->
            </div>
            
            <!-- 댓글 작성 폼 -->
            <div class="comment_form">
                <div class="comment_form_header">댓글 작성</div>
                <form id="commentForm">
                    <textarea id="commentContent" class="comment_textarea" placeholder="댓글을 입력하세요..."></textarea>
                    <button type="submit" class="comment_submit">등록</button>
                    <div style="clear: both;"></div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- 하단 부분 -->
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>