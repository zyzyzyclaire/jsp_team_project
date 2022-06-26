
<%@page import="buy.UserOrderDetailDBBean"%>
<%@page import="buy.UserOrderDBBean"%>
<%@page import="buy.UserOrderDetailBean"%>
<%@page import="buy.UserOrderBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
	String user_id = (String)session.getAttribute("user_id");
	UserOrderBean userOrder = new UserOrderBean();
	UserOrderDBBean order_db = new UserOrderDBBean();
	UserOrderDetailBean userOrderDetail = new UserOrderDetailBean();
	UserOrderDetailDBBean  detail_db = new  UserOrderDetailDBBean();
	 	String order_number = request.getParameter("order_number");
		Timestamp order_date = Timestamp.valueOf( request.getParameter("order_date"));
		String receiver_addr = request.getParameter("receiver_addr");
		String receiver_name = request.getParameter("receiver_name");
		String receiver_phone = request.getParameter("receiver_phone");
		int product_number = Integer.parseInt( request.getParameter("product_number"));
		int product_count = Integer.parseInt(request.getParameter("product_count"));
		int product_price = Integer.parseInt(request.getParameter("product_price")); 
		
		userOrder.setOrder_number(order_number);
		userOrder.setUser_id(user_id);
		userOrder.setOrder_date(order_date);
		userOrder.setReceiver_addr(receiver_addr);
		userOrder.setReceiver_name(receiver_name);
		userOrder.setReceiver_phone(receiver_phone);
		userOrderDetail.setOrder_number(order_number);
		userOrderDetail.setProduct_number(product_number);
		userOrderDetail.setProduct_count(product_count);
		userOrderDetail.setProduct_price(product_price);
%>

		
   	  <%
		if(order_db.insertUserOrder(userOrder) == 1 && detail_db.insertUserOrderDetail(userOrderDetail) == 1) {
		%>
		<script type="text/javascript">
			
		</script>
		<%
			} else {
		%>
		<script type="text/javascript">
			
		</script>
		<%	
			}
		%> 
		
		
		
</body>
</html>