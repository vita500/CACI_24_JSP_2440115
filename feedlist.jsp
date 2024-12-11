<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>작성글 리스트</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/ed3c1f461e.js" crossorigin="anonymous"></script>
    <script>function goNo(no){}</script>
    <link rel="stylesheet" href="css/feedList.css">
</head>
<body>
    <a href="main.jsp"><h6>DCODLAB</h6></a>
    <h1>Community</h1>
    <a href="feedAddForm.jsp" class="feedAdd-btn">
	    <span class="btn-text">글쓰기</span><i class="fa-solid fa-pen"></i>
	</a>
    <%
    	request.setCharacterEncoding("utf-8");	
    
		String uid = (String)session.getAttribute("loginId");
		if (uid == null) {
			response.sendRedirect("login.html");
			return;
		}
		
		session.setAttribute("uid", uid);
		ArrayList<FeedObj> feeds = (new FeedDAO()).getList();
		
		String str = "<table align=center width=900px>";

    	str += "<tr>";
		str += "<th width=150px>작성자</th>";
		str += "<th width=200px>이미지</th>";
		str += "<th width=350px>내용</th>";
		str += "<th width=200px>작성날짜</th>";
		str += "<th></th>";
		str += "</tr>";
		
		str += "<tr><td colspan=5><hr></td></tr>";
		
		FeedDAO dao = new FeedDAO();
		boolean isAdmin = dao.isAdmin(uid);  // 현재 로그인한 사용자가 관리자인지 확인

	    for (FeedObj feed : feeds) {
	    	String img = feed.getImages(), imgstr = "";
	    	if (img != null) {
	    		imgstr = "<img src='images/" + img + "'>";
	    	}
	        
	        str += "<tr>";
	    	str += "<td><small>" + feed.getId() + "</small></td>";
	        str += "<td>" + imgstr + "</td>";
	        str += "<td class='content-cell'><a href='feedDetail.jsp?no=" + feed.getNo() + "' class='content-link'>" + feed.getContent() + "</a></td>";
	    	str += "<td><small>&nbsp;(" + feed.getTs() + ")</small></td>";
	    	
	    	// 본인 글이거나 관리자면 삭제 버튼 표시
	        if (uid.equals(feed.getId()) || isAdmin) {
	            str += "<td align=right><form id='deleteForm_" + feed.getNo() + "' action='feedDelete.jsp' method='post'>"
	                 + "<input type='hidden' name='noBtn' value='" + feed.getNo() + "'>"
	                 + "<input type='submit' value='삭제'></form></td>";
	        } else {
	            str += "<td></td>";
	        }
	        str += "</tr>";	
	        
	        str += "<tr><td colspan=5><hr></td></tr>";
	        
	    	System.out.println("no : " + feed.getNo());
	    }
	    str += "</table>";
	    out.print(str);
	%>
</body>
</html>