package buy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import cart.CartBean;

public class UserOrderDBBean {
	private static UserOrderDBBean instance = new UserOrderDBBean();
	
	public static UserOrderDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		Connection conn = null;
		conn = ((DataSource)(new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
		return conn;
	}
	
	// user_order db에 저장하는 메서드 - 0422 근지
	public int insertUserOrder(UserOrderBean userOrder) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "";
		int re = -1;
		
		// order_number 설정하기 위해 (yyMMddHHss + user_id)	-0422근지
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		String time = sdf.format(userOrder.getOrder_date());
		String user_id = userOrder.getUser_id();
		String order_num = time+"_"+user_id;
		
		try {
			conn = getConnection();
			
			query = "insert into user_order(order_number,user_id,order_date,receiver_addr,receiver_name,receiver_phone)"
				  + " values(?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, order_num);
			pstmt.setString(2, userOrder.getUser_id());
			pstmt.setTimestamp(3, userOrder.getOrder_date());
			pstmt.setString(4, userOrder.getReceiver_addr());
			pstmt.setString(5, userOrder.getReceiver_name());
			pstmt.setString(6, userOrder.getReceiver_phone());
			
			pstmt.executeUpdate();
			
			re = 1;
			
			System.out.println("추가 성공");
		} catch(Exception e) {
			System.out.println("추가 실패");
			e.printStackTrace();
		} finally {
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}

		return re;
	}
	
	// order_number와 일치하는 user_order의 정보를 얻어오는 메서드 - 0418 근지
	public UserOrderBean getUserOrder(String order_number) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select * from user_order where order_number=?";
		
		UserOrderBean user_order = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, order_number);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				user_order = new UserOrderBean();
				user_order.setOrder_number(order_number);
				user_order.setUser_id(rs.getString("user_id"));
				user_order.setOrder_date(rs.getTimestamp("order_date"));
				user_order.setReceiver_addr(rs.getString("receiver_addr"));
				user_order.setReceiver_name(rs.getString("receiver_name"));
				user_order.setReceiver_phone(rs.getString("receiver_phone"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return user_order;
	}
		
}
