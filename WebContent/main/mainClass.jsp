<%@page import="java.sql.Timestamp"%>
<%@page import="java.io.File"%>
<%

String path = request.getRealPath("./");
	 path = path+"\\upload"; //폴더 경로
	 File Folder = new File(path);
	// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
	if (!Folder.exists()) {
		try{
		    Folder.mkdir(); //폴더 생성합니다.
		    //System.out.println("폴더가 생성되었습니다.");
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
   }
	
path = request.getRealPath("upload");
System.out.println(path);
request.setCharacterEncoding("UTF-8");
int product_number = 0;
String category_code = null;
String product_name = null;
int product_price = 0;
int product_stock = 0;
String product_desc = null;
Timestamp product_date = null;
int product_hits = 0;

int product_number2 = 0;
int file_number = 0 ;
String orgin_file_name= null;
String stored_file_name= null;
String stored_thumbnail= null;
String delegate_thumbnail= null;
int file_size= 0;
Timestamp create_date= null;
String delete_check= null;
String user_id = null;
String user_name = null;
String user_grade = null;
String refund_check = null;
String order_number =null,order_detail_status=null;

 int b_id;
 String u_id;
 String b_category;
 int b_view;
 String b_title;
 String b_content;
 String b_ip;
 String b_pwd;
 Timestamp b_date;

 int b_step=0;
 int b_level=0;
 int b_ref=0;	

 String b_fname;
 int b_fsize;
 String b_rfname;

 String b_secret;

int order_detail_number=0,product_count=0;

if(!((String)session.getAttribute("user_id") == null)){
	user_id =(String)session.getAttribute("user_id");
}




%>



