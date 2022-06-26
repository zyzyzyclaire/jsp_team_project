<%@page import="buy.UserOrderDetailBean"%>
<%@page import="buy.UserOrderDetailDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	int order_detail_number =  Integer.parseInt( request.getParameter("order_detail_number"));
	String refund_reason = request.getParameter("refund_reason");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
			UserOrderDetailDBBean uodb = UserOrderDetailDBBean.getInstance();
			UserOrderDetailBean ubean = new UserOrderDetailBean();	
			ubean.setOrder_detail_number(order_detail_number);
			ubean.setRefund_reason(refund_reason);
			ubean.setRefund_img("이미지없음");
			ubean.setUser_email("이메일없음");
			int re = uodb.goodsRefundRequest(ubean);
			System.out.println("환불신청상태"+re);	
	%>
</body>
</html>