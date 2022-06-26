<%@page import="java.util.ArrayList"%>
<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("UTF-8");
%>
<%
 	
	String pageNum = request.getParameter("pageNum");

	
	if(pageNum == null){
		pageNum = "1";
	}
	
%>

<%

	int j = 0;
	GoodsDBBean productdb = new GoodsDBBean();
    ArrayList<GoodsBean> productListArr = productdb.getProductlist(pageNum);
    ArrayList<GoodsBean> productListArr_best = productdb.getProductlist_best("1");
   

%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  

	
</head>
<script src="../js/jquery.js"></script>

<script>
	    $(function(){
	         $(".slide_gallery").bxSlider({
	             mainSlides:3,   //열자마자최소 4개
	             maxSlides:3,    // 열자마자 4개까지
	             slideWidth:200, //슬라이드길이
	             slideMargin:30, //슬라이드간격
	             auto:true,
	             autoControls:true,
	             
	            speed:100
	         })
	        });
	    
        $(window).resize(function() {  
            var a  =   $(".body_div").width();
                console.log(a);
            document.getElementsByClassName("body_div");
        });
        
        
      
        
        
        function sendRequest() {
   		  	var send = $("#searchinput").val(); 
   		 	document.getElementById("main_stat_point").style.display = "none";
   		 	document.getElementById("main_stat_point2").style.display = "block";
   		 if(send==""){
   			 document.getElementById("main_stat_point").style.display = "block";
   			 document.getElementById("main_stat_point2").style.display = "none";
   		 }
   		$.ajax({
   			url:"../search/search2.jsp",
   			type:"post",
   			data:{"search":send},
   			success:function(data){	
   				document.getElementById("main_stat_point2").innerHTML =data;
   			},
   			error:function(){
   			document.getElementById("main_stat_point2").innerHTML ="<h3>d fail</h3>";
   			}
   		});
   	}
</script>
<%@include file= "mainClass.jsp"%>  
<%-- <%  GoodsBean goods = new GoodsBean();
	goods.setHeadercheck(1);%> --%>
<link rel="stylesheet" href="./../css/main.css" type = "text/css">
<%-- <jsp:include page="mainClass.jsp"></jsp:include> --%> 

<body>
	
      <jsp:include page="mainHeader.jsp"></jsp:include> 
       <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" style=" width: 92%; margin: auto" > 
					  <div class="carousel-indicators" >
					    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
					    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
					    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
					  </div>
					  <div class="carousel-inner" style="width: 100%; " >
					  
					    <div class="carousel-item active">
					    <a href="./../cart/goodsDisplay.jsp?product_number=1" style="border: 1px solid yellow;">
					      <img  src="../images/products/04.jpg" class="d-block w-100" alt="이미지없음">
					      </a>
					    </div>
					    
					    <div class="carousel-item">
					    <a href="./../cart/goodsDisplay.jsp?product_number=1">
					      <img   src="../images/products/02.jpg" class="d-block w-100" alt="이미지없음">
					      </a>
					    </div>
					    <div class="carousel-item">
					    <a href="./../cart/goodsDisplay.jsp?product_number=1">
					      <img   src="../images/products/03.jpg" class="d-block w-100" alt="이미지없음">
					      </a>
					    </div>
					  </div>
					  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
					    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
					    <span class="visually-hidden">Previous</span>
					  </button>
					  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
					    <span class="carousel-control-next-icon" aria-hidden="true"></span>
					    <span class="visually-hidden">Next</span>
					  </button>
		  </div>		
	  <div class="body_div" >  
		  <div class="main_stat_point2" id="main_stat_point2"></div>
		  <div class="main_stat_point" id="main_stat_point">
		      <div class="maindiv">
				
				  
				  <div style="height: 66px; margin-bottom: 25px;">
				  </div>
				  
				  <div class="maintitle">
				 		BEST ITEM
		  		  </div>
		<!-- best 8개 출력 -0502근지-->
      	<div class="goods">
 <%
 	
	     	out.print("<table>");
	     	//번for 문
	     	for(int i=0; i<2; i++){
	     		out.print("<tr>");
	     		int num =i*4;
	     		//2번 for 문
	     
	     		for(j=0+num; j<=3+num; j++){
					
	     			product_number= productListArr_best.get(j).getProduct_number();
	     			category_code = productListArr_best.get(j).getCategory_code();
	     			product_name = productListArr_best.get(j).getProduct_name();
	     			product_price =productListArr_best.get(j).getProduct_price();
	     			product_stock = productListArr_best.get(j).getProduct_stock();
	     			product_desc = productListArr_best.get(j).getProduct_desc();
	     			product_hits = productListArr_best.get(j).getProduct_hits();

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
										 <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>">
											<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_name%>"  alt="이미지없음">
										 </a>
										<%}else{%>
										  <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>">
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
 		</div>
 		
 		
 		
				  <div style="height: 66px; margin-bottom: 25px;">
				  </div>
				  
				  <div class="maintitle">
				 		NEW ARRIVAL
		  		  </div>
		<!-- new 72개 출력 -0502근지-->
      	<div class="goods">
 <%
 	
			
		 int size = 0;
		 if(productListArr.size()%4 != 0){
		 	size = productListArr.size()/4+1 ;
		 }else{
		 		size = productListArr.size()/4;
		 } 
		 j=0;
 
	     	out.print("<table>");
	     	//번for 문
	     	for(int i=0; i<size; i++){
	     		out.print("<tr>");
	     		int num =i*4;
	     		//2번 for 문
	     
	     		for(j=0+num; j<=3+num; j++){
	     			 //System.out.println("@@@@@@@@@jj@"+j );
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
										 <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>">
											<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_name%>"  alt="이미지없음">
										 </a>
										<%}else{%>
										  <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>">
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
 		</div>
 		
 		
			  </div>
			</div> 
			
			 <!-- main_stat_point -->
			
			
			<jsp:include page="mainfooter.jsp"></jsp:include>
			 
      <div><!-- body_div -->    
</body>
</html>