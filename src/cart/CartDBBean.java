package cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CartDBBean {
	private static CartDBBean instance = new CartDBBean();
	
	// cartDBBean 객체 생성하는 메서드 - 0418 근지
	public static CartDBBean getInstance() {
		return instance;
	}
	
	// db와 연결하는 메서드 - 0418 근지
	public Connection getConnection() throws Exception {
		Connection conn = null;
		conn = ((DataSource)(new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
		return conn;
	}
	
	// 장바구니를 db에 저장하는 메서드 - 0418 근지
	public int insertCart(String user_id, int product_number, int product_count) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "";
		int re = -1;
		int number = 0;
		int count = 0;
		
		try {
			conn = getConnection();
			
			// cart_number를 세팅하기 위해 -0418 근지
			query = "select max(cart_number) from cart";
			pstmt = conn.prepareStatement(query);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				number = rs.getInt(1)+1;
			} else {
				number=1;
			}
			
			// product_count를 세팅+카드에 담기 -0418 근지
			query = "select product_count from cart where user_id=? and product_number=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user_id);
			pstmt.setInt(2, product_number);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	// 개수만 추가될 때 -0418근지
				count = rs.getInt(1)+product_count;
				
				query = "update cart set product_count=? where user_id=? and product_number=?";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, count);
				pstmt.setString(2, user_id);
				pstmt.setInt(3, product_number);
				
				re = pstmt.executeUpdate();
				re = 1;
				
			} else {	//  새 상품을 추가한 것일 때 -0418근지
				query = "insert into cart"
						+ "(cart_number, user_id, product_number, product_count)"
						+ "values(?,?,?,?)";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, number);
				pstmt.setString(2, user_id);
				pstmt.setInt(3, product_number);
				pstmt.setInt(4, product_count);
				
				re = pstmt.executeUpdate();
				re = 1;
			}
			
			System.out.println("추가 성공");
		} catch(Exception e) {
			System.out.println("추가 실패");
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return re;
	}
	
	// user_id와 일치하는 cart의 정보를 얻어오는 메서드 - 0418 근지
	public ArrayList<CartBean> getCart(String user_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select cart_number, product_number, product_count from cart where user_id=?";
		
		ArrayList<CartBean> cartArr = new ArrayList<CartBean>();
		CartBean cart = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				cart = new CartBean();
				cart.setCart_number(rs.getInt("cart_number"));
				cart.setProduct_number(rs.getInt("product_number"));
				cart.setProduct_count(rs.getInt("product_count"));
				cartArr.add(cart);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return cartArr;
	}
	
	// cart_number 열을 삭제하는 메서드 - 0418 근지
	public int deleteCart(int cart_number) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "delete from cart where cart_number=?";
		int re = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, cart_number);
			re = pstmt.executeUpdate();
			re = 1;
			
			System.out.println("삭제 성공");
		} catch(Exception e) {
			System.out.println("삭제 실패");
			e.printStackTrace();
		} finally {
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return re;
	}
	
	// cart_number 열 구매 개수를 수정하는 메서드 - 0419 근지
	public int editCart(int cart_number, int product_count) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "Update cart set product_count=? where cart_number=?";
		int re = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, product_count);
			pstmt.setInt(2, cart_number);
			re = pstmt.executeUpdate();
			re = 1;
			
			System.out.println("수정 성공");
		} catch(Exception e) {
			System.out.println("수정 실패");
			e.printStackTrace();
		} finally {
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return re;
	}
	
	// 재고수량을 확인해 장바구니 추가 가능 여부를 확인하는 메서드(장바구니에 추가할 때) - 0420 근지
	public int checkStock(int product_number, int product_count, String user_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "";
		int cnt = 0;
		int stock = 0;
		int re = -1;
		
		try {
			conn = getConnection();
			// 해당 아이디가 장바구니에 해당 물건을 담아놓은 총 개수를 cnt에 담음 - 0420 근지
			query = "select sum(product_count) from cart where product_number=? and user_id=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, product_number);
			pstmt.setString(2, user_id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				cnt = rs.getInt(1) + product_count;
			} else {
				cnt = product_count;
			}
			
			// 해당 상품 재고를 확인 - 0420 근지
			query = "select product_stock from product where product_number=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, product_number);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				stock = rs.getInt(1);				
			}
			
			if (stock >= cnt) {
				re = 1;
			} else {
				re = -1;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return re;
	}
	
	// 재고수량을 확인해 장바구니 추가 가능 여부를 확인하는 메서드(장바구니에서  수정할 때) - 0420 근지
	public int checkStockEdit(int product_number, int product_count) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "";
		int cnt = 0;
		int stock = 0;
		int re = -1;
		
		try {
			conn = getConnection();
			
			// 해당 상품 재고를 확인 - 0420 근지
			query = "select product_stock from product where product_number=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, product_number);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				stock = rs.getInt(1);				
			}
			
			if (stock >= product_count) {
				re = 1;
			} else {
				re = -1;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return re;
	}
	
	// cart_number와 일치하는 cart의 정보를 얻어오는 메서드 - 0418 근지
	public CartBean getCart_one(int cart_number) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select * from cart where cart_number=?";
		
		CartBean cart = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, cart_number);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				cart = new CartBean();
				cart.setCart_number(cart_number);
				cart.setUser_id(rs.getString("user_id"));
				cart.setProduct_number(rs.getInt("product_number"));
				cart.setProduct_count(rs.getInt("product_count"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return cart;
	}
}