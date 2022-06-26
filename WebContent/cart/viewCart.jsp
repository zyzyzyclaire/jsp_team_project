
<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cart.CartBean"%>
<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.io.File"%>

<%
	String user_id = (String)session.getAttribute("user_id");
	if(user_id == null){
%>	
		<script>
			alert("로그인이 필요한 페이지입니다.");
		</script>
<%
		response.sendRedirect("../login/login.jsp");
	}

	CartDBBean db = CartDBBean.getInstance();
	ArrayList<CartBean> cartArr = db.getCart(user_id);
	
	GoodsDBBean goodsDb = GoodsDBBean.getInstance();
	
%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<jsp:include page="../main/mainHeader.jsp"></jsp:include>
<title>Insert title here</title>
<!-- 부트스트랩	-0426근지 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<script src="../js/jquery.js"></script>
<script type="text/javascript">
	
	function deleteCart(cart_number) { 
		if(confirm("해당 상품을 장바구니에서 삭제하시겠습니까?")){ 
			location.href = "deleteCart.jsp?cart_number="+cart_number; 
		} 
	} 
	
	function editCart(i) { 
		var count = $('#product_count'+i).val();
		var pnum = $('#product_number'+i).val();
		var cnum = $('#cart_number'+i).val();
		
		if(confirm("해당 상품을 수정하시겠습니까?")){
			
			if(count <= 0) {
				alert("상품 수량을 선택해주세요.");
			} else {
				location.href="editCart.jsp?product_count="+count+"&product_number="+pnum+"&cart_number="+cnum;
			}
		} else {
			return false;
		}
	} 
	
	function checkForm() {
		if($("input:checkbox[name='cart_num_arr']").is(":checked") == true) {
			document.cart_frm.submit();
		} else {
			alert("한 가지 이상 선택해주세요.");
			return false;
		}
	}
</script>
<style>
	.body{
		min-width: 1100px;
		max-width: 1280px;
		margin: 0 auto;
	
	
		font-size:11px;
		font-family: "Nanum Gothic","Malgun Gothic","맑은 고딕","돋움","Dotum","Apple Gothic","Apple SD Gothic Neo",sans-serif;
 	}
 	.cart_h2 {
		font-size:12px;
		margin-top: 3%;
	}
	#table {
		border-top: 1px solid black;
	}

	#row1 {
		width: 100px;
	}
	#row1, #row2, #row3, #row4, #row5, #row6, #row7, #row8 {
		text-align: center;
		height: 100px;
	}
	#row1, #row3, #row4, #row5, #row6, #row7, #row8 {
		padding-top: 40px;
	}
	#editBtn {
		padding: 2px 5px 2px 5px;
		background-color: white;
		border-color:#E0E0E0;
		border-radius: 3px;
	}
	#editBtn:hover {
		background-color:#E0E0E0;
		border-color:#E0E0E0;
		border-radius: 3px;
	}
	#delBtn {
		padding: 3px 15px 3px 15px;
		background-color: white;
		border-color:#E0E0E0;
		border-radius: 3px;
	}
	#delBtn:hover {
		background-color:#E0E0E0;
		border-color:#E0E0E0;
	}
	.buyImg {
		width: 80px;
		height: 80px;
	}
	.blank {
		height: 30px;
	}
	.buyBtnClass {
		text-align:center;
		border:0;
	}
	#buyBtn {
		padding: 13px 40px 13px 40px;
		background-color: #404040;
		border-color: #404040;
		border-radius: 5px;
		color: white;
		font-weight: bold;
		font-size: 12px;		
	}
	#buyBtn:hover {
		background-color:white;
		color:black;
		border-color: #E0E0E0;
	}
</style>
</head>
<body class="body">

    

	<h2 class="cart_h2"><%= user_id %>님의 장바구니</h2>
		<table class="table" id="table">
			<tr align="center">
				<td>체크</td>
				<td id="tdImg">이미지</td>
				<td>상품정보</td>
				<td>판매가</td>
				<td>수량</td>
				<td>배송비</td>
				<td>합계</td>
				<td>선택</td>
			</tr>	
		<%
			// 장바구니가 비었다면	-0419 근지
			if(cartArr.size()==0) {
		%>
				<script>
					alert("장바구니가 비었습니다.");
					location.href="../main/main.jsp";
				</script>
		<%
			}
		%>	
			<form method="post" action="../buy/buyFromCart.jsp" name="cart_frm">
		<%
			// 장바구니 출력 -0419 근지
			int total_price = 0;
			for(int i=0; i<cartArr.size(); i++) {
				CartBean cart = cartArr.get(i);
				GoodsBean goods = goodsDb.getGoods(cart.getProduct_number());
				//System.out.println("@@@cart@"+cart.getCart_number());
				
				int cart_number = cart.getCart_number();
				int product_number = cart.getProduct_number();
				
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
				<input type="hidden" name="cart_number" value="<%= cart_number %>" id="cart_number<%=i%>">
				<input type="hidden" name="product_number" value="<%= product_number %>" id="product_number<%=i%>">
					<tr>
						<td id="row1">
							<input type="checkbox" name="cart_num_arr" value="<%= cart_number %>">
						</td>
						<td id="row2" width="200">
							<%if(isExists){%>
								<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_name%>"  alt="이미지없음" class="buyImg">
							<%}else{%>
								<img src="../images/products/noimg.PNG"  alt="이미지없음"  class="buyImg">
							<%}%>
						</td>
						<td id="row3">
							<%= goods.getProduct_name() %>
						</td>
						<td id="row4">
							<%= goods.getProduct_price() %> won
						</td>
						<td id="row5">
							<input type="text" name="product_count" value="<%= cart.getProduct_count() %>" id="product_count<%=i%>" maxlength="1" size="1">
							<input type="button" value="변경" onclick="editCart(<%=i%>)" id="editBtn">
						</td>
						<td id="row6">
							[무료]
						</td>
						<td id="row7">
							<%= goods.getProduct_price()*cart.getProduct_count() %>
						</td>
						<td id="row8">
							<input type="button" value="삭제" onclick="deleteCart('<%= cart_number %>')" id="delBtn">
						</td>
					</tr>
		<%
					total_price += goods.getProduct_price()*cart.getProduct_count();
			}
		%>
				<tr>
					<td colspan="2">[기본배송]</td>
					<td colspan="6" align="right">
						상품구매금액&nbsp;<%= total_price %>&nbsp;+&nbsp;배송비&nbsp;0&nbsp;(무료)&nbsp;=&nbsp;합계&nbsp;:<strong>&nbsp;&nbsp;&nbsp;<%= total_price %> won</strong>
					</td>
				</tr>
				<tr class="blank"></tr>
				<tr class="buyBtnClass">
					<td colspan="8">
						<input type="button" value="선택상품주문" onclick="checkForm()" id="buyBtn">
					</td>
				</tr>
			</form>
		</table>
		
		<div style=" width: 150%; margin-left: -300px">
		<jsp:include page="../main/mainfooter.jsp"></jsp:include>
		</div>
	
</body>
</html>