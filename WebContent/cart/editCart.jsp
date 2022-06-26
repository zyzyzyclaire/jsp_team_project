<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%	
	String user_id = (String)session.getAttribute("user_id");
	int cart_number = Integer.parseInt(request.getParameter("cart_number"));
	int product_count = Integer.parseInt(request.getParameter("product_count"));
	int product_number = Integer.parseInt(request.getParameter("product_number"));
	
	System.out.println("cart_number@@@###===>"+cart_number);
	System.out.println("product_count@@@###===>"+product_count);
	System.out.println("product_number@@@###===>"+product_number);
	
	CartDBBean db = CartDBBean.getInstance();
	
	if(product_count <= 0) {	// 수량을 잘못 기입시
%>		
		<script>
		alert("올바른 상품 수량을 선택해주세요.");
		history.back();
		</script>
<%		
	}
	
	// 재고 수량 확인 - 0420 근지
	else if(db.checkStockEdit(product_number, product_count) == -1) {	// 재고 부족 -0420근지
%>		
		<script>
		alert("재고 부족. 상품 수량을 다시 선택해주세요.");
		history.back();
		</script>
<%		
		} else {	// 재고 여유 -0420근지

		if(db.editCart(cart_number, product_count)==1) {
%>
			<script>
				alert("수정 되었습니다.");
				location.href="viewCart.jsp";
			</script>
<%
		} else {
%>
			<script>
				alert("수정 실패");
				history.go(-1);
			</script>
<%
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