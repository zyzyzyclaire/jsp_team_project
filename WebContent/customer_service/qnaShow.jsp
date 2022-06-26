<%@page import="notice.QnADBBean"%>
<%@page import="notice.QnABean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="login.UserDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<%
	String pageNum = request.getParameter("pageNum");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	String user_id = null;
	String b_pwd = null;
    if (session.getAttribute("user_id") != null) {
        user_id = (String) session.getAttribute("user_id");
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
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>

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

<% if(!isAdPage){ %>
<jsp:include page="../main/mainHeader.jsp"></jsp:include>
<% } %>
</head>
<body>
<%
	QnADBBean ndb = QnADBBean.getInstance();
	QnABean board;
	UserDBBean udb = new UserDBBean();
	boolean isAdmin = udb.isAdmin(user_id);
	boolean isMe = false;
	boolean isRef = false;
	boolean isMine = false;
	boolean isCategory = false;
	
	int b_id = 0;
	if (request.getParameter("b_id") == null || request.getParameter("b_id").length() == 0) {
	%>
		<script>
			alert("잘못된 접근입니다.");
			location.href = "qnaList.jsp";
		</script>
	<%
	} else {
		b_id = Integer.parseInt(request.getParameter("b_id"));
		board = ndb.getBoard(b_id, true);
		isMe = board.getU_id().equals(user_id);
		isRef = (board.getB_ref() != board.getB_id());
		int b_view =0;
		String b_title="", b_content = ""; 
		Timestamp b_date= null;
		

	
		if (board == null) {
		%>
			<script>
				alert("잘못된 접근입니다.");
				location.href = "qnaList.jsp";
			</script>
		<%
		} else if (!board.getB_secret().equals("0")) {
			if (isRef) {
				QnABean refBoard = ndb.getBoard(board.getB_ref(), false);
				isMine = refBoard.getU_id().equals(user_id);
			}
					
			 if (!isMe && !isAdmin && !isMine) {
				%><script>
					alert("작성자만 볼 수 있는 비공개 글입니다.");
					location.href = "qnaList.jsp";
				</script><%
			}
		}
%>	
<script>
	function deleteOK() {
		if (<%= !isMe && !isAdmin %>) {
			alert("작성자만 삭제가 가능합니다.");
			return;
		} else {
			if (<%= isAdmin%>) {
				if(confirm("정말 글을 삭제하시겠습니까?") == true){
					location.href = "../customer_service/qnaDeleteOK.jsp?b_id=<%=b_id%>&pageNum=<%=pageNum%>&pagecheck=<%=pagecheck%>";
				}
			} else {
				var pwd = prompt("비밀번호를 입력하세요.");
				if(pwd == <%=board.getB_pwd()%>){
					if(confirm("정말 글을 삭제하시겠습니까?") == true){
						location.href = "../customer_service/qnaDeleteOK.jsp?b_id="+<%= b_id %>+"&pageNum="+<%= pageNum %>+"&pagecheck="+<%= pagecheck %>;
					}
				} else {
					alert("비밀번호가 맞지 않습니다.");
					history.go(-1);
				}
			}
		}
	}
</script>
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
      	<% if (board != null) { %>
		<table class="table"> 
				<tr style="border-top: 1px solid #e0e0e0;">
					<td style="font-size:medium; padding-right: 150px;">No.&nbsp;<%= board.getB_id()%></td>                  
					<td colspan="2">CATEGORY&nbsp;&nbsp;&nbsp;<%= board.getB_category()%></td>
				</tr>
				<tr>
					<td colspan="3">SUBJECT&nbsp;&nbsp;&nbsp;<%= board.getB_title()%></td>
				</tr>
				<tr>
					<td colspan="3">NAME&nbsp;&nbsp;&nbsp;<%= board.getU_id()%></td>
				</tr>
				<tr>
					<td width="20px;">VIEW&nbsp;&nbsp;&nbsp;<%= board.getB_view()%></td>
					<td colspan="2">DATE&nbsp;&nbsp;&nbsp;<%= sdf.format(board.getB_date()) %></td>
				</tr>
				<tr>
					<td colspan="3">
					 	<p>FILE&nbsp;
						<% 	
							if (board.getB_fsize() > 0) {
						%>		
								<a href='FileDownload.jsp?fileN=<%= board.getB_id() %>'><%= board.getB_rfname() %></a></p>	
						<% 	} else { %>
								&nbsp;
						<% 	} %>
					</td>
				</tr>
			<tr>
				<td colspan="3" height="400px"><%= board.getB_content()%></td>
			</tr>
			<tr>
				<td align="left">
					<% if(!isAdPage){ %>
						<input type="button" value="&nbsp;&nbsp;&nbsp;목록&nbsp;&nbsp;&nbsp;" onClick="location.href='../customer_service/qnaList.jsp?b_id=<%= b_id %>&pageNum=<%= pageNum %>'"  class="btn btn-secondary">
					<% } else { %>
						<input type="button" value="&nbsp;&nbsp;&nbsp;목록&nbsp;&nbsp;&nbsp;" onClick="location.href='?pageChange=../adminPage/qnaAnswerList.jsp'" class="btn btn-secondary">
					<% } %>
				</td>
				<td colspan="3" align="right">
					<% if (isRef || isAdmin) { 
							if (!isAdPage){
					%>		
							<input type="button" value="&nbsp;&nbsp;&nbsp;답글&nbsp;&nbsp;&nbsp;" onClick="location.href='qnaWrite.jsp?b_id=<%= b_id %>&pageNum=<%= pageNum %>&pagecheck=qnaList'" class="btn btn-dark">
					<% 		} else {%>
							<input type="button" value="&nbsp;&nbsp;&nbsp;답글&nbsp;&nbsp;&nbsp;" onClick="location.href='?pageChange=../customer_service/qnaWrite.jsp?b_id=<%= b_id %>&pageNum=<%= pageNum %>&pagecheck=adminpage'" class="btn btn-dark">
					<%		}
						} 
					%>
					<% if (isMe) { %>
						<input type="button" value="&nbsp;&nbsp;&nbsp;수정&nbsp;&nbsp;&nbsp;" onClick="location.href='qnaEdit.jsp?b_id=<%= b_id %>&pageNum=<%= pageNum %>'" class="btn btn-dark">
					<% 	} %>
					<% if (isMe || isAdmin) { %>
						<input type="button" value="&nbsp;&nbsp;&nbsp;삭제&nbsp;&nbsp;&nbsp;" onClick="deleteOK()" class="btn btn-dark">
					<% 	} %>
				</td>
			</tr>
		</table>   
		<%
			}
      	}
      	%>
     
   	</div>
   		<% if(!isAdPage){ %>
      	<jsp:include page="../main/mainfooter.jsp"></jsp:include>
      	<% } %>      
</body>
</html>