<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>

<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.jspsmart.upload.File"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.sql.Timestamp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<a href="./../main/main.jsp">메인으로가기</a>
	<%

		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		request.setCharacterEncoding("UTF-8");
	    String product_name=null,product_desc=null,category_code=null;
		String product_img=null;
		int product_price=0;
		int product_stock=0;
				
		
		String path = request.getRealPath("upload");
		
		
		int size=3000*3000;
		String file_size="";
		String file="";
		String orgin_file_name="";
		String str = null;
		String stored_file_name = "";
		MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
		Enumeration files = multi.getFileNames();
	
		
		product_name = multi.getParameter("product_name");
		product_price = Integer.parseInt(multi.getParameter("product_price"));
		product_stock = Integer.parseInt(multi.getParameter("product_stock"));
		
		product_desc = multi.getParameter("product_desc");
		category_code = multi.getParameter("category_code");
		System.out.print("category_code@@@@"+category_code);
		
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
	 
			
		
		
		//stored_file_name //서버에저장될파일이름
		//orgin_file_name //원본파일이름
			//System.out.print("orgin_file_nameArr@@@@@@@@@@@");
			String orgin_file_nameArr[] = orgin_file_name.split("/");
			//System.out.print("orgin_file_nameArr@@@@@@@@@@@"+orgin_file_nameArr.length);
			String stored_file_nameArr[] = stored_file_name.split("/");
			//System.out.print("stored_file_nameArr@@@@@@@@@@@"+stored_file_nameArr.length);
			String file_sizeArr[] = file_size.split("/");
	
		GoodsBean productBean = new GoodsBean();
		productBean.setProduct_name(product_name);
		productBean.setProduct_price(product_price);
		productBean.setProduct_stock(product_stock);
		productBean.setProduct_desc(product_desc);
		productBean.setCategory_code(category_code);
		productBean.setProduct_date(timestamp);
		
		if(orgin_file_nameArr[0] != null){
			productBean.setOrgin_file_name(orgin_file_nameArr[0]);
			productBean.setStored_file_name(stored_file_nameArr[0]);
		}else{
			System.out.println("@@@@@@@>>"+path+"\1.png");
			productBean.setOrgin_file_name(path+"\1.png");
			productBean.setStored_file_name(path+"\1.png");
		}
		
		productBean.setString_file_size(file_sizeArr[0]);
		GoodsDBBean prductDBB = GoodsDBBean.getInstance();                                     
		int re = prductDBB.insertGoodss(productBean,false);
		
		//productBean.setFile_number(product_number);
		
		
		for(int i = 1; i< orgin_file_nameArr.length; i++){
			productBean.setOrgin_file_name(orgin_file_nameArr[i]);
			productBean.setStored_file_name(stored_file_nameArr[i]);
			productBean.setString_file_size(file_sizeArr[i]);
			re = prductDBB.insertGoodss(productBean, true);
		}
		
 %>
 	<%
	if(re == 1){
		 //System.out.println("goodsUpdateOk.jsp성공");
		 %>
		 <script>
		 	alert("등록성공");
		
		 	location.href="../adminPage/adminPage.jsp?pageChange=productAllList.jsp";
		
		 </script>
		 <%
	 }else{
		 //System.out.println("goodsUpdateOk.jsp실패");
		 %>
		 <script>
		 	alert("");
		 </script>
		 <%
	 }
	%>
	
</body>
</html>