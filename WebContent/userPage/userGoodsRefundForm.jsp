<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="goods.GoodsBean"%>
<%@page import="buy.UserOrderDetailBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="buy.UserOrderDetailDBBean"%>
<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	int order_detail_number = Integer.parseInt(request.getParameter("order_detail_number"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<!-- 부트스트랩	-0504근지 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<script src="../js/jquery.js"></script>
<script>
	function check(order_detail_number){
	    var refund_reason = document.getElementById('refund_reason').value;
		
		$.ajax({
   			url:"userGoodsRefundOk.jsp",
   			type:"post",
   			data:{"order_detail_number":order_detail_number, "refund_reason":refund_reason},
   			//data:{"search":send,"zipcode":"12345"},
   			//dataType,
   			success:function(data){
   				alert("환불신청이 접수되었습니다.");
   				//document.getElementById("main_stat_point2").innerHTML =data;
   			},
   			error:function(){
   				alert("접수되었습니다.");
   				//document.getElementById("main_stat_point2").innerHTML ="<h3>d fail</h3>";
   			}
   		});

	    window.close();
	} 
</script>
<style>
	#refund_div {
		text-align: center;
		padding-top: 50px;
	}
	
	#refundReasonBtn, #exitBtn {
		padding: 3px 15px 3px 15px;
		background-color: white;
		border-color:#E0E0E0;
		border-radius: 3px;
	}
	#refundReasonBtn:hover, #exitBtn:hover {
		background-color:#E0E0E0;
		border-color:#E0E0E0;
	}
</style>
</head>
<body>
	<div id="refund_div">
		<form method="post" action="userGoodsRefundOk.jsp">
			환불 사유 : 	
			<select id="refund_reason" class="form-select sm">
				<option value="1">배송 지연</option>
				<option value="2">오배송</option>
				<option value="3">제품 하자</option>
				<option value="4">단순 변심</option>
			</select>
			<input type="button" value="환불신청" onclick="check('<%= order_detail_number %>')" id="refundReasonBtn">
			<input type="button" value="닫기" onclick="window.close();" id="exitBtn">
		</form>
	</div>
</body>
</html>