<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	// 일반적으로는 id값으로 getUser() 메서드를 통해 정보를 얻은 후 이를 통해 값을 반환하지만,
	// findId는 이메일을 통해 id를 찾기 때문에 getUser() 메서드를 사용하지 않고 trytoFindId() 메서드에서 바로 id값을 가져다 줌 - 0416 근지

	// user_id가 한글일 때 정상적으로 로그인 페이지로 갈 수 있도록  캐릭터 전부 UTF-8로 맞춤 - 0416 근지
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
/* .border_bottom{border-bottom: solid 1px;} */
.logindiv{
	    width: 480px;
	    margin: 250px auto;
	    height: 440px;
		border-radius: 20px;
	}
.wrapper{
	/* padding: auto;
	margin: 100px 0px;  
	margin-left: 39%; 
	margin-right: auto;  */
		margin: 37px auto;
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
	.idview{
		background-color: #F5F5F5; 
		line-height: 50px;
		color: black; 
		font-size: 15px; 
		font-weight: 500; 
		font-family: Malgun Gothic,돋움;
		border-radius: 20px;
	}
</style>
</head>
<body>
		<div style="border: 1px solid #DCDCDC;" class="logindiv">	
	
<div class="wrapper">
 <table align="center" width="400">
  <td colspan="3" class="border_bottom"><h2 align="center" style="color: black; font-size: 25px; font-weight: 500; font-family: Malgun Gothic,돋움;">
  														아이디 찾기</h2><br></td>
	<%
		String email = request.getParameter("email");
			
		UserDBBean db = UserDBBean.getInstance();
		String user_id = db.tryToFindId(email);
		
		if(user_id==null) {
	%>
		<script>
		alert("존재하지 않는 이메일");
		history.go(-1);
		</script>
	<%
		} else {	// 이메일이 존재할 시 - 0416 근지
	%>
	
	<tr>
      <td colspan="3" align="center">
			<br><div class="idview" align="center" style="font-size: 15px; font-weight: 500; font-family: Malgun Gothic,돋움;">
																	고객님의 아이디는 <%= user_id %> 입니다.</div><br><br><br>
      </td>
	</tr>
	
	<%-- 이메일이 존재할 시 쿼리스트링으로 확인한 아이디를 갖고 로그인 페이지로 돌아감 - 0416 근지 --%>	
	<div class="form-group">
     <div class="col-sm-offset-2 col-sm-10">
      <div class="col-xs-4">	
    	<tr>
    	   <td colspan="3">
			  <form method="post" action="login.jsp?id=<%=user_id%>">
		        <!-- <input type="submit" value="로그인 페이지로 돌아가기"> -->
		        <button type="submit" class="btn btn-default btn-lg btn-block btn btn-outline-dark"
		        				style="font-size: 15px; font-weight: 500; font-family: Malgun Gothic,돋움;">
		        													로그인 페이지로 돌아가기</button><br>
	<%
		}
	%>
			</td>  
		</tr>
		
      </div>
    </div>
  </div>
  
</form>
		<tr>
			<td>
		<button onclick="location='findPwd.jsp'" class="btn btn-default btn-lg btn-block btn btn-outline-dark"
									style="font-size: 15px; font-weight: 500; font-family: Malgun Gothic,돋움;">비밀번호 찾기</button><br><br>
			</td>
		</tr> 
</table>
</div> 
</div>
</body>
</html>