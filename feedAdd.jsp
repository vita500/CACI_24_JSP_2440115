<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="dao.FeedDAO"%>
<%@ page import="util.FileUtil"%>

<%
	request.setCharacterEncoding("utf-8");	
	String uid = null, ucon = null, ufname = null;
	byte[] ufile = null;
	ServletFileUpload sfu = new ServletFileUpload(new DiskFileItemFactory());
	List items = sfu.parseRequest(request);
	Iterator iter = items.iterator();
	
	while(iter.hasNext()) {
		FileItem item = (FileItem) iter.next();
		String name = item.getFieldName();
		if(item.isFormField()) {
			
			
			String value = item.getString("UTF-8");
			if (name.equals("uid")) uid = value;
			else if (name.equals("content")) ucon = value;
		}
		else {
			if (name.equals("image")) {
				ufname = item.getName();
				ufile = item.get();
				System.out.println("ufname : " + ufname + " / ufile : " + ufile + "/ tf : " + ufname.isBlank());
				if(!ufname.isBlank()){
					String root = application.getRealPath(java.io.File.separator);
					System.out.println("root : " + root);
					FileUtil.saveImage(root, ufname, ufile);
				}else{
					ufname = null;
				}
			}
		}
	}
	
	FeedDAO dao = new FeedDAO();
	if (dao.insert(uid, ucon, ufname)) {
		session.setAttribute("loginId", uid);
		response.sendRedirect("feedlist.jsp");
	}
	else {
		out.print("작성 글의 업로드 중 오류가 발생하였습니다.");
	}

%>

