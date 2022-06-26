package login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDBBean {
	private static UserDBBean instance = new UserDBBean();
	
	// UserDBBean 객체 생성하는 메서드 - 0415 근지
	public static UserDBBean getInstance() {
		return instance;
	}
	
	// db와 연결하는 메서드 - 0415 근지
	public Connection getConnection() throws Exception {
		Connection conn = null;
		conn = ((DataSource)(new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
		return conn;
	}
	
	// register에서 user를 받아 db에 저장하는 메서드 - 0415 근지
	public int insertUser(UserBean user) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "insert into user_table(user_id,user_pwd,user_name,user_phone,user_email,user_addr,user_grade)"
					 + " values(?,?,?,?,?,?,?)";
		int re = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user.getUser_id());
			pstmt.setString(2, user.getUser_pwd());
			pstmt.setString(3, user.getUser_name());
			pstmt.setString(4, user.getUser_phone());
			pstmt.setString(5, user.getUser_email());
			pstmt.setString(6, user.getUser_addr());
			pstmt.setString(7, "B");
			
			re = pstmt.executeUpdate();
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
	
	public int confirmUserId(String user_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select * from user_table where user_id=?";
		int re = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,user_id);	// 매개변수로 받은 user_id값 넣기 - 0415 근지
			rs = pstmt.executeQuery();
			
			// 중복된 user_id값 있는지 판단하기 위한 if문 - 0415 근지
			if (rs.next()) {
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
	
	// 사용자 인증시 사용하는 메서드 - 0415 근지
	public int userCheck(String user_id, String user_pwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		ResultSet rs = null;
		String query = "select user_pwd from user_table where user_id=?";
		
		
		int re = -1;
		String db_pwd;
		
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,user_id);	// 매개변수로 받은 user_id값 넣기 - 0415 근지
			rs = pstmt.executeQuery();
			
			
			if (rs.next()) {	// 아이디가 일치하는 로우 존재 - 0415 근지
				db_pwd = rs.getString("user_pwd");
				
				if (db_pwd.equals(user_pwd)) {	// 패스워드도 일치 - 0415 근지
					re = 1;
				
				} else {	// 패스워드가 불일치 - 0415 근지
					re = 0;
					
				}
			} else {	// 해당 아이디가 존재하지 않음 - 0415 근지
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
	
	// 아이디가 일치하는 멤버의 정보를 얻어오는 메서드 - 0415 근지
	public UserBean getUser(String user_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select * from user_table where user_id=?";
		UserBean user = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,user_id);	// 매개변수로 받은 user_id값 넣기 - 0415 근지
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	// 유저네임이 일치하는 로우 존재 - 0415 근지
				user = new UserBean();
				user.setUser_id(rs.getString("user_id"));
				user.setUser_pwd(rs.getString("user_pwd"));
				user.setUser_name(rs.getString("user_name"));
				user.setUser_phone(rs.getString("user_phone"));
				user.setUser_email(rs.getString("user_email"));
				user.setUser_addr(rs.getString("user_addr"));
				user.setUser_grade(rs.getString("user_grade"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return user;
	}
	
	// 탈퇴당한 멤버의 정보를 얻어오는 메서드 - 0415 근지
	public String bannedUser(String user_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select * from user_table where user_id=?";
		UserBean user = null;
		String pwd = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,user_id);	
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	
				user = new UserBean();
				user.setUser_id(rs.getString("user_id"));
				user.setUser_pwd(rs.getString("user_pwd"));
			}
			
			pwd = user.getUser_pwd();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return pwd;
	}
	
	// 회원 정보 테이블 내의 특정 행의 값을 변경하는 메서드 - 0415 근지
	public int updateUser(UserBean user) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int re = -1;

		String query = "update user_table set user_pwd=?, user_email=?, user_phone=?, user_addr=? where user_id=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,user.getUser_pwd());
			pstmt.setString(2,user.getUser_email());
			pstmt.setString(3,user.getUser_phone());
			pstmt.setString(4,user.getUser_addr());
			pstmt.setString(5,user.getUser_id());
			re = pstmt.executeUpdate();
			
			System.out.println("변경 성공");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("변경 실패");
		} finally {
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return re;
	}
	
	// 회원 탈퇴 메서드 - 0415 근지
	public int outUser(String user_id,String user_pwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int re = -1;
		
		
	
		int check = userCheck(user_id,user_pwd);
		
		String query = "delete from cart where user_id=?";
		
	
		
		if(check!=0) {
			try {
				conn = getConnection();
			
				pstmt = conn.prepareStatement(query);
			
				pstmt.setString(1,user_id);
			
				re = pstmt.executeUpdate();
				
				
			
				query = "delete from user_table where user_id=?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1,user_id);
				re = pstmt.executeUpdate();
				
				
				System.out.println("삭제 성공");
			} catch(Exception e) {
				e.printStackTrace();
				System.out.println("삭제 실패");
			} finally {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
		}else {
			re=0;
		}
		
		return re;
	}
	
	// 이메일을 통해 사용자 아이디를 찾는 메서드 - 0416 근지
	public String tryToFindId(String email) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select user_id from user_table where user_email=?";
		
		String user_id = "";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,email);	// 매개변수로 받은 email값 넣기 - 0416 근지
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	// 이메일이 일치하는 로우 존재 - 0416 근지
				user_id = rs.getString("user_id");
			} else {	// 해당 이메일이 존재하지 않음 - 0416 근지
				user_id = null;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return user_id;
	}
	
	// 아이디, 이메일을 통해 사용자 패스워드를 찾는 메서드 - 0416 근지
	public String tryToFinPwd(String id, String email) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select user_pwd from user_table where user_id=? and user_email=?";
		
		String user_pwd = "";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,id);	// 매개변수로 받은 id값 넣기 - 0416 근지
			pstmt.setString(2,email);	// 매개변수로 받은 email값 넣기 - 0416 근지
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	// 일치하는 로우 존재 - 0416 근지
				user_pwd = rs.getString("user_pwd");
			} else {	// 존재하지 않음 - 0416 근지
				user_pwd = null;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return user_pwd;
	}
	
	//로그인한 회원이 관리자인지 확인하는 메서드 - 0419 진용
	public boolean isAdmin(String user_id) throws SQLException {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = null;

		String SQL = "SELECT user_grade FROM user_table WHERE user_id = ?";
		boolean isAdmin = false;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				isAdmin = (rs.getString("user_grade").equals("C") );
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}

		return isAdmin;
	}
	
	// 탈퇴시킨 회원을 확인하는 메서드 - 0422 진용 
		public UserBean defineUserId(String u_id) throws SQLException {
			ResultSet rs = null;
			PreparedStatement pstmt = null;
			Connection conn = null;
			
			System.out.println("????"+u_id);
			String sql = "SELECT user_id, user_grade FROM user_table WHERE user_id = ?"; 
			UserBean user = null;
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					String id = rs.getString("user_id");
					user = new UserBean(id);
					user.setUser_grade(rs.getString("user_grade"));
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			
			return user;
		}
		
		public int deleteUser(String delete_uid) throws SQLException {
			ResultSet rs = null;
			PreparedStatement pstmt = null;
			Connection conn = null;
			String sql = "UPDATE user_table SET user_pwd = '-1', user_name = '-탈퇴', user_phone = '000-0000-0000', "
					+ "user_email = 'unknown', user_addr='unknown', user_grade = 'D' WHERE user_id = ?";
			int isDelete = -1;

			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, delete_uid);
				isDelete = pstmt.executeUpdate();
				System.out.println("@@@@@@@ 탈퇴 처리(" + isDelete + "): " + delete_uid);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}

			return isDelete;
		}
		
		// 회원 목록을 불러오는 메서드 - 0422 진용
		public ArrayList<UserBean> listUsers() throws SQLException {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ArrayList<UserBean> uList = new ArrayList<UserBean>();
			String sql ="SELECT "
					+ "u.user_id, user_name, user_phone, user_email, user_addr, user_grade, o_count "
					+ "FROM user_table u, (SELECT user_id, COUNT(*) AS o_count FROM user_order GROUP BY user_id) o "
					+ "WHERE u.user_id = o.user_id(+) ORDER BY user_grade DESC, u.user_id DESC";
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					String userId = rs.getString("user_id");
					String userName = rs.getString("user_name");
					String userPhone = rs.getString("user_phone");
					String userEmail = rs.getString("user_email");
					String userAddr = rs.getString("user_addr");
					String userGrade = rs.getString("user_grade");
					int userPurchase = rs.getInt("o_count");

					UserBean user = new UserBean( //
							userId, //
							"-1", // userPassword,
							userName, //
							userPhone, //
							userEmail, //
							userAddr, //
							userGrade // 
							);
					
					user.setUserPurchase(userPurchase);

					uList.add(user);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}

			return uList;
		}
}

