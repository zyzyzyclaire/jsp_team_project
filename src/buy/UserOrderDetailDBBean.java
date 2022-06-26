package buy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import cart.CartBean;
import cart.CartDBBean;
import goods.GoodsBean;
import goods.GoodsDBBean;
public class UserOrderDetailDBBean {
	
	private static UserOrderDetailDBBean instance = new UserOrderDetailDBBean();
	
	public static UserOrderDetailDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		Connection conn = null;
		conn = ((DataSource)(new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
		return conn;
	}
	
	public int insertUserOrderDetail(UserOrderDetailBean userOrderDetail) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "";
		int re = -1;
		int number;
		
		try {
			conn = getConnection();
			
			// order_detail_number를 세팅하기 위해 -0425 근지
			query = "select max(order_detail_number) from userOrder_detail";
			pstmt = conn.prepareStatement(query);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				number = rs.getInt(1)+1;
			} else {
				number=1;
			}
			
			query = "insert into userOrder_detail(order_detail_number,order_number,product_number"
					+ ",product_count,product_price,order_detail_status,refund_check)"
					+ " values(?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, number);
			pstmt.setString(2, userOrderDetail.getOrder_number());
			pstmt.setInt(3, userOrderDetail.getProduct_number());
			pstmt.setInt(4, userOrderDetail.getProduct_count());
			pstmt.setInt(5, userOrderDetail.getProduct_price());
			pstmt.setString(6, "입금완료");
			pstmt.setString(7, "no");
			pstmt.executeUpdate();
			
			// 주문 상품 재고 줄이는 쿼리	-0422근지
			query = "Update product set product_stock=product_stock-? where product_number=? ";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, userOrderDetail.getProduct_count());
			pstmt.setInt(2, userOrderDetail.getProduct_number());
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
	
	// userOrder_detail 배열을 db에 저장하는 메서드 - 0422 근지
	public int insertUserOrderDetailArray(String[] cart_num_arr, String order_number) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "";
		int re = -1;
		int number;
		
		try {
			conn = getConnection();
			
			// 배열 크기만큼 저장	-0425근지
			for (int i = 0; i < cart_num_arr.length; i++) {
				int cart_num = Integer.parseInt(cart_num_arr[i]);
				CartDBBean cart_db = CartDBBean.getInstance();
				CartBean cart = cart_db.getCart_one(cart_num);
				
				GoodsDBBean goods_db = GoodsDBBean.getInstance();
				GoodsBean goods = goods_db.getGoods(cart.getProduct_number());
				
				int product_price = cart.getProduct_count()*goods.getProduct_price();
				
				// order_detail_number를 세팅하기 위해 -0425 근지
				query = "select max(order_detail_number) from userOrder_detail";
				pstmt = conn.prepareStatement(query);
				
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					number = rs.getInt(1)+1;
				} else {
					number=1;
				}
				
				query = "insert into userOrder_detail(order_detail_number,order_number,product_number"
						+ ",product_count,product_price,order_detail_status,refund_check)"
						+ " values(?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(query);
				
				
				pstmt.setInt(1, number);
				pstmt.setString(2, order_number);
				pstmt.setInt(3, cart.getProduct_number());
				pstmt.setInt(4, cart.getProduct_count());
				pstmt.setInt(5, product_price);
				pstmt.setString(6, "입금완료");
				pstmt.setString(7, "no");
				pstmt.executeUpdate();
				
				// 주문 상품 재고 줄이는 쿼리	-0422근지
				query = "Update product set product_stock=product_stock-? where product_number=? ";
				pstmt = conn.prepareStatement(query);
				
				pstmt.setInt(1, cart.getProduct_count());
				pstmt.setInt(2, cart.getProduct_number());
				pstmt.executeUpdate();
				
				// 구매한 상품 장바구니에서 삭제하는 쿼리	-0425근지
				query = "delete from cart where cart_number=? ";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, cart_num);
				pstmt.executeUpdate();
			}
			
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
	
	
	public int getUserRefundCheck(int order_detail_number) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select refund_check from userorder_detail where order_detail_number = ?";
		int re = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_detail_number);
			rs = pstmt.executeQuery();
			
			
			if (rs.next()) {
				if(rs.getString(1).equals("check")) re = 1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
		}
	
	public  ArrayList<UserOrderDetailBean> getUserOrderDetail(String user_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		String sql = "select * from user_order  where user_id = ?";
		
		ArrayList<UserOrderDetailBean> detailarr = new ArrayList<UserOrderDetailBean>();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			UserOrderDetailBean uodb = null;
			while (rs.next()) {
				sql = "select * from userOrder_detail where order_number = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, rs.getString("order_number"));
				rs1 = pstmt.executeQuery();
				while(rs1.next()) {
					uodb = new UserOrderDetailBean();
					uodb.setOrder_detail_number(rs1.getInt("order_detail_number"));
					uodb.setOrder_number(rs1.getString("order_number"));
					uodb.setProduct_number(	rs1.getInt("product_number"));
					uodb.setProduct_count(rs1.getInt("product_count"));
					uodb.setProduct_price(rs1.getInt("product_price"));
					uodb.setOrder_detail_status(rs1.getString("order_detail_status"));
					uodb.setRefund_check(rs1.getString("refund_check"));
					detailarr.add(uodb);	
				}
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return detailarr;
		}
	
	//입금했을때처리
	public  ArrayList<UserOrderDetailBean> updateUserOrderDetail(String user_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		String sql = "select * from user_order  where user_id = ?";
		
		ArrayList<UserOrderDetailBean> detailarr = new ArrayList<UserOrderDetailBean>();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			UserOrderDetailBean uodb = null;
			while (rs.next()) {
				sql = "select * from userOrder_detail where order_number = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, rs.getString("order_number"));
				rs1 = pstmt.executeQuery();
				while(rs1.next()) {
					uodb = new UserOrderDetailBean();
					uodb.setOrder_detail_number(rs1.getInt("order_detail_number"));
					uodb.setOrder_number(rs.getString("order_number"));
					uodb.setProduct_number(	rs1.getInt("product_number"));
					uodb.setProduct_count(rs1.getInt("product_count"));
					uodb.setProduct_price(rs1.getInt("product_price"));
					uodb.setOrder_detail_status(rs1.getString("order_detail_status"));
					uodb.setRefund_check(rs1.getString("refund_check"));
					detailarr.add(uodb);	
				}
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return detailarr;
		}
	
	public int goodsRefundRequest(UserOrderDetailBean uodbean) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//UserOrderDetailBean uodb = new UserOrderDetailBean();
		int re = -1;
		String sql = "update userorder_detail set refund_check= ? where order_detail_number=?";
		//String sql = "select * from userorder_detail  where order_number = ?";
		int num=1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "check");
			pstmt.setInt(2, uodbean.getOrder_detail_number());
			re = pstmt.executeUpdate();
			
			sql = "select max(refund_number) from userorder_refund";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				  num = rs.getInt(1)+1;
			}else {
				 num =1;
			}

			sql = "insert into userOrder_refund VALUES(?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setInt(2, uodbean.getOrder_detail_number());
			pstmt.setString(3, uodbean.getRefund_reason());
			pstmt.setString(4, uodbean.getRefund_img());
			pstmt.setString(5, uodbean.getUser_email());
			re = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
	
	
	//관리자 주문관리를 위한 전체주문리스트 불러오는 메서드 - 0429 진용 
		public  ArrayList<UserOrderDetailBean> getAllUserOrderDetail() {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs1 = null;
			ResultSet rs2 = null;
			String sql = "select * from user_order";
			
			ArrayList<UserOrderDetailBean> detailarr = new ArrayList<UserOrderDetailBean>();
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				rs1 = pstmt.executeQuery();
				int cnt=0;
				
				UserOrderDetailBean uodb = null;
				while (rs1.next()) {
					sql = "select * from userOrder_detail order by order_number desc";
					pstmt = conn.prepareStatement(sql);
					rs2 = pstmt.executeQuery();
					while(rs2.next()) {
						uodb = new UserOrderDetailBean();
						uodb.setOrder_detail_number(rs2.getInt("order_detail_number"));
						uodb.setOrder_number(rs2.getString("order_number"));
						uodb.setProduct_number(	rs2.getInt("product_number"));
						uodb.setProduct_count(rs2.getInt("product_count"));
						uodb.setProduct_price(rs2.getInt("product_price"));
						uodb.setOrder_detail_status(rs2.getString("order_detail_status"));
						uodb.setRefund_check(rs2.getString("refund_check"));
						detailarr.add(uodb);
						
						cnt++;
					}
					if (cnt > 1) {
						break;
					}
					
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs2 != null)
						rs2.close();
					if (rs1 != null)
						rs1.close();
					if (pstmt != null)
						pstmt.close();
					if (conn != null)
						conn.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			return detailarr;
		}
	
	
}
