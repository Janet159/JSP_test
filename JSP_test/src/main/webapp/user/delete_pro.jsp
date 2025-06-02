<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />

<%
	request.setCharacterEncoding("UTF-8");
	
	// 세션에서 로그인한 사용자 ID 가져오기
	String loginId = (String) session.getAttribute("loginId");
	
	// 삭제 로직
	int result = userDAO.delete(loginId);
	
	if (result > 0) {
	    // 세션 종료 (로그아웃)
	    session.invalidate();
	
	    // 탈퇴 성공 → 메인페이지 이동 (혹은 탈퇴완료 페이지 이동 가능)
	    response.sendRedirect(request.getContextPath()+"/index.jsp");
	} else {
	    // 삭제 실패 → 다시 회원정보 수정 페이지로 이동
	    response.sendRedirect("update.jsp");
	}
%>
