<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user_id = (String)session.getAttribute("user_id");
	
	UserDBBean db = UserDBBean.getInstance();
	UserBean user = db.getUser(user_id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script>
		// 도로명 주소 찾기 API 수정 -0421근지
		function goPopup(){
			// 주소검색을 수행할 팝업 페이지를 호출합니다.
			// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
			var pop = window.open("../addrApi/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
			
			// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
		    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
		}
		
		function jusoCallBack(roadFullAddr){
			// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
			document.upd_frm.user_addr.value = roadFullAddr;
		}
	
		// 입력값 체크 -0421근지
		function update_check_ok(){
			if(document.upd_frm.user_pwd.value.length == 0){
				alert("패스워드는 반드시 입력해야 합니다.");
				document.upd_frm.user_pwd.focus();
				return;
			}	
			
			if(document.upd_frm.user_pwd.value != document.upd_frm.pwd_check.value){
				alert("패스워드가 일치하지 않습니다.");
				upd_frm.pwd_check.focus();
				return;
			}	
			
			if(document.upd_frm.user_email.value.length == 0){
				alert("Email을 써주세요.");
				document.upd_frm.user_email.focus();
				return;
			}
			
			if(document.upd_frm.user_phone.value.length == 0){
				alert("휴대폰번호를 써주세요.");
				document.upd_frm.user_phone.focus();
				return;
			}
			
			if(document.upd_frm.user_addr.value.length == 0){
				alert("주소를 써주세요.");
				document.upd_frm.user_addr.focus();
				return;
			}
			document.upd_frm.submit();
		}
	</script>
	<style>
		#regidiv{
			
			margin:auto;
		   	min-width : 980px;	
			max-width : 1000px;	
			height: 475px;
			
		}
		.width_tr{
			width: 200px;
			height: 30px;
			
		}
		.title_tr{
			width: 1000px;
			height: 15px;
		 	font-weight: bold;
		 	font-family: "Nanum Gothic","Malgun Gothic","맑은 고딕","돋움","Dotum","Apple Gothic","Apple SD Gothic Neo",sans-serif;
		 	
		 	
		}
		input.btn {
			background: black;
			color: white;
		}
		
		input.btn:hover{
			background: white;
			color: black;
			border-color: gray;
		}
		input.btn1{
			background:	#A9A9A9;
			color: white;
		}
		input.btn1:hover{
			background: white;
			color: black;
			border-color: gray;
		}
		::placeholder{
			font-size: 11px;
		}
	</style>
	
</head>
<body>
     <jsp:include page="../main/mainHeader.jsp"></jsp:include> 
 <br><br>	    

<!-- <div class="regidiv"> -->
	<table class="table" id="regidiv" style="font-size: 15px;">
		<form name="upd_frm" method="post" action="userUpdateOk.jsp" >
			<tr class="title_tr">
				<td colspan="2" style="vertical-align : bottom; border: solid 2px white;"> 
					<div style="font-size: 16px;">회원 정보 수정</div><br>
				</td>
				
				<td class="regitd2" style="vertical-align : bottom; border: solid 2px white;">
					<div align="right" style="font-size: 12px;">*필수 입력 사항</div>
				</td> 
			</tr>
			<tr>
				<td width="80" class="width_tr" id="boderleft" style="vertical-align: middle; border-top: solid 3px #DCDCDC; background-color: #F5F5F5; font-size: 12px;">
					&nbsp;&nbsp;아이디
				</td>
				

				<td colspan="2" style="vertical-align: middle; border-top: solid 3px #DCDCDC;" id="boderright" >
  					<div class="col-5" style="font-size: 12px;">
   						<%= user.getUser_id() %>
					</div>
				</td>
			</tr>
			<tr>
				<td width="80" class="width_tr" id="boderleft" style="vertical-align: middle; background-color: #F5F5F5; font-size: 12px;" >
					&nbsp;&nbsp;비밀번호*
				</td>
				<td colspan="2" style="vertical-align: middle;" id="boderright">
				  <div class="col-5">
					<input type="password" size="20" name="user_pwd" placeholder="비밀번호를 입력해주세요." class="form-control" style="font-size: 12px; font-family: Malgun Gothic,돋움;">
				  </div>
				</td>
			</tr>
			<tr>
				<td width="80" class="width_tr" id="boderleft" style="vertical-align: middle; background-color: #F5F5F5; font-size: 12px;">
					&nbsp;&nbsp;비밀번호 확인*
				</td>
				<td colspan="2" style="vertical-align: middle;" id="boderright">
				  <div class="col-5">
					<input type="password" size="20" name="pwd_check" placeholder="비밀번호를 한번 더 입력해주세요." class="form-control" style="font-size: 12px; font-family: Malgun Gothic,돋움;">
				  </div>
				</td>
			</tr>
			<tr>
				<td width="80" class="width_tr" id="boderleft" style="vertical-align: middle; background-color: #F5F5F5; font-size: 12px;">
					&nbsp;&nbsp;이    름
				</td>
				<td colspan="2" style="vertical-align: middle;" id="boderright">
				  <div class="col-5" style="font-size: 12px;">
					<%= user.getUser_name() %>
				  </div>
				</td>
			</tr>
			<tr>
				<td width="80" class="width_tr" id="boderleft" style="vertical-align: middle; background-color: #F5F5F5; font-size: 12px;">
					&nbsp;&nbsp;이메일
				</td>
				<td colspan="2" style="vertical-align: middle;" id="boderright">
				  <div class="col-5">
					<input type="text" size="30" name="user_email" value="<%= user.getUser_email() %>" class="form-control"
																		style="font-size: 12px; font-family: Malgun Gothic,돋움;">
				  </div>
				</td>
			</tr>
			<tr>
				<td width="80" class="width_tr" id="boderleft" style="vertical-align: middle; background-color: #F5F5F5; font-size: 12px;">
					&nbsp;&nbsp;휴대폰 번호
				</td>
				<td colspan="2" style="vertical-align: middle;" id="boderright">
				  <div class="col-5">
					<input type="text" size="40" name="user_phone" value="<%= user.getUser_phone() %>" class="form-control"
															style="font-size: 12px; font-family: Malgun Gothic,돋움;">
				  </div>
				</td>
			</tr>
			<tr>
				<td width="80" class="width_tr" id="boderleft" style="vertical-align: middle; border-bottom: solid 3px #DCDCDC; background-color: #F5F5F5; font-size: 12px;">
					&nbsp;&nbsp;주    소
				</td>
				<td colspan="2" style="vertical-align: middle; border-bottom: solid 3px #DCDCDC;" id="boderright">
				  <div class="col-12">
					<input type="text" size="40" name="user_addr" value="<%= user.getUser_addr()%>" class="form-control" onclick="goPopup()"
								                                   style="font-size: 12px; font-family: Malgun Gothic,돋움;">
				  </div>
				</td>
			</tr>
			<tr class="title_tr">
				<td colspan="3" align="center" style="vertical-align: middle; border-bottom: none;">
					<input type="reset" value="다시입력" class="btn btn-outline-gray btn1" style="font-size: 12px; font-family: Malgun Gothic,돋움;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="수 정" onclick="update_check_ok()" class="btn btn-outline-dark" style="font-size: 12px; font-family: Malgun Gothic,돋움;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="수정안함" onclick="javascript:window.location='../userPage/userPage.jsp'" class="btn btn-outline-gray btn1" 
																style="font-size: 12px; font-family: Malgun Gothic,돋움;">
				</td>
			</tr>
		</form>
	</table>

<!-- </div> -->
 <br><br><br><br>
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>  
	
</body>
</html>
