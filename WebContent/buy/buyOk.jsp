<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="buy.UserOrderDetailDBBean"%>
<%@page import="buy.UserOrderDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 주소 받아올 때 한글 깨지지 않기 위해 -0421근지
	request.setCharacterEncoding("UTF-8");
%>   
<jsp:useBean id="userOrder" class="buy.UserOrderBean"/>
<jsp:setProperty property="*" name="userOrder"/>
<jsp:useBean id="userOrderDetail" class="buy.UserOrderDetailBean"/>
<jsp:setProperty property="*" name="userOrderDetail"/>
<%
	// buy.jsp에서 submit할 때 건너오지 않은 값들 세팅(UserOrder용) -0422근지
	String user_id = (String)session.getAttribute("user_id");
	userOrder.setUser_id(user_id);
	Timestamp now = new Timestamp(System.currentTimeMillis());
	userOrder.setOrder_date(now);
%>
<!DOCTYPE html>



  
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		UserOrderDBBean order_db = UserOrderDBBean.getInstance();
	
		UserOrderDetailDBBean detail_db = UserOrderDetailDBBean.getInstance();
		GoodsDBBean goods_db = GoodsDBBean.getInstance();
		
		// order_number값 찾기 -0425근지
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		String time = sdf.format(now);
		String order_number = time+"_"+user_id;
		userOrderDetail.setOrder_number(order_number);
		System.out.println("@@@@"+order_number);
		int total_price = Integer.parseInt( request.getParameter("total_price"));
		
		// product테이블의 product_ordered_count(구매개수) 증가	-0429근지
		/* userOrderDetail.getProduct_number() */
		 GoodsBean goods = goods_db.getGoods(userOrderDetail.getProduct_number());
		 
	%>

	

   

	
	<%
		goods_db.orderedCountUp(userOrderDetail.getProduct_count(), userOrderDetail.getProduct_number());
	%>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
		<script>
   
    	 var IMP = window.IMP; // 생략가능
    	 IMP.init('imp92375061');
       //IMP.request_pay(param, callback) 
          IMP.request_pay({ // param
          pg: "kakao",
          pay_method: "card",
          merchant_uid: "<%=order_number%>",
       
          name: "<%= userOrder.getReceiver_name()%>",
          amount: <%=total_price%>, //가격
          buyer_email: "gildong@gmail.com",
          buyer_name: "홍길동",
          buyer_tel: "010-4242-4242",
          buyer_addr: "서울특별시 강남구 신사동",
          buyer_postcode: "01181"
      }, function (rsp) { // callback
          if (rsp.success) {
	        	  	
        		$.ajax({
		    		  
	  	            url: "buyOKajax.jsp", 
	  	            type:"post",
	  	            data:{
	  	            	  "order_number":"<%=order_number%>"
						  ,"order_date":"<%=userOrder.getOrder_date()%>"
						  ,"receiver_addr":"<%=userOrder.getReceiver_addr()%>"
						  ,"receiver_name":"<%=userOrder.getReceiver_name()%>"
						  ,"receiver_phone":"<%=userOrder.getReceiver_phone()%>"
						  ,"product_number":"<%=userOrderDetail.getProduct_number()%>"
						  ,"product_count":"<%=userOrderDetail.getProduct_count()%>"
						  ,"product_price":"<%=userOrderDetail.getProduct_price()%>"  
	  	            },
	  	            success:function(data){	
	  	            	alert("주문 성공. 입금 후 발송이 시작됩니다.");
  	  					location.href="../main/main.jsp";
	  	 			},
	  	 			error:function(){
	  	 				alert("결제성공 주문 오류. 다시 시도해주세요.");
	  	 				location.href="../main/main.jsp";
	  	 			}
	  	            
	  	        }); 
					
					
				} else {
					alert("결제오류")
					location.href="../main/main.jsp";
          	   }
      	});
   		</script>
</body>
</html>