<%@page import="notice.NoticeDBBean"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String pageNum = request.getParameter("pageNum");
	int n_num = 0;
	String b_title="";
	
	String user_id = (String)session.getAttribute("user_id");
	if(session.getAttribute("user_id") == null){
		response.sendRedirect("../login/login.jsp");
	}
	
	if(request.getParameter("n_num") != null){
		n_num = Integer.parseInt(request.getParameter("n_num"));
	}

	String select = request.getParameter("pageChange");
	boolean isAdPage = true;
	if (select == null) {
		isAdPage = false;
	}
%>
<jsp:useBean id="board" class="notice.NoticeBean"></jsp:useBean>
<jsp:setProperty property="*" name="board"/>
<%
	InetAddress address = InetAddress.getLocalHost();
	String ip = address.getHostAddress();
	
	//board.setB_ip(request.getRemoteAddr());
	board.setN_ip(ip);
	board.setN_date(new Timestamp(System.currentTimeMillis()));

	board.setN_title(request.getParameter("n_title"));
	board.setN_content(request.getParameter("n_content"));
	board.setN_pwd(request.getParameter("n_pwd"));
	board.setUser_id(request.getParameter("user_id"));
	
	NoticeDBBean db = NoticeDBBean.getInstance();
	//db.insertBoard(board);
	String pagecheck =   request.getParameter("pagecheck"); 
	
	
	int re = db.insertBoard(board);
	if(re == 1){
		if(pagecheck.equals("adminpage")){
			%>
			<script>
			location.href="../adminPage/adminPage.jsp?pageChange=../customer_service/notice_list.jsp";
			</script>
			<%
		}else if(pagecheck.equals("notice_list")){
			%>
			<script>
			location.href="notice_list.jsp";
			</script>
			<%
		}
	}else{
			%>
			<script>
			location.href="notice_write.jsp";
			</script>
			<%
	}
%>