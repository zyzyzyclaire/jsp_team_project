<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%
	// user_id가 한글일 때 정상적으로 로그인 될 수 있도록 login.jsp, loginOk.jsp 캐릭터 전부 UTF-8로 맞춤 - 0416 근지
	// 영문으로만 작성 원하면 나중에 삭제 요망 - 0416 근지
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String user_id = request.getParameter("user_id");
		String user_pwd = request.getParameter("user_pwd");
			
		UserDBBean db = UserDBBean.getInstance();
		int check = db.userCheck(user_id, user_pwd);
		String pwd = db.bannedUser(user_id);
		UserBean user = db.getUser(user_id);
		
		if(user==null) {
	%>
			<script>
			alert("존재하지 않는 회원");
			history.go(-1);
			</script>
	<%		
		} else {	// 회원이 존재할 시 - 0415 근지
			String user_name = user.getUser_name();
			if(check==1) {
				session.setAttribute("user_id", user_id);
				session.setAttribute("user_name", user_name);
				session.setAttribute("user", "yes");	// url로 접속할 수 없도록 - 0415 근지
				response.sendRedirect("../main/main.jsp");
			} else if(check==0) {
				if(pwd.equals("-1")){ //탈퇴한 회원 팝업창 처리 -0426 진용
	%>			
				<script>
				alert("탈퇴처리된 회원입니다.");
				history.go(-1);
				</script>
	<% 
				}
	%>				
				<script>
				alert("비밀번호가 맞지 않습니다.");
				history.go(-1);
				</script>
	<%					
			} else {	// 거의 없는 경우 - 0415 근지
	%>
				<script>
				alert("아이디가 맞지 않습니다.");
				history.go(-1);
				</script>
	<%					
			}
		}
	%>
</body>
</html>