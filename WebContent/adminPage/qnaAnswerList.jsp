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
	
	if(pageNum == null){
		pageNum = "1";
	}
	
 	pageNum = request.getParameter("pageNum");
 	
 	String pagecheck = request.getParameter("pagecheck");
 	
 	String select = request.getParameter("pageChange");
	boolean isAdPage = true;
	if (select == null) {
		isAdPage = false;
	}
%>
<%
	QnADBBean qnaDB = QnADBBean.getInstance();
	ArrayList<QnABean> boards = qnaDB.getAdminBoardList(user_id);
	
	UserDBBean udb = new UserDBBean();
	boolean isAdmin = udb.isAdmin(user_id);
	
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
	nav > #paging { 
		text-align: center; 
	} 
</style>
</head>
<body>
<div id="navi" style= "--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
	<ul class="breadcrumb" style="float: right;">
		<li class="breadcrumb-item"><a href="../main/main.jsp">Home</a></li>
		<li class="breadcrumb-item"><a href="../customer_service/customer_service.jsp">Customer Service</a></li>
		<li class="breadcrumb-item active">Q & A</li>
	</ul>
</div>
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
			<tr>			
		    <%
		    	for(int i=0; i<boards.size(); i++){
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
					<a href="?pageChange=../customer_service/qnaShow.jsp?b_id=<%= list.getB_id() %>&pageNum=<%= pageNum %>&pagecheck=<%= pagecheck%>">
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
		%>
	</table>      
</div>  
</body>
</html>
<% QnABean.pageNumber(3); %>