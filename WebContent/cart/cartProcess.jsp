<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String user_id = null;
	
	int product_number = Integer.parseInt(request.getParameter("product_number"));
	int product_count = Integer.parseInt(request.getParameter("product_count"));
	
	CartDBBean cartDb = CartDBBean.getInstance();
	
	GoodsDBBean goodsDb = GoodsDBBean.getInstance();
	GoodsBean goods = goodsDb.getGoods(product_number);
	int stock = goods.getProduct_stock();

	// 회원이 아닐 때는 장바구니 등록이 불가능함 - 0418 근지
	if(session.getAttribute("user_id")==null) {
%>
		<script>
			alert("회원만 장바구니 등록이 가능합니다.");
			location.href="../login/login.jsp";
		</script>
<%	
	} else {	// 회원일 때 - 0420 근지
		user_id = (String)session.getAttribute("user_id");
		
		// 재고 수량 확인 - 0420 근지
		if(cartDb.checkStock(product_number, product_count, user_id) == -1) {	// 재고 부족 -0420근지
%>		
			<script>
			alert("재고 부족. 장바구니에 담긴 상품 수량을 확인 후 수량을 다시 선택해주세요.");
			history.back();
			</script>
<%			
		} else {
	
			// 장바구니에 저장	-0419 근지
			if(cartDb.insertCart(user_id, product_number, product_count) == -1) {
%>		
				<script>
				alert("장바구니 저장 실패");
				history.back();
				</script>
<%
			} else {
%>
				<script>
				alert("장바구니 저장 완료");
				history.back();
				</script>
<%	
			}
		}
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