<%-- 전역변수 --%>
<%
	// Context Path (루트 경로)
	String root = request.getContextPath();
	// 로그인 아이디 (세션)
	String loginId = (String) session.getAttribute("loginId");
	Boolean roleObj = (Boolean) session.getAttribute("role");
	boolean role = (roleObj != null) ? roleObj : false;
	pageContext.setAttribute("root", root);
%>