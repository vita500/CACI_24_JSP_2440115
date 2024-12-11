<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="dao.FeedDAO"%>
<%@ page import="util.FileUtil"%>

<%
    request.setCharacterEncoding("utf-8");
    String no = null, content = null, fname = null;
    byte[] file = null;

    ServletFileUpload sfu = new ServletFileUpload(new DiskFileItemFactory());
    List<FileItem> items = sfu.parseRequest(request);
    
    for(FileItem item : items) {
        if(item.isFormField()) {
            String fieldName = item.getFieldName();
            String value = item.getString("UTF-8");
            if(fieldName.equals("no")) no = value;
            else if(fieldName.equals("content")) content = value;
        }
        else {
            if(item.getFieldName().equals("image")) {
                fname = item.getName();
                if(!fname.isBlank()) {
                    file = item.get();
                    String root = application.getRealPath(java.io.File.separator);
                    FileUtil.saveImage(root, fname, file);
                } else {
                    fname = null;
                }
            }
        }
    }
    
    FeedDAO dao = new FeedDAO();
    if(dao.update(no, content, fname)) {
        response.sendRedirect("feedDetail.jsp?no=" + no);
    } else {
        out.print("수정 중 오류가 발생했습니다.");
    }
%>