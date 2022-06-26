<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%	
	
	String user_id = null,user_pwd=null;
	user_id = (String)session.getAttribute("user_id");
	user_pwd =request.getParameter("user_pwd");
	
	
	UserDBBean db = UserDBBean.getInstance();
	
	int re = db.outUser(user_id,user_pwd);

%>
<%
	if(re==1) {
%>
		<script>
			alert("회원 탈퇴퇴었습니다.");
			document.location.href="../login/logOut.jsp";	// sendRedirect써도 됨 - 0415 근지
		</script>
<%
	} else if(re==0){
%>
		<script>
			alert("비밀번호가틀렸습니다.");
			history.go(-1);
		</script>
<%
	}else{
%>
		<script>
			alert("탈퇴 실패되었습니다.");
			history.go(-1);
		</script>
<%
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>