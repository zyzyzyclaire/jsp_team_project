package notice;

import java.sql.Timestamp;

public class QnABean {
	private int b_id;
	private String u_id;
	private String b_category;
	private int b_view;
	private String b_title;
	private String b_content;
	private String b_ip;
	private String b_pwd;
	private Timestamp b_date;

	private int b_step=0;
	private int b_level=0;
	private int b_ref=0;	
	
	private String b_fname;
	private int b_fsize;
	private String b_rfname;
	
	private String b_secret;
	private String b_anschk;
	
	public static int pageSize = 10; //한 페이지에 10개를 보여주기 위한 변수
	public static int pageCount = 1; //페이지 개수 카운트, 페이지가 많을수록 늘어남
	public static int pageNum = 1;  //페이지 번호
	
	//페이지 목록들을 만들어주는 메소드
	//int limit -> 몇개의 페이지에 대한 로직을 처리할것인지 설정
	public static String pageNumber(int limit) { 
		
		String str="";	//return값
		int temp = (pageNum-1) % limit;	//시작페이지를 구하기 위함
		int startPage=pageNum - temp;	//시작페이지 설정 1-0이기 때문에 1이 됨
		
		
		if ((startPage - limit) > 0) {	//[이전]을 구현하기 위한 if문
			str="<a href='qnaList.jsp?pageNum="+(startPage-1)+"'>[이전]</a>&nbsp;&nbsp;";
		}
		
		
		for (int i = startPage; i < (startPage+limit); i++) {
			if (i == pageNum) {
				str += "["+i+"]&nbsp;&nbsp;";
			} else {
				str += "<a href='qnaList.jsp?pageNum="+i+"'>"+"["+i+"]</a>&nbsp;&nbsp;";
			}
			if(i >= pageCount) break;
		}
		
		if ((startPage + limit) <= pageCount) { //[다음]을 구현하기 위한 if문
			str += "<a href='qnaList.jsp?pageNum="+(startPage+limit)+"'>[다음]</a>";
		}
		return str;
	}
	
	public int getB_id() {
		return b_id;
	}
	public void setB_id(int b_id) {
		this.b_id = b_id;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getB_category() {
		return b_category;
	}
	public void setB_category(String b_category) {
		this.b_category = b_category;
	}
	public int getB_view() {
		return b_view;
	}
	public void setB_view(int b_view) {
		this.b_view = b_view;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	public String getB_ip() {
		return b_ip;
	}
	public void setB_ip(String b_ip) {
		this.b_ip = b_ip;
	}
	public String getB_pwd() {
		return b_pwd;
	}
	public void setB_pwd(String b_pwd) {
		this.b_pwd = b_pwd;
	}
	public Timestamp getB_date() {
		return b_date;
	}
	public void setB_date(Timestamp b_date) {
		this.b_date = b_date;
	}
	public int getB_step() {
		return b_step;
	}
	public void setB_step(int b_step) {
		this.b_step = b_step;
	}
	public int getB_level() {
		return b_level;
	}
	public void setB_level(int b_level) {
		this.b_level = b_level;
	}
	public int getB_ref() {
		return b_ref;
	}
	public void setB_ref(int b_ref) {
		this.b_ref = b_ref;
	}
	public String getB_fname() {
		return b_fname;
	}
	public void setB_fname(String b_fname) {
		this.b_fname = b_fname;
	}
	public String getB_rfname() {
		return b_rfname;
	}
	public void setB_rfname(String b_rfname) {
		this.b_rfname = b_rfname;
	}
	public int getB_fsize() {
		return b_fsize;
	}
	public void setB_fsize(int b_fsize) {
		this.b_fsize = b_fsize;
	}
	public String getB_secret() {
		return b_secret;
	}
	public void setB_secret(String b_secret) {
		this.b_secret = b_secret;
	}
	
	
	private int n_num;
	private String n_title;
	private String n_content;
	private Timestamp n_date;
	private String user_id;
	private int n_hit;
	private String n_pwd;
	private String n_ip;

	public int getN_num() {
		return n_num;
	}
	public void setN_num(int n_num) {
		this.n_num = n_num;
	}
	public String getN_title() {
		return n_title;
	}
	public void setN_title(String n_title) {
		this.n_title = n_title;
	}
	public String getN_content() {
		return n_content;
	}
	public void setN_content(String n_content) {
		this.n_content = n_content;
	}
	public Timestamp getN_date() {
		return n_date;
	}
	public void setN_date(Timestamp n_date) {
		this.n_date = n_date;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getN_hit() {
		return n_hit;
	}
	public void setN_hit(int n_hit) {
		this.n_hit = n_hit;
	}
	public String getN_pwd() {
		return n_pwd;
	}
	public void setN_pwd(String n_pwd) {
		this.n_pwd = n_pwd;
	}
	public String getN_ip() {
		return n_ip;
	}
	public void setN_ip(String n_ip) {
		this.n_ip = n_ip;
	}
	public String getB_anschk() {
		return b_anschk;
	}
	public void setB_anschk(String b_anschk) {
		this.b_anschk = b_anschk;
	}
	
}
