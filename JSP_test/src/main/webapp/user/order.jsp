<%@page import="shop.dao.OrderRepository"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%

    // 만약 비로그인 상태라면 로그인 페이지로 보낼 수도 있음 (선택)
    if (loginId == null) {
        response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        return;
    }

    // DAO 호출해서 주문내역 조회
    OrderRepository orderDAO = new OrderRepository();
    List<Product> orderList = orderDAO.list(loginId);

    if(orderList == null) {
        orderList = new ArrayList<>();
    }

    int sum = 0;
    for(Product p : orderList) {
        sum += p.getUnitPrice() * p.getQuantity();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 내역 - Shop🛒</title>
    <jsp:include page="/layout/meta.jsp" />
    <jsp:include page="/layout/link.jsp" />
</head>
<body>
    <jsp:include page="/layout/header.jsp" />

    <div class="row m-0 mypage">
        <div class="sidebar border-end col-md-3 col-lg-2 p-0 bg-body-tertiary">
            <div class="d-flex flex-column p-3">
                <ul class="nav nav-pills flex-column mb-auto">
                    <li><a href="/user/index.jsp" class="nav-link link-body-emphasis">마이 페이지</a></li>
                    <li><a href="/user/update.jsp" class="nav-link link-body-emphasis">회원정보 수정</a></li>
                    <li><a href="#" class="nav-link active link-body-emphasis">주문내역</a></li>
                </ul>
                <hr>
            </div>
        </div>

        <div class="col-md-9 ms-sm-auto col-lg-10 p-0">
            <div class="px-4 py-3 my-3 text-center">
                <h1 class="display-5 fw-bold text-body-emphasis">주문 내역</h1>
            </div>

            <div class="container shop m-auto mb-5">
                <table class="table table-striped table-hover table-bordered text-center align-middle">
                    <thead>
                        <tr class="table-primary">
                            <th>주문번호</th>
                            <th>상품명</th>
                            <th>가격</th>
                            <th>수량</th>
                            <th>소계</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if(orderList.isEmpty()) {
                        %>
                            <tr><td colspan="5">주문 내역이 없습니다.</td></tr>
                        <%
                            } else {
                                for(Product product : orderList) {
                                    int total = product.getUnitPrice() * product.getQuantity();
                        %>
                            <tr>
                                <td><%= product.getOrderNo() %></td>
                                <td><%= product.getName() %></td>
                                <td><%= product.getUnitPrice() %></td>
                                <td><%= product.getQuantity() %></td>
                                <td><%= total %></td>
                            </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                    <% if(!orderList.isEmpty()) { %>
                    <tfoot>
                        <tr>
                            <td colspan="4" class="text-end fw-bold">총액</td>
                            <td class="fw-bold"><%= sum %></td>
                        </tr>
                    </tfoot>
                    <% } %>
                </table>
            </div>

            <jsp:include page="/layout/footer.jsp" />
        </div>
    </div>

    <jsp:include page="/layout/script.jsp" />
</body>
</html>
