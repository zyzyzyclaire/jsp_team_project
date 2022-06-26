<%@page import="java.sql.Timestamp"%>
<%@page import="buy.UserOrderDetailDBBean"%>
<%@page import="buy.UserOrderDetailBean"%>
<%@page import="buy.UserOrderDBBean"%>
<%@page import="buy.UserOrderBean"%>
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
	System.out.println("@@@@들어오냐 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ");
	String name = request.getParameter("name");
	System.out.println("@@@@"+name);
		if(request.getParameter("order_number")!=null){
			String[] cart_num_arr = request.getParameterValues("cart_num_arr");
			for(int i = 0; i<cart_num_arr.length; i++){
				System.out.println("@@@cart_num_arr@@"+cart_num_arr[i]);
			}
			
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
			int total_price = Integer.parseInt(request.getParameter("total_price")); 
			
			userOrder.setOrder_number(order_number);
			userOrder.setUser_id(user_id);
			userOrder.setOrder_date(order_date);
			userOrder.setReceiver_addr(receiver_addr);
			userOrder.setReceiver_name(receiver_name);
			userOrder.setReceiver_phone(receiver_phone);
			
		%>
	
		<%
			if(order_db.insertUserOrder(userOrder) == 1 && detail_db.insertUserOrderDetailArray(cart_num_arr, order_number) == 1) {
	 	%>		
	 		<script type="text/javascript">
			alert("주문 성공. 입금 후 발송이 시작됩니다.");
			location.href="../main/main.jsp";
			</script>
	 	<%
	 		} else {
	 	%>
	 			<script type="text/javascript">
				alert("주문 오류. 다시 시도해주세요.");
				location.href="../main/main.jsp";
				</script>
	 				
	 	<%	
	 		}
		}
 	%>

</body>
</html>