<!-- 로그인 처리 -->
<%@page import="java.util.UUID"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	
	UserRepository userDAO = new  UserRepository();
	User loginUser = userDAO.login(id, pw);
	
	// 로그인 실패
	if (loginUser == null) {
	// 로그인 실패 시 → 로그인 페이지로 다시 이동 (에러파라미터 전달)
	response.sendRedirect("login.jsp?error=0");
	return;
	}
	// 로그인 성공
	// - 세션에 아이디 등록
	session.setAttribute("loginId", loginUser.getId());
	
	// 아이디 저장
	String rememberId = request.getParameter("remember-id");

	if (rememberId != null && rememberId.equals("on")) {
		// 쿠키 생성 → 아이디 저장
		Cookie cookie = new Cookie("remember-id", id);
		cookie.setMaxAge(60 * 60 * 24 * 7);  // 7일 유지
		response.addCookie(cookie);
	} else {
		// 체크 안한 경우 → 기존 쿠키 삭제
		Cookie cookie = new Cookie("remember-id", "");
		cookie.setMaxAge(0);  // 삭제
		response.addCookie(cookie);
	}
	// 자동 로그인
	String rememberMe = request.getParameter("remember-me");

	if (rememberMe != null && rememberMe.equals("on")) {
		// UUID 토큰 생성
		String token = userDAO.refreshToken(id);

		// 자동 로그인용 쿠키 생성
		Cookie cookie = new Cookie("remember-me", token);
		cookie.setMaxAge(60 * 60 * 24 * 30);  // 30일 유지
		response.addCookie(cookie);
	} else {
		// 자동 로그인 체크 안했으면 쿠키 삭제
		Cookie cookie = new Cookie("remember-me", "");
		cookie.setMaxAge(0);
		response.addCookie(cookie);
	}
	// 쿠키 전달
	
	// 로그인 성공 페이지로 이동
	response.sendRedirect("complete.jsp?msg=0");		

%>





