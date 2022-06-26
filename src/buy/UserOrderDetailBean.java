package buy;

import java.sql.Timestamp;

public class UserOrderDetailBean {
	private int order_detail_number;
	private String order_number;
	private int product_number;
	private int product_count;
	private int product_price;
	private String order_detail_status;
	private String refund_check;
	private int refund_number;
	
	private String refund_reason;
	private String refund_img;
	private String user_email;
	
	public int getRefund_number() {
		return refund_number;
	}
	public void setRefund_number(int refund_number) {
		this.refund_number = refund_number;
	}
	public String getRefund_reason() {
		return refund_reason;
	}
	public void setRefund_reason(String refund_reason) {
		this.refund_reason = refund_reason;
	}
	public String getRefund_img() {
		return refund_img;
	}
	public void setRefund_img(String refund_img) {
		this.refund_img = refund_img;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	
	
	
	public String getRefund_check() {
		return refund_check;
	}
	public void setRefund_check(String refund_check) {
		this.refund_check = refund_check;
	}
	public int getOrder_detail_number() {
		return order_detail_number;
	}
	public void setOrder_detail_number(int order_detail_number) {
		this.order_detail_number = order_detail_number;
	}
	public String getOrder_number() {
		return order_number;
	}
	public void setOrder_number(String order_number) {
		this.order_number = order_number;
	}
	public int getProduct_number() {
		return product_number;
	}
	public void setProduct_number(int product_number) {
		this.product_number = product_number;
	}
	public int getProduct_count() {
		return product_count;
	}
	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public String getOrder_detail_status() {
		return order_detail_status;
	}
	public void setOrder_detail_status(String order_detail_status) {
		this.order_detail_status = order_detail_status;
	}
	
}
