<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// DB에 한글로 저장시키기 위해 registerOK.jsp 와 register.jsp 파일 캐릭터 타입 UTF-8f로 캐릭터값 맞추고
	// request.setCharacterEncoding("UFT-8");로 설정	- 0415 근지
	request.setCharacterEncoding("UTF-8");

%>
<jsp:useBean id="user" class="login.UserBean"/>
<jsp:setProperty property="*" name="user"/>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		UserDBBean db = UserDBBean.getInstance();
	%>
	<%
		if(db.confirmUserId(user.getUser_id())==1) {
	%>		
			<script type="text/javascript">
			alert("중복되는 아이디가 존재합니다.");
			history.back();
			</script>
	<%
		} else {
			int re = db.insertUser(user);
			if(re==1) {
	%>
				<script>
				alert("회원가입을 축하드립니다.\n 회원으로 로그인 해주세요.");
				document.location.href="login.jsp";
				</script>
	<%				
			} else {
	%>
				<script>
				alert("회원가입에 실패했습니다.");
				document.location.href="login.jsp";
				</script>
	<%	
			}
		}
	%>
</body>
</html>