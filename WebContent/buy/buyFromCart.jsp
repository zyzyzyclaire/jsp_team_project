
<%@page import="java.util.ArrayList"%>
<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="cart.CartDBBean"%>
<%@page import="cart.CartBean"%>
<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>

<%
	

	// 주소 받아올 때 한글 깨지지 않기 위해 -0421근지
	request.setCharacterEncoding("UTF-8");
%>
<%
	String[] cart_num_arr = request.getParameterValues("cart_num_arr");
	
	String user_id = (String)session.getAttribute("user_id");
	
	UserDBBean userDb = UserDBBean.getInstance();
	UserBean user = userDb.getUser(user_id);
	
	CartDBBean cartDb = CartDBBean.getInstance();
	CartBean cart = null;
	
	GoodsDBBean goodsDb = GoodsDBBean.getInstance();
	GoodsBean goods = null;

%>
<jsp:include page="../main/mainHeader.jsp"></jsp:include> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  
<title>Insert title here</title>
<!-- 부트스트랩	-0426근지 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

	<script src="../js/jquery.js"></script>
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
		document.buy_frm.receiver_addr.value = addr;
	}
	
	$(function () {
		$("#check").change(function() {
			if($("#check").is(":checked")) {
				document.getElementById("re_name").value = "<%= user.getUser_name() %>";
				document.getElementById("re_phone").value = "<%= user.getUser_phone() %>";
				document.getElementById("re_addr").value = "<%= user.getUser_addr() %>";
			} else {
				document.getElementById("re_name").value = null;
				document.getElementById("re_phone").value = null;
				document.getElementById("re_addr").value = null;
			}
		});
	});
	
	// 입력값 체크 -0503근지
	function buyFromCart_check_ok(){
		if(document.buy_frm.receiver_name.value.length == 0){
			alert("이름을 써주세요.");
			document.buy_frm.receiver_name.focus();
			return;
		}
		
		if(document.buy_frm.receiver_phone.value.length == 0){
			alert("휴대폰번호를 써주세요.");
			document.buy_frm.receiver_phone.focus();
			return;
		}
		
		if(document.buy_frm.receiver_addr.value.length == 0){
			alert("주소를 써주세요.");
			document.buy_frm.receiver_addr.focus();
			return;
		}
		// 유효성 체크	-0503근지
	    var phone_RegExp = /01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}/;
	    if(!phone_RegExp.test(buy_frm.receiver_phone.value)) {
	        alert('휴대폰 형식이 잘못되었습니다.');
	        buy_frm.receiver_phone.focus();
			return;
	    }
	    
		document.buy_frm.submit();
	}
	
	</script>
	
<link rel="stylesheet" href="../css/buy.css" type = "text/css">	
</head>
<body class="buyBody" style="margin-top: 0px;">

    
<%

%>
	<h1 class="buyH1">주문서 작성</h1>
		<form action="buyOkFromCart.jsp" name="buy_frm" >

				<table class="table" id="buyTable1">
					<h2 class="buyH2">주문 내역</h2>
						<tr align="center">
							<td>이미지</td>
							<td>상품정보</td>
							<td>판매가</td>
							<td>수량</td>
							<td>배송비</td>
							<td>합계</td>
						</tr>
			<%			
			int total_price = 0;
						for(int i=0; i<cart_num_arr.length; i++) {
							cart = cartDb.getCart_one(Integer.parseInt(cart_num_arr[i]));
							goods = goodsDb.getGoods(cart.getProduct_number());
							
							//상품세부이미지까지불러오기
							ArrayList<GoodsBean> getGoodsimg = goodsDb.getGoodsimg(cart.getProduct_number());
							String stored_file_name = getGoodsimg.get(0).getStored_file_name();
							//System.out.println("@@@@@@"+stored_file_name);
							String path = request.getRealPath("upload");
							File file = new File(path+"\\"+stored_file_name);
							boolean isExists = file.exists();
							/* if(isExists) { System.out.println("I find the existFile.txt"); } 
							else { System.out.println("No, there is not a no file."); } */
							
			%>			
						<!-- 값 넘기기 위해. 나중에 해당 체크박스는 css로 보이지 않게 설정하기	-0425근지 -->
						<div width=0 height=0 style="visibility:hidden">
						<input type="checkbox" value="<%= cart_num_arr[i] %>" name="cart_num_arr" checked onclick="return false;">
						</div>
						
							<tr>
								<td id="buyRow1_1" width="200">
									<%if(isExists){%>
										<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_name%>"  alt="이미지없음" class="buyImg">
									<%}else{%>
										<img src="../images/products/noimg.PNG"  alt="이미지없음"  class="buyImg">
									<%}%>
								</td>							
								<td id="buyRow1_2"><%= goods.getProduct_name() %></td>
								<td id="buyRow1_3"><%= goods.getProduct_price() %> won</td>								
								<td id="buyRow1_4"><%= cart.getProduct_count() %></td>
								<td id="buyRow1_5">[무료]</td>
								<td id="buyRow1_6"><%= goods.getProduct_price()*cart.getProduct_count() %> won</td>
			<%
								total_price += goods.getProduct_price()*cart.getProduct_count();
			
						}
						
			%>				
					<input type="hidden" name="total_price" value="<%=total_price%>">
							</tr>
							<tr>
								<td>[기본배송]</td>
								<td colspan="5" align="right">
									상품구매금액&nbsp;<%= total_price %>&nbsp;+&nbsp;배송비&nbsp;0&nbsp;(무료)&nbsp;=&nbsp;합계&nbsp;:<strong>&nbsp;&nbsp;&nbsp;<%= total_price %> won</strong>
								</td>
							</tr>	
				</table>
				<div class="buyBlank1"></div>
				<table class="table">
					<h2 class="buyH2">배송 정보</h2>
						<tr>
							<td colspan="2" align="right">
								<input type="checkbox" id="check">&nbsp;회원정보와 동일
							</td>
						</tr>
						<tr>
							<td id="buyRow2_1">이름</td>
							<td><input type="text" name="receiver_name" id="re_name" class="form-control" placeholder="이름을 입력해주세요."></td>
						</tr>
						<tr>
							<td id="buyRow2_2">휴대폰 번호</td>
							<td><input type="text" name="receiver_phone" id="re_phone" class="form-control" placeholder="( 하이픈'-' 포함 입력 )"></td>
						</tr>
						<tr>
							<td id="buyRow2_3">주소</td>
							<td><input type="text" name="receiver_addr" id="re_addr" class="form-control" placeholder="(클릭하여 주소 입력)" onclick="goPopup()"></td>
						</tr>
						<tr class="buyBlank2"></tr>
						<tr class="buyBtnClass">
							<td colspan="2">
								<input type="button" value="주문하기" id="buyBtn" onclick="buyFromCart_check_ok()">
							</td>
						</tr>
				</table>
		</form>
		<div style=" width: 150%; margin-left: -300px">
		<jsp:include page="../main/mainfooter.jsp"></jsp:include>
		</div>
</body>
</html>