<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="dao.UserDAO"%>
<%@ page import="dao.UserDO"%>

<%
	request.setCharacterEncoding("utf-8");
	
	// 현재 로그인된 사용자의 ID 가져오기
	String loginId = (String) session.getAttribute("loginId");
	if (loginId == null) {
	    response.setContentType("text/html; charset=UTF-8");
	    response.getWriter().println("<script>alert('로그인이 필요합니다.'); location.href='login.html';</script>");
	    return;
	}
	
	// 입력된 ID와 비밀번호 가져오기
	String inputId = request.getParameter("id");
	String inputPS = request.getParameter("ps");
	
	try {
	    UserDAO dao = new UserDAO();
	    
	    // 1. 로그인된 ID와 입력된 ID 비교
	    if (!loginId.equals(inputId)) {
	        response.setContentType("text/html; charset=UTF-8");
	        response.getWriter().println("<script>alert('본인의 아이디를 정확하게 입력해주세요.'); history.back();</script>");
	        return;
	    }
	    
	    // 2. 사용자 정보 가져오기 및 비밀번호 확인
	    UserDO user = dao.getUser(inputId);
	    if (user == null || !user.getUpw().equals(inputPS)) {
	        response.setContentType("text/html; charset=UTF-8");
	        response.getWriter().println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
	        return;
	    }
	    
	    // 3. 모든 확인이 완료되면 계정 삭제
	    if (dao.delete(inputId)) {
	        // 탈퇴 성공
	        session.invalidate(); // 모든 세션 제거
	        response.setContentType("text/html; charset=UTF-8");
	        response.getWriter().println("<script>alert('탈퇴가 완료되었습니다.'); location.href='main.jsp';</script>");
	    } else {
	        // 탈퇴 실패
	        response.setContentType("text/html; charset=UTF-8");
	        response.getWriter().println("<script>alert('탈퇴 처리 중 오류가 발생했습니다.'); history.back();</script>");
	    }
	} catch (Exception e) {
	    response.setContentType("text/html; charset=UTF-8");
	    response.getWriter().println("<script>alert('시스템 오류가 발생했습니다.'); history.back();</script>");
	    e.printStackTrace();
	}
%>