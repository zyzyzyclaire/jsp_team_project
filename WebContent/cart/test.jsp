<%@page import="goods.GoodsDBBean"%>
<%@page import="goods.GoodsBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String user_id = (String)session.getAttribute("user_id");
	int product_number = Integer.parseInt(request.getParameter("product_number"));	

	GoodsDBBean db = GoodsDBBean.getInstance();
	GoodsBean goods = db.getGoods(product_number);
	String product_name = goods.getProduct_name();
	int product_price = goods.getProduct_price();
	int product_stock = goods.getProduct_stock();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Mukta:300,400,700"> 
    <link rel="stylesheet" href="fonts/icomoon/style.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/magnific-popup.css">
    <link rel="stylesheet" href="../css/jquery-ui.css">
    <link rel="stylesheet" href="../css/owl.carousel.min.css">
    <link rel="stylesheet" href="../css/owl.theme.default.min.css">
    <link rel="stylesheet" href="../css/aos.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/custom2.css">

<script type="text/javascript">

	function cartProcess(product_name) {
		if(confirm(product_name+" 을/를 장바구니에 담으시겠습니까?")) { 
			document.cart_frm.submit();
		}
	} 
	
	function viewCart(user_id) { 
		if(confirm("장바구니를 보시겠습니까?")){ 
			location.href = "viewCart.jsp"; 
		} 
	} 
</script>

</head>
<body>
	<div class="border d-flex justify-content-center" id="hearder_title"> 
		<div class="header_title" >
	    	<h1><strong>shopping mall</strong></h1>
	    </div>
	</div>
	<br>
	<div style="margin:auto; text-align:center;">
	<h1><label for="floatingInput">상품 상세 페이지</label></h1>
	<div class="card" style="width: 27rem; margin:auto; text-align:center;">
	  <img src="../images/serverimgs/pic_8.jpg" class="card-img-top">
	  	<div class="card-body">
		    <h5 class="card-title"><label><%= user_id %>님</label> </h5>
			    <p class="card-text">상품명 :  <%= product_name %> </p>
			    <p class="card-text">상품 가격 :  <%= product_price %> $</p>
	 	</div>
	  <ul class="list-group list-group-flush">
	    <li class="list-group-item">상품 번호 : <%= product_number %></li>
	    <li class="list-group-item">상품 재고 : <%=product_stock %> 개</li>
	  </ul>
	  	<div class="card-body">
	    	<form method="post" action="cartProcess.jsp" name="cart_frm">
				<input type="hidden" name="product_number" value="<%=product_number%>">
		  장바구니 담을 수량 선택 : <select name="product_count">
						<option value="1" selected>1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				<input type="submit" value="장바구니 담기" onclick="cartProcess('<%=product_name%>')" class="btn btn-outline-dark">
			</form>
	    		<input type="button" value="장바구니 보기" onclick="viewCart()" class="btn btn-outline-dark">
	  	</div>
	</div>
	</div>
</body>
</html>