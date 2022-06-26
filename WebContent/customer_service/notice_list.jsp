<%@page import="notice.NoticeBean"%>
<%@page import="notice.NoticeDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%
	String user_id = null;
	String pageNum = null;
	if(((String)session.getAttribute("user_id"))!=null){
		user_id =(String)session.getAttribute("user_id");
		System.out.print(user_id);
	}
	
	String pagecheck = request.getParameter("pagecheck");
	
	pageNum = request.getParameter("pageNum");
	
	
	if(pageNum == null){
		pageNum = "1";
	}
	NoticeDBBean db = NoticeDBBean.getInstance();
	
	ArrayList<NoticeBean> boardList = db.listBoard(pageNum);
	int n_num, n_hit;
	String n_title, n_content;
	Timestamp n_date;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
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
	<a href="qnaList.jsp">Q</a>
<style type="text/css">
	div{
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
<% if(!isAdPage){ %>
<jsp:include page="../main/mainHeader.jsp"></jsp:include>
<% } %>


<!-- Breadcrumb 시작 -->
<center style="font-size: 11px;">
<div style="min-width: 1100px; max-width: 1280px;">
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
	<div class="table-responsive" >
		<div style="min-width: 1100px; max-width: 1280px; padding-right: 700px; text-align: left;">
		<p>
		<h1 style="font-size: 16px; line-height: 17px; padding-bottom: 10px;">NOTICE</h1>
		<h1 style="font-size: 12px; color: #939393;">구매 전에 꼭 읽어 주세요~</h1>
		</p>
		</div>	
	</center>
	<center>
		<table class="table" style="min-width: 1100px; max-width: 1280px; font-size: 12px;">
    <tr style="font-size: 10px;">
      <th scope="col" style="width: 70px;">NO.</th>
      <th scope="col" style="text-align: center; width: 600px;">SUBJECT</th>
      <th scope="col" style="text-align: right;">NAME</th>
      <th scope="col" style="text-align: center;">DATE</th>
      <th scope="col" style="text-align: right;">VIEWS</th>
    </tr>
  			<%
			if(boardList.size()==0) {
			%>
			
 		<tr align="center" bgcolor="#FFFFFF" height="30">
 	   		<td colspan="5">등록된 글이 없습니다.</td>
 	  	</tr>
			<% } else {
				for(int i=0; i<boardList.size(); i++){
						NoticeBean board = boardList.get(i);
						
						n_num = board.getN_num();
						n_title = board.getN_title();
						n_content = board.getN_content();
						n_date = board.getN_date();
						n_hit = board.getN_hit();
			%>
    	<tr>
	      <td scope="row"><%= n_num %></td>
	      <td>
	      	<% if(!isAdPage){ %>
	      	<a href="notice_show.jsp?n_num=<%= n_num %>&pageNum=<%= pageNum %>"><%= n_title %></a>
	      	<% } else { %>
	      	<a href="?pageChange=../customer_service/notice_show.jsp?n_num=<%= n_num %>&pageNum=<%= pageNum %>&pagecheck=<%=pagecheck%>"><%= n_title %></a>
	      	<% } %>
	      </td>
	      <td style="text-align: right;">
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
	      <td style="text-align: center;"><%= sdf.format(n_date) %></td>
	      <td style="text-align: right;"><%= n_hit %></td>
	      <%
						}
					}
				%>
   		 </tr>
</table>
	<%  if(user_id!=null && !isAdPage) {  //관리자 아이디로 접속할 때만 글쓰기 버튼 노출
	if(user_id.equals("admin")){	
	%>
	<table style="width: 1280px";>
		<tr>
			<td align="right">
				<input type="button" class="btn btn-outline-dark" value="글쓰기" onclick="location.href='notice_write.jsp?pageNum=<%= pageNum %>&pagecheck=notice_list'" style="font-size: 11px;"></input>
			</td>
		</tr>
	</table>
	<% }} %>
		<div >
		<nav id="paging" style="font-size: 10px;"> 
			<ul class="pagination justify-content-center"> 
				<li class="page-item"><a class="page-link" href="#">이전</a></li> 
				<li class="page-item"><a class="page-link" href="notice_list.jsp?pageNum=1">1</a></li> 
				<li class="page-item"><a class="page-link" href="notice_list.jsp?pageNum=2">2</a></li> 
				<li class="page-item"><a class="page-link" href="notice_list.jsp?pageNum=3">3</a></li> 
				<li class="page-item"><a class="page-link" href="#">다음</a></li> 
			</ul> 
		</nav>
	</div>
</div>

<% NoticeBean.pageNumber(3); %>
	</center>

<!-- 검색창 시작 -->
<!-- <br><br>
<center>
<div style="min-width: 1100px; max-width: 1280px;">
<table style="float: left;">
	<tr>
		<td width="100px;">
			<select class="form-select" aria-label="Default select example" style="font-size: 11px;">
			  <option selected>일주일</option>
			  <option value="1">한달</option>
			  <option value="2">세달</option>
			  <option value="3">전체</option>
			</select>
		</td>
		<td width="100px;">
			<select class="form-select" aria-label="Default select example" style="font-size: 11px;">
			  <option selected>제목</option>
			  <option value="1">내용</option>
			  <option value="2">글쓴이</option>
			  <option value="3">아이디</option>
			  <option value="3">별명</option>
			</select>
		</td>
		<td>
			<input type="search" class="form-control" style="font-size: 11px;">
		</td>
		<td>
			<button type="button" class="btn btn-outline-secondary" style="font-size: 11px;">검색</button>
		</td>
	</tr>
</table>
</div>
</center> -->
<!-- 검색창 끝 -->



<br><br><br><br><br><br><br><br>
<!-- <hr class="mx-0 px-0">
<div class="container">
  <footer class="row row-cols-0 py-0 my-0">

    <div class="col">
      <h5>Team3</h5>
      <ul class="nav flex-column">
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">TEL. 000-000</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">OPEN : 09:00 ~ 18:00</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">LUNCH : 12:00 ~ 13:00</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">토요일, 일요일 OFF</a></li>
      </ul>
    </div>

    <div class="col">
      
      <ul class="nav flex-column">
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">customer service<br>Tel 010-0000-0000</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">customer service<br>Tel 010-0000-0000</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">customer service<br>Tel 010-0000-0000</a></li>
      </ul>
    </div>

    <div class="col">
      <h5>&nbsp;</h5>
      <ul class="nav flex-column">
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">국민은행 000002-01-000000</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">예금주 : 그린컴</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">주소 : 부산 중구 새마을로 146 3-4층</a></li>
      </ul>
    </div>
  </footer> -->
</div>
<% if(!isAdPage){ %>
<jsp:include page="../main/mainfooter.jsp"></jsp:include>
<% } %>
</body>
</html>

