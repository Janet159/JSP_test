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
    pageContext.setAttribute("cartList", cartList);
    pageContext.setAttribute("sum", sum);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shop</title>
    <jsp:include page="/layout/meta.jsp" />
    <jsp:include page="/layout/link.jsp" />
</head>
<body>
    <jsp:include page="/layout/header.jsp" />

    <div class="px-4 py-5 my-5 text-center">
        <h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
        <div class="col-lg-6 mx-auto">
            <p class="lead mb-4">담긴 상품 목록입니다.</p>
        </div>
    </div>

    <div class="container mb-5 shop">
        <table class="table table-striped table-hover table-bordered text-center align-middle">
            <thead>
                <tr class="table-primary">
                    <th>상품명</th>
                    <th>가격</th>
                    <th>수량</th>
                    <th>소계</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${cartList}">
                    <tr>
                        <td>${product.name}</td>
                        <td>${product.unitPrice}</td>
                        <td>${product.quantity}</td>
                        <td>${product.unitPrice * product.quantity}</td>
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot>
                <c:choose>
                    <c:when test="${empty cartList}">
                        <tr>
                            <td colspan="4">추가된 상품이 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="2"></td>
                            <td>총액</td>
                            <td id="cart-sum">${sum}</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tfoot>
        </table>
        <div class="d-flex justify-content-end">
            <a href="${root}/shop/products.jsp" class="btn btn-secondary me-2">계속 쇼핑하기</a>
            <a href="${root}/user/order.jsp" class="btn btn-primary">주문하기</a>
        </div>
    </div>

    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
</body>
</html>