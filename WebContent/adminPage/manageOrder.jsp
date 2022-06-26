<%@page import="buy.UserOrderDBBean"%>
<%@page import="buy.UserOrderBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="buy.UserOrderDetailBean"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="buy.UserOrderDetailDBBean"%>
<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file= "../main/mainClass.jsp"%>  
<!DOCTYPE html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">

.div2 div{
	border-bottom: 1px solid rgba(0, 0, 0, 0.09);
}
.usersBuyGoodsdiv{
clear:both;

	margin:auto;
	min-width : 1120px;	
	max-width : 1280px;	
	font-size: 12px;
}
.userBuyGoods{
	margin-top: 50px;
}
.userBuyGoods img{

	width: 80px;
	height: 80px;
}
</style>
</head>
<link rel="stylesheet" href="../css/nav.css" type = "text/css">
<body>
<%
	 
	if(((String)session.getAttribute("user_id")) != null){
		 user_id  = (String)session.getAttribute("user_id");
		 UserDBBean udb =  UserDBBean.getInstance();
		 UserBean ubean = udb.getUser(user_id);
	  	 user_name = ubean.getUser_name();
	  	
	  	 user_grade = ubean.getUser_grade();
	}	else{
		response.sendRedirect("../login/login.jsp");
	} 	
%>




<nav class="nav2" >
		<nav style="--bs-breadcrumb-divider: '>'; font-size: 10px;" aria-label="breadcrumb" class="nav2div">
		  <ul class="breadcrumb ">
		    <li class="breadcrumb-item"><a href="../main/main.jsp">home</a></li>
		    <li class="breadcrumb-item active" aria-current="page">OrderList</li>
		  </ul>
		</nav>
		
		<br><br><br>
		<div style="width:900px; padding-right: 700px; text-align: left;">
		<p>
		<h2>Orders&nbsp;Management</h2>
		</p>
		</div>	

<div class="usersBuyGoodsdiv">
	<table class="table table-hover userBuyGoods">
		  <thead>
		    <tr>
	    		<th>#</th>
				<th>주문일자</th>
				<th>주문번호</th>
				<th>회원이름</th>
				<th>이미지</th>
				<th>상품이름</th>
				<th>수량</th>
				<th>상품구매금액</th>
				<th>주문처리상태</th>
				<th>환불처리</th>
				
		    </tr>
		  </thead>
	  <tbody>
	
	 
	
	<% 
		UserOrderDetailDBBean UODBB =  UserOrderDetailDBBean.getInstance();
		UserOrderDBBean uodbb = UserOrderDBBean.getInstance();
		UserOrderBean uob = null;
		ArrayList<UserOrderDetailBean> getUserOrderDetail = UODBB.getAllUserOrderDetail();
		GoodsDBBean goodsdb =GoodsDBBean.getInstance();
		GoodsBean goods	= null;
		
		  
		
		System.out.println("@@@@@크기는@@"+getUserOrderDetail.size());
		for(int i =0; i<getUserOrderDetail.size(); i++){
			
			order_detail_number =  getUserOrderDetail.get(i).getOrder_detail_number();
			order_number =  getUserOrderDetail.get(i).getOrder_number();
			product_number =  getUserOrderDetail.get(i).getProduct_number();
			product_count =  getUserOrderDetail.get(i).getProduct_count();
			product_price =  getUserOrderDetail.get(i).getProduct_price();
			order_detail_status =  getUserOrderDetail.get(i).getOrder_detail_status();	
			int re = UODBB.getUserRefundCheck(order_detail_number);
			goods = goodsdb.getGoods(product_number);
			order_number = getUserOrderDetail.get(i).getOrder_number();
			refund_check = getUserOrderDetail.get(i).getRefund_check();
			product_name = goods.getProduct_name();
			SimpleDateFormat DtFormat = new SimpleDateFormat("yyyy-MM-dd");
			uob = uodbb.getUserOrder(order_number);
			String order_name = uob.getUser_id();
			Timestamp order_date = uob.getOrder_date();
			String strDtFormat = DtFormat.format(order_date); 
			ArrayList<GoodsBean> getGoodsimg = goodsdb.getGoodsimg(product_number);
			
			stored_file_name = getGoodsimg.get(0).getStored_file_name();
			//System.out.println("포맷 후 : " + strNewDtFormat);
	
	
	
	%>			
		    <tr style="cursor:pointer; line-height: 80px;" onclick="location.href='../userPage/userGoodsRefund.jsp?order_detail_number=<%=order_detail_number%>'">
		      <th scope="row"><%=i+1%></th>
		      <td><%= strDtFormat%></td>
		      <td><%= order_number%></td>
		      <td><%= order_name%></td>
		      <td><img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%= stored_file_name%>"></td>
		      <td><%= product_name%></td>
		      <td><%=product_count%></td>
		      <td> <%=product_price %></td>
		      <td> <%=order_detail_status %></td>
		      <td><input type="checkbox"  id="checkbox<%=i%>" disabled="disabled"></td>
		    </tr>	
	<%
		    if(re == 1){
	%>		
				<script>
				  $('#checkbox<%=i%>').prop("checked", true);
				</script>
	<%
			}else{
	%>
				<script>
					$('#checkbox<%=i%>').prop("checked", false);
				 //document.getElementById("checkbox<%=i%>").checked = false;
				</script>
	<%			
			}
		}	
	%>
	    
	  </tbody>
	</table>
</div>

</body>
</html>