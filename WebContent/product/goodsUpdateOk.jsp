<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="goods.GoodsBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <%
    	request.setCharacterEncoding("UTF-8");
 %>
<title>Insert title here</title>
</head>
<body>
<a href="./../main/main.jsp">메인으로가기</a>
	<%
	String checkpage = null;
	
	
	int product_number = 0;
	String category_code = null;
	String product_name = null;
	int product_price = 0;
	int product_stock = 0;
	String product_desc = null;
	int size=3000*3000;
	String path = request.getRealPath("upload");
	MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
	product_number = Integer.parseInt( multi.getParameter("product_number"));
	GoodsDBBean goodsDb = GoodsDBBean.getInstance();
	GoodsBean goods = new GoodsBean();
	
	 
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
	
	
	
	String file_size="";
	String file="";
	String orgin_file_name="";
	String str = null;
	String stored_file_name = "";
	
	
	
	
	 product_name = multi.getParameter("product_name");
	 product_price = Integer.parseInt( multi.getParameter("product_price"));
	 product_stock = Integer.parseInt( multi.getParameter("product_stock"));
	 product_desc = multi.getParameter("product_desc");
	 category_code = multi.getParameter("category_code");
	 checkpage = request.getParameter("checkpage");
	 String category = request.getParameter("category");
	 
	 int count=2;
	 for(int i=1; i<count; i++){
			str ="product_img";
			str= str+i;
			file = multi.getFilesystemName(str);
			//System.out.println("여기까지들어옴"+str);
		
			/* System.out.println("@@@@@@>>"+file); */
			
			if(file != null){
				//System.out.println("@@@@@@몇번"+i);
				count++;
				stored_file_name += file; //서버에저장되는이름
				orgin_file_name += multi.getOriginalFileName(str) ; //업로드한이름
				file_size += file.getBytes().length ; //파일크기
				
				str ="product_img";
				str= str+(i+1);
				file = multi.getFilesystemName(str);
				if(file != null){
					stored_file_name+="/";
					orgin_file_name+="/";
					file_size+="/";
				}
		
			}else if (file == null){
				//System.out.println("@@@@@@>>>>>>몇번"+str);
				str ="product_img";
				str= str+(i+1);
				file = multi.getFilesystemName(str);
				if(file != null){
					count++;
				}
				
			}
		}
	 
	 String orgin_file_nameArr[] = orgin_file_name.split("/");
	 //System.out.println("@@@@@@>>"+stored_file_name);
	 String stored_file_nameArr[] = stored_file_name.split("/");
		//System.out.println("@@@@@@>>"+stored_file_name);
	 String file_sizeArr[] = file_size.split("/");
	// System.out.println("@@@@@@>>"+file_sizeArr[0]);
	 
	 
	 goods.setProduct_number(product_number);
	 goods.setProduct_name(product_name);
	 goods.setProduct_price(product_price);
	 goods.setProduct_desc(product_desc);
	 goods.setCategory_code(category_code);
	 
	 goods.setCategory_code(category_code);
	 goods.setCategory_code(category_code);
	 goods.setOrgin_file_name(orgin_file_nameArr[0]);
	 goods.setStored_file_name(stored_file_nameArr[0]);
	 //goods.setFile_size(Integer.parseInt( file_sizeArr[0]));
	 int re = goodsDb.updateGoods(goods,false,false);
	 
	 
	 //System.out.println("orgin_file_nameArr.length@@@"+orgin_file_nameArr.length);
 	for(int i = 1; i< orgin_file_nameArr.length; i++){
 			//System.out.println("상품이미지가 두개이상 포문안에"+stored_file_nameArr[i]);
			 goods.setOrgin_file_name(orgin_file_nameArr[i]);
			 goods.setStored_thumbnail(stored_file_nameArr[i]);
			 goods.setString_file_size(file_sizeArr[i]);
		re = goodsDb.updateGoods(goods,true,true);
	}
 	/* //이미지가하나일때 이미지데이터 삭제
 	if(orgin_file_nameArr.length == 1){
		  re = goodsDb.updateGoods(goods,true);
	} */
 	
	 if(re == 1){
		 //System.out.println("goodsUpdateOk.jsp성공");
		 %>
		 <script>
		 alert("수정성공");
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
		 <%}else if(checkpage.equals("categoryProduct")){
			
		 %>
		 	<script>
		 	location.href="../product/categoryProduct.jsp?category=<%=category%>";
		 	</script>
		 <%}else if(checkpage.equals("adminpage")){ %>
		 <script>
		 	location.href="../adminPage/adminPage.jsp?pageChange=productAllList.jsp";
		 	</script>
		 <%} 
		 
	 }else{
		 //System.out.println("goodsUpdateOk.jsp실패");
		 %>
		 <script>
		 	alert("수정실패");
		 </script>
		 <%
	 }
	%>
	
	
	
</body>
</html>