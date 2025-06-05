<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    List<Product> cartList = (List<Product>) session.getAttribute("cartList");
    if(cartList == null) {
        cartList = new ArrayList<>();
    }
    int sum = 0;
    for(Product p : cartList) {
        sum += p.getUnitPrice() * p.getQuantity();
    }
    session.setAttribute("cartList", cartList);
    pageContext.setAttribute("sum", sum);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>배송 정보 - Shop🛒</title>
    <jsp:include page="/layout/meta.jsp" />
    <jsp:include page="/layout/link.jsp" />
</head>
<body>
    <jsp:include page="/layout/header.jsp" />

    <div class="px-4 py-5 my-5 text-center">
        <h1 class="display-5 fw-bold text-body-emphasis">배송 정보</h1>
    </div>

    <!-- 배송 정보 입력 -->
    <div class="container shop mb-5 p-4">
        <form action="${root}/shop/order.jsp" class="form-horizontal" method="post">
            <div class="input-group mb-3 row">
                <label class="input-group-text col-md-2">성명</label>
                <input type="text" class="form-control col-md-10" name="name" required>
            </div>
            <div class="input-group mb-3 row">
                <label class="input-group-text col-md-2">배송일</label>
                <input type="date" class="form-control col-md-10" name="shippingDate" required>
            </div>
            <div class="input-group mb-3 row">
                <label class="input-group-text col-md-2">국가명</label>
                <input type="text" class="form-control col-md-10" name="country" required>
            </div>
            <div class="input-group mb-3 row">
                <label class="input-group-text col-md-2">우편번호</label>
                <input type="text" class="form-control col-md-10" name="zipCode" required>
            </div>
            <div class="input-group mb-3 row">
                <label class="input-group-text col-md-2">주소</label>
                <input type="text" class="form-control col-md-10" name="addressName" required>
            </div>
            <div class="input-group mb-3 row">
                <label class="input-group-text col-md-2">전화번호</label>
                <input type="text" class="form-control col-md-10" name="phone" required>
            </div>

            <!-- 버튼 영역 -->
            <div class="d-flex justify-content-between mt-5 mb-5">
                <div class="item">
                    <a href="${root}/shop/cart.jsp" class="btn btn-lg btn-success">이전</a>
                    <a href="/" class="btn btn-lg btn-danger">취소</a>				
                </div>
                <div class="item">
                    <input type="submit" class="btn btn-lg btn-primary" value="등록">
                </div>
            </div>

        </form>
    </div>

    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
</body>
</html>
