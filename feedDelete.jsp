<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.FeedDAO" %>
<%
    request.setCharacterEncoding("utf-8");
    
    String loginId = (String)session.getAttribute("loginId");
    String uno = request.getParameter("noBtn");
    
    if (uno != null && loginId != null) {
        FeedDAO dao = new FeedDAO();
        boolean isAdmin = dao.isAdmin(loginId);
        
        // 관리자이거나 본인 글인 경우 삭제 가능
        if(dao.delete(uno) || isAdmin) {
            out.println("<script>alert('삭제되었습니다.'); location.href='feedlist.jsp';</script>");
        } else {
            out.println("<script>alert('삭제 권한이 없습니다.'); location.href='feedlist.jsp';</script>");
        }
    } else {
        out.println("<script>alert('잘못된 요청입니다.'); location.href='feedlist.jsp';</script>");
    }
%>