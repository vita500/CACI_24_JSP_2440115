<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dao.UserDO" %>

<%
request.setCharacterEncoding("utf-8");

// 세션에서 로그인된 사용자 ID 가져오기
String uid = (String) session.getAttribute("loginId");
if (uid == null) {
    response.sendRedirect("login.html");
    return;
}

// POST 요청(폼 제출)인 경우 처리
if (request.getMethod().equals("POST")) {
    try {
        String upw = request.getParameter("upw");
        String upw2 = request.getParameter("upw2");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");

        // 비밀번호 확인 검증
        if (!upw.equals(upw2)) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
            return;
        }

        UserDAO dao = new UserDAO();
        if (dao.update(uid, upw, name, phone)) {
            // 세션의 이름 정보도 업데이트
            session.setAttribute("loginSuccess", name);
            
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('회원정보가 수정되었습니다.'); location.href='main.jsp';</script>");
            return;
        } else {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('오류가 발생했습니다.'); history.back();</script>");
            return;
        }
    } catch (Exception e) {
        response.setContentType("text/html; charset=UTF-8");
        response.getWriter().println("<script>alert('시스템 오류가 발생했습니다.'); history.back();</script>");
        return;
    }
}
%>