<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="EI=edge">
	<meta name="viewport" content="width-device-width, initial-scale=1.0">
	<title>사용자 리스트</title>
	<link rel="icon" href="favicon.ico" type="image/x-icon">
	<link rel="stylesheet" href="css/style.css">
	<script defer src="js/ie.js"></script>
</head>
<body>
	<header>
		<form class="userlist">
		<a href="main.jsp"><h6>DCODLAB</h6></a>
		<h1>User List</h1>
		<h6>
		<%
			UserDAO dao = new UserDAO();
			ArrayList<UserDO> users = dao.selectAll();
			
			String str = "";
			for(UserDO user: users) {
		
				str += user.getId() + " / " + user.getName() + " / " + user.getPhone() + "</br>";
			}
			
			str += "</table>";
			out.print(str);
		%>
		</h6>
	</form>
	</header>
</body>
</html>