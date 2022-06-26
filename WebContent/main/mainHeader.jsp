<%@page import="java.util.ArrayList"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="goods.GoodsBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file= "mainClass.jsp"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>elpmis</title>
<%
	request.setCharacterEncoding("UTF-8");

%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Rubik:wght@700&display=swap" rel="stylesheet">

 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<link rel="stylesheet" href="./../css/main.css" type = "text/css">
<link rel="stylesheet" href="../fontstyle/fontello-4581031e/css/fontello.css">
<script src="../js/jquery.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script>

		function goTop(){
			$('html').scrollTop(0);
			// scrollTop 메서드에 0 을 넣어서 실행하면 끝 !!
			// 간혹 이 소스가 동작하지 않는다면
			// $('html, body') 로 해보세요~
		}
		
	$(window).scroll(function(){ 
		
		var scroll = $(window).scrollTop();
		/* $("선택자").offset().top; *///특정요소 y 좌표값반환
		 console.log(scroll); 
		//var height = 114;
		//height = height-scroll
		//$( ".header_title" ).css("height", height);
		
		
		if(scroll>=220 - scroll){
			$( ".addstyle" ).addClass( "fixed");
			$( ".addstyle1" ).addClass( "fixed1");
			//alert("숨겨졌음");
		}
		else if(scroll<=50){
			
			//$( ".headertop2" ).hide();
			$( ".addstyle" ).removeClass( "fixed");
			$( ".addstyle1" ).removeClass( "fixed1");
			
		}
		//
	})
	window.onload = function () {
		$( ".headertop2" ).hide();
	}
	
	
	 $(document).mouseup(function (e){  //검색 외클릭시 숨김
	        if($("#searchbox").has(e.target).length == 0){
	        	$("#searchinput").val("");
	        	sendRequest();
	        	document.getElementById("main_stat_point2").style.display = "none";
	        	document.getElementById("main_stat_point").style.display = "block";
	            $("#searchbox").hide();
	            $("#hearder_title").css("margin-bottom","26px");
	        }
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
	  
	   function selectbox(){ //검색 클릭시 ㄴ타남   
	        const sebox = document.getElementById('searchbox');
	        const inbox = document.getElementById('searchinput');
	        const hearder_title = document.getElementById('hearder_title');
            sebox.style.display = 'flex';
            hearder_title.style.marginBottom = '-2px';
            inbox.focus();
	    }
	   function sub() {
		   document.search.submit();	
	}
	   
</script>

<script src="../js/jquery-ui.js"></script>
 <script>
        $(function(){
            $(".layer_popup").draggable();
            
        });
    </script>
    
    
<style type="text/css">
a {
   color: rgb(34, 34, 34);
}
.fixed{
	position: fixed;
	
	text-align:center;
	z-index: 1;
	left: 0px;
	right: 0px;
	top:0px;
	background-color: white;
}
.fixed1{
	position: fixed;
	width:100%;
	text-align:center;
	top: 40px;
	/* margin-top: 13px; */
/* 	margin-top: 0.5%; */
	z-index: 1;
	left: 0%;
	right: 0%;
	background-color: white;
}
.main_stat_point{
	
	 	min-width : 1120px;	
	max-width : 1280px;	
	margin:auto;
}
.main_stat_point2{
 	min-width : 1120px;	
	max-width : 1280px;	
	margin:auto;
}
.layer_popup{
			position: fixed;
            text-align:center;
            right: 100px;
            top: 300px;
            z-index: 2;
        }
</style>
</head>
 
<body >
	<%-- <%  GoodsBean goods = new GoodsBean();
	if(goods.headercheck ==1 ){%> --%>
	<%
	GoodsDBBean db = GoodsDBBean.getInstance();
	ArrayList<GoodsBean>  myList = db.myList();
	String stored_file_name1 =null;
	String stored_file_name2 =null;
	String stored_file_name3 =null;
	String stored_file_name4 =null;
	String stored_file_name5 =null;
	int product_number11 = 0;
	int product_number22 = 0;
	int product_number33 = 0;
	int product_number44 = 0;
	int product_number55 = 0;

	
	%>
	  <%				for(int i=0; i<myList.size(); i++){  
		  			
						product_number =  myList.get(i).getProduct_number(); 
					  	GoodsBean getGoodsImg = db.getGoodsImg(product_number);
		     			file_number = getGoodsImg.getFile_number();
		     			orgin_file_name = getGoodsImg.getOrgin_file_name();
		     			stored_file_name = getGoodsImg.getStored_file_name();
		     			stored_thumbnail = getGoodsImg.getStored_thumbnail();
		     			delegate_thumbnail = getGoodsImg.getDelegate_thumbnail();
		     			file_size = getGoodsImg.getFile_size();
		     			create_date = getGoodsImg.getCreate_date();
		     			delete_check = getGoodsImg.getDelete_check();
		     			if(i==0) product_number11 =  product_number;
						if(i==1) product_number22 =  product_number;
						if(i==2) product_number33 =   product_number;
						if(i==3) product_number44 =  product_number;
						if(i==4) product_number55 =  product_number;
						
		     			if(stored_file_name!=null){
							String orgin_file_namearr[] = orgin_file_name.split("/");
							String stored_file_namearr[] = stored_file_name.split("/");
							if(i==0) stored_file_name1 =  stored_file_namearr[0];
							if(i==1) stored_file_name2 =  stored_file_namearr[0];
							if(i==2) stored_file_name3 =  stored_file_namearr[0];
							if(i==3) stored_file_name4 =  stored_file_namearr[0];
							if(i==4) stored_file_name5 =  stored_file_namearr[0];
						}else{
							stored_file_name = null;
						}
		     			
						//파일존재확인
						File file = new File(path+"\\"+stored_file_name);
						boolean isExists = file.exists();
						}%>
	
		<div class="layer_popup" style="background-color:#F5F5F5; width: 150px; height: 313px; /* border: 1px solid; background-color: yellow; */ " >
		<br>
		<p style="font-size: 11px;">최근 본 상품<p>
	        <div style="margin-top: 30px; width: 80%; margin-right: auto; margin-left: auto;">
        		 <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" style=" width: 92%; margin: auto" > 
					  <div class="carousel-indicators" >
					    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
					    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
					    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
				         <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
				         <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="4" aria-label="Slide 5"></button>
					  </div>
					  <div class="carousel-inner">
						    <div class="carousel-item active">
							    <a href="./../cart/goodsDisplay.jsp?product_number=<%= product_number11%>" >
							      
							      <img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_name1%>" class="d-block w-100"   alt="이미지없음" style="width: 100px; height: 100px;">
							      </a>
						    </div>
						    <div class="carousel-item">
							    <a href="./../cart/goodsDisplay.jsp?product_number=<%= product_number22%>">
							      <img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_name2%>" class="d-block w-100"   alt="이미지없음" style="width: 100px; height: 100px;">
							      </a>
						    </div>
						    <div class="carousel-item">
							    <a href="./../cart/goodsDisplay.jsp?product_number=<%= product_number33%>">
							      <img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_name3%>" class="d-block w-100"   alt="이미지없음" style="width: 100px; height: 100px;">
							      </a>
						    </div>
						    <div class="carousel-item">
							    <a href="./../cart/goodsDisplay.jsp?product_number=<%= product_number44%>">
							      <img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_name4%>" class="d-block w-100"   alt="이미지없음" style="width: 100px; height: 100px;">
							      </a>
						    </div>
						    <div class="carousel-item">
							    <a href="./../cart/goodsDisplay.jsp?product_number=<%= product_number55%>">
							      <img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_name5%>" class="d-block w-100"   alt="이미지없음" style="width: 100px; height: 100px;">
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
	        </div>
	        <br>
	        	<a onclick="goTop()" href="#" style="text-decoration: none;"><!-- 맨위로가기 -->▲<p style="font-size: 5px;">TOP</p></a>
	        	
	        	<a href="#footerdiv" style="text-decoration: none;"><!-- 맨아래 --><p style="font-size: 5px; margin-bottom: 1px;">DOWN</p>▼</a>
	        	
	        	
	    </div>
	    
	    
	    
	    
	    
	    
	    
	    
	    
   <%--  <%}%>	 --%>
			
			<div class="addstyle"  style="color: rgb(34, 34, 34); ">
	            <div class="headertop" >
	            <div class="d-flex justify-content-between headerlinks " >
		                <nav class="nav navbox" >
			                <%
			                	if(user_id==null){
			                %>
			                	<a class="nav-link active" aria-current="page" href="../login/login.jsp"> <span>&#xf2c0</span> 로그인</a>
			                    <!-- <a class="nav-link" href="../login/register.jsp"><span></span>회원가입</a> -->
			                     <a class="nav-link" href="../login/regiagree.jsp"><span></span>회원가입</a>
			                <%
			                	}else{
			                %>
			                	<a class="nav-link active" aria-current="page" href="../login/logOut.jsp"> <span>&#xf2c0</span> 로그아웃</a>
			                    <a class="nav-link" href="../userPage/userPage.jsp"><span></span>마이페이지</a>
			                <%
			                   if(user_id.equals("admin")){
			             	%>
			             		<a class="nav-link" href="../adminPage/adminPage.jsp"><span></span>관리페이지</a>
			                    <!-- <a class="nav-link" href="../product/productAdd.jsp"><span></span>상품등록</a> -->
			                <%						
								}
			                %>
			                   
			                <%
			                	}
			                	
			                %>  
		                </nav>
	                
	                
	                <ul class="nav justify-content-end ulbox"  style="margin-bottom: 0px">
	                	
	                    <li class="nav-item">
	                    	<a class="nav-link" href="../cart/viewCart.jsp"><span>&#xf218</span>장바구니목록</a>
	                    </li>
	                    
	                    <li class="nav-item">
	                    	<a class="nav-link" href="#" onclick="selectbox()"> <span> &#xe800</span>검색</a>
	                    </li>
	                
	                </ul>
	            </div>
			</div>
		
			</div>
           	<div style="border-bottom: 1px rgba(0, 0, 0, 0.09) solid; "></div>
			<div class="header_titlecheck">
	            <div class=" d-flex justify-content-center" id="hearder_title" > 
	                <div class="header_title" style="overflow: hidden;"> 
	                    <a href="./../main/main.jsp" style="font-size: 50px; ">elpmis</a>
	                </div>
	            </div>
            </div>
            <div class="headersearchbox">
            	<div class="searchbox1"></div>
	            <div class="d-flex justify-content-end searchbox2"> 
	               <div class="search"  id="searchbox">
	                	<form name="search" action="../search/search.jsp" method="post" style="width: 180px; display:flex;	 border: 1px rgba(0, 0, 0, 0.09) solid;" class="searchform">
	                    	<input type="text" id="searchinput" name="searchtext" onkeyup="sendRequest()" style="flex:9; width: 100px; border: none;">
	                   	 	<a href="#" onclick="sub()" style="text-decoration:none; flex:1;	font-family: 'fontello';">&#xe800</a>
	                  	</form>
	               </div>
	            </div>
            </div>

            <ul class="nav justify-content-center header_footer headernav addstyle1" style="font-size: 13px; ">
              	<li class="nav-item">             		
              		<a class="nav-link" href="../customer_service/notice_list.jsp">공지사항</a>
              	</li>
              	<li class="nav-item">             		
              		<a class="nav-link" href="../customer_service/qnaList.jsp">Q & A</a>
              			
              	</li>
              
            	<li class="nav-item">
                    <a class="nav-link" href="../product/productAllList.jsp">전체</a>
                </li>
                <li class="nav-item">
                	<a class="nav-link" href="../product/categoryProduct.jsp?category=1">상의</a>
                </li>
                <li class="nav-item">
                	<a class="nav-link" href="../product/categoryProduct.jsp?category=2">하의</a>
                <li class="nav-item">
                    <a class="nav-link" href="../product/categoryProduct.jsp?category=3">신발</a>
                </li>
            </ul>  
           
            
     
      <div 	 class="main_stat_point2" id="main_stat_point2" > </div>
	  <div   class="main_stat_point" id="main_stat_point">   </div>
	
 		    <script type="text/javascript">
			<%
				
				if(request.getParameter("searchCheck")!=null){
					if(request.getParameter("searchCheck").equals("false")){
						//System.out.println("검색한내용이없습니다.."+request.getParameter("searchCheck"));
						%>
						 	alert("검색한내용이없습니다..");
						
						<%
					}
				}
			%>
			</script>

	
</body>
</html>