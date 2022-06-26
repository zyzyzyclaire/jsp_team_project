<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <%
 		String checkpage = null;
 		
    	request.setCharacterEncoding("UTF-8");
    	checkpage = request.getParameter("checkpage");
    	
    	 
   	    String category =	request.getParameter("category");
    	if(checkpage == null){
    		checkpage = "main";
    	}
 %>
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
    </script> <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js">
    </script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-5.1.3-dist/css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="../fontstyle/fontello-4581031e/css/fontello.css">
    <link rel="stylesheet" href="../css/jquery.bxslider.css">
<style type="text/css">
	body{
		font-family: "Nanum Gothic","Malgun Gothic","맑은 고딕","돋움","Dotum","Apple Gothic","Apple SD Gothic Neo",sans-serif;
	}
	.breadcrumb {
		 background: white; 
	}
	a:link { color:black; }
	a:visited { color:black; }
	a:hover { color:mute;}
	a:active { color:black; }
</style>
<%

	int product_number = Integer.parseInt( request.getParameter("product_number"));
	GoodsDBBean goodsDb = GoodsDBBean.getInstance();
	GoodsBean goods = goodsDb.getGoods(product_number); //상품정보를가져온다
	//ArrayList<GoodsBean> getGoodsimg = goodsDb.getGoodsimg(product_number);
	String category_code = null;
	String product_name = null;
	int product_price = 0;
	int product_stock = 0;
	String product_desc = null;
	 
	

  	product_name = goods.getProduct_name();
	product_price = goods.getProduct_price();
	product_stock = goods.getProduct_stock();
	product_desc = goods.getProduct_desc();
	category_code = goods.getCategory_code();
	
	%>
	 <script src="../js/jquery.js"></script>
	<script>
		window.onload = function () {
			var category_code = '<%=category_code%>';
			$("#category_code").val(category_code).prop("selected", true);	
		}
	</script>

<script type="text/javascript">
function product_check_ok(){
	
	if(document.product_frm.product_name.value.length == 0){
		alert("상품이름을입력하세요");
		document.product_frm.product_name.focus();
		return;
	}	
	if(document.product_frm.product_price.value.length == 0){
		alert("가격을입력하세요");
		document.product_frm.product_price.focus();
		return;
	}	
	if(document.product_frm.product_stock.value.length == 0){
		alert("상품수량을입력하세요");
		document.product_frm.product_stock.focus();
		return;
	}	
	if(document.product_frm.product_desc.value.length == 0){
		alert("상품설명을입력하세요");
		document.product_frm.product_desc.focus();
		return;
	}	
	
	if(document.product_frm.category_code.value.length == 0){
		alert("상품종류를선택하세요");
		document.product_frm.category_code.focus();
		return;
	}	

	// userUpdate.jsp의 form action값으로 submit함
	document.product_frm.submit();
}


</script>		
 <script>
 cnt=1;
 function input_append(ff){
   cnt++;
   app = document.getElementById("append");
   app.innerHTML +="<tr><td>"+cnt+"</td><td colspan=2> <input type=file name=product_img"+cnt+" size=40 maxlength=100 class="+"form-control"+" style="+"font-size: 12px;"+"></td></tr>";
   //document.product_frm.submit();
 }
</script>					
</head>
<body>
<jsp:include page="../main/mainHeader.jsp"></jsp:include>
<!-- Breadcrumb 시작 -->
<center style="font-size: 11px;">
<div style="width: 1280px;">
	<nav aria-label="breadcrumb" style="float: right;">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a style="text-decoration: none;" href="../main/main.jsp">Home</a></li>
			<li class="breadcrumb-item"><a style="text-decoration: none;" href="../adminPage/adminPage.jsp">Admin page</a></li>
			<li class="breadcrumb-item active" aria-current="page">Product update</li>
		</ol>
	</nav>
</div>
</center>
<!-- Breadcrumb 끝 -->
<br>
<center>
<div class="table-responsive" >
		<div style="width:1280px; padding-right: 700px; text-align: left;">
		<p>
		<h1 style="font-size: 16px; line-height: 17px; padding-bottom: 10px;">PRODUCT</h1>
		<h1 style="font-size: 12px; color: #939393;">상품 수정</h1>
		</p>
		</div>	
	<form  name="product_frm" action="goodsUpdateOk.jsp?checkpage=<%=checkpage %>&category=<%=category %>" method="post" enctype="multipart/form-data">
		<table id="append" class="table" style="width: 1280px; font-size: 12px;">
			<input type="hidden" name="product_number" value="<%= product_number%>">
			<tr>
				<td>상품이름</td>
				<td><input type="text" name="product_name" value="<%=product_name%>" class="form-control" style="width: 300px; font-size: 12px;"></td>
			</tr>
			<tr>
				<td>상품가격</td>
				<td><input type="text" name="product_price" value="<%= product_price%>" class="form-control" style="width: 100px; font-size: 12px;"></td>
			</tr>
			<tr >
				<td>상품수량</td>
				<td><input type="text" name="product_stock" value="<%=product_stock %>" class="form-control" style="width: 100px; font-size: 12px;"></td>
			</tr>
			<tr>
				<td>상품설명</td>
				<td>
					<textarea rows="100" cols="100" name="product_desc" class="form-control" style="height: 100px; font-size: 12px;"><%=product_desc %></textarea>
				</td>
			</tr>
			<tr>
				<td>카테고리</td>
				<td>
					<select name="category_code" id="category_code" class="form-select" style="width: 100px; font-size: 12px;"> 
						<option value="상의">상의</option>
						<option value="하의">하의</option>
						<option value="신발">신발</option>
					</select>
				</td>
			</tr>
		 
			<tr>
			
				<td>대표이미지</td>
				<td>
					 <input  type="file" name="product_img1" size="40" maxlength="100" class="form-control" style="font-size: 12px;">
				</td>
				
			</tr>
			 <tr>
			</tr>
			<tr>
				<td colspan="2"><input type="button" value="사진 추가" onclick="input_append(this.form)" class="btn btn-outline-dark" style="font-size: 12px;"></td>
			</tr>
			
		</table>
		<br><br>
				<td colspan="2"><input type="button" value="수정" onclick="product_check_ok()" class="btn btn-outline-dark" style="font-size: 12px;"></td>
	</from>	
	</center>
<br><br><br><br>
<jsp:include page="../main/mainfooter.jsp"></jsp:include>
</body>
</html>