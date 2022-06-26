<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%
	// user_id가 한글일 때 정상적으로 로그인 될 수 있도록 login.jsp, loginOk.jsp 캐릭터 전부 UTF-8로 맞춤 - 0416 근지
	// 영문으로만 작성 원하면 나중에 삭제 요망 - 0416 근지
	request.setCharacterEncoding("UTF-8");
%>
<%
	String id = request.getParameter("id");
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
    <!-- <link rel="stylesheet" href="../css/bootstrap.min.css"> -->
    
	<!-- 합쳐지고 최소화된 최신 CSS -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->
<style>
	/* a{  color: black; 
	   text-decoration: none;
	 } */ 
	 
	a.a_style{
		color: black;
		text-decoration: none;
		font-size: 15px; 
		font: 500; 
		font-family: Malgun Gothic,돋움;
	}
	a.a_style:hover{
		color: gray;
	}
	
	/* .wrapper{
	padding: auto;
	margin: 100px 0px;  
	margin-left: auto; 
	margin-right: auto;  
	}  
	 */
	.btn{
		color: white;
	}
	
	h3{
		color: black;
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
	
	/* table {
		padding: 5px;
	} */
	
	/* div.outbox {
		box-sizing: border-box;
		width:500px;
		height: 430px;  
		margin: 20pxs auto;
		background-color: orange;  
		 border-radius: 20px 20px; 
		border: solid 1px;	
	} */
	
	/* .logindiv>.outbox{
		height: 800px;
	} */
	.logindiv{
	    width: 480px;
	    margin: 50px auto;
	    height: 440px;
		border-radius: 20px;
		padding: auto;
	}
	
	#hearder_title{
   /*  border: 1px solid black;   */
 	line-height: 84px;
 	margin: auto;
 	font-size: 50px;
 	
 		
 	max-width : 1280px;	
 	min-width : 1120px;	
 }
.header_title a{
	text-decoration: none;
	color: black;
}
</style>
<!-- <script src="../js/jquery.js"></script>
<script type="text/javascript">

	$(window).resize(function() {  
		
	    var a  =   $(".logindiv").();
	        console.log(a);
	   
	});
</script> -->
</head>
<body>
<%-- <jsp:include page="../main/mainHeader.jsp" flush="false"/> --%>
         
 <div style="margin-top: 150px;">    
		<div class="header_title" style="overflow: hidden; align="center"> 
             <a href="./../main/main.jsp" style="font-size: 50px;" ><div align="center">elpmis<div></a>
         </div>
	
	<div style="border: 1px solid #DCDCDC;" class="logindiv">
		
		 <table align="center" width="400">
		  <td colspan="4" class="border_bottom"><h3 align="center" style="font-size: 25px; font-weight: 500;">MEMBER LOGIN<br><br></h3></td>
		    <form class="form-horizontal" method="post" action="loginOk.jsp">
			      <div class="form-group">
			       	<div class="col-sm-10">
						<div class="col-xs-4">	
						  <tr>	
				    <%
								if(id != null) {	// 아이디 찾기를 통해 아이디를 찾은 후 로그인 한 경우 - 0416 근지
					%>
								
							
					        <td>
					        	<br><input type="text" name="user_id" value="<%= id %> " class="form-control" id="inputEmail3"><br>
					      	</td>
					<%				
								} else {	// 일반 로그인 경우 - 0416 근지
					%>			
							
					        <td colspan="3">
					      	  <br><input value="admin" type="text" name="user_id" class="form-control " id="inputEmail3" placeholder="아이디를 입력하세요"
					      	  				style=" font-size: 15px; font: 500; font-family: Malgun Gothic,돋움; "><br>
					        </td>
					        
					<%
								}
					%>
						  </tr>
					    </div>
			       	</div>
			      </div>
		  
					<div class="form-group">
					 <div class="col-sm-10">
					  <div class="col-xs-4">
					  	<tr>
					      <td colspan="3">
					    	<input type="password" value="1234" name="user_pwd" class="form-control" id="inputPassword3" placeholder="비밀번호를 입력하세요"
					    				style="font-size: 15px; font: 500; font-family: Malgun Gothic,돋움;"><br>
					      </td>
					    </tr>
					   </div>
					  </div>
					</div>
		  
			<div class="form-group">
			 <div class="col-sm-offset-2 col-sm-10">
			  <div class="col-xs-4">
			    <tr>
				    <td colspan="3" class="border_bottom2">
						 <!-- <input type="submit" value="로그인"> -->
				    	<button type="submit" class="btn btn-default btn-lg btn-block" style="font-size: 15px; font: 500; font-family: Malgun Gothic,돋움;">
				    	 																			로그인</button><br><br>
				    </td>
			    </tr>
			  </div>
			 </div>
			</div>
		  
		</form>
		<!-- 전달할 값이 없기 때문에 form 밖에 작성 - 0416 근지 -->
				<!-- <tr>
					 <td>
						<input type="button" value="아이디 찾기" onclick="location='findId.jsp'">
					</td> 
					 <td>
						<input type="button" value="비밀번호  찾기" onclick="location='findPwd.jsp'">
					</td> 
				</tr> -->
				<tr>
					<td align="center">
						<a href="findId.jsp" class="a_style">아이디 찾기</a>
						<a href="findPwd.jsp" class="a_style">| 비밀번호 찾기</a>
						<a href="regiagree.jsp" class="a_style">| 회원가입</a>
					</td>
				</tr>
			</table>
			 
		 <br><br><br><br>
	</div>

</div>
	<%-- <jsp:include page="../main/mainfooter.jsp" flush="false"/> --%>
</body>
</html>