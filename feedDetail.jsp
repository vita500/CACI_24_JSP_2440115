<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 보기</title>
    <link rel="stylesheet" href="css/feedDetail.css">
    <script src="https://kit.fontawesome.com/ed3c1f461e.js" crossorigin="anonymous"></script>
</head>
<body>
    <main class="detail-container">
        <header>
            <a href="feedlist.jsp" class="back-link">&larr; Community</a>
        </header>

        <% 
            String loginId = (String)session.getAttribute("loginId");
            String feedNo = request.getParameter("no");
            
            if(feedNo == null || feedNo.trim().isEmpty()) {
                response.sendRedirect("feedlist.jsp");
                return;
            }
            
            FeedDAO dao = new FeedDAO();
            FeedObj feed = dao.getFeed(feedNo);
            
            if(feed == null) {
                response.sendRedirect("feedlist.jsp");
                return;
            }
            
         	// 관리자 여부 확인 추가
            boolean isAdmin = dao.isAdmin(loginId);
            // 작성자이거나 관리자일 때 수정/삭제 권한 부여
            boolean hasEditPermission = loginId != null && (isAdmin || loginId.equals(feed.getId()));
        %>

        <form action="feedUpdate.jsp" method="post" enctype="multipart/form-data">
            <input type="hidden" name="no" value="<%= feedNo %>">
            
            <section class="content-section">
                <div class="user-info"><label>ID: <%= feed.getId() %></label></div>

                <div class="content-area">
                    <textarea name="content" readonly><%= feed.getContent() %></textarea>
                </div>

                <div class="image-area">
                    <% if(feed.getImages() != null) { %>
                        <img src="images/<%= feed.getImages() %>" alt="게시글 이미지" id="preview">
                    <% } %>
                </div>

                <!-- 나머지 코드는 동일하고 버튼 표시 조건만 변경 -->
				<% if(hasEditPermission) { %>
					<input type="file" name="image" id="image-upload" accept="image/*" style="display: none;">
				    <div class="button-group">
				        <button type="button" id="editBtn" onclick="toggleEdit()">UPDATE</button>
				        <button type="button" class="delete-btn" onclick="deleteFeed()">
				            <i class="fa-solid fa-trash-can"></i>
				        </button>
				    </div>
				<% } %>
            </section>
        </form>
    </main>

    <script>
        let isEditing = false;

        function toggleEdit() {
            const textarea = document.querySelector('textarea');
            const imageUpload = document.getElementById('image-upload');
            const editBtn = document.getElementById('editBtn');
            const form = document.querySelector('form');

            isEditing = !isEditing;
            
            textarea.readOnly = !isEditing;
            imageUpload.disabled = !isEditing;
            imageUpload.style.display = isEditing ? 'block' : 'none';
            
            if(isEditing) {
            	imageUpload.style.display = 'block';
                editBtn.textContent = "SAVE";
                editBtn.onclick = () => form.submit();
            } else {
            	imageUpload.style.display = 'none';
                editBtn.textContent = "UPDATE";
                editBtn.onclick = toggleEdit;
            }
        }

        function deleteFeed() {
            if(confirm('정말 삭제하시겠습니까?')) {
                location.href = 'feedDelete.jsp?noBtn=<%= feedNo %>';
            }
        }

        document.getElementById('image-upload').onchange = function(e) {
            const preview = document.getElementById('preview');
            preview.src = URL.createObjectURL(e.target.files[0]);
        };
    </script>
</body>
</html>