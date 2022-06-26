<%@page import="java.util.ArrayList"%>
<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@page import="java.io.File"%>
<title>Insert title here</title>

</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String checkpage = "";
		checkpage = request.getParameter("checkpage");
		System.out.println("checkpage"+checkpage);
		checkpage = checkpage.trim();
		
		int product_number = Integer.parseInt(request.getParameter("product_number"));	
		GoodsDBBean goodsDb = GoodsDBBean.getInstance();
		String path = request.getRealPath("upload");
		ArrayList<GoodsBean>  getGoodsimg =  goodsDb.getGoodsimg(product_number);
		File filee = null;
		
		for(int i=0; i<getGoodsimg.size(); i++){
			if(getGoodsimg.get(i).getStored_file_name()!=null){
				filee = new File(path+"\\"+getGoodsimg.get(i).getStored_file_name()); 
				  
			}else if(getGoodsimg.get(i).getStored_thumbnail()!=null){
				filee = new File(path+"\\"+getGoodsimg.get(i).getStored_thumbnail()); 
			}
			
			
			if( filee.exists() ){
					if(filee.delete()){ 
						//System.out.println("파일삭제 성공"); 
					}else{ 
						//System.out.println("파일삭제 실패"); 
					} 
			}else{ 
				//System.out.println("파일이 존재하지 않습니다."); 
			} 
		}
		
		
		 int re = goodsDb.deleteGoods(product_number);
		/*response.sendRedirect("../adminPage/productAllList.jsp"); */
	%>
	<!-- alert('삭제되었습니다.'); -->
	<%
	String category = request.getParameter("category");
	//System.out.println("category"+category);
	 if(re == 1){
		 //System.out.println("goodsUpdateOk.jsp성공");
		 %>
		
			 <script>
				alert("삭제성공");
			</script>
		 <% if(checkpage.equals("main")){
			
		 %>
		  	<script>
		 		location.href="../main/main.jsp";
		 	</script>
		 <%}else if(checkpage.equals("productAllList")){
			
		 %>
		 	<script>
		 	location.href="../product/productAllList.jsp";
		 	</script>
		 <%}else if(checkpage.equals("categoryProduct")){%>
		 	<script>
		 	location.href="../product/categoryProduct.jsp?category=<%=category%>";
		 	</script>
		 <%}else if(checkpage.equals("adminpage")){ %>
			<script>
		 	location.href="../adminPage/adminPage.jsp?pageChange=productAllList.jsp";
		 	</script>
		 <%} %>
		
		 <%
	 }else{
		 //System.out.println("goodsUpdateOk.jsp실패");
		 %>
		 <script>
		 alert("삭제실패");
		 </script>
		 <%
	 }
	%>
	
	
</body>
</html>