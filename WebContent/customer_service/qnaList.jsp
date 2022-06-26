<%@page import="notice.QnABean"%>
<%@page import="notice.QnADBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="login.UserDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%

	String user_id = null;
	String pageNum = null;
	if(((String)session.getAttribute("user_id"))!=null){
		user_id =(String)session.getAttribute("user_id");
		System.out.print(user_id);
	}
	
 	pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}

 	
%>
<%
	QnADBBean qnaDB = QnADBBean.getInstance();
	ArrayList<QnABean> boards = qnaDB.getList(pageNum);
	
	UserDBBean udb = new UserDBBean();
	boolean isAdmin = udb.isAdmin(user_id);
	
	int n_num=0, n_hit=0;
	String n_title, n_content;
	Timestamp n_date;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
	

%>
<!doctype html>
<html>
<head>
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>

    <script src="board.js" type="text/javascript"></script> 
    <script>
	    function canWrite(id) {
	    	if	(id == null || id.length == 0) {
	    		alert("로그인 해주세요.");
	    	} else {
	    		location.href="qnaWrite.jsp?pagecheck=qnaList";
	    	}
	    }
    </script>
<style> 
	#container, #ntc, #navi { 
		min-width: 1100px; 
		max-width: 1280px; 
		margin: 0 auto; /* 가로로 중앙에 배치 */ 
		font-family: "Malgun Gothic",돋음;
		font-size: 12px;
	}
	#ntc{
		padding-top: 3%;
	} 
	p{
		font-size: small;
	} 
	#list { 
		text-align: left; 
	} 
	#title { 
		text-align: left; 
	} 
	#write { 
		text-align: right; 
	} /* Bootstrap 수정 */ 
	.table > thead > tr > td { 
		text-align: center; 
	} 
	.table-hover > tbody > tr:hover { 
		background-color: #eeeeef; 
	} 
	.table > tbody > tr > td { 
		text-align: center; 
	} 
	a:link { color: black; text-decoration: none;}
 	a:visited { color: gray; text-decoration: none;}
 	a:hover { color: blue; text-decoration: underline;}
	div #paging { 
		text-align: center;
		display: inline-block;
	} 
</style>
 <jsp:include page="../main/mainHeader.jsp"></jsp:include>
</head>
<body>
<div id="navi" style= "--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
	<ul class="breadcrumb" style="float: right;">
		<li class="breadcrumb-item"><a href="../main/main.jsp">Home</a></li>
		<li class="breadcrumb-item"><a href="../customer_service/customer_service.jsp">Customer Service</a></li>
		<li class="breadcrumb-item active">Q & A</li>
	</ul>
</div>
<div id="ntc">
	<h4 id="list">Q & A</h4>
	<p>사이즈 문의, 입금 배송 문의, 코디 문의, 이벤트 문의 등 모든 궁금한 사항들을 남겨주세요~</p>
</div>

<center>
<div style="min-width: 1100px; max-width: 1280px;">
<form method="post" name="search" action="searchqna.jsp">
<table style="float: right;">
	<tr>
		<td width="100px;">
			<select class="form-select" name="searchCat" aria-label="Default select example" style="font-size: 11px;">
			  <option selected>카테고리</option>
			  <option value="1">상품</option>
			  <option value="2">배송</option>
			  <option value="3">회원정보</option>
			</select>
		</td>
		<td width="100px;">
			<select class="form-select" name="searchField" aria-label="Default select example" style="font-size: 11px;">
			  <option selected value="b_title">제목</option>
			  <option value="1">내용</option>
			  <option value="2">제목+내용</option>
			  <option value="3">작성자</option>
			</select>
		</td>
		<td>
			<input type="search" class="form-control" placeholder="검색어 입력" name="searchText" maxlength="100" style="font-size: 11px;">
		</td>
		<td>
			<button type="button" class="btn btn-outline-secondary" style="font-size: 11px;">검색</button>
		</td>
	</tr>
</table>
</form>
</div>
</center>

<div id="container">
	<table class="table table-hover"> 
			<tr>
				<td width="90px">글번호</td>
				<td width="90px">분류</td>
				<td width="300px">제목</td>
				<td width="90px">작성자</td>
				<td width="150px">작성일</td>
				<td width="90px">조회수</td>
				<td width="80px">첨부파일</td>
				<td width="90px">비공개</td>
			</tr>
			<% //공지사항 3줄 불러오기	
			for(int i=0; i<boards.size(); i++){
				
				if(i<3){
					QnABean list = boards.get(i);
					n_num = list.getN_num();
					n_title = list.getN_title();
					n_content = list.getN_content();
					if(n_num == 0) {
						continue;
					}
			%>
			<tr bgcolor="#F7F7F7">
				<td> 공지 </td>
				<td> &nbsp; </td>
				<td id="title">
					<a href="../customer_service/notice_show.jsp?n_num=<%= n_num %>&pageNum=<%= pageNum %>">
						<%= n_title %>
					</a>
				</td>
				<td>
					<%  if(user_id!=null) { 
							if(user_id.equals("admin")){	
					%>
							<%= user_id %>	
					<% 	}}else {%>
							admin
					<% }%>
				</td>
				<td> &nbsp; </td>
				<td> &nbsp; </td>
				<td> &nbsp; </td>
				<td> &nbsp; </td>
			</tr>
						
			<tr>
			    <%
					} else {
						QnABean list = boards.get(i);
						boolean isMine = false;
				%>
				
				<td> <%= list.getB_id() %> </td>
				<td> <%= list.getB_category() %> </td>
				<td id="title"> <!-- 답변글일 경우 들여쓰기 후 이미지 표시 -->
				<%
						if(list.getB_level() > 0) {	
							for(int j=0; j<list.getB_level(); j++){
				%>				&nbsp;
				<% 		} %>
					<img src='../images/outline_subdirectory_arrow_right_black_24dp.png'>
				<% 	}	%>
					<a href="../customer_service/qnaShow.jsp?b_id=<%= list.getB_id() %>&pageNum=<%= pageNum %>&pagecheck=qnaList">
						<%= list.getB_title() %> 
					</a>
				</td>
				<td> 
					<%= list.getU_id() %> 
				</td>
				<td> 
					<%= sdf.format(list.getB_date()) %> 
				</td>
				<td> 
					<%= list.getB_view() %>  
				</td>
				<% 	
					//첨부파일 있을 시 이미지 표시
					if (list.getB_fsize() > 0) {
				%>		
						<td><img src='../images/zip.gif'></td>	
				<% 	} else { %>
						<td>&nbsp;</td>
				<% 	}
					//비밀글일 경우 이미지 표시
					if (list.getB_secret().equals("0")) {
				%>		<td>&nbsp;</td>
				<% 	} else { %>
						<td><img src='../images/outline_lock_black_24dp.png'></td>	
				<% 	} %>	
			</tr>
		<% 			 
			}
		}	
		%>
		<tr>
			<td colspan="8" id="write">
				<% if (user_id != null) { %> <!-- 회원일 경우 글쓰기 가능  -->
				<input type="button" class="btn btn-dark"
					value="&nbsp;&nbsp;&nbsp;글쓰기&nbsp;&nbsp;&nbsp;" onClick="canWrite('<%= user_id == null ? "" : user_id %>')"
					style="cursor: pointer;">
				<% } %>
			</td>
		</tr>
	</table>      
</div> 
	<div id="paging"> 
		<nav> 
			<ul class="pagination justify-content-center"> 
				<li class="page-item"><a class="page-link" href="#">이전</a></li> 
				<li class="page-item"><a class="page-link" href="qnaList.jsp?pageNum=1">1</a></li> 
				<li class="page-item"><a class="page-link" href="qnaList.jsp?pageNum=2">2</a></li> 
				<li class="page-item"><a class="page-link" href="qnaList.jsp?pageNum=3">3</a></li> 
				<li class="page-item"><a class="page-link" href="#">다음</a></li> 
			</ul> 
		</nav>
	</div>
	<br>

</body>
<jsp:include page="../main/mainfooter.jsp"></jsp:include>
</html>
<% QnABean.pageNumber(3); %>