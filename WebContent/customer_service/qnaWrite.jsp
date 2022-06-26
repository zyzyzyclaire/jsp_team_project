<%@page import="notice.QnABean"%>
<%@page import="notice.QnADBBean"%>
<%@page import="login.UserDBBean"%>
<%@page import="login.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<%	
	String pageNum = request.getParameter("pageNum");

	if(pageNum == null){
		pageNum = "1";
	}
	
	int b_id=0, b_ref=1, b_step=0, b_level=0;
	String b_title="", b_anschk="";
	
    String user_id = null;
    if (session.getAttribute("user_id") != null) {
        user_id = (String) session.getAttribute("user_id");
    }
	
	if (request.getParameter("b_id") != null) {	
		b_id = Integer.parseInt(request.getParameter("b_id"));
	}
	QnADBBean qdb = QnADBBean.getInstance();
	QnABean board = qdb.getBoard(b_id, false);
	UserDBBean udb = new UserDBBean();
	
	if(board != null){ //board가 널값이 아니면(답변글이면)
		b_title = board.getB_title();
		b_ref = board.getB_ref();
		b_step = board.getB_step();
		b_level = board.getB_level();
		b_anschk = board.getB_anschk();
	}
	
	String pagecheck = request.getParameter("pagecheck");
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
    <script src="board.js" type="text/javascript"></script> 
	
	  <script type="text/javascript">
	  function doWrite() {
			if (document.boardForm.u_id.value.length == 0) {
				alert("잘못된 접근입니다.");
				location.href="qnaList.jsp";
				return;
			}
			if (document.boardForm.b_title.value.length == 0) {
				alert("글 제목을 입력해 주세요.");
				document.boardForm.b_title.focus();
				return;
			}
			if (document.boardForm.b_content.value.length == 0) {
				alert("글 내용을 입력해 주세요.");
				document.boardForm.b_content.focus();
				return;
			}
			if(document.boardForm.b_pwd.value.length == 0){
				alert("비밀번호를 입력해 주세요.");
				boardForm.b_pwd.focus();
				return;
			}
			
			document.boardForm.submit();
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
	a:link { color: black; text-decoration: none;}
 	a:visited { color: gray; text-decoration: none;}
 	a:hover { color: blue; text-decoration: underline;}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="navi" style= "--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
		<ul class="breadcrumb" style="float: right;">
			<li class="breadcrumb-item"><a href="../main/main.jsp">Home</a></li>
			<li class="breadcrumb-item"><a href="../customer_service/customer_service.jsp">Customer Service</a></li>
			<li class="breadcrumb-item active">Q & A</li>
		</ul>
	</div>
	<% if(!isAdPage){ %>
	<div id="ntc">
		<h4 id="list">Q & A</h4>
		<p>사이즈 문의, 입금 배송 문의, 코디 문의, 이벤트 문의 등 모든 궁금한 사항들을 남겨주세요~</p>
	</div>  
	<% } %>
	<div id="container">
		<form method="post" action="../customer_service/qnaWriteOK.jsp?b_id=<%= b_id %>&pagecheck=<%= pagecheck %>" name="boardForm" enctype="multipart/form-data">
			<table class="table" >
					<input type="hidden" name="b_id" value="<%= b_id %>">
					<input type="hidden" name="b_ref" value="<%= b_ref %>">
					<input type="hidden" name="b_step" value="<%= b_step %>">
					<input type="hidden" name="b_level" value="<%= b_level %>">
					<input type="hidden" name="b_anschk" value="<%= b_anschk %>">
				<tr>
					<td style="padding-right: 40px">SUBJECT</td>
					<td>
					<%
						if(b_id == 0){
					%>
							<input name="b_title" type="text" size="100px" value="<%= b_title %>" placeholder="제목을 입력하세요." aria-label="default input example">
					<% 	
						} else {
					%>	
							<input name="b_title" type="text" size="100px" value="[RE]: <%= b_title %>">
					<% 	
						}
					%>
					</td>
				</tr>
				<tr>
					<td>NAME</td>
					<td>
						<input type="text" name="u_id" disabled="disabled" value=<%= user_id %>>
					</td>
				</tr>
				<tr>
					<td>CATEGORY</td>
					<td>
						<select name="b_category">
							<option value = "상품">상품</option>
							<option value = "배송">배송</option>
							<option value = "회원정보">회원정보</option>
						</select> 
					</td>
				</tr>
			<tr>
				<td colspan="2">
					<textarea name="b_content" placeholder="내용을 입력하세요." style="height: 500px; width: 100%;"></textarea>
				</td>
			</tr>
			<tr>
				<td>FILE</td>
				<td>
					<input type="file" name="b_fname">
				</td>
			</tr>
			<tr>
				<td>PASSWORD</td>
				<td>
					<input type="password" name="b_pwd" size="100px" maxlength="30" placeholder="암호를 입력하세요." aria-label="default input example">
				</td>
			</tr>
			<% if (!udb.isAdmin(user_id) || b_ref != 0) { %>  <!-- 관리자와 작성자가 아니면 글 비공개 설정  -->
			<tr height="30px">
				<td>SECRET</td>
				<td class="btn-group-toggle" data-toggle="buttons" colspan="4">
					<input type="checkbox" class="btn-check" id="btn-check-outlined" name="b_secret" autocomplete="off" checked>
					<label class="btn btn-outline-primary" for="btn-check-outlined">비밀글</label>
				</td>
			</tr>
			<% } %>
			<tr height="30px">
				<td align="left">
					<% if(!isAdPage){ %>
						<input type="button" value="&nbsp;&nbsp;&nbsp;목록&nbsp;&nbsp;&nbsp;" onClick="location.href='qnaList.jsp?b_id=<%= b_id %>&pageNum=<%= pageNum %>'" class="btn btn-secondary">
					<% } else { %>
						<input type="button" value="&nbsp;&nbsp;&nbsp;목록&nbsp;&nbsp;&nbsp;" onClick="location.href='?pageChange=../adminPage/qnaAnswerList.jsp'" class="btn btn-secondary">
					<% } %>
				</td>
				<td align="right">
					<input type="button" onClick="doWrite()" value="&nbsp;&nbsp;&nbsp;등록&nbsp;&nbsp;&nbsp;" class="btn btn-dark">
					<input type="reset" value="&nbsp;&nbsp;&nbsp;다시쓰기&nbsp;&nbsp;&nbsp;" class="btn btn-dark">
				</td>
			</tr>
			</table>
		</form>
	</div>
</body>
	<% if(!isAdPage){ %>
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>
	<% } %>
</html>