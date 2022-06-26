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
 <%
 	String pageNum = request.getParameter("pageNum");

	if(pageNum == null){
		pageNum = "1";
	}
	
	int j = 0;
	GoodsDBBean productdb = new GoodsDBBean();
    ArrayList<GoodsBean> productListArr = productdb.getProductlist(pageNum);
    int size = 0;
    if(productListArr.size()%4 != 0){
    	size = productListArr.size()/4+1 ;
    }else{
    		size = productListArr.size()/4;
    } 
%>
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
	
<%@include file= "../main/mainClass.jsp"%> 
<jsp:include page="../main/mainHeader.jsp"></jsp:include> 
<%
 	path = request.getRealPath("upload");
%>	
	<nav class="nav2" >
	
	<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="nav2div">
	  <ul class="breadcrumb ">
	    <li class="breadcrumb-item"><a href="../main/main.jsp">home</a></li>
	    <li class="breadcrumb-item active" aria-current="page">전체</li>
	  </ul>
	</nav>
		
		<div style="clear: both; font-size: large; color: black;">
			전체
		</div>
		<div class="d-flex justify-content-between"  style="clear: both;  margin-top: 35px; padding-bottom: 10px; border-bottom: 1px rgba(0, 0, 0, 0.09) solid">
			<div class="nav navbox" >
				Total <%= productListArr.size() %> items
			</div>
			<div class="nav justify-content-end ulbox">
 				<ul id="sort" class="sort_ul">
 					<li class="sort_li">
 						<a href="productAllList.jsp?sort=1" class="sort_a">최신순</a>
 					</li>
 					<li class="sort_li_bar">|</li>
 					<li class="sort_li">
 						<a href="productAllList.jsp?sort=2" class="sort_a">판매순</a>
 					</li>
 					<li class="sort_li_bar">|</li>
 					<li class="sort_li">
 						<a href="productAllList.jsp?sort=3" class="sort_a">조회순</a>
 					</li>
 					<li class="sort_li_bar">|</li>
 					<li class="sort_li">
 						<a href="productAllList.jsp?sort=4" class="sort_a">높은가격순</a>
 					</li>
 					<li class="sort_li_bar">|</li>
 					<li class="sort_li">
 						<a href="productAllList.jsp?sort=5" class="sort_a">낮은가격순</a>
 					</li>
 				</ul>
			</div>
		</div>
	</nav>

	<main>
		<!-- 사용자가 클릭한 정렬순대로 정렬 -0502근지-->
<%
		String result = request.getParameter("sort");
		
//		System.out.println("@@@###===>"+result);
		if(result==null) {
			productListArr = productdb.getProductlist(pageNum);
		} else if(result.equals("1")) {
			productListArr = productdb.getProductlist(pageNum);
		} else if(result.equals("2")) {
			productListArr = productdb.getProductlist_best(pageNum);
		} else if(result.equals("3")) {
			productListArr = productdb.getProductlist_hits(pageNum);
		} else if(result.equals("4")) {
			productListArr = productdb.getProductlist_price_desc(pageNum);
		} else if(result.equals("5")) {
			productListArr = productdb.getProductlist_price(pageNum);
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
	     			if(productListArr.size()==j) break;
					
	     			product_number= productListArr.get(j).getProduct_number();
	     			category_code = productListArr.get(j).getCategory_code();
	     			product_name = productListArr.get(j).getProduct_name();
	     			product_price =productListArr.get(j).getProduct_price();
	     			product_stock = productListArr.get(j).getProduct_stock();
	     			product_desc = productListArr.get(j).getProduct_desc();
	     			product_hits = productListArr.get(j).getProduct_hits();
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
										 <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>&checkpage=productAllList">
											<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_name%>"  alt="이미지없음">
										 </a>
										<%}else{%>
										  <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>&checkpage=productAllList">
											<img src="../images/products/noimg.png"  alt="이미지없음">
										  </a>
										<%}%>
									</td>
								</tr>
								<tr  style = "cursor:pointer;" onclick="location.href='../cart/goodsDisplay.jsp?product_number=<%=product_number%>&checkpage=productAllList'">
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
	</main>
				<div style="margin: auto;  width: 300px; text-align: center;"> 
			 		<ul class="pagination justify-content-center"> 
			 			
			 			<%= GoodsBean.pageNumer(4,"All",null,result) %>
		 			</ul> 
		 		</div>
	</table> 
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>
</body>
</html>

 		