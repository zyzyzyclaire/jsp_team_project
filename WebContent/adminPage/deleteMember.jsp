<%@page import="login.UserDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
		String user_id = null;
		if (session.getAttribute("user_id") != null) {
			user_id = (String) session.getAttribute("user_id");
		} else {
	%>
		<script>
			alert("잘못된 접근입니다.");
			location.href = "../main/main.jsp";
		</script>
	<%	}
		UserDBBean udb = new UserDBBean();
		boolean isAdmin = udb.isAdmin(user_id);
		
		if (!isAdmin) {
	%>
		<script>
			alert("잘못된 접근입니다.");
			location.href = "../main/main.jsp";
		</script>
	<%
		} else {
			String deleteID = request.getParameter("delete_uid");
        	if (udb.isAdmin(deleteID)) {
    	%>
        	<script>
			alert("관리자 계정은 탈퇴할 수 없습니다.");
			history.back();
			</script>
		<%
        } else if (udb.deleteUser(deleteID) == 1) {
        	%><script>
			alert("탈퇴 처리되었습니다.");
			/* location.href = "?pageChange=manageMember.jsp"; */
			location.href = "../adminPage/adminPage.jsp?pageChange=manageMember.jsp";
			
			
			</script><%
        } else if(udb.deleteUser(deleteID) == -1){
        	%><script>
			alert("탈퇴 처리 오류입니다.");
			history.back();
			</script><%
        }
	}
%>