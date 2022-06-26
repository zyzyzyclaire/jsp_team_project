
<%@page import="notice.QnABean"%>
<%@page import="notice.QnADBBean"%>
<%@page import="java.util.Date"%>
<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@page import="buy.UserOrderDetailBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="buy.UserOrderDetailDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="goods.GoodsBean"%>
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

<script src="../js/jquery.js"></script>
<script type="text/javascript">

/*	
	function refund(order_detail_number) {
		if(confirm("환불신청하시겠습니까?")){
			$.ajax({
	   			url:"./userGoodsRefundOk.jsp",
	   			type:"post",
	   			data:{"order_detail_number":order_detail_number},
	   			//data:{"search":send,"zipcode":"12345"},
	   			//dataType,
	   			success:function(data){
	   				alert("환불신청이 접수되었습니다.");
	   				//document.getElementById("main_stat_point2").innerHTML =data;
	   			},
	   			error:function(){
	   				alert("실패");
	   				//document.getElementById("main_stat_point2").innerHTML ="<h3>d fail</h3>";
	   			}
	   		});
		}
	}
*/	
	function showPopUp(order_detail_number) { 
		
		//창 크기 지정
		var width = 500; 
		var height = 300; 
		//pc화면기준 가운데 정렬 
		var left = (window.screen.width/2) - (width/2); var top = (window.screen.height / 4); 
		//윈도우 속성 지정 
		var windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+', scrollbars=yes, status=yes, resizable=yes, titlebar=yes'
		var url="userGoodsRefundForm.jsp?order_detail_number="+order_detail_number;
        window.open(url,"",windowStatus);
    }

</script>

<style type="text/css">
.mypage{
	margin:auto;
	min-width : 1120px;	
	max-width : 1280px;	
}
.divs{
	 width: 500px;
	 margin-left: 170px;
	 line-height: 40px;
}

.div2 div{
	border-bottom: 1px solid rgba(0, 0, 0, 0.09);
}
.userBuyGoodsdiv{
	clear:both;

	margin:auto;
	min-width : 1120px;	
	max-width : 1280px;	
}
.userBuyGoods{
	margin-top: 50px;
}
.userBuyGoods img{

	width: 80px;
	height: 80px;
}


#table_cus {
	margin-bottom: 150px;
}

#orderList1, #orderList2, #orderList3, #orderList4, #orderList5, #orderList6, #orderList7, #orderList8, #orderList9, #orderList10 {
	text-align: center;
}
#orderList1, #orderList2, #orderList3, #orderList5, #orderList6, #orderList7, #orderList8, #orderList9, #orderList10 {
	padding-top: 35px;
}
#refundBtn {
	padding: 3px 15px 3px 15px;
	background-color: white;
	border-color:#E0E0E0;
	border-radius: 3px;
}
#refundBtn:hover {
	background-color:#E0E0E0;
	border-color:#E0E0E0;
}
</style>
</head>
<link rel="stylesheet" href="../css/nav.css" type = "text/css">
<jsp:include page="../main/mainHeader.jsp"></jsp:include>
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
		    <li class="breadcrumb-item active" aria-current="page">MY PAGE</li>
		  </ul>
		</nav>
		
		<div style="clear: both; font-size: large; color: black;">
			MY PAGE
		</div>
</nav>

<div class="media mypage" style="font-size: 12px;">
  <img class="mr-3" src="../images/noimg.png" alt="NO IMG" 
       style="width: 150px; height: 150px; border: 1px solid black; float: left; 
  								margin-right: 25px;">
  <div class="media-body">
    	<div class="div1 divs" >
		    <div> 회원이름 : <%=user_name %>   </div>
	    </div>
		    <div style="width: 100%-170px;  margin-left: 170px; border-bottom: 1px solid rgba(0, 0, 0, 0.09);"></div>
		<div class="div2 divs">
		    <div> 회원등급 : <%=user_grade %> </div>
	    </div>
	    
	    <div class="div2 divs">
		    <div> <a href="../login/userUpdate.jsp">프로필수정 </a><span></span>&nbsp;/&nbsp;<a href="../login/userOut.jsp">탈퇴</a></div>
	    </div>
  </div>
</div>


<div class="userBuyGoodsdiv" style="font-size: 12px;">
	<table class="table table-hover userBuyGoods">
  		<thead>
		    <tr style="text-align: center;">
	    		<th>#</th>
				<th>주문일자</th>
				<th>주문번호</th>
				<th>이미지</th>
				<th>상품이름</th>
				<th>수량</th>
				<th>상품구매금액</th>
				<th>주문처리상태</th>
				<th>환불신청</th>
				<th>환불처리</th>
				
		    </tr>
		  </thead>
	  <tbody>
	
	 
	
	<% 
		UserOrderDetailDBBean UODBB =  UserOrderDetailDBBean.getInstance();
		ArrayList<UserOrderDetailBean> getUserOrderDetail = UODBB.getUserOrderDetail(user_id);
		GoodsDBBean goodsdb =GoodsDBBean.getInstance();
		GoodsBean goods	= goodsdb.getGoods(product_number);
		
		  	
		
		
		
		 
		  
		
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
			order_number = order_number.substring(0,6);
			refund_check = getUserOrderDetail.get(i).getRefund_check();
			product_name = goods.getProduct_name();
			SimpleDateFormat dtFormat = new SimpleDateFormat("yyMMdd"); 
			SimpleDateFormat newDtFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date formatDate = dtFormat.parse(order_number);
			String strNewDtFormat = newDtFormat.format(formatDate); 
			ArrayList<GoodsBean> getGoodsimg = goodsdb.getGoodsimg(product_number);
			
			stored_file_name = getGoodsimg.get(0).getStored_file_name();
			//System.out.println("포맷 후 : " + strNewDtFormat);
	
			
			
			
	
	
	%>			
<!-- 		    <tr style="cursor:pointer; line-height: 80px;" onclick="location.href='userGoodsRefund.jsp?order_detail_number=<%=order_detail_number%>'">	 -->
			<tr style="cursor:pointer;">
		      <th scope="row" id="orderList1"><%=i+1%></th>
		      <td id="orderList2"><%= strNewDtFormat%></td>
		      <td id="orderList3"><%=i+1%></td>
		      <td id="orderList4"><img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%= stored_file_name%>"></td>
		      <td id="orderList5"><%= product_name%></td>
		      <td id="orderList6"><%=product_count%></td>
		      <td id="orderList7"> <%=product_price %></td>
		      <td id="orderList8"> <%=order_detail_status %></td>
<!--		      <td id="orderList9"><input type="button" onclick="refund(<%=order_detail_number%>)" value="환불신청" id="refundBtn"> </td>  -->
		      <td id="orderList9"><input type="button" onclick="showPopUp(<%=order_detail_number%>)" value="환불신청" id="refundBtn"> </td>
		      <td id="orderList10"><input type="checkbox"  id="checkbox<%=i%>" disabled="disabled"></td>
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




<div class="userBuyGoodsdiv" style="font-size: 12px;">
	<table class="table table-hover userBuyGoods" id="table_cus">
		  <thead>
		    <tr>
	    		<th>#</th>
				<th>글번호</th>
				<th>분류</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회</th>
		    </tr>
		  </thead>
	  <tbody>
	  
<%
	QnADBBean Qdbb = QnADBBean.getInstance();
	//System.out.println("@@@@"+user_id);
	ArrayList<QnABean> getMyboardlist = Qdbb.getMyboardlist(user_id);
	
	for(int i = 0; i < getMyboardlist.size(); i++){
%>  
  		 <tr>
		      <%-- <th scope="row"><%=qbeanarr.get(i).getB_id %></th> --%>
		      <td></td>
		      <td><%=getMyboardlist.get(i).getB_id() %></td>
		      <td><%=getMyboardlist.get(i).getB_category()%></td>
		      <td><%=getMyboardlist.get(i).getB_title() %></td>
		      <td><%=getMyboardlist.get(i).getU_id()%></td>
		      <td><%=getMyboardlist.get(i).getB_date() %></td>
		      <td><%=getMyboardlist.get(i).getB_view() %></td>
	    </tr>
<%
	}
%>	  
	   </tbody>
	</table>
</div>
	  
	
<!-- 	
	<a href="../login/userOut.jsp">탈퇴</a>
	<a href="../login/userUpdate.jsp">회원정보수정</a>
	<a href="./userBuygoods.jsp">구매한상품조회</a> -->
	
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>
</body>
</html>