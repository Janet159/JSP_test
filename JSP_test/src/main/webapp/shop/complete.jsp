<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String orderNo = (String) session.getAttribute("orderNo");
    String addressName = (String) session.getAttribute("orderAddress");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 완료 - Shop🛒</title>
    <jsp:include page="/layout/meta.jsp" />
    <jsp:include page="/layout/link.jsp" />
</head>
<body>
    <jsp:include page="/layout/header.jsp" />

    <div class="px-4 py-5 my-5 text-center">
        <h1 class="display-5 fw-bold text-body-emphasis">주문 완료</h1>
    </div>

    <div class="container order mb-5 p-5">
        <h2 class="text-center">주문이 정상적으로 완료되었습니다.</h2>

        <div class="ship-box">
            <table class="table">
                <tbody>
                    <tr>
                        <td>주문번호 :</td>
                        <td><%= orderNo %></td>
                    </tr>
                    <tr>
                        <td>배송지 :</td>
                        <td><%= addressName %></td>
                    </tr>
                </tbody>
            </table>

            <div class="btn-box d-flex justify-content-center">
                <a href="${root}/user/order.jsp" class="btn btn-primary btn-lg px-4 gap-3">주문내역 확인</a>
            </div>
        </div>
    </div>

    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
</body>
</html>
