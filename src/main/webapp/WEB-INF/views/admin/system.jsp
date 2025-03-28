<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>  
<head> 
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="context-path" content="${root}">
    <title>DDuk Bae Gi Admin - 시스템 설정</title>
    
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://hangeul.pstatic.net/hangeul_static/css/NanumGarMaesGeur.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- 외부 CSS -->
    <link rel="stylesheet" href="${root}/css/admin_system.css" />
  
</head>
<body>
<div class="background_container">
    <!-- 사이드 메뉴 -->
   <div class="side">
        <c:import url="/WEB-INF/views/include/admin_side.jsp" />
    </div>
    <!-- 메인 컨텐츠 -->
    <div class="container mt-5 mb-5">
        <h2 class="text-center mb-4">메인 페이지 관리</h2>
        
        <!-- 탭 메뉴 -->
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item">
                <a class="nav-link ${param.activeTab != 'product' ? 'active' : ''}" id="banner-tab" data-toggle="tab" href="#banner" role="tab">배너 이미지 관리</a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.activeTab == 'product' ? 'active' : ''}" id="product-tab" data-toggle="tab" href="#product" role="tab">추천 상품 관리</a>
            </li>
        </ul>
        
        <!-- 탭 컨텐츠 -->
        <div class="tab-content" id="myTabContent">
            <!-- 배너 이미지 관리 탭 -->
            <div class="tab-pane fade ${param.activeTab != 'product' ? 'show active' : ''}" id="banner" role="tabpanel">
                <div class="admin-content">
                    <h4>배너 이미지 관리</h4>
                    <p>메인 페이지에 표시되는 배너 이미지를 관리합니다. (최대 5개)</p>
                    
                    <button type="button" class="btn btn-primary btn-add" data-toggle="modal" data-target="#addBannerModal">
                        <i class="fas fa-plus"></i> 새 배너 추가
                    </button>
                    
                    <div class="table-responsive mt-3">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th style="width: 5%">순서</th>
                                    <th style="width: 20%">이미지</th>
                                    <th style="width: 15%">이름</th>
                                    <th style="width: 20%">링크</th>
                                    <th style="width: 10%">상태</th>
                                    <th style="width: 30%">관리</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="banner" items="${bannerList}">
                                    <tr>
                                        <td>${banner.banner_order}</td>
                                        <td>
                                            <img src="${root}/upload/${banner.banner_img}" alt="${banner.banner_name}" class="image-preview">
                                        </td>
                                        <td>${banner.banner_name}</td>
                                        <td>
                                            <div class="text-truncate" style="max-width: 200px;" title="${banner.banner_link}">
                                                <c:choose>
                                                    <c:when test="${empty banner.banner_link}">
                                                        <span class="text-muted">링크 없음</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${banner.banner_link}
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${banner.is_active == 'Y'}">
                                                    <span class="badge badge-success">활성</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-secondary">비활성</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <button class="btn btn-sm btn-info edit-banner-btn" 
                                                        data-idx="${banner.banner_idx}"
                                                        data-name="${banner.banner_name}"
                                                        data-img="${banner.banner_img}"
                                                        data-title="${banner.banner_title}"
                                                        data-subtitle="${banner.banner_subtitle}"
                                                        data-link="${banner.banner_link}"
                                                        data-order="${banner.banner_order}"
                                                        data-active="${banner.is_active}">
                                                    <i class="fas fa-edit"></i> 수정
                                                </button>
                                                <a href="${root}/admin/delete_banner?idx=${banner.banner_idx}&activeTab=banner" 
                                                   class="btn btn-sm btn-danger"
                                                   onclick="return confirm('정말 삭제하시겠습니까?')">
                                                    <i class="fas fa-trash"></i> 삭제
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <!-- 추천 상품 관리 탭 -->
            <div class="tab-pane fade ${param.activeTab == 'product' ? 'show active' : ''}" id="product" role="tabpanel">
                <div class="admin-content">
                    <h4>추천 상품 관리</h4>
                    <p>메인 페이지에 표시되는 추천 상품을 관리합니다.</p>
                    
                    <!-- 새 상품 추가 버튼 수정 -->
                    <button type="button" class="btn btn-primary btn-add mb-3" data-toggle="modal" data-target="#addProductModal">
                        <i class="fas fa-plus"></i> 새 상품 추가
                    </button>
                    
                    <!-- 카테고리 필터 버튼 추가 -->
                    <div class="category-filter mb-3">
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-outline-primary active" data-category="all">전체 보기</button>
                            <button type="button" class="btn btn-outline-primary" data-category="1">Fashion </button>
                            <button type="button" class="btn btn-outline-primary" data-category="2">Accessories </button>
                            <button type="button" class="btn btn-outline-primary" data-category="3">Beauty</button>
                            <button type="button" class="btn btn-outline-primary" data-category="4">DIY kit</button>
                            <button type="button" class="btn btn-outline-primary" data-category="5">Mealkit</button>
                        </div>
                    </div>
                    
                    <!-- 테이블 반응형 래퍼 -->
                    <div class="table-responsive mt-3">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th style="width: 5%">순서</th>
                                    <th style="width: 15%">이미지</th>
                                    <th style="width: 15%">상품명</th>
                                    <th style="width: 20%">설명</th>
                                    <th style="width: 10%">가격</th>
                                    <th style="width: 10%">카테고리</th>
                                    <th style="width: 10%">상태</th>
                                    <th style="width: 15%">관리</th>
                                </tr>
                            </thead>
                            <tbody id="product-list">
                                <c:forEach var="product" items="${productList}">
                                    <tr data-category="${product.category_type}">
                                        <td>${product.product_order}</td>
                                        <td>
                                            <img src="${root}/upload/${product.product_img}" alt="${product.product_name}" class="image-preview">
                                        </td>
                                        <td>${product.product_name}</td>
                                        <td>
                                            <div class="text-truncate" style="max-width: 200px;" title="${product.product_desc}">
                                                ${product.product_desc}
                                            </div>
                                        </td>
                                        <td>${product.product_price}원</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${product.category_type == 1}">
                                                    <span class="badge badge-info">Fashion</span>
                                                </c:when>
                                                <c:when test="${product.category_type == 2}">
                                                    <span class="badge badge-success">Accessories</span>
                                                </c:when>
                                                <c:when test="${product.category_type == 3}">
                                                    <span class="badge badge-primary">Beauty</span>
                                                </c:when>
                                                <c:when test="${product.category_type == 4}">
                                                    <span class="badge badge-danger">DIY kit</span>
                                                </c:when>
                                                <c:when test="${product.category_type == 5}">
                                                    <span class="badge badge-warning">Mealkit</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-secondary">기타</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${product.is_active == 'Y'}">
                                                    <span class="badge badge-success">활성</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-secondary">비활성</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <button class="btn btn-sm btn-info edit-product-btn" 
                                                        data-idx="${product.product_idx}"
                                                        data-name="${product.product_name}"
                                                        data-desc="${product.product_desc}"
                                                        data-img="${product.product_img}"
                                                        data-link="${product.product_link}"
                                                        data-price="${product.product_price}"
                                                        data-order="${product.product_order}"
                                                        data-category="${product.category_type}"
                                                        data-active="${product.is_active}">
                                                    <i class="fas fa-edit"></i> 수정
                                                </button>
                                                <a href="${root}/admin/delete_product?idx=${product.product_idx}&activeTab=product" 
                                                   class="btn btn-sm btn-danger"
                                                   onclick="return confirm('정말 삭제하시겠습니까?')">
                                                    <i class="fas fa-trash"></i> 삭제
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 하단 고정 바 -->
    <div class="bottom">
        <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
    </div>
</div>

<!-- 배너 추가 모달 -->
<div class="modal fade" id="addBannerModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">새 배너 추가</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="${root}/admin/add_banner" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="activeTab" value="banner">
                    <div class="form-group">
                        <label for="banner_name">배너 이름</label>
                        <input type="text" class="form-control" id="banner_name" name="banner_name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="banner_img">배너 이미지</label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="banner_img" name="banner_img" required
                                   accept="image/jpeg, image/png, image/gif, image/jpg" onchange="previewBannerImage(this)">
                            <label class="custom-file-label" for="banner_img">이미지 선택...</label>
                        </div>
                        <small class="form-text text-muted">권장 크기: 1920 x 800px</small>
                    </div>
                    
                    <!-- 배너 텍스트 입력 필드 추가 -->
                    <div class="form-group">
                        <label for="banner_title">배너 제목 텍스트 (선택사항)</label>
                        <input type="text" class="form-control" id="banner_title" name="banner_title" 
                               placeholder="배너 이미지에 표시할 제목" onkeyup="updatePreview()">
                    </div>
                    
                    <div class="form-group">
                        <label for="banner_subtitle">배너 부제목 텍스트 (선택사항)</label>
                        <input type="text" class="form-control" id="banner_subtitle" name="banner_subtitle" 
                               placeholder="배너 이미지에 표시할 부제목" onkeyup="updatePreview()">
                    </div>
                    
                    <!-- 배너 미리보기 영역 추가 -->
                    <div class="form-group">
                        <label>배너 미리보기</label>
                        <div class="banner-preview-container">
                            <div class="banner-preview" id="preview-image">
                                <div class="banner-text">
                                    <h3 id="preview-title"></h3>
                                    <p id="preview-subtitle"></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="banner_link">링크 (선택사항)</label>
                        <input type="text" class="form-control" id="banner_link" name="banner_link" placeholder="링크가 필요없는 경우 비워두세요">
                    </div>
                    
                    <div class="form-group">
                        <label for="banner_order">순서</label>
                        <input type="number" class="form-control" id="banner_order" name="banner_order" min="1" value="${nextBannerOrder}" readonly>
                    </div>
                    
                    <div class="text-right">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary">저장</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 배너 수정 모달 -->
<div class="modal fade" id="editBannerModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">배너 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="${root}/admin/update_banner" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="activeTab" value="banner">
                    <input type="hidden" id="edit_banner_idx" name="banner_idx">
                    
                    <div class="form-group">
                        <label for="edit_banner_name">배너 이름</label>
                        <input type="text" class="form-control" id="edit_banner_name" name="banner_name" required>
                    </div>
                    
                    <div class="form-group">
                        <label>현재 이미지</label>
                        <div>
                            <img id="current_banner_img" class="image-preview mb-2" alt="현재 이미지">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="edit_banner_img">새 이미지 (선택사항)</label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="edit_banner_img" name="banner_img"
                                   accept="image/jpeg, image/png, image/gif, image/jpg" onchange="previewEditImage(this)">
                            <label class="custom-file-label" for="edit_banner_img">이미지 변경...</label>
                        </div>
                        <small class="form-text text-muted">권장 크기: 1920 x 800px</small>
                    </div>
                    
                    <!-- 배너 텍스트 입력 필드 추가 -->
                    <div class="form-group">
                        <label for="edit_banner_title">배너 제목 텍스트 (선택사항)</label>
                        <input type="text" class="form-control" id="edit_banner_title" name="banner_title" 
                               placeholder="배너 이미지에 표시할 제목" onkeyup="updateEditPreview()">
                    </div>
                    
                    <div class="form-group">
                        <label for="edit_banner_subtitle">배너 부제목 텍스트 (선택사항)</label>
                        <input type="text" class="form-control" id="edit_banner_subtitle" name="banner_subtitle" 
                               placeholder="배너 이미지에 표시할 부제목" onkeyup="updateEditPreview()">
                    </div>
                    
                    <!-- 배너 미리보기 영역 추가 -->
                    <div class="form-group">
                        <label>배너 미리보기</label>
                        <div class="banner-preview-container">
                            <div class="banner-preview" id="edit-preview-image">
                                <div class="banner-text">
                                    <h3 id="edit-preview-title"></h3>
                                    <p id="edit-preview-subtitle"></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="edit_banner_link">링크 (선택사항)</label>
                        <input type="text" class="form-control" id="edit_banner_link" name="banner_link">
                    </div>
                    
                    <div class="form-group">
                        <label for="edit_banner_order">순서</label>
                        <input type="number" class="form-control" id="edit_banner_order" name="banner_order" min="1" required>
                    </div>
                    
                    <div class="form-group">
                        <div class="custom-control custom-switch">
                            <input type="checkbox" class="custom-control-input" id="edit_banner_active" name="is_active" value="Y">
                            <label class="custom-control-label" for="edit_banner_active">활성화</label>
                        </div>
                    </div>
                    
                    <div class="text-right">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary">저장</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 상품 추가 모달 -->
<div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">새 상품 추가</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="${root}/admin/add_product" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="activeTab" value="product">
                    <div class="form-group">
                        <label for="product_category">상품 카테고리</label>
                        <select class="form-control" id="product_category" name="category_type" onchange="updateNextOrder()">
                            <option value="1">Fashion </option>
                            <option value="2">Accessories</option>
                            <option value="3">Beauty</option>
                            <option value="4">DIY kit</option>
                            <option value="5">Mealkit</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="product_name">상품명</label>
                        <input type="text" class="form-control" id="product_name" name="product_name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="product_desc">상품 설명</label>
                        <input type="text" class="form-control" id="product_desc" name="product_desc" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="product_img">상품 이미지</label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="product_img" name="product_img" required
                                   accept="image/jpeg, image/png, image/gif, image/jpg">
                            <label class="custom-file-label" for="product_img">이미지 선택...</label>
                        </div>
                        <small class="form-text text-muted">권장 크기: 500 x 400px</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="product_link">링크 (선택사항)</label>
                        <input type="text" class="form-control" id="product_link" name="product_link" placeholder="링크가 필요없는 경우 비워두세요">
                    </div>
                    
                    <div class="form-group">
                        <label for="product_price">가격</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="product_price" name="product_price" min="0" value="0" required>
                            <div class="input-group-append">
                                <span class="input-group-text">원</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="product_order">순서</label>
                        <input type="number" class="form-control" id="product_order" name="product_order" min="1" readonly>
                    </div>
                    
                    <div class="text-right">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary">저장</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 상품 수정 모달 -->
<div class="modal fade" id="editProductModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">상품 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="${root}/admin/update_product" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="activeTab" value="product">
                    <input type="hidden" id="edit_product_idx" name="product_idx">
                    
                    <div class="form-group">
                        <label for="edit_product_category">상품 카테고리</label>
                        <select class="form-control" id="edit_product_category" name="category_type">
                            <option value="1">Fashion </option>
                            <option value="2">Accessories</option>
                            <option value="3">Beauty</option>
                            <option value="4">DIY kit</option>
                            <option value="5">Mealkit</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="edit_product_name">상품명</label>
                        <input type="text" class="form-control" id="edit_product_name" name="product_name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="edit_product_desc">상품 설명</label>
                        <input type="text" class="form-control" id="edit_product_desc" name="product_desc" required>
                    </div>
                    
                    <div class="form-group">
                        <label>현재 이미지</label>
                        <div>
                            <img id="current_product_img" class="image-preview mb-2" alt="현재 이미지">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="edit_product_img">새 이미지 (선택사항)</label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="edit_product_img" name="product_img"
                                   accept="image/jpeg, image/png, image/gif, image/jpg">
                            <label class="custom-file-label" for="edit_product_img">이미지 변경...</label>
                        </div>
                        <small class="form-text text-muted">권장 크기: 500 x 400px</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="edit_product_link">링크 (선택사항)</label>
                        <input type="text" class="form-control" id="edit_product_link" name="product_link">
                    </div>
                    
                    <div class="form-group">
                        <label for="edit_product_price">가격</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="edit_product_price" name="product_price" min="0" required>
                            <div class="input-group-append">
                                <span class="input-group-text">원</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="edit_product_order">순서</label>
                        <input type="number" class="form-control" id="edit_product_order" name="product_order" min="1" required>
                    </div>
                    
                    <div class="form-group">
                        <div class="custom-control custom-switch">
                            <input type="checkbox" class="custom-control-input" id="edit_product_active" name="is_active" value="Y">
                            <label class="custom-control-label" for="edit_product_active">활성화</label>
                        </div>
                    </div>
                    
                    <div class="text-right">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary">저장</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
/* admin_system.js */

// 카테고리별 마지막 순서 번호를 저장하는 객체
var categoryMaxOrders = {
    1: ${category1MaxOrder != null ? category1MaxOrder : 0},
    2: ${category2MaxOrder != null ? category2MaxOrder : 0},
    3: ${category3MaxOrder != null ? category3MaxOrder : 0},
    4: ${category4MaxOrder != null ? category4MaxOrder : 0},
    5: ${category5MaxOrder != null ? category5MaxOrder : 0}
};

// 페이지 로드 시 실행
document.addEventListener('DOMContentLoaded', function() {
    // 파일 입력 필드에 파일명 표시
    $('.custom-file-input').on('change', function() {
        var fileName = $(this).val().split('\\').pop();
        $(this).next('.custom-file-label').html(fileName);
    });
    
    // 배너 수정 버튼 클릭 이벤트
    $('.edit-banner-btn').on('click', function() {
        var idx = $(this).data('idx');
        var name = $(this).data('name');
        var img = $(this).data('img');
        var title = $(this).data('title') || '';
        var subtitle = $(this).data('subtitle') || '';
        var link = $(this).data('link');
        var order = $(this).data('order');
        var active = $(this).data('active');
        
        // 폼 필드 값 설정
        $('#edit_banner_idx').val(idx);
        $('#edit_banner_name').val(name);
        $('#edit_banner_title').val(title);
        $('#edit_banner_subtitle').val(subtitle);
        $('#current_banner_img').attr('src', '${root}/upload/' + img);
        $('#edit_banner_link').val(link);
        $('#edit_banner_order').val(order);
        $('#edit_banner_active').prop('checked', active === 'Y');
        
        // 미리보기 이미지 설정
        $('#edit-preview-image').css('background-image', 'url(${root}/upload/' + img + ')');
        $('#edit-preview-title').text(title);
        $('#edit-preview-subtitle').text(subtitle);
        
        $('#editBannerModal').modal('show');
    });
    
    // 상품 수정 버튼 클릭 이벤트
    $('.edit-product-btn').on('click', function() {
        var idx = $(this).data('idx');
        var name = $(this).data('name');
        var desc = $(this).data('desc');
        var img = $(this).data('img');
        var link = $(this).data('link');
        var price = $(this).data('price');
        var order = $(this).data('order');
        var active = $(this).data('active');
        var category = $(this).data('category') || 1; // 설정되지 않은 경우 기본값 1
        
        $('#edit_product_idx').val(idx);
        $('#edit_product_name').val(name);
        $('#edit_product_desc').val(desc);
        $('#current_product_img').attr('src', '${root}/upload/' + img);
        $('#edit_product_link').val(link);
        $('#edit_product_price').val(price);
        $('#edit_product_order').val(order);
        $('#edit_product_active').prop('checked', active === 'Y');
        $('#edit_product_category').val(category);
        
        $('#editProductModal').modal('show');
    });
    
    // 카테고리 필터 버튼 클릭 이벤트
    $('.category-filter .btn').on('click', function() {
        var category = $(this).data('category');
        
        // 버튼 활성화 상태 변경
        $('.category-filter .btn').removeClass('active');
        $(this).addClass('active');
        
        // 상품 표시 필터링
        if (category === 'all') {
            $('#product-list tr').show();
        } else {
            $('#product-list tr').hide();
            $('#product-list tr[data-category="' + category + '"]').show();
        }
        
        // 현재 선택된 카테고리 저장 (페이지 새로고침 시 유지를 위해)
        localStorage.setItem('selectedCategory', category);
    });
    
    // 페이지 로드 시 이전에 선택한 카테고리 필터 복원
    var savedCategory = localStorage.getItem('selectedCategory');
    if (savedCategory) {
        $('.category-filter .btn[data-category="' + savedCategory + '"]').click();
    }
    
    // 페이지 로드 시 상품 추가 모달의 순서 필드 초기화
    updateNextOrder();
    
    // 상품 추가 모달 열릴 때 이벤트
    $('#addProductModal').on('show.bs.modal', function() {
        updateNextOrder();
    });
    
    // URL 파라미터로 전달된 activeTab에 따라 탭 활성화 (이미 JSP에서 처리했으므로 주석 처리)
    // var urlParams = new URLSearchParams(window.location.search);
    // var activeTab = urlParams.get('activeTab');
    // if (activeTab === 'product') {
    //    $('#product-tab').tab('show');
    // }
});

// 배너 이미지 미리보기 (추가 모달)
function previewBannerImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        
        reader.onload = function(e) {
            $('#preview-image').css('background-image', 'url(' + e.target.result + ')');
        }
        
        reader.readAsDataURL(input.files[0]);
    }
}

// 배너 이미지 미리보기 (수정 모달)
function previewEditImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        
        reader.onload = function(e) {
            $('#edit-preview-image').css('background-image', 'url(' + e.target.result + ')');
        }
        
        reader.readAsDataURL(input.files[0]);
    }
}

// 미리보기 텍스트 업데이트 (추가 모달)
function updatePreview() {
    var title = $('#banner_title').val();
    var subtitle = $('#banner_subtitle').val();
    
    $('#preview-title').text(title);
    $('#preview-subtitle').text(subtitle);
}

// 미리보기 텍스트 업데이트 (수정 모달)
function updateEditPreview() {
    var title = $('#edit_banner_title').val();
    var subtitle = $('#edit_banner_subtitle').val();
    
    $('#edit-preview-title').text(title);
    $('#edit-preview-subtitle').text(subtitle);
}

// 선택된 카테고리에 따라 다음 순서 번호 업데이트
function updateNextOrder() {
    var selectedCategory = parseInt($('#product_category').val());
    var nextOrder = categoryMaxOrders[selectedCategory] + 1;
    $('#product_order').val(nextOrder);
}
</script>

<!-- 추가 스타일 -->
<style>
.image-preview {
    max-width: 100px;
    max-height: 60px;
    object-fit: cover;
}

.banner-preview-container {
    width: 100%;
    margin-top: 10px;
}

.banner-preview {
    width: 100%;
    height: 150px;
    background-color: #e9ecef;
    background-size: cover;
    background-position: center;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
}

.banner-text {
    color: white;
    text-align: center;
    text-shadow: 1px 1px 3px rgba(0,0,0,0.7);
    padding: 15px;
    background-color: rgba(0,0,0,0.3);
    border-radius: 5px;
}

.action-buttons {
    display: flex;
    gap: 5px;
}

.category-filter {
    overflow-x: auto;
    white-space: nowrap;
    padding-bottom: 10px;
}

.category-filter .btn-group {
    flex-wrap: nowrap;
}

@media (max-width: 768px) {
    .action-buttons {
        flex-direction: column;
    }
    
    .category-filter .btn {
        font-size: 0.8rem;
        padding: 0.375rem 0.5rem;
    }
}
</style>
</body>
</html>