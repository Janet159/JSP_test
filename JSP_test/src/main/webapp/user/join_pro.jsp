<!-- 
	회원 가입 처리
 -->
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	User user = new User();
	//1. 파라미터 받아오기
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String mail1 = request.getParameter("email1");
	String mail2 = request.getParameter("email2");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	
	// 2. 데이터 가공
	String birth = year + "-" + month + "-" + day;
	String mail = mail1 + "@" + mail2;
	
	// 3. DTO에 담기
/* 	User user = new User(); */
	user.setId(id);
	user.setPassword(pw);
	user.setName(name);
	user.setGender(gender);
	user.setBirth(birth);
	user.setMail(mail);
	user.setPhone(phone);
	user.setAddress(address);
	
	// 4. DB insert 요청
	UserRepository userDAO = new UserRepository();
	int result = userDAO.insert(user);
	
	if (result > 0) {
	    // 성공 시
	    response.sendRedirect(request.getContextPath()+"/index.jsp");
	} else {
	    // 실패 시
	    response.sendRedirect("join.jsp?error=1");
	}
	
	
%>
    
    

    
    
    
    
    
    