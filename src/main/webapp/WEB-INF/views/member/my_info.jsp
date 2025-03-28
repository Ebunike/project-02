<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var ="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="https://hangeul.pstatic.net/hangeul_static/css/NanumGaRamYeonGgoc.css" rel="stylesheet">
<!-- Font Awesome 아이콘 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    body {
        font-family: 'NanumGaRamYeonGgoc';
        font-weight: 600;
        background-color: white;
    }
    
    .container_info {
        max-width: 700px;
        margin: 40px auto;
        background: white;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
        border: 2px solid #e67e22;
    }
    
    h2 {
        text-align: center;
        color: #e67e22;
        font-weight: bold;
        margin-bottom: 30px;
        font-size: 28px;
    }
    
    .info-box {
        border: 2px solid #e67e22;
        padding: 15px 20px;
        margin-bottom: 15px;
        border-radius: 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 16px;
        transition: transform 0.2s, box-shadow 0.2s;
    }
    
    .info-box:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 10px rgba(230, 126, 34, 0.2);
    }
    
    .info-box label {
        font-weight: bold;
        color: #e67e22;
        margin-right: 10px;
        min-width: 110px;
        display: flex;
        align-items: center;
    }
    
    .info-box label i {
        margin-right: 10px;
        font-size: 20px;
    }
    
    .info-box span {
        color: #5a4635;
        flex-grow: 1;
        text-align: right;
        font-weight: 600;
    }
    
    .btn-container {
        text-align: center;
        margin-top: 30px;
        display: flex;
        justify-content: center;
        gap: 20px;
    }
    
    .btn-edit {
        background-color: #e67e22;
        color: white;
        padding: 12px 25px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 18px;
        transition: all 0.3s ease;
        font-weight: bold;
        text-decoration: none;
        display: inline-block;
    }
    
    .btn-edit:hover {
        background-color: #d35400;
        transform: translateY(-3px);
        box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
        color: white;
        text-decoration: none;
    }
    
    .btn-danger {
        background-color: #e74c3c;
        color: white;
        padding: 12px 25px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 18px;
        transition: all 0.3s ease;
        font-weight: bold;
    }
    
    .btn-danger:hover {
        background-color: #c0392b;
        transform: translateY(-3px);
        box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
    }
    
    /* SweetAlert2 버튼 스타일 */
    .custom-confirm-btn {
        background-color: #e67e22 !important;
        color: #ffffff !important;
        font-size: 16px !important;
        padding: 10px 20px !important;
        border-radius: 6px !important;
        border: none !important;
        box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
        cursor: pointer;
        font-family: 'NanumGaRamYeonGgoc' !important;
    }
    
    .custom-cancel-btn {
        background-color: #7f8c8d !important;
        color: #ffffff !important;
        font-size: 16px !important;
        padding: 10px 20px !important;
        border-radius: 6px !important;
        border: none !important;
        box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
        cursor: pointer;
        font-family: 'NanumGaRamYeonGgoc' !important;
    }
    
    .custom-confirm-btn:hover {
        background-color: #d35400 !important;
    }
    
    .custom-cancel-btn:hover {
        background-color: #6c7a89 !important;
    }
</style>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

<div class="container_info">
    <h2 style="color: black;">내 정보</h2>
     
    <div class="box">
        <div class="info-box">
            <label><i class="fas fa-user"></i>이름:</label> <span>${loginUser.name}</span>
        </div>
        <div class="info-box">
            <label><i class="fas fa-id-card"></i>아이디:</label> <span>${loginUser.id}</span>
        </div>
        <div class="info-box">
            <label><i class="fas fa-map-marker-alt"></i>주소:</label> <span>${loginUser.address}</span>
        </div>
        <div class="info-box">
            <label><i class="fas fa-envelope"></i>이메일:</label> <span>${loginUser.email}</span>
        </div>
        <div class="info-box">
            <label><i class="fas fa-phone"></i>전화번호:</label> <span>${loginUser.tel}</span>
        </div>
        <div class="info-box">
            <label><i class="fas fa-birthday-cake"></i>나이:</label> <span>${loginUser.age}</span>
        </div>
        <div class="info-box">
            <label><i class="fas fa-venus-mars"></i>성별:</label>
            <span>
                <c:choose>
                    <c:when test="${loginUser.gender eq 'male'}">남성</c:when>
                    <c:when test="${loginUser.gender eq 'female'}">여성</c:when>
                </c:choose>
            </span>
        </div>
        <div class="info-box">
            <label><i class="fas fa-tags"></i>관심 키워드:</label>
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
            <input type="hidden" id="password" name="pw" />
            <input type="hidden" id="user-id" name="id" value="${loginUser.id}" />
            <button type="button" class="btn-danger" id="delete-btn">탈퇴하기</button>
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
                    style="width: 80%; padding: 12px; border: 2px solid #e67e22; 
                    border-radius: 8px; font-size: 16px; text-align: center; 
                    background-color: #fff9e6; color: #4b4b4b;" 
                    placeholder="비밀번호를 입력하세요">
            </div>
        `,
        background: "#fff9e6",
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
                        background: "#fff9e6",
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