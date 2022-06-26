<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String user_id = null;
    if (session.getAttribute("user_id") != null) {
    	user_id = (String) session.getAttribute("user_id");
    }
%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
<script src="notice.js" type="text/javascript"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
    </script> <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js">
    </script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-5.1.3-dist/css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="../fontstyle/fontello-4581031e/css/fontello.css">
    <link rel="stylesheet" href="../css/jquery.bxslider.css">
<style type="text/css">
	/* body{font-size: small;} */
	#scroll{
		position: sticky;
		top: 0;
		background-color: white;
		background-color: rgba( 255, 255, 255, 0.5 );
	}
	#lastnav{
		padding-right: 50px;
	}
	.breadcrumb {
		 background: white; 
	}
	a:link { color:black; }
	a:visited { color:black; }
	a:hover { color:mute;}
	a:active { color:black; }
</style>
</head>
<body>
<!-- Breadcrumb 시작 -->
<center>
<div style="width: 1100px;">
	<nav aria-label="breadcrumb" style="float: right;">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="../main/main.jsp">Home</a></li>
			<li class="breadcrumb-item"><a href="../adminPage/adminPage.jsp">Admin page</a></li>
			<li class="breadcrumb-item active" aria-current="page">Manager Management</li>
		</ol>
	</nav>
</div>
</center>
<!-- Breadcrumb 끝 -->

<br><br><br>
	<center>
		<div class="table-responsive" >
		<div style="width:900px; padding-right: 700px; text-align: left;">
		<p>
		<h2>Members&nbsp;Management</h2>
		진상 바로 손절치기
		</p>
		</div>	
	
	<%
		UserDBBean udb = null;
		boolean isAdmin = false;
		if (user_id == null) {
	%>
		<script>
			alert("잘못된 접근입니다.");
			location.href = "../main/main.jsp";
		</script>
	<%	
		} else {
			udb = new UserDBBean();
			isAdmin = udb.isAdmin(user_id);
		}
	
		if (!isAdmin) {
	%>
		<script>
			alert("잘못된 접근입니다.");
			location.href = "../main/main.jsp";
		</script>
	<%
		} else {
	%>
<script>
function delete_check_admin(u_id) {
	if(confirm("정말 탈퇴 처리하시겠습니까?") == true) {
		location.href = "deleteMember.jsp?delete_uid=" + u_id;
	} else {
		location.reload();
	}
}
</script>
</center>
	<center style="font-size: 11px;">
		<table class="table" style="width: 900px;">
			<tr>
				<th>User ID</th>
				<th>NAME</th>
				<th>CONTACT</th>
				<th>E-MAIL</th>
				<th>ADDRESS</th>
				<th style="text-align: center;">ORDER</th>
				<th style="text-align: center;">BANISHMENT</th>
			</tr>
		<tbody>
			<%	
				ArrayList<UserBean> uList = udb.listUsers();
				for (UserBean user : uList) {
					String u_id = user.getUser_id();
					if (udb.isAdmin(u_id)) {
			%>
				<tr style="font-size: small; background-color: aqua;">
			<%				
					} else if (udb.defineUserId(u_id).getUser_grade().equals("D")) {
			%>
				<tr style="font-size: small; background-color: grey;">
			<%			
					} else {
			%>
				<tr style="font-size: small;">
			<%
					}
			%>
					<td><%= u_id %></td>
					<td><%= user.getUser_name() %></td>
					<td><%= user.getUser_email() %></td>
					<td><%= user.getUser_phone() %></td>
					<td><%= user.getUser_addr() %></td>
					<td style="text-align: center;"><%= user.getUserPurchase() %></td>
					<td style="text-align: center;"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-x-fill" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm6.146-2.854a.5.5 0 0 1 .708 0L14 6.293l1.146-1.147a.5.5 0 0 1 .708.708L14.707 7l1.147 1.146a.5.5 0 0 1-.708.708L14 7.707l-1.146 1.147a.5.5 0 0 1-.708-.708L13.293 7l-1.147-1.146a.5.5 0 0 1 0-.708z"/>
</svg>
					&nbsp;&nbsp;<input type="button" onClick="delete_check_admin('<%= user.getUser_id() %>')" value="탈퇴" class="btn btn-outline-dark btn-sm"></td>
				</tr>	
			<%					
				}
		}
			%>
			</tbody>
		</table>
	</div>
		</center>
		<!-- 검색창 시작 -->
<br><br>
<center>
<div style="width: 1100px; padding-left: 100px;">
<table style="float: left;">
	<tr>
		<td width="100px;">
			<select class="form-select" aria-label="Default select example">
			  <option selected>아이디</option>
			  <option value="1">이름</option>
			  <option value="2">연락처</option>
			  <option value="3">이메일</option>
			  <option value="3">주소</option>
			</select>
		</td>
		<td>
			<input type="search" class="form-control">
		</td>
		<td>
			<button type="button" class="btn btn-outline-secondary">검색</button>
		</td>
	</tr>
</table>
</div>
</center>
<!-- 검색창 끝 -->
<br><br><br><br><br><br><br><br>
	
<%-- 	<jsp:include page="../main/mainfooter.jsp"></jsp:include>
 --%></body>
</html>