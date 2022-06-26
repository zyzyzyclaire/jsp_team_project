<%@page import="java.io.File"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="goods.GoodsBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	if(request.getParameter("product_number")==null) {
	%>		
		<script>
		alert("잘못된 경로입니다.");
		location.href = "../main/main.jsp";
		</script>
	<%
		return;
	}

	
		
	 String checkpage = request.getParameter("checkpage"); 
	 String category =	request.getParameter("category");
	if(checkpage == null){
		checkpage = "main";
	}
	//System.out.println("checkpage@@@@@@@@@@@@@@@@"+checkpage);
	
	int file_number = 0 ;
	String orgin_file_name= null;
	String stored_file_name= null;
	String stored_thumbnail= null;
	String delegate_thumbnail= null;
	int file_size= 0;
	Timestamp create_date= null;
	String delete_check= null;


	String user_id = (String)session.getAttribute("user_id");

	


	int product_number = Integer.parseInt(request.getParameter("product_number"));	
	
	
	
	
	GoodsDBBean db = GoodsDBBean.getInstance();
	GoodsBean goods = db.getGoods(product_number);
	db.insertMyList(product_number);
	
/*	//상품세부이미지까지불러오기
	ArrayList<GoodsBean> getGoodsimg = db.getGoodsimg(product_number); */
	String product_name = goods.getProduct_name();
	int product_price = goods.getProduct_price();
	int product_stock = goods.getProduct_stock();

	//상품세부이미지까지불러오기
	ArrayList<GoodsBean> getGoodsimg = db.getGoodsimg(product_number);
	stored_file_name = getGoodsimg.get(0).getStored_file_name();
	//System.out.println("@@@@@@"+stored_file_name);
	String path = request.getRealPath("upload");
	File file = new File(path+"\\"+stored_file_name);
	boolean isExists = file.exists();
/* 	if(isExists) { System.out.println("I find the existFile.txt"); } 
	else { System.out.println("No, there is not a no file."); } */
	
	// 조회수 1 증가시키는 메서드	-0429근지
	db.hitUp(product_number);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>elpmis</title>
<!-- 부트스트랩	-0426근지 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<script src="../js/jquery.js"></script>
<script type="text/javascript">
	function deleteok() {	
		   var delConfirm = confirm('상품을 삭제 하시겠습니까?');
		   if (delConfirm) {
		     
		      location.href="../product/goodsDelete.jsp?product_number=<%=product_number %>&checkpage=<%=checkpage%> &category=<%=category%>";
			
		   }
		   else {
		      alert('삭제가 취소되었습니다.');
		   }
		}
	
	
		 
		 
	$(function() {
		$("#setCart").on("click", function() {
			var value = $('#product_count').val();
			if(confirm("장바구니에 담으시겠습니까?")) {
				
				if(value == 0) {
					alert("상품 수량을 선택해주세요.");
				} else {
					location.href="cartProcess.jsp?product_count="+value+"&product_number="+<%= product_number %>;
				}
			} else {
				return false;
			}
		});
	});
	
	// 바꾼 수량에 재고가 없을 시 알림창 띄우도록 함 -0420근지
	$(function () {
		$("#product_count").on("change",function() {
			var value = $('#product_count').val();
			
			if(value == 0) {
				alert("상품 수량을 선택해주세요.");
			} else {
				location.href="checkStock.jsp?product_count="+value+"&product_number="+<%= product_number %>;
			}
		});
	});
	
	// 0개를 구매할 시 알림창 띄우도록 함 -0421근지
	$(function () {
		$("#buyCount").on("click",function() {
			var value = $('#product_count').val();
			if(value == 0) {
				alert("상품 수량을 선택해주세요.");
			} else {
				document.goods_frm.submit();
			}
		});
	}); 
</script>
<style>
	#displayBody{
		min-width: 1100px;
		max-width: 1280px;
		margin: 0 auto;
		
		font-size:11px;
		font-family: "Nanum Gothic","Malgun Gothic","맑은 고딕","돋움","Dotum","Apple Gothic","Apple SD Gothic Neo",sans-serif;
 	}
 	#displayTable {
 		border-top: 1px solid black;
 	}
 	.fisrtDiv {
 		text-align: center;
 	}
 	.imgDiv {
		display: inline-block;
 		padding: 50px;
 		width: 700px;
 		height: 630px;
 	}
 	.descDiv {
		display: inline-block;
 		padding: 50px;
 		padding-top: 85px;
 		width: 550px;
 		height: 400px;
 	}
 	.buyImg {
 		width: 620px;
 		height: 640px;
 	}

 	#desc1, #desc2, #desc3, #desc4, #desc5, #desc6, #desc7, #desc8 {
 		text-align: left;
 		height: 60px;
 	}
 	#desc1 {
 		font-size: 16px;
 	}
 	#desc2 {
 		font-weight: bold;
 	}
 	#desc3 {
 		font-size: 12px;
 		font-weight: bold;
 		color: rgb(0, 139, 204);
 	}	
 	#desc8 {
 		text-align: center;
 	}
 	.selectBox { 
 		width: 200px; /* 원하는 너비설정 */ 
 		height: 25px;
 		font-family: inherit; /* 폰트 상속 */ 
 		border: 1px solid #999; 
 		border-radius: 0px; /* iOS 둥근모서리 제거 */ 
 	}
 	.buyBtn {
 		margin-right: 30px;
		padding: 13px 40px 13px 40px;
		background-color: #404040;
		border-color: #404040;
		border-radius: 5px;
		color: white;
		font-weight: bold;
		font-size: 12px;		
	}
	.buyBtn:hover {
		background-color:white;
		color:black;
		border-color: #E0E0E0;
	}
 	.cartBtn {
 		margin-left: 30px;
		padding: 13px 40px 13px 40px;
		background-color: white;
		border-color: #E0E0E0;
		border-radius: 5px;
		color: #404040;
		font-weight: bold;
		font-size: 12px;
	}
	.cartBtn:hover {
		background-color: white;
		border-color: black;
		color: #404040;
	}
	.secondDiv {
		margin-top: 150px;
 		text-align: center;
 		font-size: 12px;
 	}
 	.guideBar {
 		font-size: 11px;
 		text-align: center;
 		margin-bottom: 80px;
 	}
 	.guideBarBtn {
 		width: 100px;
 		border: 0px;
 		background-color: transparent;
 	}
 	.guideBarBtn:hover {
		background-color: #E0E0E0;
		color: #404040;
	}
 	.guideBarATag {
 		text-decoration: none;
 	}
 	.thumbImg {
 		width: 800px;
 		height: 1000px;
 	}
 	.thumbBlank {
 		height: 100px;
 	}
 	.thirdDiv {
 		margin-bottom: 50px;
 		padding: 0px 100px 0px 100px;
 	}
</style>
</head>
<body id="displayBody">
	
	<jsp:include page="../main/mainHeader.jsp"></jsp:include> 
		<%
		if(user_id !=null){
		if(user_id.equals("admin")){
			%>
			<div style="margin-left:88% ; width:100px; ">
				<a href="../product/goodsUpdate.jsp?product_number=<%=product_number %>&checkpage=<%=checkpage%>&category=<%=category%>">상품수정</a>
				<a onclick="deleteok()" style="text-decoration: underline; cursor: pointer;">상품삭제</a>
			</div>
			<%
		}
		}
		 %>
		 
	
	<div class="fisrtDiv">
		<div class="imgDiv">
<%	out.println(product_number); %>
			<%if(isExists){%>
				<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_name%>"  alt="이미지없음" class="buyImg">
			<%}else{%>
				<img src="../images/products/noimg.png"  alt="이미지없음"  class="buyImg">
			<%}%>
		</div>
		<div class="descDiv">
			<table class="table" id="displayTable">
				<tr>
					<td colspan="2" id="desc1">[무료배송]<%= product_name %></td>
				</tr>
				<tr>
					<td id="desc2">판매가</td>
					<td id="desc3"><%= product_price %> won</td>
				</tr>
				<tr>
					<td id="desc4">상품 재고</td>
					<td id="desc5"><%=product_stock %></td>
				</tr>
				<tr>
					<td id="desc6">수량</td> 
					<td id="desc7">
						<form method="post" action="../buy/buy.jsp" name="goods_frm">
							<input type="hidden" name="product_number" value="<%= product_number %>">
								<select name="product_count" id="product_count" class="selectBox">
									<option value="0" selected>수량을 선택하세요.</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
								</select>
					</td>
				</tr>
	 			<tr>
					<td colspan="2"  id="desc8">
						<input type="button" value="바로구매" id="buyCount" class="buyBtn">
						<input type="button" value="장바구니" id="setCart" class="cartBtn">
					</td>
				</tr>
						</form>
			</table>
		</div>
	</div>
	
	<% 
//		admin계정일 때만 상품수정, 삭제 버튼이 보이도록 하는 부분. 일단 실행 안되는 것 같아 각주처리함	-0428근지
//		if(user_id != null){
//			if(user_id.equals("admin")){
//			}
//		}
//		out.println("<a href='../product/goodsUpdate.jsp?product_number="+product_number+"'>상품수정</a>");
//		out.println("<a href='../product/goodsDelete.jsp?product_number="+product_number+"'>상품삭제</a>");
	%>
	
	<div class="secondDiv">
		<hr>
		<div class="guideBar">
			<button class="guideBarBtn"><a href="#displayBody" class="guideBarATag">GET IT!</a></button>
			|
			<button class="guideBarBtn"><a href="#descSen" class="guideBarATag"><strong>DETAIL INFO</strong></a></button>
			|
			<button class="guideBarBtn"><a href="#guide" class="guideBarATag">SHOP GUIDE</a></button>
		</div>
		
		<div id="descSen"><%= goods.getProduct_desc() %></div>
		<div>
	<%
			for(int i = 0 ; i< getGoodsimg.size(); i++){
				if(getGoodsimg.get(i).getStored_thumbnail() != null){
					stored_thumbnail = getGoodsimg.get(i).getStored_thumbnail();
					//System.out.println("@@@@"+stored_thumbnail);
	%>
				<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%= stored_thumbnail%>" class="thumbImg">
				<div class="thumbBlank"></div>
	<%
				}
			}
	%>
		</div>
	</div>
	<div class="thirdDiv">
		<div id="guide">
			<hr>
			<div class="guideBar">
				<button class="guideBarBtn"><a href="#displayBody" class="guideBarATag">GET IT!</a></button>
				|
				<button class="guideBarBtn"><a href="#descSen" class="guideBarATag">DETAIL INFO</a></button>
				|
				<button class="guideBarBtn"><a href="#guide" class="guideBarATag"><strong>SHOP GUIDE</strong></a></button>
			</div>
			<jsp:include page="shopGuide.jsp"></jsp:include>
		</div>
	</div>	
	
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>
			
</body>
</html>