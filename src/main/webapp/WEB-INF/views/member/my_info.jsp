<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var ="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My_info</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
    /* 🟢 전체 페이지 스타일 */
    body {
        font-family: 'Arial', sans-serif; /* 기본 글꼴 */
        /*background-color: #f5f5dc; /* 페이지 전체 배경색 (베이지) */
    }
    /* 🟢 컨테이너 스타일 (메인 박스) */
    .container_info {
        max-width: 700px; /* 최대 가로 크기 제한 */
        margin: 0 auto; /* 가운데 정렬 */
        /* background: white; /* 컨텐츠 배경색 */ */
        padding: 30px; /* 내부 여백 */
        border-radius: 15px; /* 둥근 모서리 */
        box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2); /* 그림자 효과 추가 */
    }
    /* 🟢 제목 스타일 */
    h2 {
        text-align: center; /* 제목 중앙 정렬 */
        color: #5a4635; /* 어두운 갈색 (배경과 조화) */
        font-weight: bold; /* 볼드 처리 */
        margin-bottom: 20px; /* 아래 여백 추가 */
    }
    /* 🟢 각 정보 박스 스타일 */
    .info-box {
        background: #f9f9f3; /* 연한 배경색 */
        border: 2px solid #c2a87d; /* 테두리 색상 */
        padding: 12px 15px; /* 안쪽 여백 */
        margin-bottom: 15px; /* 아래쪽 여백 */
        border-radius: 10px; /* 둥근 모서리 */
        display: flex; /* 가로 정렬 */
        justify-content: space-between; /* 라벨과 값 사이 간격 */
        align-items: center; /* 세로 중앙 정렬 */
        font-size: 16px; /* 글씨 크기 조정 */
        font-weight: 500; /* 글씨 조금 두껍게 */
    }
    /* 🟢 라벨 (항목 제목) 스타일 */
    .info-box label {
        font-weight: bold; /* 글씨 굵게 */
        color: #5a4635; /* 어두운 갈색 (배경과 조화) */
        margin-right: 10px; /* 오른쪽 여백 추가 */
        min-width: 90px; /* 최소 너비 설정 (정렬 통일) */
    }
    /* 🟢 정보 값 스타일 */
    .info-box span {
        color: #333; /* 기본 글씨 색상 */
        flex-grow: 1; /* 가변 크기로 확장 */
        text-align: right; /* 오른쪽 정렬 */
    }
    /* 🟢 버튼 컨테이너 스타일 */
    .btn-container {
        text-align: center; /* 가운데 정렬 */
        margin-top: 20px; /* 버튼과 내용 사이 간격 */
    }
    /* 🟢 "정보 수정" 버튼 스타일 */
    .btn-edit {
        background-color: #b38b6d; /* 버튼 기본 색상 */
        color: white; /* 글씨 색상 */
        padding: 10px 20px; /* 내부 여백 */
        border: none; /* 테두리 없음 */
        border-radius: 8px; /* 버튼 둥글게 */
        cursor: pointer; /* 마우스 올리면 클릭 가능하도록 */
        font-size: 18px; /* 글씨 크기 */
        transition: background-color 0.3s ease; /* 색상 변경 애니메이션 */
        font-weight: bold; /* 글씨 굵게 */
        text-decoration: none; /* 밑줄 제거 */
        display: inline-block; /* 인라인 블록 형태 */
    }
    /* 🟢 "정보 수정" 버튼 마우스 오버 효과 */
    .btn-edit:hover {
        background-color: #9c7554; /* 버튼 색상 어둡게 변경 */
    }
	    /* SweetAlert2 버튼 스타일 */
	.custom-confirm-btn {
	    background-color: #c4b99c !important;
	    color: #ffffff !important;
	    font-size: 16px !important;
	    padding: 10px 20px !important;
	    border-radius: 6px !important;
	    border: none !important;
	    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
	    cursor: pointer;
	}
	.custom-cancel-btn {
	    background-color: #b3a18e !important;
	    color: #ffffff !important;
	    font-size: 16px !important;
	    padding: 10px 20px !important;
	    border-radius: 6px !important;
	    border: none !important;
	    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
	    cursor: pointer;
	}
	.custom-confirm-btn:hover {
	    background-color: #a59785 !important;
	}
	.custom-cancel-btn:hover {
	    background-color: #988675 !important;
	}
</style>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

<div class="container_info">
	<h2></h2>
    <h2>내 정보</h2>
     
    <div class="box">
	    <div class="info-box">
	        <label>이름:</label> <span>${loginUser.name}</span>
	    </div>
	    <div class="info-box">
	        <label>아이디:</label> <span>${loginUser.id}</span>
	    </div>
	    <div class="info-box">
	        <label>주소:</label> <span>${loginUser.address}</span>
	    </div>
	    <div class="info-box">
	        <label>이메일:</label> <span>${loginUser.email}</span>
	    </div>
	    <div class="info-box">
	        <label>전화번호:</label> <span>${loginUser.tel}</span>
	    </div>
	    <div class="info-box">
	        <label>나이:</label> <span>${loginUser.age}</span>
	    </div>
	    <div class="info-box">
            <label>성별:</label>
            <span>
                <c:choose>
                    <c:when test="${loginUser.gender eq 'male'}">남성</c:when>
                    <c:when test="${loginUser.gender eq 'female'}">여성</c:when>
                    <%-- <c:otherwise>미선택</c:otherwise> --%>
                </c:choose>
            </span>
        </div>
        <div class="info-box">
            <label>관심 키워드:</label>
            <span>
                <c:choose>
                    <c:when test="${not empty loginUser.keyword}">
                         <c:forEach var="keyword" items="${loginUser.keyword}">
		               		${keyword}<br>
		                 </c:forEach>
                    </c:when>
                    <c:otherwise>선택 없음</c:otherwise>
                </c:choose>
            </span>
        </div>
     </div>
        <div class="btn-container">
            <a href="${root}/member/modify_user" class="btn-edit">정보 수정</a>
            <form:form id="delete-form" action="${root}/member/member_delete_pro" method="post">
			    <input type="hidden" id="password" name="pw" />  <!-- 비밀번호 전달 -->
			    <input type="hidden" id="user-id" name="id" value="${loginUser.id}" />  <!-- 로그인한 사용자의 ID 전달 -->
			    <button type="button" class="btn btn-danger" id="delete-btn">탈퇴하기</button>
			</form:form>
        </div>
    </div>
	<script>
	document.getElementById("delete-btn").addEventListener("click", function () {
	    Swal.fire({
	        title: "비밀번호 입력",
	        html: `
	            <div style="display: flex; flex-direction: column; align-items: center;">
	                <input type="password" id="swal-password" class="swal2-input"
	                    style="width: 80%; padding: 12px; border: 2px solid #c4b99c; 
	                    border-radius: 8px; font-size: 16px; text-align: center; 
	                    background-color: #f5f5dc; color: #4b4b4b;" 
	                    placeholder="비밀번호를 입력하세요">
	            </div>
	        `,
	        background: "#f5f5dc",  // 메인 컬러 반영
	        showCancelButton: true,
	        confirmButtonText: "확인",
	        cancelButtonText: "취소",
	        buttonsStyling: false,
	        customClass: {
	            confirmButton: "custom-confirm-btn",
	            cancelButton: "custom-cancel-btn"
	        },
	        preConfirm: () => {
	            let password = document.getElementById("swal-password").value;
	            if (!password) {
	                Swal.showValidationMessage("비밀번호를 입력해야 합니다.");
	            }
	            return password;
	        }
	    }).then((result) => {
	        if (result.isConfirmed) {
	            let password = result.value;

	            // 서버에 비밀번호 검증 요청
	            $.post("${root}/member/checkPassword", { password: password }, function (response) {
	                if (response === "success") {
	                    // 비밀번호를 hidden input에 설정하고 form 제출
	                    document.getElementById("password").value = password;
	                    document.getElementById("delete-form").submit();
	                } else {
	                    Swal.fire({
	                        icon: "error",
	                        title: "비밀번호 오류",
	                        text: "비밀번호가 일치하지 않습니다.",
	                        background: "#f5f5dc",
	                        confirmButtonText: "확인",
	                        buttonsStyling: false,
	                        customClass: {
	                            confirmButton: "custom-confirm-btn"
	                        }
	                    });
	                }
	            });
	        }
	    });
	});
	</script>
<!-- 게시판 하단 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>