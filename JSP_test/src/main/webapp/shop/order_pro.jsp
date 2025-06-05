<%@page import="shop.dao.ProductIORepository"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.OrderRepository"%>
<%@page import="shop.dto.Order"%>
<%@page import="shop.dto.Product"%>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    // 장바구니(주문상품목록)
    List<Product> orderList = (List<Product>) session.getAttribute("orderList");
    if(orderList == null || orderList.isEmpty()) {
        out.print("<script>alert('장바구니가 비어있습니다.'); history.back();</script>");
        return;
    }

    // 총액 계산
    int sum = 0;
    for(Product p : orderList) {
        sum += p.getUnitPrice() * p.getQuantity();
    }

    // 배송정보 세션에서 꺼내오기
    String name = (String) session.getAttribute("orderName");
    String zipCode = (String) session.getAttribute("orderZipCode");
    String country = (String) session.getAttribute("orderCountry");
    String addressName = (String) session.getAttribute("orderAddress");
    String shippingDate = (String) session.getAttribute("orderShippingDate");
    String phone = (String) session.getAttribute("orderPhone");

    // 비회원 주문 비밀번호 받기 (비회원일 경우만 입력됨)
    String orderPw = request.getParameter("orderPw");
    if(orderPw == null) orderPw = "";

    // 회원 여부 체크
    boolean isLogin = (loginId != null);
    String userId = (isLogin) ? loginId : "GUEST";

    // Order 객체 생성
    Order order = new Order();
    order.setShipName(name);
    order.setZipCode(zipCode);
    order.setAddress(addressName);
    order.setDate(shippingDate);
    order.setPhone(phone);
    order.setOrderPw(orderPw);
    order.setUserId(userId);
    order.setTotalPrice(sum);
    order.setCountry(country);


    // DB insert
    OrderRepository orderDAO = new OrderRepository();
    ProductIORepository ioDAO = new ProductIORepository();
    int result = orderDAO.insert(order);
    
    if (result > 0) {
        // 방금 등록한 주문번호 가져오기
        int orderNo = orderDAO.lastOrderNo();
        
        // product_io 테이블 insert
        for (Product p : orderList) {
            ioDAO.insert(p, orderNo, "OUT", userId);
        }

        // 장바구니 비우기
        session.removeAttribute("cartList");
        session.removeAttribute("orderList");

        // 주문번호 세션으로 넘겨서 complete.jsp에서 보여줄 수 있게
        session.setAttribute("lastOrderNo", orderNo);

        // 완료페이지로 이동
        response.sendRedirect("complete.jsp");
    } else {
        out.print("<script>alert('주문처리에 실패했습니다.'); history.back();</script>");
    }
%>
