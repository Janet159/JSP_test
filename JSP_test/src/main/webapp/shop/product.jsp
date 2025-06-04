<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 상품 ID 파라미터 받기 
	String id = request.getParameter("id");
	
	// 유효성 체크 
	if( id == null || id.trim().isEmpty()) {
		response.sendRedirect("products.jsp");
		return; 
	}
	
	// DAO 생성 및 상품 조회 
	ProductRepository productRepository = new ProductRepository();
	Product product = productRepository.getProductById(id);
	
	// 상품이 존재하지 않을 경우 처리 
	if(product == null ){
		response.sendRedirect("products.jsp");
		return; 
	}
	
	// request에 product 저장 
	pageContext.setAttribute("product", product);

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop</title>
	<jsp:include page="/layout/meta.jsp" /> <jsp:include page="/layout/link.jsp" />
</head>
<body>   
	
	<jsp:include page="/layout/header.jsp" />
	
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품 정보</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
				<a href="./products.jsp" class="btn btn-primary btn-lg px-4 gap-3">상품목록</a>
			</div>
		</div>
	</div>
	
	<!-- 상품 정보 영역 -->
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<!-- 썸네일 이미지 -->
				<img src="img?id=${product.productId}" class="w-100 p-2" alt="${product.name}" />
			</div>
			<div class="col-md-6">
				<h3 class="mb-5">${product.name}</h3>
				<table class="table">
					<colgroup>
						<col width="120px" />
						<col />
					</colgroup>
					<tr>
						<td>상품ID :</td>
						<td>${product.productId}</td>
					</tr>
					<tr>
						<td>제조사 :</td>
						<td>${product.manufacturer}</td>
					</tr>
					<tr>
						<td>분류 :</td>
						<td>${product.category}</td>
					</tr>
					<tr>
						<td>상태 :</td>
						<td>${product.condition}</td>
					</tr>
					<tr>
						<td>재고 수 :</td>
						<td>${product.unitsInStock}</td>
					</tr>
					<tr>
						<td>가격 :</td>
						<td>₩ ${product.unitPrice}</td>
					</tr>
				</table>
	
				<div class="mt-4">
					<form name="addForm" action="./addCart.jsp" method="post">
						<input type="hidden" name="id" value="${product.productId}" />
						<div class="btn-box d-flex justify-content-end">
							<!-- 장바구니 바로가기 -->
							<a href="./cart.jsp" class="btn btn-lg btn-warning mx-3">장바구니</a>
	
							<!-- 주문하기 버튼 (submit) -->
							<a href="javascript:;" class="btn btn-lg btn-success mx-3" onclick="document.addForm.submit()">주문하기</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>