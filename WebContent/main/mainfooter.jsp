<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
 	.footerdiv{
 		color: rgb(136, 136, 136);
 		border-top: 1px solid  rgb(136, 136, 136);
 		padding-top: 30px;
 	
 		
 	}
 	
	.u1 li{
		list-style: none;
		font-size: 12px;
	}
	.u1 ul li span{
		 color: black;
		 font-size: 16px;
	} 
	.u1 > li{
		float:left;
	}
	.footerdiv{
		
		max-width : 100%;	
 		min-width : 1120px;	
 		margin: auto;
 		padding-left: 190px;
		
	}
	.footerdiv1{
		display: flex;
	}
	ul{
		margin-left: 40px;
		margin-right: 20px;
	}
	a{
		text-decoration: none;
		color: rgb(136, 136, 136);
	}
	a:hover{
		color: black;
	}
	#bt:hover{
		background-color: black;
	}
	#bt{
		color: white !important;
		background-color: #d3d3d3;
		border-radius: 4px;
	}
</style>
<link rel="stylesheet" href="./../css/main.css" type = "text/css">
</head>
<body>
	
	<div class="footerdiv" id="footerdiv">
		<div class="footerdiv1">
			<ul class="u1">
				<li>
					<ul>
						<li><span><a href="./../main/main.jsp">elpmis</a></span></li>
						<li style="font-size: 9px;">COPYRIGHT @ elpmis ALL RIGHTS RESERVED.</li>
						<li>&nbsp;</li>
						<li style="font-size: 9px;">TEL <span style="font-size: 15px;">000-0000-0000</span></li>
						<li style="font-size: 9px;">평일 오후 1:00 ~ 오후 6:00/토.일.공휴일.휴무</li>
						<li>&nbsp;</li>
						<li style="font-size: 9px;">COMPANY 주식회사 elpmis OWNER 3팀</li>
						<li style="font-size: 9px;">ADDRESS 01234 부산광역시 부산진구 부전동 1층 elpmis</li>
						<li style="font-size: 9px;">MASTER 3team E-MAIL <a href="" style="color: rgb(136, 136, 136);"><svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-envelope" viewBox="0 0 18 18"><path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2Zm13 2.383-4.708 2.825L15 11.105V5.383Zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741ZM1 11.105l4.708-2.897L1 5.383v5.722Z"/></svg>
																		 3team@naver.com</a></li>
						<li style="font-size: 9px;">BUSINESS LICENSE 000-00-00000 
						<button id="bt" style="border: 0; font-size: 0.1em; " onclick="window.open('https://ftc.go.kr/www/bizCommList.do?key=232')">사업자정보확인</button></li>
						<li style="font-size: 9px;">MALL-ORDER LICENSE 2022-부산진구-0000호</li>
						<li style="font-size: 9px;">HOSTING By TEAM3 | DESIGNED By TEAM3</li>
					</ul>
				</li>
				<li style="margin-left: 50px;">
					<ul  style="margin-top: 65px;">
						<li style="margin-bottom:6px; "><span style="font-size: 9px;">ACCOUNT INFO</span></li>
						<li style="font-size: 9px;">부산 333-1111-222</li>
						<li style="font-size: 9px;">예금주 : 주식회사 elpmis</li>
					</ul>
				</li>
				<li>
					<ul  style="margin-top: 65px;">
						<li style="margin-bottom:6px; "><span style="font-size: 9px;">WITH US</span></li>
						<li style="font-size: 9px;"><a href="#" style="color: rgb(136, 136, 136);">COMPANY</a></li>
						<li style="font-size: 9px;">AGREEMENT</li>
						<li style="font-size: 9px;">PRIVACY POLICY</li>
						<li style="font-size: 9px;">GUIDE</li>
					</ul>
					<br>
					<ul >
						<li style="margin-bottom:6px; "><span style="font-size: 9px;">SOCIAL NETWORK</span></li>
						<li style="font-size: 9px;"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-facebook" viewBox="0 0 16 16">
  <path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951z"/>
</svg>&nbsp;&nbsp;
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-instagram" viewBox="0 0 16 16">
  <path d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.917 3.917 0 0 0-1.417.923A3.927 3.927 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.916 3.916 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.926 3.926 0 0 0-.923-1.417A3.911 3.911 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0h.003zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599.28.28.453.546.598.92.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.47 2.47 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.478 2.478 0 0 1-.92-.598 2.48 2.48 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233 0-2.136.008-2.388.046-3.231.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92.28-.28.546-.453.92-.598.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045v.002zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92zm-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217zm0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334z"/>
</svg></li>
					</ul>
				</li>
				<li style="border-right:  1px rgba(0, 0, 0, 0.09) solid; margin-left: 80px; height: 235px;">
					&nbsp;<br>
					&nbsp;<br>
					&nbsp;<br>
					&nbsp;<br>
					&nbsp;<br>
					&nbsp;<br>
					&nbsp;<br>
					&nbsp;<br>
					&nbsp;<br>
					&nbsp;<br>
				</li>
				<li>
					<ul>
						<li style="margin-bottom:6px; "><span style="font-size: 9px;">RETURN / EXCHANGE</span></li>
						<li style="font-size: 9px;">654321 부산광역시 부산진구 부전동 cj대한통운 부산지점 부전1팀 'elpmis'</li>
						<li style="font-size: 9px;">(CJ대한통운택배 가상주소로 CJ택배로만 반품가능함)</li>
						<li style="font-size: 9px;">자세한 교환·반품절차 안내는 문의란 및 공지사항을 참고해주세요</li>
						<li style="margin-top:20px; "><a style="color: rgb(136, 136, 136);" href="../customer_service/notice_list.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-mic-fill" viewBox="0 0 16 16">
  <path d="M5 3a3 3 0 0 1 6 0v5a3 3 0 0 1-6 0V3z"/>
  <path d="M3.5 6.5A.5.5 0 0 1 4 7v1a4 4 0 0 0 8 0V7a.5.5 0 0 1 1 0v1a5 5 0 0 1-4.5 4.975V15h3a.5.5 0 0 1 0 1h-7a.5.5 0 0 1 0-1h3v-2.025A5 5 0 0 1 3 8V7a.5.5 0 0 1 .5-.5z"/>
</svg></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														<a style="color: rgb(136, 136, 136);" href="../customer_service/qnaList.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-chat-text-fill" viewBox="0 0 16 16">
  <path d="M16 8c0 3.866-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.584.296-1.925.864-4.181 1.234-.2.032-.352-.176-.273-.362.354-.836.674-1.95.77-2.966C.744 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7zM4.5 5a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1h-7zm0 2.5a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1h-7zm0 2.5a.5.5 0 0 0 0 1h4a.5.5 0 0 0 0-1h-4z"/>
</svg></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														<a style="color: rgb(136, 136, 136);" href="../product/productAllList.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-camera-fill" viewBox="0 0 16 16">
  <path d="M10.5 8.5a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/>
  <path d="M2 4a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2h-1.172a2 2 0 0 1-1.414-.586l-.828-.828A2 2 0 0 0 9.172 2H6.828a2 2 0 0 0-1.414.586l-.828.828A2 2 0 0 1 3.172 4H2zm.5 2a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1zm9 2.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0z"/>
</svg></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														<a style="color: rgb(136, 136, 136);" href="../cart/viewCart.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-credit-card-fill" viewBox="0 0 16 16">
  <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v1H0V4zm0 3v5a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7H0zm3 2h1a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-1a1 1 0 0 1 1-1z"/>
</svg></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														<a style="color: rgb(136, 136, 136);" href="../userPage/userPage.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-tag-fill" viewBox="0 0 16 16">
  <path d="M2 1a1 1 0 0 0-1 1v4.586a1 1 0 0 0 .293.707l7 7a1 1 0 0 0 1.414 0l4.586-4.586a1 1 0 0 0 0-1.414l-7-7A1 1 0 0 0 6.586 1H2zm4 3.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
</svg></a>
						</li>
					</ul>
					
				</li>
				<li>
					<ul>
						<li style="font-size: 10px;">&nbsp;NOTICE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;QnA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;List&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cart&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;My&nbsp;page</li>
						<li>&nbsp;</li>
						<li style="font-size: 9px;">For detailed exchange/return procedures,<br> please refer to the inquiry section and notice.</li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	<br>
</body>
</html>