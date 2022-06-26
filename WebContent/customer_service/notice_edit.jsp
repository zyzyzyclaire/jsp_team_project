<%@page import="notice.NoticeBean"%>
<%@page import="notice.NoticeDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pageNum = request.getParameter("pageNum");
	
	String user_id = (String)session.getAttribute("user_id");
	if(session.getAttribute("user_id") == null){
		response.sendRedirect("../login/login.jsp");
	}

	int n_num = Integer.parseInt(request.getParameter("n_num"));
	NoticeDBBean db = NoticeDBBean.getInstance();
	NoticeBean board = db.getBoard(n_num, false);
	
	String pagecheck =   request.getParameter("pagecheck"); 
	
	String select = request.getParameter("pageChange");
	boolean isAdPage = true;
	if (select == null) {
		isAdPage = false;
	}
%>
<% if(!isAdPage){ %>
<jsp:include page="../main/mainHeader.jsp"></jsp:include>
<% } %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="notice.js" type="text/javascript"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
    </script> <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js">
    </script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-5.1.3-dist/css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="../fontstyle/fontello-4581031e/css/fontello.css">
    <link rel="stylesheet" href="../css/jquery.bxslider.css">
<!-- 서머노트를 위해 추가해야할 부분 시작 -->
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
  <script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
<!-- 서머노트를 위해 추가해야할 부분 끝 -->
	<script src="../customer_service/notice.js" type="text/javascript"></script>
<style type="text/css">
	body{
		font-family: "Nanum Gothic","Malgun Gothic","맑은 고딕","돋움","Dotum","Apple Gothic","Apple SD Gothic Neo",sans-serif;
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
<center style="font-size: 11px;">
<div style="width: 1280px;">
	<nav aria-label="breadcrumb" style="float: right;">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="../main/main.jsp">Home</a></li>
			<li class="breadcrumb-item">Board</li>
			<li class="breadcrumb-item active" aria-current="page">NOTICE</li>
		</ol>
	</nav>
</div>
</center>
<!-- Breadcrumb 끝 -->

	<br>
	<center>
		<div class="table-responsive">
			<div style="width:1280px; padding-right: 700px; text-align: left;">
					<p>
						<h1 style="font-size: 16px; line-height: 17px; padding-bottom: 10px;">NOTICE</h1>
						
					</p>
				</div>
		<form name="reg_frm" method="post" action="../customer_service/notice_edit_ok.jsp?n_num=<%= n_num %>&pageNum=<%= pageNum %>&pagecheck=<%=pagecheck%>">
			<table class="table" style="width: 1280px; font-size: 12px;">
			 	<tr>
					<td style="width: 120px;">NAME</td>
					<td>
						<input type="text" name="user_id" size="10" maxlength="20" value="<%= user_id %>" class="form-control form-control-sm" style="width: 200px;">
					</td>
				</tr> 
				<tr>
					<td style="width: 120px;">SUBJECT</td>
					<td>
						<input type="text" name="n_title" size="55" maxlength="80" value="<%= board.getN_title() %>" class="form-control form-control-sm">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea rows="10" cols="65" name="n_content" class="summernote" style="height: 500px; width: 100%;">
							<%= board.getN_content() %>
						</textarea>
					</td>
				</tr>
				<tr>
					<td style="width: 120px;">PASSWARD</td>
					<td>
						<input type="password" name="n_pwd" size="12" maxlength="12" class="form-control form-control-sm" style="width: 200px; font-size: 12px;">
					</td>
				</tr>
			</table>
			<div style="width: 1280px;">
						<% if(!isAdPage){ %>
							<input style="float: left; font-size: 12px;" class="btn btn-outline-dark" type="button" value="글목록" onclick="location.href='notice_list.jsp?pageNum=<%= pageNum %>'">
						<% } else { %>
							<input style="float: left; font-size: 12px;" class="btn btn-outline-dark" type="button" value="글목록" onclick="location.href='?pageChange=../customer_service/notice_list.jsp?pageNum=<%= pageNum %>'">
						<% } %>
						<input style="float: right; font-size: 12px;" class="btn btn-outline-dark" onclick="check_ok()" value="글수정" type="button">
						<input style="float: right; font-size: 12px;" class="btn btn-outline-dark" type="reset" value="다시작성">
			</div>
			<br><br><br><br>
		</form>
		</div>
	</center>
<% if(!isAdPage){ %>
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>
<% } %>
	<script>
$('.summernote').summernote({
	  height: 500,
	  lang: "ko-KR"
	});
</script>

</body>
</html>