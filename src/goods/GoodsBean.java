package goods;

import java.sql.Timestamp;

public class GoodsBean {
	public static int headercheck = 0;
	
     public static int getHeadercheck() {
		return headercheck;
	}

	public static void setHeadercheck(int headercheck) {
		GoodsBean.headercheck = headercheck;
	}
	private int product_number;
     private String category_code;
     private String product_name;
     private int product_price;
     private int product_stock;
     private String product_desc;
     private Timestamp product_date;
     private int product_hits;
     private  int file_number;
  	 private  String orgin_file_name;
  	 private  String stored_file_name;
  	 private  String stored_thumbnail;
  	 private  String delegate_thumbnail;
  	 private  int file_size;
  	 private  Timestamp create_date;
  	 private  String delete_check;
  	 
  	public static int pageSize = 12; //한 페이지당 10개 출력물
	public static int pageCount = 1; //페이지 개수 지정 변수
	public static int pageNum = 1; //페이지 번호

 	public static String pageNumer(int limit ,String page,String category,String sort) {
		String str="";
		
		int temp = (pageNum-1) % limit;
		int startPage=pageNum - temp;
		if(page.equals("main")) page = "main.jsp?";
		else if(page.equals("All")) page = "productAllList.jsp?&sort="+sort;
		else if(page.equals("category")) {
			page = "categoryProduct.jsp?&category="+category+"&sort="+sort;
		}else if(page.equals("adminAll")) {
			page = "adminPage.jsp?pageChange=productAllList.jsp";
		}
		
		
		
	
		//[이전] 출력
		if ((startPage - limit) > 0) {
			str="<a href='"+page+"&pageNum="+(startPage-1)+"'>[이전]</a>&nbsp;&nbsp;";
		}
		
		//페이지 번호 나열하기
		for (int i = startPage; i < (startPage+limit); i++) {
			if (i == pageNum) {
				str += "<li class='page-item'> <a class='page-link' >"+i+"</a></li>";
			} else {
				
				str += "<li class='page-item'> <a class='page-link'  href='"+page+"&pageNum="+i+"'>"+""+i+"</a></li>";
				
				
			}
			if(i >= pageCount) break;
		}
		//[다음] 출력
		if ((startPage + limit) <= pageCount) {
			str +="<a href='"+page+"&pageNum="+(startPage+limit)+"'>[다음]</a>";
		}
		
		return str;
	}
     
 	public Timestamp getProduct_date() {
		return product_date;
	}
	public void setProduct_date(Timestamp product_date) {
		this.product_date = product_date;
	}
	

	public String getString_file_size() {
		return String_file_size;
	}
	public void setString_file_size(String string_file_size) {
		String_file_size = string_file_size;
	}
	private  String String_file_size;
	
     
	public int getFile_number() {
		return file_number;
	}
	public void setFile_number(int file_number) {
		this.file_number = file_number;
	}
	public String getOrgin_file_name() {
		return orgin_file_name;
	}
	public void setOrgin_file_name(String orgin_file_name) {
		this.orgin_file_name = orgin_file_name;
	}
	public String getStored_file_name() {
		return stored_file_name;
	}
	public void setStored_file_name(String stored_file_name) {
		this.stored_file_name = stored_file_name;
	}
	public String getStored_thumbnail() {
		return stored_thumbnail;
	}
	public void setStored_thumbnail(String stored_thumbnail) {
		this.stored_thumbnail = stored_thumbnail;
	}
	public String getDelegate_thumbnail() {
		return delegate_thumbnail;
	}
	public void setDelegate_thumbnail(String delegate_thumbnail) {
		this.delegate_thumbnail = delegate_thumbnail;
	}
	public int getFile_size() {
		return file_size;
	}
	public void setFile_size(int file_size) {
		this.file_size = file_size;
	}
	public Timestamp getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Timestamp create_date) {
		this.create_date = create_date;
	}
	public String getDelete_check() {
		return delete_check;
	}
	public void setDelete_check(String delete_check) {
		this.delete_check = delete_check;
	}
	public int getProduct_number() {
		return product_number;
	}
	public void setProduct_number(int product_number) {
		this.product_number = product_number;
	}
	public String getCategory_code() {
		return category_code;
	}
	public void setCategory_code(String category_code) {
		this.category_code = category_code;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public int getProduct_stock() {
		return product_stock;
	}
	public void setProduct_stock(int product_stock) {
		this.product_stock = product_stock;
	}
	public String getProduct_desc() {
		return product_desc;
	}
	public void setProduct_desc(String product_desc) {
		this.product_desc = product_desc;
	}
	
	public int getProduct_hits() {
		return product_hits;
	}
	public void setProduct_hits(int product_hits) {
		this.product_hits = product_hits;
	}
	
     
}
