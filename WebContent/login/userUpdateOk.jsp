<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// DB에 한글로 저장시키기 위해 userUpdateOK.jsp 와 userUpdate.jsp 파일 캐릭터 타입 UTF-8로 캐릭터값 맞추고
	// request.setCharacterEncoding("UFT-8");로 설정	- 0415 근지
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="login.UserBean"></jsp:useBean>
<jsp:setProperty property="*" name="user"/>
<%	
	String user_id = (String)session.getAttribute("user_id");
	user.setUser_id(user_id);	// user_id는 세팅 안되어있으니까 -  0415 근지
	UserDBBean db = UserDBBean.getInstance();
	int re = db.updateUser(user);
%>
<%
	if(re==1) {
%>
		<script>
			alert("입력하신대로 회원 정보가 수정되었습니다.");
			document.location.href="../userPage/userPage.jsp";	// sendRedirect써도 됨 -  0415 근지
		</script>
<%
	} else {
%>
		<script>
			alert("수정이 실패되었습니다.");
			history.go(-1);
		</script>
<%
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>