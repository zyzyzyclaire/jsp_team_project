package login;

import java.sql.Timestamp;

public class UserBean {
	private String user_id;
	private String user_pwd;
	private String user_name;
	private String user_email;
	private String user_phone;
	private String user_addr;
	private String user_grade;
	private int userPurchase;
	
	public UserBean() {
	}
	public UserBean(String user_id, String user_pwd, String user_name, String user_email, String user_phone,
			String user_addr, String user_grade) {
		this.user_id = user_id;
		this.user_pwd = user_pwd;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_phone = user_phone;
		this.user_addr = user_addr;
		this.user_grade = user_grade;
	}
	public UserBean(String user_id) {
		this.user_id = user_id;
	}
	
	public String getUser_grade() {
		return user_grade;
	}
	public void setUser_grade(String user_grade) {
		this.user_grade = user_grade;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_addr() {
		return user_addr;
	}
	public void setUser_addr(String user_addr) {
		this.user_addr = user_addr;
	}
	public int getUserPurchase() {
		return userPurchase;
	}
	public void setUserPurchase(int userPerchase) {
		this.userPurchase = userPerchase;
	}
	
}

