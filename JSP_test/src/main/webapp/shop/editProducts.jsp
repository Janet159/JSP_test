<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ProductRepository productRepository = new ProductRepository();
	List<Product> productList =  productRepository.list();
	pageContext.setAttribute("productList", productList);
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
		<h1 class="display-5 fw-bold text-body-emphasis">상품 편집</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">쇼핑몰 상품 목록 입니다.</p>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
			
				<a href="add.jsp" class="btn btn-primary btn-lg px-4 gap-3">상품 등록</a>
				<!-- [NEW] 상품 편집 버튼 추가 -->
				<a href="products.jsp" class="btn btn-success btn-lg px-4 gap-3">상품 목록</a>
				
			</div>
		</div>
	</div>
	
<div class="container mb-5">
	<div class="row gy-4">
		<c:forEach var="product" items="${productList}">
			<div class="col-md-6 col-xl-4 col-xxl-3">
				<div class="card p-3">
					<!-- 이미지 영역 -->
					<div class="img-content">
						<img src="img?id=${product.productId}" class="w-100 p-2" />
					</div>
					<!-- 컨텐츠 영역 -->
					<div class="content">
						<h3 class="text-center">${product.name}</h3>
						<p>${product.description}</p>
						<p class="text-end price">₩ ${product.unitPrice}</p>
						<p class="d-flex justify-content-end">
							<a href="./update.jsp?id=${product.productId}" class="btn btn-primary mx-2">수정</a>
							<a href="javascript:;" class="btn btn-danger mx-2"
							   onclick="deleteProduct('${product.productId}')">삭제</a>
						</p>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
	
	<script type="text/javascript">
		function deleteProduct(productId) {
			if (confirm("정말 삭제하시겠습니까?")) {
				location.href = "./delete.jsp?id=" + productId;
			}
		}
	</script>
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>