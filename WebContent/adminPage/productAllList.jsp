<%@page import="java.io.File"%>
<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
	*{
		font-family: "Malgun Gothic",돋음;
	}
	.nav2{
		margin:auto;
		max-width : 1280px;	
 		min-width : 1120px;	
	}
	
	.nav2div{
		float: right;
	}
	.userBuyGoodsdiv{
	
	clear:both;
	font-size: 12px;
	line-height:40px;
	min-width : 1220px;	
	max-width : 1220px;	
	text-align: center;
	
}

.userBuyGoodsdiv a{
	text-decoration: none;
}
	.userBuyGoods img{

	width: 40px;
	height: 40px;
}

main{
	margin:auto;
	min-width : 1120px;	
	max-width : 1280px;	
}
</style>
</head>
<body>
	
<%@include file= "../main/mainClass.jsp"%> 
<%-- <jsp:include page="../main/mainHeader.jsp"></jsp:include>  --%>
<%
 	path = request.getRealPath("upload");
%>	

<!-- <nav class="nav2" >
		<nav style="--bs-breadcrumb-divider: '>'; font-size: 10px;" aria-label="breadcrumb" class="nav2div">
		  <ul class="breadcrumb ">
		    <li class="breadcrumb-item"><a href="../main/main.jsp">home</a></li>
		    <li class="breadcrumb-item active" aria-current="page">관리자</li>
		    <li class="breadcrumb-item active" aria-current="page">상품목록</li>
		  </ul>
		</nav>
		
		<div style="clear: both; font-size: large; color: black;">
			상품목록
		</div>
</nav>
 -->


	<main >
 <%
		 	String pageNum = request.getParameter("pageNum");
			
			if(pageNum == null){
				pageNum = "1";
			}
			int j = 0;
			GoodsDBBean productdb = new GoodsDBBean();
         	ArrayList<GoodsBean> productListArr = productdb.getProductlist(pageNum);
         	ArrayList<GoodsBean> ProductImgListArr  =  productdb.getProductimg(productListArr);
        	
%>
     	
<%
	     	
%>
		<div class="userBuyGoodsdiv" >
			<table class="table table-hover userBuyGoods" >
				<thead >
					    <tr style="font-size: 12px; line-height: 30px; " >
					    
				    		<th>#</th>
				    		<th>이미지</th>
							<th >상품번호</th>
							<th>상품이름</th>
							<th>수량</th>
							<th>상품금액</th>
							<th>등록일자</th>
							<th>#</th>
							<th>#</th>
								
					    </tr>
			  	</thead>
	    	  	<tbody>
	    	  	
    	  	<script>
function deleteok(product_number) {	
	   var delConfirm = confirm('상품을 삭제 하시겠습니까?');
	   if (delConfirm) {
	   
	      location.href= "../product/goodsDelete.jsp?product_number="+product_number+"&checkpage=adminpage";
	      
	   }
	   else {
	      alert('삭제가 취소되었습니다.');
	   }
	}
</script>
<%


	     	//번for 문
		     	for(int i=0; i<productListArr.size(); i++){
	
						product_number= productListArr.get(i).getProduct_number();
						category_code = productListArr.get(i).getCategory_code();
						product_name = productListArr.get(i).getProduct_name();
						product_price =productListArr.get(i).getProduct_price();
						product_stock = productListArr.get(i).getProduct_stock();
						product_desc = productListArr.get(i).getProduct_desc();
						product_hits = productListArr.get(i).getProduct_hits();
						create_date = productListArr.get(i).getProduct_date();
						
						file_number =ProductImgListArr.get(i).getFile_number();
						orgin_file_name = ProductImgListArr.get(i).getOrgin_file_name();
						stored_file_name = ProductImgListArr.get(i).getStored_file_name();
						stored_thumbnail = ProductImgListArr.get(i).getStored_thumbnail();
						delegate_thumbnail =ProductImgListArr.get(i).getDelegate_thumbnail();
						file_size = ProductImgListArr.get(i).getFile_size();
						/* create_date = ProductImgListArr.get(i).getCreate_date(); */
						delete_check = ProductImgListArr.get(i).getDelete_check();
						
						String orgin_file_namearr[] = orgin_file_name.split("/");
						String stored_file_namearr[] = stored_file_name.split("/");
						//파일존재확인
						File file = new File(path+"\\"+stored_file_namearr[0]);
						boolean isExists = file.exists();
					
%>
	
	 				<tr>
	 					<td><%=i+1 %></td>
	 					<td><img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%= stored_file_name%>"></td>
	 					<td style="width: 70px; margin-right: 0px;"><%=product_number %></td>
	 					<td style="margin-left: 0px; text-align: left;"><%=product_name %></td>
	 					<td ><%=product_stock %></td>
	 					<td><%=product_price %></td>
	 					<td><%=create_date %></td>
	 					<td style="width: 80px;" ><button type="button" class="btn btn-dark" style="background-color: white; width: 50px; padding:5px;  font-size: 11px;"><a href="../product/goodsUpdate.jsp?product_number=<%=product_number %>&checkpage=adminpage">수정</a></button></td>
	 					<td style="width: 80px;"><button type="button" class="btn btn-dark" style="background-color: white; width: 50px; padding:5px;  font-size: 11px;"><a onclick="deleteok(<%=product_number%>)"  href="#">삭제</a></button></td>
	 				</tr>
 <%

     			}

%>
				</tbody>
	     	</table>
		     	<div style="margin: auto;  width: 300px; text-align: center;"> 
				 		<ul class="pagination justify-content-center"> 
				 			<%= GoodsBean.pageNumer(4,"adminAll",null,null) %>
			 			</ul> 
			 		</div>
     	</div>
	</main>
	
	<%-- <jsp:include page="../main/mainfooter.jsp"></jsp:include> --%>
</body>
</html>


	      