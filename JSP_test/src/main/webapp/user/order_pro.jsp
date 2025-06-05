<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.OrderRepository"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%
	
	// 비회원 주문 내역 세션에 등록 처리
		
	response.sendRedirect(root + "/user/order.jsp");
	request.setCharacterEncoding("UTF-8");
	
	String phone = request.getParameter("phone");
	String orderPw = request.getParameter("orderPw");
	
	if (phone == null) phone = "";
	if (orderPw == null) orderPw = "";
	
	String url = root + "/user/order.jsp?phone="
	        + URLEncoder.encode(phone, "UTF-8")
	        + "&orderPw="
	        + URLEncoder.encode(orderPw, "UTF-8");
	response.sendRedirect(url);

%>