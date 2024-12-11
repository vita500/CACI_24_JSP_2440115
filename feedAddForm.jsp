<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글쓰기</title>
    <link rel="stylesheet" href="css/feedAdd.css">
</head>
<body>
    <main class="write-container">
    <a href="main.jsp"><h6>DCODLAB</h6></a>
        <h1>글쓰기</h1>
        <form action="feedAdd.jsp" method="post" enctype="multipart/form-data">
            <section class="form-content">
                <div class="form-group">
                    <label for="user-id">ID: <%= (String)session.getAttribute("loginId") %></label>
                    <input type="hidden" name="uid" value="<%= (String)session.getAttribute("loginId") %>">
                </div>

                <div class="form-group">
                    <label for="content">CONTENT</label>
                    <textarea id="content" name="content" required></textarea>
                </div>

                <div class="form-group">
                    <label for="image">IMAGE</label>
                    <div class="image-placeholder"><img id="preview" src="img/placeholder.svg" alt="이미지 미리보기"></div>
                    <input type="file" id="image" name="image" accept="image/*" onChange="previewImage(event)">
                </div>

                <button type="submit">UPLOAD</button>
            </section>
        </form>
    </main>

    <script>
        function previewImage(e) {
            const preview = document.getElementById('preview');
            preview.src = e.target.files[0] ? URL.createObjectURL(e.target.files[0]) : 'img/placeholder.svg';
        }
    </script>
</body>
</html>