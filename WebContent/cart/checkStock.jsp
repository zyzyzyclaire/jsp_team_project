<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%	
	// 바꾼 수량에 재고가 없을 시 알림창 띄우도록 함 -0420근지

	String user_id = (String)session.getAttribute("user_id");
	
	int product_number = Integer.parseInt(request.getParameter("product_number"));
	int product_count = Integer.parseInt(request.getParameter("product_count"));
	
	CartDBBean cartDb = CartDBBean.getInstance();
	
	GoodsDBBean goodsDb = GoodsDBBean.getInstance();
	GoodsBean goods = goodsDb.getGoods(product_number);
	int stock = goods.getProduct_stock();

	// 재고 수량 확인 - 0420 근지
	if(cartDb.checkStock(product_number, product_count, user_id) == -1) {	// 재고 부족 -0420근지
%>		
		<script>
		alert("재고 부족. 장바구니에 담긴 상품 수량을 확인 후 수량을 다시 선택해주세요.");
		history.back();
		</script>
<%			
	} else {
%>		
		<script>
		history.back();
		</script>
<%			
		
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>