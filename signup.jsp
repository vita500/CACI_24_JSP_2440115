<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<% 
	request.setCharacterEncoding("utf-8");

	String uid = request.getParameter("uid");
	String upw = request.getParameter("upw");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	
	UserDAO dao = new UserDAO();
	if(dao.exists(uid)){
		response.setContentType("text/html; charset=UTF-8");
	    response.getWriter().println("<script>alert('가입된 정보입니다.'); location.href='signup.html';</script>");
		return;
	}
	
	if(dao.insert(uid, upw, name, phone)) {
		response.setContentType("text/html; charset=UTF-8");
	    response.getWriter().println("<script>alert('회원가입이 완료되었습니다.'); location.href='login.html';</script>");
	}else{
		response.setContentType("text/html; charset=UTF-8");
	    response.getWriter().println("<script>alert('오류가 발생하였습니다.'); location.href='signup.html';</script>");
	}
	
%>
