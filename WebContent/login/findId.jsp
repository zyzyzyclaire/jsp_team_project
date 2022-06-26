<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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

</style>
</head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
    </script> <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js">
    </script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-5.1.3-dist/css/bootstrap-grid.min.css">
     <link rel="stylesheet" href="../fontstyle/fontello-4581031e/css/fontello.css">
    <link rel="stylesheet" href="../css/jquery.bxslider.css">
<body>
		<div style="border: 1px solid #DCDCDC;" class="logindiv">	 

		<div class="wrapper">
		 <table align="center" width="400">
		  <td colspan="3" class="border_bottom"><h2 align="center" style="color: black; font-size: 25px; font-weight: 500;">아이디 찾기</h2><br></td>
		  
		   <form class="form-horizontal" method="post" action="findIdOk.jsp">
		 
		     <div class="form-group">
		      <div class="col-sm-10">
		       <div class="col-xs-4">
		      	<tr>
		        	<td colspan="3" align="center">
		      		     <br><div style="color: black; font-size: 15px; font-weight: 500; font-family: Malgun Gothic,돋움;" >등록하신 이메일 주소를 입력해 주세요.</div><br><br>
		      			  <input type="text" name="email" class="form-control" id="inputPassword3" placeholder="E-mail을 입력하세요"
		      			  									style="font-size: 15px; font-weight: 500; font-family: Malgun Gothic,돋움;"><br><br>
		      		</td>
		      	</tr>
		      </div>
		    </div>
		  </div>
		  
		  <div class="form-group">
		   <div class="col-sm-offset-2 col-sm-10">
		    <div class="col-xs-4">
		     <tr>
		      	<td colspan="3">
		      	 	<button type="submit" class="btn btn-default btn-lg btn-block btn btn-outline-dark"
		      	 									style="font-size: 15px; font-weight: 500; font-family: Malgun Gothic,돋움;">확인</button><br><br>  
		      	</td>
		     </tr>
		    </div>
		   </div>
		  </div>
  
</form>
</table>
</div>
</div>
</body>
</html>