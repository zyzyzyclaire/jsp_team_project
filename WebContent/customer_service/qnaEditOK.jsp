<%@page import="notice.QnABean"%>
<%@page import="notice.QnADBBean"%>
<%@page import="java.net.InetAddress"%>
<%@page import="login.UserDBBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	String path = request.getRealPath("upload");
	int size=1024*1024*10;
	int fileSize=0;
	String file="";
	String oriFile="";
	
	MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
	Enumeration files = multi.getFileNames();
	String str = (String) files.nextElement();
	
	file = multi.getFilesystemName(str);
	
	if(file != null){
		oriFile = multi.getOriginalFileName(str);
		fileSize = file.getBytes().length;
	}
%>
<%
	InetAddress address = InetAddress.getLocalHost();
	String ip = address.getHostAddress();	   
   
   String pageNum = request.getParameter("pageNum");
   
   QnADBBean qdb = QnADBBean.getInstance();
   QnABean board = new QnABean();
   UserDBBean udb = new UserDBBean();
   
   String user_id = (String) session.getAttribute("user_id");
	boolean isAdmin = udb.isAdmin(user_id);
   
   int b_id = Integer.parseInt(multi.getParameter("b_id"));
   board.setB_id(b_id);
   board.setB_title(multi.getParameter("b_title"));
   board.setU_id(multi.getParameter(user_id));
   board.setB_content(multi.getParameter("b_content"));
   board.setB_pwd(multi.getParameter("b_pwd"));
   board.setB_category(multi.getParameter("b_category"));
   board.setB_ip(ip);
   
   if(file != null){
		board.setB_fname(file);
		board.setB_fsize(fileSize);
		board.setB_rfname(oriFile);
   }
   
   if(multi.getParameter("b_secret") == null){
      //공개글
      board.setB_secret("0");
   }else{
      //비공개글
      board.setB_secret("1");      
   }
   
   if(qdb.editBoard(board) == 1){
      response.sendRedirect("qnaShow.jsp?b_id="+ b_id +"&pageNum="+pageNum);
   }else if(qdb.editBoard(board) == 0){
%>
      <script>
			alert("비밀번호가 맞지 않습니다.");
			history.go(-1);
	  </script>
<%
   }
%>