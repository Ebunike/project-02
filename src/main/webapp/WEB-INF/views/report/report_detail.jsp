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
        background-color: #f9f9f9;
        font-family: 'Noto Sans KR', sans-serif;
        color: #333;
        line-height: 1.6;
    }
    
    /* 상단 메뉴 */
    .top_menu {
        width: 100%;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        position: sticky;
        top: 0;
        z-index: 100;
        background-color: #fff;
        margin-bottom: 40px;
    }
    
    /* 본문 래퍼 */
    .content_wrapper {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: flex-start;
        min-height: calc(100vh - 160px);
        padding: 0 20px 40px;
        max-width: 900px;
        margin: 0 auto;
    }
    
    /* 관리자 댓글 스타일 */
    .admin_comment {
        background: linear-gradient(to right, #e3f2fd, #f0f8ff);
        border-left: 4px solid #2196F3;
        font-weight: 500;
        box-shadow: 0 4px 15px rgba(33, 150, 243, 0.1);
    }

    .admin_comment .comment_author {
        color: #1976D2;
        font-weight: 700;
    }
    
    /* 게시글 컨테이너 */
    .report_container {
        width: 100%;
        background: white;
        padding: 35px;
        border-radius: 15px;
        box-shadow: 0 5px 30px rgba(0, 0, 0, 0.05);
        margin-bottom: 30px;
        border: none;
        transition: all 0.3s ease;
    }
    
    .report_container:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 35px rgba(0, 0, 0, 0.07);
    }
    
    /* 게시글 제목 영역 */
    .title_box {
        border-bottom: 2px solid #e9ecef;
        margin-bottom: 25px;
        padding-bottom: 20px;
        position: relative;
    }
    
    .title_box h2 {
        font-weight: 700;
        font-size: 26px;
        color: #333;
        margin-bottom: 0;
        word-break: break-word;
        line-height: 1.4;
    }
    
    /* 작성자, 날짜 정보 영역 */
    .report_info {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        flex-wrap: wrap;
        padding: 10px 15px;
        border-radius: 10px;
        background-color: #f8f9fa;
    }
    
    .author_info, .date_info {
        display: flex;
        align-items: center;
    }
    
    .author_info i, .date_info i {
        margin-right: 10px;
        color: #FF6347;
    }
    
    .author_info span, .date_info span {
        font-size: 16px;
        color: #495057;
        font-weight: 500;
    }
    
    /* 게시글 내용 영역 */
    .content_area {
        margin-bottom: 30px;
    }
    
    .content_label {
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 15px;
        color: #333;
    }
    
    .report_content {
        width: 100%;
        min-height: 300px;
        padding: 25px;
        border: 1px solid #e9ecef;
        border-radius: 10px;
        resize: none;
        background-color: #f8f9fa;
        color: #212529;
        line-height: 1.8;
        font-size: 16px;
        box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.05);
    }
    
    /* 버튼 영역 */
    .action_buttons {
        display: flex;
        justify-content: center;
        margin: 0 0 30px;
        flex-wrap: wrap;
        gap: 20px;
    }
    
    .action_button {
        background-color: white;
        border: 1px solid #e9ecef;
        cursor: pointer;
        padding: 15px;
        border-radius: 10px;
        display: flex;
        flex-direction: column;
        align-items: center;
        margin: 0;
        transition: all 0.3s ease;
        min-width: 80px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.03);
    }
    
    .action_button:hover {
        background-color: #f8f9fa;
        transform: translateY(-3px);
        box-shadow: 0 8px 15px rgba(0, 0, 0, 0.07);
    }
    
    .action_button img {
        width: 24px;
        height: 24px;
        margin-bottom: 8px;
        object-fit: contain;
    }
    
    .action_button span {
        font-size: 14px;
        color: #495057;
        font-weight: 500;
    }
    
    /* 페이지 이동 버튼 */
    .nav_buttons {
        display: flex;
        justify-content: space-between;
        width: 100%;
        margin-bottom: 40px;
    }
    
    .list_button {
        background: linear-gradient(90deg, #FF6347, #FF8C69);
        color: white;
        border: none;
        padding: 12px 25px;
        border-radius: 8px;
        font-weight: 500;
        font-size: 16px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 10px rgba(255, 99, 71, 0.2);
        display: flex;
        align-items: center;
    }
    
    .list_button:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(255, 99, 71, 0.3);
        background: linear-gradient(90deg, #FF5847, #FF7C59);
    }
    
    .list_button i {
        margin-right: 8px;
    }
    
    /* 댓글 섹션 */
    .comments_section {
        width: 100%;
        margin-bottom: 40px;
    }
    
    .comments_header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 2px solid #e9ecef;
    }
    
    .comments_title {
        font-size: 20px;
        font-weight: 700;
        color: #333;
        display: flex;
        align-items: center;
    }
    
    .comments_title i {
        margin-right: 10px;
        color: #FF6347;
    }
    
    .comments_count {
        background: linear-gradient(90deg, #FF6347, #FF8C69);
        color: white;
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 14px;
        margin-left: 12px;
        box-shadow: 0 2px 5px rgba(255, 99, 71, 0.3);
    }
    
    .comment_item {
        background-color: white;
        padding: 20px;
        border-radius: 12px;
        margin-bottom: 20px;
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
        border-left: 4px solid #e9ecef;
        transition: all 0.3s ease;
    }
    
    .comment_item:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
    }
    
    .comment_header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 15px;
        padding-bottom: 10px;
        border-bottom: 1px solid #f1f3f5;
    }
    
    .comment_author {
        font-weight: 600;
        font-size: 16px;
        color: #333;
    }
    
    .comment_date {
        font-size: 14px;
        color: #adb5bd;
    }
    
    .comment_content {
        font-size: 16px;
        color: #495057;
        line-height: 1.7;
    }
    
    .comment_actions {
        margin-left: 15px;
    }
    
    /* 댓글 작성 폼 */
    .comment_form {
        background-color: white;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
        margin-top: 30px;
        border-top: 4px solid #FF6347;
    }
    
    .comment_form_header {
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 20px;
        color: #333;
    }
    
    .comment_textarea {
        width: 100%;
        height: 120px;
        padding: 15px;
        border: 1px solid #e9ecef;
        border-radius: 8px;
        margin-bottom: 20px;
        resize: none;
        font-family: 'Noto Sans KR', sans-serif;
        font-size: 16px;
        box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.05);
    }
    
    .comment_textarea:focus {
        outline: none;
        border-color: #FF6347;
        box-shadow: 0 0 0 3px rgba(255, 99, 71, 0.2);
    }
    
    .comment_submit {
        background: linear-gradient(90deg, #FF6347, #FF8C69);
        color: white;
        border: none;
        padding: 12px 25px;
        border-radius: 8px;
        font-weight: 500;
        font-size: 16px;
        cursor: pointer;
        transition: all 0.3s ease;
        float: right;
        box-shadow: 0 4px 10px rgba(255, 99, 71, 0.2);
    }
    
    .comment_submit:hover {
        background: linear-gradient(90deg, #FF5847, #FF7C59);
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(255, 99, 71, 0.3);
    }
    
    .comment_list {
        margin-top: 30px;
    }
    
    .comment_list h3 {
        font-weight: 700;
        font-size: 20px;
        color: #333;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 2px solid #e9ecef;
    }
    
    /* 삭제 버튼 크기 조정 */
    .comment_actions .action_button {
        padding: 8px;
        min-width: auto;
    }
    
    .comment_actions .action_button img {
        width: 16px;
        height: 16px;
        margin-bottom: 5px;
    }
    
    /* 반응형 스타일 */
    @media (max-width: 768px) {
        .report_container {
            padding: 25px;
        }
        
        .title_box h2 {
            font-size: 22px;
        }
        
        .report_content {
            padding: 15px;
            font-size: 15px;
        }
        
        .comment_textarea {
            height: 100px;
        }
        
        .action_buttons {
            gap: 10px;
        }
        
        .list_button {
            padding: 10px 20px;
            font-size: 15px;
        }
    }
</style>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
    var commentForm = document.getElementById("commentForm");
    if (commentForm) {
        commentForm.onsubmit = function(event) {
            event.preventDefault();  // 기본 폼 제출 동작을 막음

            var replyContent = document.getElementById("reply").value;  // 댓글 내용
            var reportId = document.getElementById("report_id").value;  // 히든 필드에서 report_id 값 가져오기
            var commentWriter = "${loginUser.id}";  // 현재 로그인된 사용자의 ID (JSP에서 동적으로 값 설정)

            console.log("Report ID:", reportId); // report_id 값 확인
            console.log("Comment Writer:", commentWriter); // comment_writer 값 확인

            // 폼 데이터 객체 생성
            var formData = new FormData();
            formData.append("report_id", reportId);  // report_id 추가 (히든 필드에서 가져온 값)
            formData.append("comment_content", replyContent);
            formData.append("comment_writer", commentWriter);  // comment_writer 값 추가

            // AJAX 요청
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "${root}/report/addComment", true);  // URL에서 report_id를 빼고 FormData로만 전송

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    alert("댓글이 등록되었습니다.");
                    location.reload();  // 새로고침
                }
            };
            xhr.send(formData);  // FormData로 데이터 전송
        };
    }
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
        
        <!-- 수정/삭제 버튼 -->
        <div class="action_buttons">
            <c:if test="${loginUser.id == report.id || loginUser.id == 'admin'}">
                <button class="action_button" onclick="location.href='${root}/report/report_edit?report_id=${report.report_id}'">
                    <img src="https://img.icons8.com/ios-filled/50/000000/edit.png" alt="수정">
                    <span>수정</span>
                </button>
                <button class="action_button" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='${root}/report/report_delete?report_id=${report.report_id}'">
                    <img src="https://img.icons8.com/ios-filled/50/000000/trash.png" alt="삭제">
                    <span>삭제</span>
                </button>
            </c:if>
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
                    <span class="comments_count" id="commentCount">${commentBean.size()}</span>
                </div>
            </div>
            
            <!-- 댓글 작성 폼 -->
            <div class="comment_form">
                <div class="comment_form_header"><i class="fas fa-pen"></i> 댓글 작성</div>
                <form id="commentForm">
                    <textarea id="reply" class="comment_textarea" placeholder="댓글을 입력하세요..."></textarea>
                    <input type="hidden" id="report_id" value="${report.report_id}">
                    <button type="submit" class="comment_submit"><i class="fas fa-paper-plane mr-2"></i>등록</button>
                    <div style="clear: both;"></div>
                </form>
            </div>
            
            <!-- 댓글 목록 -->
            <div class="comment_list">
                <h3><i class="fas fa-comments mr-2"></i>댓글 목록</h3>
                
                <!-- admin 댓글을 먼저 표시 -->
                <c:forEach var="comment" items="${commentBean}">
                    <c:if test="${comment.comment_Writer == 'admin'}">
                        <div class="comment_item admin_comment">
                            <div class="comment_header">
                                <div class="comment_author"><i class="fas fa-user-shield mr-2"></i>${comment.comment_Writer}</div>
                                <div class="comment_date"><i class="far fa-clock mr-1"></i>${comment.comment_Date}</div>
                                <c:if test="${loginUser.id == comment.comment_Writer || loginUser.id == 'admin'}">
                                    <div class="comment_actions"> 
                                        <!-- 삭제 버튼 -->
                                        <button class="action_button" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='${root}/report/comment_delete?comment_id=${comment.comment_Id}&report_id=${report.report_id}'">
                                            <img src="https://img.icons8.com/ios-filled/50/000000/trash.png" alt="삭제">
                                            <span>삭제</span>
                                        </button>
                                    </div>
                                </c:if>
                            </div>
                            <div class="comment_content">
                                ${comment.comment_Content}
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
                
                <!-- 나머지 댓글들 -->
                <c:forEach var="comment" items="${commentBean}">
                    <c:if test="${comment.comment_Writer != 'admin'}">
                        <div class="comment_item">
                            <div class="comment_header">
                                <div class="comment_author"><i class="fas fa-user mr-2"></i>${comment.comment_Writer}</div>
                                <div class="comment_date"><i class="far fa-clock mr-1"></i>${comment.comment_Date}</div>
                                <c:if test="${loginUser.id == comment.comment_Writer || loginUser.id == 'admin'}">
                                    <div class="comment_actions"> 
                                        <!-- 삭제 버튼 -->
                                        <button class="action_button" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='${root}/report/comment_delete?comment_id=${comment.comment_Id}&report_id=${report.report_id}'">
                                            <img src="https://img.icons8.com/ios-filled/50/000000/trash.png" alt="삭제">
                                            <span>삭제</span>
                                        </button>
                                    </div>
                                </c:if>
                            </div>
                            <div class="comment_content">
                                ${comment.comment_Content}
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>
    
    <!-- 하단 부분 -->
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>