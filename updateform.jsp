<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<%@ page import="dao.UserDO" %>
<%
    // 세션에서 사용자 ID 가져오기
    String uid = (String) session.getAttribute("loginId");
    if (uid == null) {
        response.sendRedirect("login.html");
        return;
    }
    
    // 사용자 정보 가져오기
    UserDAO dao = new UserDAO();
    UserDO user = dao.getUser(uid);
    if (user == null) {
        response.sendRedirect("login.html");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <form action="update.jsp" method="post">
        <a href="main.jsp"><h6>DCODLAB</h6></a>
        <h1>MY PAGE</h1>
        <div class="mb-3">
            <label for="formGroupExampleInput" class="form-label">ID</label>
            <input type="text" value="<%= uid %>" class="form-control" readonly>
        </div>
        <div class="mb-3">
			<label for="formGroupExampleInput2" class="form-label">PASSWORD</label>
			<input type="password" name="upw" class="form-control" id="formGroupExampleInput2"
			value="<%= user.getUpw() %>" required>
		</div>
		<div class="mb-3">
			<label for="formGroupExampleInput2" class="form-label">PASSWORD-CHECK</label>
			<input type="password" name="upw2" class="form-control" id="formGroupExampleInput2"
			value="<%= user.getUpw() %>" required>
		</div>
        <div class="mb-3">
            <label for="formGroupExampleInput" class="form-label">NAME</label>
            <input type="text" name="name" class="form-control" id="formGroupExampleInput"
                value="<%= user.getName() %>" required>
        </div>
        <div class="mb-3">
            <label for="formGroupExampleInput" class="form-label">PHONE NUMBER</label>
            <input type="text" name="phone" class="form-control" id="formGroupExampleInput"
                value="<%= user.getPhone() %>" required>
        </div>
        <input type="submit" value="수정하기" class="update-btn">
        <a href="withdraw.html"><h6>>> Delete Account</h6></a>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>