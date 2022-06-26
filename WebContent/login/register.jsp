<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 주소 받아올 때 한글 깨지지 않기 위해 -0421근지
	request.setCharacterEncoding("UTF-8");

	String addr = request.getParameter("roadFullAddr");
	if(addr == null) {
		addr = "클릭하여 주소 입력하기";
	}
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 구글리캡차	-0503근지 -->
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script>
		// 도로명 주소 찾기 API 수정 -0421근지
		function goPopup(){
			// 주소검색을 수행할 팝업 페이지를 호출합니다.
			// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
			var pop = window.open("../addrApi/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
			
			// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
		    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
		}
		
		function jusoCallBack(roadAddrPart1,addrDetail, zipNo){
			// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
			var addr = roadAddrPart1+", "+addrDetail+" ("+zipNo+")";
			document.reg_frm.user_addr.value = addr;
	}
		
		// 필수입력값 및 패스워드 체크 -0421근지
		function check_ok(){
			if(reg_frm.user_id.value.length == 0){
				alert("아이디를 써주세요.");
				reg_frm.user_id.focus();
				return;
			}
			
			if(reg_frm.user_pwd.value.length == 0){
				alert("패스워드는 반드시 입력해야 합니다.");
				reg_frm.user_pwd.focus();
				return;
			}	
			
			if(reg_frm.user_pwd.value != reg_frm.pwd_check.value){
				alert("패스워드가 일치하지 않습니다.");
				reg_frm.pwd_check.focus();
				return;
			}	
			
			if(reg_frm.user_name.value.length == 0){
				alert("이름을 써주세요.");
				reg_frm.user_name.focus();
				return;
			}
			
			if(reg_frm.user_email.value.length == 0){
				alert("Email을 써주세요.");
				reg_frm.user_email.focus();
				return;
			}
			
			if(reg_frm.user_phone.value.length == 0){
				alert("휴대폰 번호를 써주세요.");
				reg_frm.user_phone.focus();
				return;
			}
			
			if(reg_frm.user_addr.value.length == 0){
				alert("주소를 써주세요.");
				reg_frm.user_addr.focus();
				return;
			}
			
			// 유효성 체크	-0503근지
			var id_RegExp = /^[a-zA-z0-9]{4,12}$/; //아이디 유효성 검사
     	  	if (!id_RegExp.test(reg_frm.user_id.value)) {
				alert("아이디는 영문 대소문자와 숫자 4~12자리로 입력해야합니다!");
				reg_frm.user_id.value = "";
				reg_frm.user_id.focus();
           		return;
      		}

			var pwd_RegExp1 = /[0-9]/; // 숫자
			var pwd_RegExp2 = /[a-zA-Z]/; // 문자
			var pwd_RegExp3 = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자
			if(!pwd_RegExp1.test(reg_frm.user_pwd.value) || !pwd_RegExp2.test(reg_frm.user_pwd.value) || !pwd_RegExp3.test(reg_frm.user_pwd.value) || reg_frm.user_pwd.value.length < 8) {
				alert("비밀번호는 8자리 이상 문자, 숫자, 특수문자로 구성하여야 합니다.");
				reg_frm.user_pwd.focus();
				return;
			}
			
			var email_RegExp = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
		     if(!email_RegExp.test(reg_frm.user_email.value)) {
				alert("이메일 형식이 잘못되었습니다.");
				reg_frm.user_email.focus();
				return;
		     }
		     
		     var phone_RegExp = /01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}/;
		     if(!phone_RegExp.test(reg_frm.user_phone.value)) {
		         alert('휴대폰 형식이 잘못되었습니다.');
				reg_frm.user_phone.focus();
				return;
		     }
		     
			// 구글 리캡차	-0503근지
			if (grecaptcha.getResponse().length == 0) {
				alert('로봇이 아닙니다에 체크해주세요.');
				return;
			}
			document.reg_frm.submit();
		
		}
		
	</script>
	
	<style>
		#regidiv{
			
			margin:auto;
		   	min-width : 980px;	
			max-width : 1000px;	
			height: 600px;
			
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
	<table class="table" id="regidiv">
		<form name="reg_frm" method="post" action="registerOk.jsp">
			<tr class="title_tr">
				<td colspan="2" style="vertical-align : bottom; border: solid 2px white;"> 
					<div style="font-size: 16px;">회원 가입 신청</div><br>
				</td>
				
				<td class="regitd2" style="vertical-align : bottom; border: solid 2px white;">
					<div align="right" style="font-size: 12px;">*모든 입력값은 필수사항입니다.</div>
				</td>
			</tr>
			<tr>
				<td width="80" class="width_tr" id="boderleft" style="vertical-align: middle; border-top: solid 3px #DCDCDC; background-color: #F5F5F5; font-size: 12px;">
					&nbsp;&nbsp;아이디*
				</td>
				<td colspan="2" style="vertical-align: middle; border-top: solid 3px #DCDCDC;" id="boderright" >
  					<div class="col-5">
   						 <input type="text" name="user_id" class="form-control" placeholder="( 4~12자 영문, 숫자 조합 )" style=" font-size: 12px; font-family: Malgun Gothic,돋움;">
					</div>
				</td>
			</tr>
			<tr>
				<td width="80" class="width_tr" id="boderleft" style="vertical-align: middle; background-color: #F5F5F5; font-size: 12px;" >
					&nbsp;&nbsp;비밀번호*
				</td>
				<td colspan="2" style="vertical-align: middle;" id="boderright">
				  <div class="col-5">
					<input type="password" size="20" name="user_pwd" class="form-control" placeholder="( 8자리 이상 문자, 숫자, 특수문자 조합 )" style="font-size: 12px; font-family: Malgun Gothic,돋움;">
				  </div>
				</td>
			</tr>
			<tr>
				<td width="80" class="width_tr" id="boderleft" style="vertical-align: middle; background-color: #F5F5F5; font-size: 12px;">
					&nbsp;&nbsp;비밀번호 확인*
				</td>
				<td colspan="2" style="vertical-align: middle;" id="boderright">
				  <div class="col-5">
					<input type="password" size="20" name="pwd_check" class="form-control" placeholder="비밀번호를 한번 더 입력해주세요." style="font-size: 12px; font-family: Malgun Gothic,돋움;">
				  </div>
				</td>
			</tr>
			<tr>
				<td width="80" class="width_tr" id="boderleft" style="vertical-align: middle; background-color: #F5F5F5; font-size: 12px;">
					&nbsp;&nbsp;이    름*
				</td>
				<td colspan="2" style="vertical-align: middle;" id="boderright">
				  <div class="col-5">
					<input type="text" size="20" name="user_name" class="form-control" placeholder="이름을 입력해주세요." style="font-size: 12px; font-family: Malgun Gothic,돋움;">
				  </div>
				</td>
			</tr>
			<tr>
				<td width="80" class="width_tr" id="boderleft" style="vertical-align: middle; background-color: #F5F5F5; font-size: 12px;">
					&nbsp;&nbsp;이메일*
				</td>
				<td colspan="2" style="vertical-align: middle;" id="boderright">
				  <div class="col-5">
					<input type="text" size="30" name="user_email" class="form-control"  placeholder="이메일을 입력해주세요." style="font-size: 12px; font-family: Malgun Gothic,돋움;">
				  </div>
				</td>
			</tr>
			<tr>
				<td width="80" class="width_tr" id="boderleft" style="vertical-align: middle; background-color: #F5F5F5; font-size: 12px;">
					&nbsp;&nbsp;휴대폰 번호*
				</td>
				<td colspan="2" style="vertical-align: middle;" id="boderright">
				  <div class="col-5">
					<input type="text" size="40" name="user_phone" class="form-control"  placeholder="( 하이픈'-' 포함 입력 )" style="font-size: 12px; font-family: Malgun Gothic,돋움;">
				  </div>
				</td>
			</tr>
			<tr>
				<td width="80" class="width_tr" id="boderleft" style="vertical-align: middle; border-bottom: solid 3px #DCDCDC; background-color: #F5F5F5; font-size: 12px;">
					&nbsp;&nbsp;주    소*
				</td>
				<td colspan="2" style="vertical-align: middle; border-bottom: solid 3px #DCDCDC;" id="boderright">
				  <div class="col-12">
					<input type="text" size="40" name="user_addr" placeholder="( 클릭하여 주소 입력 )" onclick="goPopup()" class="form-control" style="font-size: 12px; font-family: Malgun Gothic,돋움;">
				  </div>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="border-bottom: none;">
					<div class="g-recaptcha" data-sitekey="6LfpRb0fAAAAALlJGedVQc7w-EtUfgJ8sPIpwLjX"></div>
				</td>
			</tr>
			<tr class="title_tr">
				<td colspan="3" align="center" style="vertical-align: middle; border-bottom: none;">
					<input type="reset" value="다시입력" class="btn btn-outline-gray btn1" style="font-size: 12px; font-family: Malgun Gothic,돋움;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="회원가입" onclick="check_ok()" class="btn btn-outline-dark" style="font-size: 12px; font-family: Malgun Gothic,돋움;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="가입안함" onclick="javascript:window.location='../main/main.jsp'" class="btn btn-outline-gray btn1" style="font-size: 12px; font-family: Malgun Gothic,돋움;">
				</td>
			</tr>
		</form>
	</table>
<!-- </div> -->
 <br><br><br><br>
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>  
	
</body>
</html>