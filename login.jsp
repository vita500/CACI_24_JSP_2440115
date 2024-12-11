<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<%@ page import="dao.UserDO" %> 
<% 
	request.setCharacterEncoding("utf-8");

	String uid = request.getParameter("uid");
	String upass = request.getParameter("upw");
	
	UserDAO dao = new UserDAO();
	int code = dao.login(uid, upass);
	if (code == 1) {
		response.setContentType("text/html; charset=UTF-8");
	    response.getWriter().println("<script>alert('아이디가 존재하지 않습니다.'); location.href='login.html';</script>");
	}
	else if (code ==2) {
		response.setContentType("text/html; charset=UTF-8");
	    response.getWriter().println("<script>alert('패스워드가 일치하지 않습니다.'); location.href='login.html';</script>");
	}
	else {
	    // 로그인 성공시 사용자 이름을 가져와서 세션에 저장
		UserDO user = dao.getUser(uid);
	    session.setAttribute("loginSuccess", user.getName());
	    session.setAttribute("loginId", uid);  // ID도 저장
	    response.sendRedirect("main.jsp");
	}
	
%>
