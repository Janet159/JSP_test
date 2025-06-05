<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String mode = request.getParameter("mode");

    List<Product> cartList = (List<Product>) session.getAttribute("cartList");
    if(cartList == null) {
        cartList = new ArrayList<>();
        session.setAttribute("cartList", cartList);
    }

    // 삭제 처리
    if ("delete".equals(mode)) {
        if(id != null) {
            cartList.removeIf(p -> p.getProductId().equals(id));
        }
        response.sendRedirect("cart.jsp");
        return;
    }
    
    if("clear".equals(mode)) {
        // 전체삭제 모드일 때
        cartList.clear();
        response.sendRedirect("../shop/cart.jsp");
        return;
    }

    // 기본은 담기 (add)
    if(id == null || id.trim().isEmpty()) {
        response.sendRedirect("products.jsp");
        return;
    }

    ProductRepository productRepository = new ProductRepository();
    Product product = productRepository.getProductById(id);
    if(product == null) {
        response.sendRedirect("products.jsp");
        return;
    }

    boolean found = false;
    for(Product p : cartList) {
        if(p.getProductId().equals(id)) {
            p.setQuantity(p.getQuantity() + 1);
            found = true;
            break;
        }
    }
    if(!found) {
        product.setQuantity(1);
        cartList.add(product);
    }

    response.sendRedirect("cart.jsp");
%>
