<%@page import="java.util.ArrayList"%>
<%@page import="shop.dao.ProductIORepository"%>
<%@page import="shop.dto.ProductIO"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.OrderRepository"%>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String phone = request.getParameter("phone");
	String orderPw = request.getParameter("orderPw");
	
	List<ProductIO> ioList = new ArrayList<>();
	ProductIORepository dao = new ProductIORepository();
	ioList = dao.selectByOrderPhonePw(phone, orderPw);
	// 비회원 주문 내역 세션에 등록 처리
    session.setAttribute("orderPhone", phone);
    session.setAttribute("orderPw", orderPw);
    session.setAttribute("orderList", ioList);
    
	response.sendRedirect(root + "/user/order.jsp");

%>