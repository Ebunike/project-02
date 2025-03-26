<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
    <title>뚝배기 고객센터 문의</title>
    
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    
    <!-- Font Awesome 아이콘 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    
    <style>
        /* 기본 설정 */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f9f9;
            color: #333;
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }
        
        /* 메인 컨테이너 스타일 */
        .inquiry-container {
            max-width: 850px;
            margin: 40px auto;
            padding: 0;
            position: relative;
        }
        
        /* 카드 스타일 */
        .inquiry-card {
            background-color: #fff;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            margin-bottom: 40px;
        }
        
        /* 헤더 섹션 스타일 */
        .inquiry-header {
            background: linear-gradient(135deg, #FF6B35 0%, #f7941d 100%);
            color: white;
            padding: 40px;
            text-align: center;
            position: relative;
        }
        
        .inquiry-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 20px;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1440 100'%3E%3Cpath fill='%23FFFFFF' fill-opacity='1' d='M0,64L80,69.3C160,75,320,85,480,80C640,75,800,53,960,42.7C1120,32,1280,32,1360,32L1440,32L1440,100L1360,100C1280,100,1120,100,960,100C800,100,640,100,480,100C320,100,160,100,80,100L0,100Z'%3E%3C/path%3E%3C/svg%3E");
            background-size: cover;
            background-position: center;
        }
        
        .inquiry-header h2 {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 15px;
        }
        
        .inquiry-header p {
            font-size: 16px;
            opacity: 0.95;
            margin-bottom: 5px;
            font-weight: 300;
        }
        
        .inquiry-header .description {
            max-width: 600px;
            margin: 0 auto;
        }
        
        .highlight {
            background-color: rgba(255, 255, 255, 0.2);
            padding: 3px 6px;
            border-radius: 4px;
            font-weight: 500;
        }
        
        /* 폼 부분 스타일 */
        .inquiry-form-container {
            padding: 40px;
        }
        
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
            font-size: 16px;
        }
        
        .form-control {
            height: auto;
            padding: 12px 15px;
            font-size: 16px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            box-shadow: none;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #FF6B35;
            box-shadow: 0 0 0 3px rgba(255, 107, 53, 0.1);
        }
        
        /* 드롭다운 스타일 */
        .form-select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%23333' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14L2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 16px;
            padding-right: 40px;
        }
        
        /* 버튼 스타일 */
        .btn {
            padding: 12px 24px;
            font-size: 16px;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s ease;
            border: none;
        }
        
        .btn-primary {
            background-color: #FF6B35;
            border-color: #FF6B35;
            box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
        }
        
        .btn-primary:hover {
            background-color: #e55a29;
            border-color: #e55a29;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(255, 107, 53, 0.35);
        }
        
        .btn-info {
            background-color: #17a2b8;
            border-color: #17a2b8;
            box-shadow: 0 4px 15px rgba(23, 162, 184, 0.3);
        }
        
        .btn-info:hover {
            background-color: #138496;
            border-color: #138496;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(23, 162, 184, 0.35);
        }
        
        .btn-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn-icon i {
            margin-right: 8px;
        }
        
        /* 히스토리 섹션 스타일 */
        .history-section {
            background-color: #f9f9f9;
            padding: 25px 40px;
            border-top: 1px solid #eee;
            border-radius: 0 0 15px 15px;
        }
        
        .history-section h4 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #333;
            display: flex;
            align-items: center;
        }
        
        .history-section h4 i {
            margin-right: 10px;
            color: #FF6B35;
        }
        
        /* 텍스트 에리어 스타일 */
        textarea.form-control {
            min-height: 150px;
            resize: vertical;
        }
        
        /* 아이콘 스타일 */
        .section-icon {
            margin-right: 8px;
            color: #FF6B35;
        }
        
        /* 반응형 조정 */
        @media (max-width: 768px) {
            .inquiry-container {
                margin: 20px;
            }
            
            .inquiry-header {
                padding: 30px 20px;
            }
            
            .inquiry-form-container {
                padding: 30px 20px;
            }
            
            .history-section {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <!-- 상단 메뉴 -->
    <div class="top">
        <c:import url="/WEB-INF/views/include/top_menu.jsp" /> 
    </div>

    <!-- 메인 컨테이너 -->
    <div class="inquiry-container">
        <!-- 문의 카드 -->
        <div class="inquiry-card">
            <!-- 헤더 섹션 -->
            <div class="inquiry-header">
                <h2>뚝배기 고객센터 문의</h2>
                <div class="description">
                    <p>뚝배기를 이용하면서 느끼신 불편사항이나 바라는 점을 알려주세요.</p>
                    <p>고객님의 <span class="highlight">소중한 의견</span>으로 한 뼘 더 자라는 뚝배기가 되겠습니다.</p>
                    <p><i class="fas fa-info-circle"></i> 문의량이 많아 답변은 24시간 이상 소요될 수 있습니다.</p>
                </div>
            </div>
            
            <!-- 폼 섹션 -->
            <div class="inquiry-form-container">
                <!-- Spring form:form 사용 -->
                <form:form action="inquiry_pro" method="post" modelAttribute="inquiryBean" enctype="multipart/form-data">
                    
                    <!-- 유형 선택 -->
                    <div class="form-group">
                        <label for="inquiry_category"><i class="fas fa-tag section-icon"></i> 유형을 선택해주세요</label>
                        <form:select id="inquiry_category" path="inquiry_category" class="form-control form-select">
                            <option value="order">주문 상품 문의</option>
                            <option value="delivery">배송 관련 문의</option>
                            <option value="payment">결제 관련 문의</option>
                            <option value="system">시스템 개선 의견</option>
                            <option value="service">뚝배기 서비스 불편/제안</option>
                        </form:select>
                    </div>
                    
                    <!-- 제목 입력 -->
                    <div class="form-group">
                        <label for="inquiry_title"><i class="fas fa-heading section-icon"></i> 제목</label>
                        <form:input id="inquiry_title" path="inquiry_title" class="form-control" placeholder="문의 제목을 입력하세요" />
                    </div>
                    
                    <!-- 내용 입력 -->
                    <div class="form-group">
                        <label for="inquiry_content"><i class="fas fa-comment-alt section-icon"></i> 내용</label>
                        <form:textarea id="inquiry_content" path="inquiry_content" class="form-control" rows="5" 
                            placeholder="여기에 의견을 자세히 작성해주세요. 구체적인 내용을 알려주시면 더 정확한 답변을 드릴 수 있습니다."></form:textarea>
                    </div>
                    
                    <!-- 제출 버튼 -->
                    <button type="submit" class="btn btn-primary btn-icon">
                        <i class="fas fa-paper-plane"></i> 문의 보내기
                    </button>
                </form:form>
            </div>
            
            <!-- 내 문의 히스토리 섹션 -->
            <div class="history-section">
                <h4><i class="fas fa-history"></i> 내 문의 확인하기</h4>
                <p>이전에 보낸 문의 내역과 답변을 확인하실 수 있습니다.</p>
                <a href="${root}/inquiry/inquiry_list?id=${loginUser.id}" class="btn btn-info btn-icon">
                    <i class="fas fa-list-alt"></i> 내 문의 내역 보기
                </a>
            </div>
        </div>
    </div>

    <!-- 하단 정보 - include로 불러옴 -->
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>