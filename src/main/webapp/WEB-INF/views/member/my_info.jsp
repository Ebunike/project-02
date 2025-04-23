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
<!-- Font Awesome 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
    :root {
        --primary-color: #5d5fef;
        --primary-light: #eceefe;
        --primary-dark: #4b4eca;
        --secondary-color: #fb8c00;
        --text-color: #373a47;
        --text-light: #6c757d;
        --bg-light: #f8f9fa;
        --border-radius: 12px;
        --box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    }

    body {
        font-family: 'Noto Sans KR', 'NanumGaRamYeonGgoc', sans-serif;
        background-color: #f7f9fc;
        color: var(--text-color);
        line-height: 1.6;
    }
    
    .container_info {
        max-width: 800px;
        margin: 60px auto;
        background: white;
        padding: 40px;
        border-radius: var(--border-radius);
        box-shadow: var(--box-shadow);
        border: none;
        position: relative;
        overflow: hidden;
    }
    
    .container_info::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 6px;
        background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
    }
    
    h2 {
        text-align: center;
        color: var(--primary-color);
        font-weight: 700;
        margin-bottom: 40px;
        font-size: 32px;
        position: relative;
        display: inline-block;
        left: 50%;
        transform: translateX(-50%);
    }
    
    h2::after {
        content: '';
        position: absolute;
        bottom: -10px;
        left: 0;
        width: 60%;
        height: 4px;
        background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
        border-radius: 2px;
        left: 50%;
        transform: translateX(-50%);
    }
    
    .box {
        display: grid;
        grid-template-columns: 1fr;
        gap: 18px;
        margin-top: 30px;
    }
    
    .info-box {
        border: none;
        padding: 18px 25px;
        border-radius: var(--border-radius);
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 16px;
        background-color: white;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.04);
        transition: var(--transition);
        position: relative;
        overflow: hidden;
    }
    
    .info-box::before {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        bottom: 0;
        width: 4px;
        background: linear-gradient(to bottom, var(--primary-color), var(--secondary-color));
        border-radius: 4px;
    }
    
    .info-box:hover {
        box-shadow: 0 8px 25px rgba(93, 95, 239, 0.15);
    }
    
    .info-box label {
        font-weight: 500;
        color: var(--text-light);
        margin-right: 20px;
        min-width: 120px;
        display: flex;
        align-items: center;
    }
    
    .info-box label i {
        margin-right: 12px;
        font-size: 20px;
        color: var(--primary-color);
        width: 24px;
        text-align: center;
    }
    
    .info-box span {
        color: var(--text-color);
        flex-grow: 1;
        text-align: right;
        font-weight: 500;
        font-size: 15px;
    }
    
    .btn-container {
        text-align: center;
        margin-top: 40px;
        display: flex;
        justify-content: center;
        gap: 20px;
    }
    
    .btn-edit {
        background: linear-gradient(45deg, var(--primary-color), var(--primary-dark));
        color: white;
        padding: 14px 30px;
        border: none;
        border-radius: 50px;
        cursor: pointer;
        font-size: 16px;
        transition: var(--transition);
        font-weight: 500;
        text-decoration: none;
        display: inline-block;
        box-shadow: 0 4px 15px rgba(93, 95, 239, 0.3);
        position: relative;
        overflow: hidden;
        z-index: 1;
    }
    
    .btn-edit::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(45deg, var(--primary-dark), var(--primary-color));
        transition: var(--transition);
        z-index: -1;
    }
    
    .btn-edit:hover {
        box-shadow: 0 7px 20px rgba(93, 95, 239, 0.4);
        color: white;
        text-decoration: none;
    }
    
    .btn-edit:hover::before {
        left: 0;
    }
    
    .btn-edit i {
        margin-right: 8px;
    }
    
    .btn-danger {
        background: linear-gradient(45deg, #ff5252, #ff7675);
        color: white;
        padding: 14px 30px;
        border: none;
        border-radius: 50px;
        cursor: pointer;
        font-size: 16px;
        transition: var(--transition);
        font-weight: 500;
        box-shadow: 0 4px 15px rgba(255, 82, 82, 0.3);
        position: relative;
        overflow: hidden;
        z-index: 1;
    }
    
    .btn-danger::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(45deg, #ff7675, #ff5252);
        transition: var(--transition);
        z-index: -1;
    }
    
    .btn-danger:hover {
        box-shadow: 0 7px 20px rgba(255, 82, 82, 0.4);
    }
    
    .btn-danger:hover::before {
        left: 0;
    }
    
    .btn-danger i {
        margin-right: 8px;
    }
    
    /* 키워드 스타일 */
    .keyword-tag {
        display: inline-block;
        background-color: var(--primary-light);
        color: var(--primary-color);
        border-radius: 20px;
        padding: 4px 12px;
        margin: 2px;
        font-size: 14px;
    }
    
    /* SweetAlert2 버튼 스타일 */
    .custom-confirm-btn {
        background: linear-gradient(45deg, var(--primary-color), var(--primary-dark)) !important;
        color: #ffffff !important;
        font-size: 16px !important;
        padding: 12px 24px !important;
        border-radius: 50px !important;
        border: none !important;
        box-shadow: 0 4px 15px rgba(93, 95, 239, 0.3) !important;
        cursor: pointer;
        font-family: 'Noto Sans KR', 'NanumGaRamYeonGgoc', sans-serif !important;
        font-weight: 500 !important;
    }
    
    .custom-cancel-btn {
        background-color: #e6e7ee !important;
        color: #6c757d !important;
        font-size: 16px !important;
        padding: 12px 24px !important;
        border-radius: 50px !important;
        border: none !important;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08) !important;
        cursor: pointer;
        font-family: 'Noto Sans KR', 'NanumGaRamYeonGgoc', sans-serif !important;
        font-weight: 500 !important;
    }
    
    .custom-confirm-btn:hover {
        background: linear-gradient(45deg, var(--primary-dark), var(--primary-color)) !important;
        transform: translateY(-2px) !important;
    }
    
    .custom-cancel-btn:hover {
        background-color: #d6d8e1 !important;
        transform: translateY(-2px) !important;
    }
    
    /* 사용자 프로필 섹션 추가 */
    .profile-section {
        text-align: center;
        margin-bottom: 30px;
    }
    
    .profile-circle {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background: linear-gradient(45deg, var(--primary-light), #f0f2ff);
        margin: 0 auto 15px;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 5px 15px rgba(93, 95, 239, 0.2);
        border: 4px solid white;
    }
    
    .profile-circle i {
        font-size: 40px;
        color: var(--primary-color);
    }
    
    .profile-name {
        font-size: 24px;
        font-weight: 700;
        color: var(--text-color);
        margin-bottom: 5px;
    }
    
    .profile-id {
        font-size: 16px;
        color: var(--text-light);
        margin-bottom: 20px;
    }
    
    /* 반응형 조정 */
    @media (max-width: 768px) {
        .container_info {
            margin: 30px 15px;
            padding: 30px 20px;
        }
        
        h2 {
            font-size: 28px;
        }
        
        .info-box {
            padding: 15px 20px;
            flex-direction: column;
            align-items: flex-start;
        }
        
        .info-box span {
            text-align: left;
            margin-top: 5px;
            margin-left: 36px;
        }
        
        .btn-container {
            flex-direction: column;
            gap: 15px;
        }
        
        .btn-edit, .btn-danger {
            width: 100%;
        }
    }
</style>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

<div class="container_info">
    <div class="profile-section">
        <div class="profile-circle">
            <i class="fas fa-user"></i>
        </div>
        <div class="profile-name">${loginUser.name}</div>
        <div class="profile-id">@${loginUser.id}</div>
    </div>
    
    <h2>내 정보</h2>
     
    <div class="box">
        <div class="info-box">
            <label><i class="fas fa-user"></i>이름</label> <span>${loginUser.name}</span>
        </div>
        <div class="info-box">
            <label><i class="fas fa-id-card"></i>아이디</label> <span>${loginUser.id}</span>
        </div>
        <div class="info-box">
            <label><i class="fas fa-map-marker-alt"></i>주소</label> <span>${loginUser.address}</span>
        </div>
        <div class="info-box">
            <label><i class="fas fa-envelope"></i>이메일</label> <span>${loginUser.email}</span>
        </div>
        <div class="info-box">
            <label><i class="fas fa-phone"></i>전화번호</label> <span>${loginUser.tel}</span>
        </div>
        <div class="info-box">
            <label><i class="fas fa-birthday-cake"></i>나이</label> <span>${loginUser.age}</span>
        </div>
        <div class="info-box">
            <label><i class="fas fa-venus-mars"></i>성별</label>
            <span>
                <c:choose>
                    <c:when test="${loginUser.gender eq 'male'}">남성</c:when>
                    <c:when test="${loginUser.gender eq 'female'}">여성</c:when>
                </c:choose>
            </span>
        </div>
        <div class="info-box">
            <label><i class="fas fa-tags"></i>관심 키워드</label>
            <span>
                <c:choose>
                    <c:when test="${not empty loginUser.keyword}">
                        <c:forEach var="keyword" items="${loginUser.keyword}">
                            <span class="keyword-tag">${keyword}</span>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>선택 없음</c:otherwise>
                </c:choose>
            </span>
        </div>
    </div>
    <div class="btn-container">
        <a href="${root}/member/modify_user" class="btn-edit"><i class="fas fa-edit"></i>정보 수정</a>
        <form:form id="delete-form" action="${root}/member/member_delete_pro" method="post">
            <input type="hidden" id="password" name="pw" />
            <input type="hidden" id="user-id" name="id" value="${loginUser.id}" />
            <button type="button" class="btn-danger" id="delete-btn"><i class="fas fa-user-times"></i>탈퇴하기</button>
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
                    style="width: 80%; padding: 12px; border: 2px solid #5d5fef; 
                    border-radius: 10px; font-size: 16px; text-align: center; 
                    background-color: #f8f9fa; color: #373a47;" 
                    placeholder="비밀번호를 입력하세요">
            </div>
        `,
        background: "#ffffff",
        showCancelButton: true,
        confirmButtonText: "확인",
        cancelButtonText: "취소",
        buttonsStyling: false,
        customClass: {
            confirmButton: "custom-confirm-btn",
            cancelButton: "custom-cancel-btn",
            popup: "custom-popup"
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
                        background: "#ffffff",
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