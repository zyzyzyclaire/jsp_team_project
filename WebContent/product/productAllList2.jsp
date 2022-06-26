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
</style>
</head>
<body>
	
<%@include file= "../main/mainClass.jsp"%> 
<jsp:include page="../main/mainHeader.jsp"></jsp:include> 
<%
 	path = request.getRealPath("upload");

	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
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
				Total
			</div>
			<div class="nav justify-content-end ulbox">
				판매순
			</div>
		</div>
	</nav>

	<main>
 <%
			int j = 0;
			GoodsDBBean productdb = new GoodsDBBean();
			
         	ArrayList<GoodsBean> productListArr = productdb.getProductlist(pageNum);
         	ArrayList<GoodsBean> ProductImgListArr  =  productdb.getProductimg(productListArr);
        	int size = 0;
	     	if(productListArr.size()%4 != 0){
	     		size = productListArr.size()/4+1 ;
	     	}else{
	     		size = productListArr.size()/4;
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
					
					
					file_number =ProductImgListArr.get(j).getFile_number();
					orgin_file_name = ProductImgListArr.get(j).getOrgin_file_name();
					stored_file_name = ProductImgListArr.get(j).getStored_file_name();
					stored_thumbnail = ProductImgListArr.get(j).getStored_thumbnail();
					delegate_thumbnail =ProductImgListArr.get(j).getDelegate_thumbnail();
					file_size = ProductImgListArr.get(j).getFile_size();
					create_date = ProductImgListArr.get(j).getCreate_date();
					delete_check = ProductImgListArr.get(j).getDelete_check();
					
					String orgin_file_namearr[] = orgin_file_name.split("/");
					String stored_file_namearr[] = stored_file_name.split("/");
					//파일존재확인
					File file = new File(path+"\\"+stored_file_namearr[0]);
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
											<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_namearr[0]%>"  alt="이미지없음">
										 </a>
										<%}else{%>
										  <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>&checkpage=productAllList">
											<img src="../images/products/noimg.png"  alt="이미지없음">
										  </a>
										<%}%>
									</td>
								</tr>
								<tr  style = "cursor:pointer;" onclick="location.href='../cart/goodsDisplay.jsp?product_number=<%=product_number%>'">
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
			 			<%= GoodsBean.pageNumer(4,"All",null,null) %>
		 			</ul> 
		 		</div>
	    </div>
	</main>
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>
</body>
</html>
