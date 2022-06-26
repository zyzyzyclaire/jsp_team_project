<%@page import="java.io.File"%>
<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file= "../main/mainClass.jsp"%>  
<%
	request.setCharacterEncoding("UTF-8");
    path = request.getRealPath("upload");
%>
<%


	String pageNum = request.getParameter("pageNum");

	if(pageNum == null){
		pageNum = "1";
	}
  	category_code = request.getParameter("category");

	String goods = null;
	
	if(category_code.equals("1") || category_code.equals("상의")){
		goods = "상의";
		category_code = "상의";
	}else if(category_code.equals("2")  || category_code.equals("하의")){
		goods = "하의";
		category_code = "하의";
	}else if(category_code.equals("3")  || category_code.equals("신발")){
		goods = "신발";
		category_code = "신발";
	}
	GoodsDBBean productdb = new GoodsDBBean();
	ArrayList<GoodsBean> CategoryProductList = productdb.getCategoryProductList(category_code,"1");
	
//필요없어서 주석처리-0502근지 	ArrayList<GoodsBean> productlistArr  =  productdb.getProductimg(CategoryProductList);
 	int j = 0;
 	int size = 0;
 	if(CategoryProductList.size()%4 != 0){
 		size = CategoryProductList.size()/4+1 ;
 	}else{
 		size = CategoryProductList.size()/4;
 	} 
 	
 	// 베스트상품 4개를 얻어오기 위해	-0429근지
	ArrayList<GoodsBean> CategoryProductList_best = productdb.getCategoryProductList_best(category_code,"1");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery.js"></script>
<script>

</script>

<style>
	.best_tr {
		height:10px;
	}
	.best_td {
		border-top: 1px solid #e0e0e0;
		padding-top: 3px;
		text-align: center;
	}
	.sort_a {
  		text-decoration-line: none;
  	}
  	.sort_ul {
  		list-style: none;
  	}
  	.sort_li, .sort_li_bar {
  		float: left;
  		padding: 3px 8px;
  		font-size: 12px;
  	}
  	.sort_li:hover {
		background-color: #E0E0E0;
		border-color: #E0E0E0;
		border-radius: 5px;
	}
</style>

</head>
<body>
<link rel="stylesheet" href="../css/nav.css" type = "text/css">
<jsp:include page="../main/mainHeader.jsp"></jsp:include>
	
	<nav class="nav2" >
	
		<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="nav2div">
		  <ul class="breadcrumb ">
		    <li class="breadcrumb-item"><a href="../main/main.jsp">home</a></li>
		    <li class="breadcrumb-item active" aria-current="page"><%=goods %></li>
		  </ul>
		</nav>
		<div style="clear: both; font-size: large; color: black;">
			<%=goods %>
		</div>
		
		<!-- 베스트 상품 4개만 출력 -0429근지-->
       	<div class="goods">
 <%
	     	out.print("<table>");

	     	//번for 문
	     	for(int i=0; i<1; i++){
	     		out.print("<tr>");
	     		//2번 for 문	     
	     		for(j=0; j<=3; j++){
	     			if(CategoryProductList_best.size()==j) break;
					
	     			product_number= CategoryProductList_best.get(j).getProduct_number();
	     			category_code = CategoryProductList_best.get(j).getCategory_code();
	     			product_name = CategoryProductList_best.get(j).getProduct_name();
	     			product_price =CategoryProductList_best.get(j).getProduct_price();
	     			product_stock = CategoryProductList_best.get(j).getProduct_stock();
	     			product_desc = CategoryProductList_best.get(j).getProduct_desc();
	     			product_hits = CategoryProductList_best.get(j).getProduct_hits();
	     			
	     			GoodsBean getGoodsImg = productdb.getGoodsImg(product_number);
	     			
	     			file_number = getGoodsImg.getFile_number();
	     			orgin_file_name = getGoodsImg.getOrgin_file_name();
	     			stored_file_name = getGoodsImg.getStored_file_name();
	     			stored_thumbnail = getGoodsImg.getStored_thumbnail();
	     			delegate_thumbnail = getGoodsImg.getDelegate_thumbnail();
	     			file_size = getGoodsImg.getFile_size();
	     			create_date = getGoodsImg.getCreate_date();
	     			delete_check = getGoodsImg.getDelete_check();
				
				
					//파일존재확인
					File file = new File(path+"\\"+stored_file_name);
					boolean isExists = file.exists();
					/* if(isExists) { System.out.println("I find the existFile.txt"); } 
					else { System.out.println("No, there is not a no file."); } */
%>
		   <td>
				<table>
					<tr>
						<td class="best_td">BEST<%=j+1%></td>
					</tr>
					<tr>
						<td class="mainalinkimg">
							<%if(isExists){%>
							 <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>&checkpage=categoryProduct&category=<%=category_code%>">
								<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_name%>"  alt="이미지없음">
							 </a>
							<%}else{%>
							  <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>&checkpage=categoryProduct&category=<%=category_code%>">
								<img src="../images/products/noimg.png"  alt="이미지없음">
							  </a>
							<%}%>
						</td>
					</tr>
					<tr  style = "cursor:pointer;" onclick="location.href='../cart/goodsDisplay.jsp?product_number=<%=product_number%>&checkpage=categoryProduct&category=<%=category_code%>'">
					 	<td style="border-bottom: 1px rgba(0, 0, 0, 0.09) solid; line-height: 30px;">	
					 			<%=product_name %>
					 	</td>
						
					</tr>
					<tr>
						<td style="color: rgb(0, 139, 204); line-height: 15px;">판매가 :<%=product_price%> won</td>
					</tr>
				</table>
			</td>
 <%
	     		}
	     		out.print("</tr>");
	     	}
	     	out.print("</table>");
 %>
	    </div>
	    
		<div class="d-flex justify-content-between"  style="clear: both;  margin-top: 35px; padding-bottom: 10px; border-bottom: 1px rgba(0, 0, 0, 0.09) solid">
			<div class="nav navbox" >
				Total <%= CategoryProductList.size() %>items
			</div>
			<div class="nav justify-content-end ulbox">
 				<ul id="sort" class="sort_ul">
 					<li class="sort_li">
 						<a href="categoryProduct.jsp?category=<%=category_code%>&sort=1" class="sort_a">최신순</a>
 					</li>
 					<li class="sort_li_bar">|</li>
 					<li class="sort_li">
 						<a href="categoryProduct.jsp?category=<%=category_code%>&sort=2" class="sort_a">판매순</a>
 					</li>
 					<li class="sort_li_bar">|</li>
 					<li class="sort_li">
 						<a href="categoryProduct.jsp?category=<%=category_code%>&sort=3" class="sort_a">조회순</a>
 					</li>
 					<li class="sort_li_bar">|</li>
 					<li class="sort_li">
 						<a href="categoryProduct.jsp?category=<%=category_code%>&sort=4" class="sort_a">높은가격순</a>
 					</li>
 					<li class="sort_li_bar">|</li>
 					<li class="sort_li">
 						<a href="categoryProduct.jsp?category=<%=category_code%>&sort=5" class="sort_a">낮은가격순</a>
 					</li>
 				</ul>
			</div>
		</div>
	</nav>

		<!-- 사용자가 클릭한 정렬순대로 정렬 -0502근지-->
<%
		CategoryProductList = productdb.getCategoryProductList(category_code,pageNum);
		String result = request.getParameter("sort");
		
		
		if(result==null) {
			CategoryProductList = productdb.getCategoryProductList(category_code,pageNum);
		
		} else if(result.equals("1")) {
			CategoryProductList = productdb.getCategoryProductList(category_code,pageNum);
		
		} else if(result.equals("2")) {
			CategoryProductList = productdb.getCategoryProductList_best(category_code,pageNum);
			
		} else if(result.equals("3")) {
			CategoryProductList = productdb.getCategoryProductList_hits(category_code,pageNum);
			System.out.println("@@@CategoryProductList@@@"+CategoryProductList.size());
		} else if(result.equals("4")) {
			CategoryProductList = productdb.getCategoryProductList_price_desc(category_code,pageNum);
			System.out.println("@@@CategoryProductList@@@"+CategoryProductList.size());
		} else if(result.equals("5")) {
			CategoryProductList = productdb.getCategoryProductList_price(category_code,pageNum);
		}
		
		//System.out.println("@@CategoryProductListresult@@@@@@@@"+CategoryProductList.size());
	 	if(CategoryProductList.size()%4 != 0){
	 		size = CategoryProductList.size()/4+1 ;
	 	}else{
	 		size = CategoryProductList.size()/4;
	 	}
%>	 
      	<div class="goods">
 <%
	     	out.print("<table>");
	     	//번for 문
	     	for(int i=0; i<size; i++){
	     		out.print("<tr>");
	     		int num =i*4;
	     		//2번 for 문
	     
	     		for(j=0+num; j<=3+num; j++){
	     			if(CategoryProductList.size()==j) break;
					//System.out.println("j@@@@"+j);
	     			product_number= CategoryProductList.get(j).getProduct_number();
	     			category_code = CategoryProductList.get(j).getCategory_code();
	     			product_name = CategoryProductList.get(j).getProduct_name();
	     			product_price =CategoryProductList.get(j).getProduct_price();
	     			product_stock = CategoryProductList.get(j).getProduct_stock();
	     			product_desc = CategoryProductList.get(j).getProduct_desc();
	     			product_hits = CategoryProductList.get(j).getProduct_hits();
	     			
//	     			file_number =productlistArr.get(j).getFile_number();
//	     			orgin_file_name = productlistArr.get(j).getOrgin_file_name();
//	     			stored_file_name = productlistArr.get(j).getStored_file_name();
//	     			stored_thumbnail = productlistArr.get(j).getStored_thumbnail();
//	     			delegate_thumbnail =productlistArr.get(j).getDelegate_thumbnail();
//	     			file_size = productlistArr.get(j).getFile_size();
//	     			create_date = productlistArr.get(j).getCreate_date();
//	     			delete_check = productlistArr.get(j).getDelete_check();

					// 이미지 불러오기	-0502근지
	     			GoodsBean getGoodsImg = productdb.getGoodsImg(product_number);
	     			
	     			file_number = getGoodsImg.getFile_number();
	     			orgin_file_name = getGoodsImg.getOrgin_file_name();
	     			stored_file_name = getGoodsImg.getStored_file_name();
	     			stored_thumbnail = getGoodsImg.getStored_thumbnail();
	     			delegate_thumbnail = getGoodsImg.getDelegate_thumbnail();
	     			file_size = getGoodsImg.getFile_size();
	     			create_date = getGoodsImg.getCreate_date();
	     			delete_check = getGoodsImg.getDelete_check();
					if(stored_file_name!=null){
						String orgin_file_namearr[] = orgin_file_name.split("/");
						String stored_file_namearr[] = stored_file_name.split("/");
						stored_file_name =  stored_file_namearr[0];
					}else{
						stored_file_name = null;
					}
					//파일존재확인
					File file = new File(path+"\\"+stored_file_name);
					boolean isExists = file.exists();
					/* if(isExists) { System.out.println("I find the existFile.txt"); } 
					else { System.out.println("No, there is not a no file."); } */
%>
	 				
					   <td>
							<table>
								<tr>
									<td class="mainalinkimg">
										<%if(isExists){%>
										 <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>&checkpage=categoryProduct&category=<%=category_code%>">
											<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_name%>"  alt="이미지없음">
										 </a>
										<%}else{%>
										  <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>&checkpage=categoryProduct&category=<%=category_code%>">
											<img src="../images/products/noimg.png"  alt="이미지없음">
										  </a>
										<%}%>
									</td>
								</tr>
								<tr  style = "cursor:pointer;" onclick="location.href='../cart/goodsDisplay.jsp?product_number=<%=product_number%>&checkpage=categoryProduct&category=<%=category_code%>'">
									 	<td style="border-bottom: 1px rgba(0, 0, 0, 0.09) solid; line-height: 30px;">	
									 			<%=product_name %>
									 	</td>
									
								</tr>
								<tr>
									<td style="color: rgb(0, 139, 204); line-height: 15px;">판매가 :<%=product_price%> won</td>
								</tr>
							</table>
						</td>
		 	   
		 	
 <%

	     		}
	     		out.print("</tr>");
	     	}
	     	out.print("</table>");
 %>
 			<div style="margin: auto;  width: 300px; text-align: center;"> 
			 		<ul class="pagination justify-content-center"> 
			 			<%= GoodsBean.pageNumer(4,"category",category_code,result) %>
		 			</ul> 
		 		</div>
 		</div>
  
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>
</body>
</html>

