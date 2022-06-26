<%@page import="notice.NoticeBean"%>
<%@page import="notice.NoticeDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String pageNum = request.getParameter("pageNum");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	int num = Integer.parseInt(request.getParameter("n_num"));
	NoticeDBBean db = NoticeDBBean.getInstance();
	NoticeBean board = db.getBoard(num, true);
%>

<%
	String user_id = null;

	if(!((String)session.getAttribute("user_id") == null)){
		user_id =(String)session.getAttribute("user_id");
	}
	
	String pagecheck = request.getParameter("pagecheck");
	
	String select = request.getParameter("pageChange");
	boolean isAdPage = true;
	if (select == null) {
		isAdPage = false;
	}
%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
    </script> <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js">
    </script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-5.1.3-dist/css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="../fontstyle/fontello-4581031e/css/fontello.css">
    <link rel="stylesheet" href="../css/jquery.bxslider.css">

<!-- <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet"> -->


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
<script type="text/javascript">
	function delete_OK() {
	if(confirm("정말 글을 삭제하시겠습니까?") == true){
		location.href = "../customer_service/notice_delete_ok.jsp?n_num=<%= board.getN_num()%>&pageNum=<%= pageNum %>&pagecheck=<%=pagecheck%>";
	}
}
</script>
</head>
<body>
<% if(!isAdPage){ %>
<jsp:include page="../main/mainHeader.jsp"></jsp:include>
<% } %>

<!-- Breadcrumb 시작 -->
<center style="font-size: 11px;">
	<nav style= "--bs-breadcrumb-divider: '>'; min-width: 1100px; max-width: 1280px;" aria-label="breadcrumb">
		<ul class="breadcrumb" style= "float: right;">
			<li class="breadcrumb-item"><a href="../main/main.jsp">Home</a></li>
			<li class="breadcrumb-item"><a href="../customer_service/notice_list.jsp">Notice</a></li>
			<li class="breadcrumb-item active" aria-current="page">VIEW</li>
		</ul>
	</nav>
</center>
	<br>
	<center>
		<div class="table-responsive">
				<% if(!isAdPage){ %>
				<div style="min-width: 1100px; max-width: 1280px; padding-right: 700px; text-align: left;">
					<p>
						<h1 style="font-size: 16px; line-height: 17px; padding-bottom: 10px;">NOTICE</h1>
						<h1 style="font-size: 12px; color: #939393;">구매 전에 꼭 읽어 주세요~</h1>
					</p>
				</div>	
				<% } %>
			<table class="table" style="min-width: 1100px; max-width: 1280px;">
				<tr>
					<td style="width: 120px; font-size: 11px;">SUBJECT</td><td style="font-size: 12px;"><%= board.getN_title() %></td>
				</tr>
				<tr>
					<td style="width: 120px; font-size: 11px;">NAME</td>
					<td style="font-size: 12px;">
					<%  if(user_id!=null) {  //관리자 아이디로 접속할 때만 글쓰기 버튼 노출
							if(user_id.equals("admin")){	
					%>
							<%= user_id %>	<!-- 세션을 통해 id받아와 입력  -->
					<% }else {%>
							admin
					<% }} else { %>
							admin
					<% } %>
				</td>
				</tr>
				<tr>
					<td colspan="2" height="400px" style="font-size: 12px;"><%= board.getN_content() %></td>
				</tr>
			</table>
			<div style="min-width: 1100px; max-width: 1280px;">
				<% if(!isAdPage){ %>
					<button style="float: left; font-size: 11px;" class="btn btn-outline-dark" onclick="location.href='notice_list.jsp?pageNum=<%= pageNum %>'">목록</button>
				<% } else { %>
					<button style="float: left; font-size: 11px;" class="btn btn-outline-dark" onclick="location.href='?pageChange=../customer_service/notice_list.jsp?pageNum=<%= pageNum %>'">목록</button>
				<% } %>
					<%  if(user_id!=null) {  //관리자 아이디로 접속할 때만 글수정,삭제 버튼 노출
							if(user_id.equals("admin")){
					%>
						<button style="float: right; font-size: 11px;" class="btn btn-outline-dark" id="editbtn" onclick="location.href='../customer_service/notice_edit.jsp?n_num=<%= board.getN_num() %>&pageNum=<%= pageNum %>&pagecheck=<%=pagecheck%>'">수정</button>
						<button style="float: right; font-size: 11px;" class="btn btn-outline-dark" id="delbtn" onclick="delete_OK()">삭제</button>
					<%
							}
						} 
					%>
			</div>
			<!-- <br><br><br><br>
			<table class="table" style="min-width: 1100px; max-width: 1280px;">
				<tr>
					<td style="width: 120px; font-size: 11px;"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-up" viewBox="0 0 16 16">
												<path fill-rule="evenodd" d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"/>
												</svg>
												PREV</td><td style="font-size: 11px;"><a href="#">?????</a></td>
				</tr>
				<tr>
					<td style="width: 120px; font-size: 11px;"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-down" viewBox="0 0 16 16">
												<path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
												</svg>
												NEXT</td><td style="font-size: 11px;"><a href="#">?????</a></td>
				</tr>
			</table> -->
		</div>	
	</center>
	<% if(!isAdPage){ %>
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>
	<% } %>
</body>
</html>
