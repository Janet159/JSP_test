<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	String root = request.getContextPath();

	// 세션에서 loginId 가져오기
	String loginId = (String) session.getAttribute("loginId");
	
	// 자동 로그인 DB 토큰 삭제
	if (loginId != null) {
		UserRepository userDAO = new UserRepository();
		userDAO.deleteToken(loginId);
	}


	// 자동 로그인, 토큰 쿠키 삭제
	    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("remember-me".equals(c.getName())) {
                c.setMaxAge(0);
                c.setPath("/");  // 경로 맞춰서 삭제
                response.addCookie(c);
            }
        }
    }
	// 세션 무효화
	session.invalidate();
	response.sendRedirect(root + "/index.jsp");
	return;
	// 쿠키 전달
%>