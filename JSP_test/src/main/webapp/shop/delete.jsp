<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String productId = request.getParameter("id");

	ProductRepository productRepository = new ProductRepository();
	int result =  productRepository.delete(productId);
		
	
	if(result > 0) {
    	response.sendRedirect("editProducts.jsp");
    } else {
    	out.print("상품 삭제 실패");
    }

	
	
	
	

%>