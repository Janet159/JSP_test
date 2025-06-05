<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    // 배송정보 파라미터 받기
    String name = request.getParameter("name");
    String zipCode = request.getParameter("zipCode");
    String addressName = request.getParameter("addressName");
    String shippingDate = request.getParameter("shippingDate");
    String phone = request.getParameter("phone");

    // 세션에 배송정보 저장
    session.setAttribute("orderName", name);
    session.setAttribute("orderZipCode", zipCode);
    session.setAttribute("orderAddress", addressName);
    session.setAttribute("orderShippingDate", shippingDate);
    session.setAttribute("orderPhone", phone);

    // 예시 주문번호 생성 (실제는 DB insert 후 생성되는 값 사용)
    String orderNo = "ORD-" + System.currentTimeMillis();
    session.setAttribute("orderNo", orderNo);
    
    // 장바구니(주문목록) 가져오기
    List<Product> orderList = (List<Product>) session.getAttribute("cartList");
    if (orderList == null) {
        orderList = new ArrayList<>();
    }
    session.setAttribute("orderList", orderList);

    // 총액 계산
    int sum = 0;
    for (Product p : orderList) {
        sum += p.getUnitPrice() * p.getQuantity();
    }
    pageContext.setAttribute("sum", sum);
    
    // 로그인 여부
    boolean isLogin = (loginId != null);

%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 정보 - Shop🛒</title>
    <jsp:include page="/layout/meta.jsp" />
    <jsp:include page="/layout/link.jsp" />
</head>
<body>
    <jsp:include page="/layout/header.jsp" />

    <div class="px-4 py-5 my-5 text-center">
        <h1 class="display-5 fw-bold text-body-emphasis">주문 정보</h1>
    </div>

    <div class="container order mb-5">
        <form action="complete.jsp" method="post">

            <!-- 배송 정보 출력 -->
            <div class="ship-box">
                <table class="table">
                    <tbody>
                        <tr>
                        <td>주문 형태 :</td>
                        <td>
					        <% if (loginId != null) { %>
					            회원 주문
					        <% } else { %>
					            비회원 주문
					        <% } %>
					    </td>
                        </tr>
                        <tr><td>성 명 :</td><td><%= name %></td></tr>
                        <tr><td>우편번호 :</td><td><%= zipCode %></td></tr>
                        <tr><td>주소 :</td><td><%= addressName %></td></tr>
                        <tr><td>배송일 :</td><td><%= shippingDate %></td></tr>
                        <tr><td>전화번호 :</td><td><%= phone %></td></tr>
				        <% if (!isLogin) { %>
							<tr>
							    <td>주문 비밀번호 :</td>
							    <td>
							            <input type="password" class="form-control" name="orderPw" required>
							    </td>
							</tr>
				        <% }%>
                    </tbody>
                </table>
            </div>

            <!-- 주문 상품 목록 -->
            <div class="cart-box mt-5">
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
                        <c:choose>
                            <c:when test="${empty orderList}">
                                <tr><td colspan="4">주문하신 상품이 없습니다.</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="product" items="${orderList}">
                                    <tr>
                                        <td>${product.name}</td>
                                        <td>${product.unitPrice}</td>
                                        <td>${product.quantity}</td>
                                        <td>${product.unitPrice * product.quantity}</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="2"></td>
                            <td>총액</td>
                            <td>${sum}</td>
                        </tr>
                    </tfoot>
                </table>
            </div>

            <!-- 버튼 영역 -->
            <div class="d-flex justify-content-between mt-5 mb-5">
                <div class="item">
                    <a href="ship.jsp" class="btn btn-lg btn-success">이전</a>
                    <a href="/" class="btn btn-lg btn-danger">취소</a>
                </div>
                <div class="item">
                    <input type="hidden" name="login" value="false">
                    <input type="hidden" name="totalPrice" value="${sum}">
                    <input type="submit" class="btn btn-lg btn-primary" value="주문완료">
                </div>
            </div>

        </form>
    </div>

    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
</body>
</html>
