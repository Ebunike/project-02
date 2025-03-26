<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<html>
<head>
    <title>고객 문의 상세보기</title> 
    <!-- JavaScript 추가 -->
    <script>
        function showReplyForm() {
            // 답글 수정 폼을 표시
            document.getElementById('reply-form').style.display = 'block';
            // 기존 답글을 textarea에 미리 채워넣기
            const replyContent = document.getElementById('existing-reply').innerText;
            document.getElementById('reply-content').value = replyContent;
            // 수정 폼 버튼을 숨기기
            document.getElementById('edit-btn').style.display = 'none';
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>고객 문의 상세보기</h1>

        <!-- 제목, 내용, 글쓴이 출력 -->
        <div class="report-details">
            <p><strong>제목:</strong> ${oneInquiry.inquiry_title}</p>
            <p><strong>내용:</strong> ${oneInquiry.inquiry_content}</p>
            <p><strong>글쓴이:</strong> ${oneInquiry.id}</p>
        </div>

        <!-- 답글 출력 -->
        <div class="report-reply">
            <p><strong>답글:</strong></p>
			<script>
				console.log(${oneInquiry.inquiry_idx});
			</script>
            <!-- 답글이 없다면 답글 달기 폼을 보여준다 -->
            <c:if test="${empty oneInquiry.inquiry_reply}">
                <form action="${root}/admin/viewinquiry_pro" method="POST" class="reply-form">
                    <input type="hidden" name="idx" value="${oneInquiry.inquiry_idx}" />
                    <textarea name="reply_content" placeholder="답글을 작성하세요" required></textarea>
                    <button type="submit">답글 작성</button>
                </form>
            </c:if>

            <!-- 답글이 있으면 수정, 삭제 버튼을 보여준다 -->
            <c:if test="${not empty oneInquiry.inquiry_reply}">
                <div id="existing-reply" class="existing-reply">${oneInquiry.inquiry_reply}</div>

                <!-- 수정 버튼 -->
                <button id="edit-btn" class="btn btn-edit" onclick="showReplyForm()">수정</button>

                <!-- 답글 수정 폼 (숨겨진 상태) -->
                <form action="${root}/admin/viewinquiry_pro" method="POST" class="reply-form" id="reply-form" style="display:none;">
                    <input type="hidden" name="idx" value="${oneInquiry.inquiry_idx}" />
                    <textarea name="reply_content" id="reply-content" placeholder="답글을 수정하세요" required></textarea>
                    <button type="submit">수정하기</button>
                </form>

                <!-- 삭제 버튼 -->
                <form action="${root}/admin/deleteReply" method="POST" style="display:inline;">
                    <input type="hidden" name="idx" value="${oneInquiry.inquiry_idx}" />
                    <button type="submit" class="btn btn-delete">삭제</button>
                </form>
            </c:if>
            <a href="${root}/admin/inquiry">뒤로가기</a>
        </div>
    </div>
</body>
</html>