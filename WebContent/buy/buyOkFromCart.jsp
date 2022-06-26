<%@page import="goods.GoodsDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="buy.UserOrderDetailDBBean"%>
<%@page import="buy.UserOrderDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 주소 받아올 때 한글 깨지지 않기 위해 -0421근지
	request.setCharacterEncoding("UTF-8");

	String total_price = request.getParameter("total_price");
	
%>
<jsp:useBean id="userOrder" class="buy.UserOrderBean"/>
<jsp:setProperty property="*" name="userOrder"/>
<%
	// buyFromCart.jsp에서 submit할 때 건너오지 않은 값들 세팅(UserOrder용) -0422근지
	String user_id = (String)session.getAttribute("user_id");
	userOrder.setUser_id(user_id);
	
	Timestamp now = new Timestamp(System.currentTimeMillis());
	userOrder.setOrder_date(now);
%>
<%
	// 값을 메서드를 통해 세팅(UserOrderDetail용) -0425근지
	
	UserOrderDBBean order_db = UserOrderDBBean.getInstance();
	UserOrderDetailDBBean detail_db = UserOrderDetailDBBean.getInstance();
	GoodsDBBean goods_db = GoodsDBBean.getInstance();

	// order_number값 찾기 -0425근지
	SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
	String time = sdf.format(now);
	String order_number = time+"_"+user_id;
	System.out.println("@@order_number@@"+order_number);
	
	
	// cart_number 배열 받기 -0425근지
	String[] cart_num_arr = request.getParameterValues("cart_num_arr");
	
	// product테이블의 product_ordered_count(구매개수) 증가	-0429근지
	goods_db.orderedCountUpArray(cart_num_arr);
	
	String str = "buyOkFromajax.jsp?";
	for(int i=0; i<cart_num_arr.length; i++){
		str +="&cart_num_arr="+cart_num_arr[i];
	}
	
		 
	String order_date = String.valueOf(userOrder.getOrder_date());
	String receiver_addr = userOrder.getReceiver_addr();
	String receiver_name = userOrder.getReceiver_name();
	String receiver_phone = userOrder.getReceiver_phone();
	str +="&order_number="+order_number+"&order_date="+order_date+"&receiver_addr="+receiver_addr;
	str +="&receiver_name="+receiver_name+"&receiver_phone="+receiver_phone+"&total_price="+total_price;
	System.out.println("@@@@"+str);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
       
          name: "상품들<%=order_number%>",
          amount: <%=total_price%>, //가격
          buyer_email: "gildong@gmail.com",
          buyer_name: "홍길동",
          buyer_tel: "010-4242-4242",
          buyer_addr: "서울특별시 강남구 신사동",
          buyer_postcode: "01181"
      }, function (rsp) { // callback
          if (rsp.success) {
        	 
        	   location.href="<%=str%>";
        	 <%--   $.ajax({  
	  	            url: "buyOkFromajax.jsp", 
	  	            type:"post",
	  	            data:{
	  	            	  "name":"name1"
	  	            },
	  	            success:function(data){	
	  	              	alert("<%=str%>");  
					 	location.href="<%=str%>";
	  	 			},
	  	 			error:function(){
	  	 				alert("@@@@주문 오류. 다시 시도해주세요.");
	  	 				location.href="../main/main.jsp";
	  	 			} 
	  	            
	  	       	 });  
         --%>
        	 
        	 /* 	alert("결제성공 from"); */
					
				} else {
					
					alert("실패"); 
					location.href="../main/main.jsp";
					
          	   }
      	});
   		</script>
   		
   			
		
</body>
</html>