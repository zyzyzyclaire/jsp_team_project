<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
    </script> <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js">
    </script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-5.1.3-dist/css/bootstrap-grid.min.css">
    
    
    <link rel="stylesheet" href="../fontstyle/fontello-4581031e/css/fontello.css">
    <link rel="stylesheet" href="../css/jquery.bxslider.css">
    
    <style>
.wrapper{
padding: auto;
margin: 100px 0px; 
margin-left: auto; 
margin-right: auto;
}
.logindiv{
	    width: 480px;
	    margin: 250px auto;
	    height: 440px;
		border-radius: 20px;
	}

.wrapper{
		margin: 70px auto;
		max-width : 400px;	
	 	min-width : 400px;	
	 	
	} 
	button.btn {
		background: black;
		color: white;
	}
	
	button.btn:hover{
		background: white;
		color: black;
		border-color: gray;
	}
	.pwdview{
		background-color: #F5F5F5; 
		line-height: 50px;
		color: black; 
		font-size: 15px; 
		font-weight: 500; 
		font-family: Malgun Gothic,돋움;
		border-radius: 20px;
	}
</style>
<body>
 <%-- <jsp:include page="../main/mainHeader.jsp" flush="false"/> --%>
		<div style="border: 1px solid #DCDCDC;" class="logindiv">
<div class="wrapper">
  <table align="center" width="400">
  	<td colspan="3" class="border_bottom"><h2 align="center" style="color: black; font-size: 25px; font-weight: 500; font-family: Malgun Gothic,돋움;">
  																	비밀번호 찾기</h2><br><br></td>
	<%
		String id = request.getParameter("id");
		String email = request.getParameter("email");
			
		UserDBBean db = UserDBBean.getInstance();
		String pwd = db.tryToFinPwd(id, email);
		
		if(pwd==null) {
	%>
		<script>
		alert("존재하지 않는 회원");
		history.go(-1);
		</script>
	<%
		} else {	// 이메일이 존재할 시 - 0416 근지
	%>
	<tr>
      <td colspan="3" align="center">
			<div class="pwdview" style="color: black; font-size: 15px; font-weight: 500; font-family: Malgun Gothic,돋움;" >고객님의 비밀번호는 <%= pwd %> 입니다.</div><br><br><br>
      </td>
    </tr>
	
<div class="form-group">
 <div class="col-sm-offset-2 col-sm-10">
  <div class="col-xs-4">	
    <tr>
      <td colspan="3">
		<button class="btn btn-default btn-lg btn-block btn btn-outline-dark" 
						                            onclick="location='login.jsp'" style="font-size: 15px; font-weight: 500; font-family: Malgun Gothic,돋움;">
						                            로그인 하기</button><br><br>
	<%
		}
	%>
	  </td>  
	</tr>
   </div>
  </div>
 </div>
 
</table>
</div>  
</body>

</html>