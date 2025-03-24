<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value='${pageContext.request.contextPath }'/>
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피상세페이지</title>
</head>
<body>

<c:import url="/WEB-INF/views/include/top_menu.jsp"/>




<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<div class="form-group">
						<label for="id">작성자</label>
						<input type="text" id="id" name="id" class="form-control" value="${readRecipeBean.id }" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="id">글번호</label>
						<input type="text" id="openRecipe_index" name="openRecipe_index" class="form-control" value="${readRecipeBean.openRecipe_index }" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="openRecipe_title">제목</label>
						<input type="text" id="openRecipe_title" name="openRecipe_title" class="form-control" value="${readRecipeBean.openRecipe_title }" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="openRecipe_intro">한줄소개</label>
						<input type="text" id="openRecipe_intro" name="openRecipe_intro" class="form-control" value="${readRecipeBean.openRecipe_intro }" disabled="disabled"/>
					</div>
					
					<!--좋아요 버튼  -->
				<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
					<script type="text/javascript">
					$(document).ready(function() {
					    // 좋아요 버튼 클릭 이벤트
					    $("#likeBtn").click(function(e) {
					        e.preventDefault();
					        
					        // 로그인 상태 체크 (optional, 서버에서도 체크해야 함)
					        <c:if test="${empty loginMember.id}">
					            alert("로그인이 필요한 기능입니다.");
					            return;
					        </c:if>
					
					        var recipeIndex = $(this).data("recipe-index");
					        
					        $.ajax({
					            url: "${root}/recipe/recipe_like",
					            type: "POST",
					            data: { 
					                openRecipe_index: recipeIndex 
					            },
					            success: function(newLikeCount) {
					                // 좋아요 수 업데이트
					                $("#likeCount").text(newLikeCount);
					                
					                // 좋아요 버튼 스타일 토글 (선택사항)
					                $("#likeBtn").toggleClass("btn-danger btn-outline-danger");
					            },
					            error: function(xhr, status, error) {
					                console.error("좋아요 처리 중 오류 발생:", error);
					                alert("좋아요 처리 중 오류가 발생했습니다.");
					            }
					        });
					    });
					});
					</script>
					
				<!-- 좋아요 버튼 개선 -->
                    <div class="form-group">
                        <c:choose>
                            <c:when test="${empty loginMember.id}">
                                <button class="btn btn-secondary" disabled>
                                    좋아요 (<span id="likeCount">${readRecipeBean.openRecipe_like}</span>)
                                </button>
                                <small class="text-muted ml-2">로그인 후 좋아요를 누를 수 있습니다.</small>
                            </c:when>
                            <c:otherwise>
                                <button id="likeBtn" 
                                        data-recipe-index="${readRecipeBean.openRecipe_index}" 
                                        class="btn btn-danger">
                                    좋아요 (<span id="likeCount">${readRecipeBean.openRecipe_like}</span>)
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
					
					
					
					<div class="form-group">
						<label for="openRecipe_prepare">재료</label>
						<input type="text" id="openRecipe_prepare" name="openRecipe_prepare" class="form-control" value="${readRecipeBean.openRecipe_prepare }" disabled="disabled"/>
					</div>
					
					
<%-- 				<div class="form-group">
						<label for="openRecipe_content">내용</label>
						<textarea id="openRecipe_content" name="openRecipe_content" class="form-control" rows="10" style="resize:none" disabled="disabled">${readRecipeBean.openRecipe_content }</textarea>
					</div> --%>
					
					
					<c:if test="${readRecipeBean.openRecipe_picture != null }">
					<div class="form-group">
						<label for="openRecipe_picture">완성 이미지</label>
						<img src="${root }/upload/${readRecipeBean.openRecipe_picture}"/>	
					</div>
					</c:if>
					
				<!-- List<StepBean> stepList의 stepBean들 꺼내오기 -->
						<div class="form-group">
						    <h4>요리 단계</h4>
						    <c:forEach var="step" items="${readRecipeBean.stepBeanList}" varStatus="status">
						        <div class="card mb-3">
						            <div class="card-body">
						                <div class="form-group">
						                    <label>Step ${status.index + 1} 설명</label>
						                    <!-- 수정 불가한 텍스트로 변경 -->
						                    <textarea class="form-control" rows="3" disabled="disabled">${step.stepText}</textarea>
						                </div>
						                
						                <div class="form-group">
						                   <c:if test="${not empty step.stepImageUrl}">
						                    <label>Step ${status.index + 1} 이미지</label>
						                        <div class="mb-2">
						                            <img src="${root}/upload/${step.stepImageUrl}" width="200" class="img-thumbnail" />
						                        </div>
						                    </c:if>
						                </div>
						            </div>
						        </div>
						    </c:forEach>
						</div>



					
					<div class="form-group">
						<div class="text-right">
							<a href="${root }/recipe_kit/recipe_kit_main?theme_index=${readRecipeBean.theme_index}" class="btn btn-primary">목록보기</a>
							<c:if test="${loginMember.id == readRecipeBean.id }">
							<a href="${root }/recipe/recipe_modify?openRecipe_index=${readRecipeBean.openRecipe_index}" class="btn btn-info">수정하기</a>
							<a href="${root }/recipe/recipe_delete?openRecipe_index=${readRecipeBean.openRecipe_index}" class="btn btn-danger">삭제하기</a>
							<a href="${root }/payment/payment?openRecipe_index=${readRecipeBean.openRecipe_index}" class="btn btn-danger">구매하기</a>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>

<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>

</body>
</html>