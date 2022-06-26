package notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class QnADBBean {
	private static QnADBBean instance=new QnADBBean();
	public static QnADBBean getInstance() {
		return instance;
	}

	public Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}

	public ArrayList<QnABean> getMyboardlist(String user_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<QnABean> boards = new ArrayList<QnABean>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM qna_board WHERE u_id = ?");
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				QnABean qbean = new QnABean();
				qbean.setB_id(rs.getInt("b_id"));
				qbean.setU_id(rs.getString("u_id"));
				qbean.setB_category(rs.getString("b_category"));
				//System.out.println(rs.getString("b_category"));
				qbean.setB_view(rs.getInt("b_view"));
				qbean.setB_title(rs.getString("b_title"));
				qbean.setB_content(rs.getString("b_content"));
				qbean.setB_ip(rs.getString("b_ip"));
				qbean.setB_pwd(rs.getString("b_pwd"));
				qbean.setB_date(rs.getTimestamp("b_date"));
				qbean.setB_secret(rs.getString("b_secret"));
				qbean.setB_ref(rs.getInt("b_ref"));
				qbean.setB_level(rs.getInt("b_level"));
				qbean.setB_step(rs.getInt("b_step"));
				qbean.setB_fname(rs.getString("b_fname"));
				qbean.setB_fsize(rs.getInt("b_fsize"));
				qbean.setB_rfname(rs.getString("b_rfname"));
				qbean.setB_anschk(rs.getString("b_anschk"));
				boards.add(qbean);
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return boards;
	}
	
	
	public QnABean getBoard(int b_id, boolean isView) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmtup=null;
		ResultSet rs = null;
		QnABean board = null;

		try {
			conn = getConnection();
			
			if (isView == true) {
				pstmtup = conn.prepareStatement("update qna_board set b_view=b_view+1 where b_id=?");
				pstmtup.setInt(1, b_id);
				pstmtup.executeUpdate();
				pstmtup.close();
			}
			
			pstmt = conn.prepareStatement("SELECT * FROM qna_board WHERE b_id = ?");
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				board = new QnABean();
				
				board.setB_id(rs.getInt("b_id"));
				board.setU_id(rs.getString("u_id"));
				board.setB_category(rs.getString("b_category"));
				board.setB_view(rs.getInt("b_view"));
				board.setB_title(rs.getString("b_title"));
				board.setB_content(rs.getString("b_content"));
				board.setB_ip(rs.getString("b_ip"));
				board.setB_pwd(rs.getString("b_pwd"));
				board.setB_date(rs.getTimestamp("b_date"));
				board.setB_secret(rs.getString("b_secret"));
				board.setB_ref(rs.getInt("b_ref"));
				board.setB_level(rs.getInt("b_level"));
				board.setB_step(rs.getInt("b_step"));
				board.setB_fname(rs.getString("b_fname"));
				board.setB_fsize(rs.getInt("b_fsize"));
				board.setB_rfname(rs.getString("b_rfname"));
				board.setB_anschk(rs.getString("b_anschk"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return board;
	}
	
	public ArrayList<QnABean> getList(String pageNumber) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet pageSet = null;	//�뜝�럥�쓡�뜝�럩逾좂춯�쉻�삕�뵓怨뺣쐡占쎄퉰占쎈ご�뜝占� �뛾�룇猷꾤뵳怨ㅼ삕占쎈쭊�뜝�럥�돵
		int dbCount=0;	//�뜝�럥�쓡�뜝�럩逾좂춯�쉻�삕 �뵓怨뺣쐡占쎄퉰�뜝�럩踰� �뤆�룇裕뉛옙�빢占쎈ご�뜝占� �뛾�룇猷꾤뵳占� �뜝�럩留꾢뜝�럥由� �솻洹⑥삕�뜝�럥�빢
		int absolutePage=1;	//占쎈퉲占쎈츊占쎌졑�뜝�럥留� �뜝�럥�쓡�뜝�럩逾좂춯�쉻�삕
		
		ArrayList<QnABean> boards = new ArrayList<QnABean>();

		try {
			conn = getConnection();
			
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pageSet = stmt.executeQuery("select count(b_id) from qna_board");
			
			if (pageSet.next()) {	
				dbCount = pageSet.getInt(1);
				pageSet.close();
				stmt.close();
			}
			
			if (dbCount % QnABean.pageSize == 0) {	//80
				QnABean.pageCount = dbCount / QnABean.pageSize;
			} else {	//84
				QnABean.pageCount = dbCount / QnABean.pageSize + 1;
			}
			
			if (pageNumber != null) {
				QnABean.pageNum = Integer.parseInt(pageNumber);
				//1: 0*10+1=1, 2: 1*10+1=11
				absolutePage = (QnABean.pageNum - 1) * QnABean.pageSize + 1;
			}	
			
			pstmt = conn.prepareStatement("SELECT * FROM notice ORDER BY n_num desc");
			
			int count = 0;
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				if (count == 3) {
					break;
				}
				QnABean board = new QnABean();
				board.setN_num(rs.getInt(1));
				board.setN_title(rs.getString(2));
				board.setN_content(rs.getString(3));
				board.setN_date(rs.getTimestamp(4));
				board.setN_hit(rs.getInt(5));
				board.setN_pwd(rs.getString(6));
				board.setN_ip(rs.getString(7));
				boards.add(board);
				count++;
			}
			
			String sql = "SELECT * FROM qna_board order by b_ref desc, b_step asc";
			pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				rs.absolute(absolutePage);
				//System.out.println("@@@qnalist1>>>");
				
				int cnt = 0;
			
				while (cnt < QnABean.pageSize) {
					QnABean board = new QnABean();
					board.setB_id(rs.getInt("b_id"));
					board.setU_id(rs.getString("u_id"));
					board.setB_category(rs.getString("b_category"));
					board.setB_view(rs.getInt("b_view"));
					board.setB_title(rs.getString("b_title"));
					board.setB_content(rs.getString("b_content"));
					board.setB_ip(rs.getString("b_ip"));
					board.setB_pwd(rs.getString("b_pwd"));
					board.setB_date(rs.getTimestamp("b_date"));
					board.setB_secret(rs.getString("b_secret"));
					board.setB_ref(rs.getInt("b_ref"));
					board.setB_level(rs.getInt("b_level"));
					board.setB_step(rs.getInt("b_step"));
					board.setB_fname(rs.getString("b_fname"));
					board.setB_fsize(rs.getInt("b_fsize"));
					board.setB_anschk(rs.getString("b_anschk"));
					boards.add(board);
					
					if (rs.isLast()) {
						break;
					} else {
						rs.next();
					}
	 				
	 				cnt++;
	 				//System.out.println("@@@qnalist2>>>");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return boards;
	}

	
	public int writeBoard(QnABean board) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int isWrite = -1;
		int number;
		
		int id = board.getB_id();
		int ref = board.getB_ref(); //�뜝�럥堉쀧솻洹⑥삕�뼨�먯삕�뜝�럩踰� �뵓怨뺣쐡占쎄퉰 占쎈퉲占쎈츊占쎌졑
		int step = board.getB_step(); //�뜝�럥堉쀧솻洹⑥삕�뼨�먯삕�뜝�럩逾좂춯濡녹삕 �뜝�럥�뼪�뜝�럩�겱 1�뜝�럥�럠 嶺뚯빘鍮볟뜝占�
		int level = board.getB_level();	//�뜝�럥堉쀧솻洹⑥삕�뼨�먯삕�뜝�럩逾� �뜝�럥堉롳옙逾놂옙�맓�듆 1 嶺뚯빘鍮볟뜝占�
		
		try {
			conn = getConnection();
			rs = conn.prepareStatement("SELECT MAX(b_id) FROM qna_board").executeQuery();
			if (rs.next()) {
				number = rs.getInt(1) + 1;	//�뤆�룆占썬굦逾� �뜝�럩肉녑뜝�럩諭� �뇦猿뗫윪占쎈뮡�뜝�럩逾좂뼨�먯삕 �뜝�럥瑜댐옙�닱筌뤾쑬�뱺 +1
			} else {
				number = 1;	//�뤆�룆占썬굦逾� �뜝�럥�뵪�뜝�럩諭� �뇦猿뗫윪占쎈뮡
			}
			if (id != 0) {	//id�뤆�룊�삕 0�뜝�럩逾� �뜝�럥�닡�뜝�럥鍮띸춯濡녹삕 �뜝�럥堉쀧뼨�먯삕�슖�댙�삕 占쎄괌�뜝占�
				String sql="UPDATE qna_board SET b_step = b_step+1"
						+ " WHERE b_ref=? and b_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, step);
				pstmt.executeUpdate();
				
				step=step+1;
				level=level+1;
			} else {	// �뜝�럥堉쀧뼨�먯삕�뜝�럩逾� �뜝�럥�닡�뜝�럥鍮� �뜝�럥瑜� (�뼨�먯삕�뜝�럥苡븀뼨�먯삕 �뜝�럩逾� �뜝�럥瑜�)
				ref= number;	//ref�뜝�럥�뱺 �뼨�먯삕 �뵓怨뺣쐡占쎄퉰�뤆�룊�삕 �뜝�럥援뜹뜝�럥�꽑�뤆�룊�삕�뇦猿볦삕 �뜝�럥彛�
				step=0;
				level=0;
			}
			
			
			pstmt = conn.prepareStatement("INSERT INTO qna_board "
					+ "(b_id, u_id, b_category, b_title, b_content, "
					+ "b_ip, b_pwd, b_date, b_secret, b_ref, b_level, b_step, "
					+ "b_fname, b_fsize, b_rfname, b_anschk)"
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

			pstmt.setInt(1, number);
			pstmt.setString(2, board.getU_id());
			pstmt.setString(3, board.getB_category());
			pstmt.setString(4, board.getB_title());
			pstmt.setString(5, board.getB_content());
			pstmt.setString(6, board.getB_ip());
			pstmt.setString(7, board.getB_pwd());
			pstmt.setTimestamp(8, board.getB_date());
			pstmt.setString(9, board.getB_secret());
			pstmt.setInt(10, ref);
			pstmt.setInt(11, level);
			pstmt.setInt(12, step);
			pstmt.setString(13, board.getB_fname());
			pstmt.setInt(14, board.getB_fsize());
			pstmt.setString(15, board.getB_rfname());
			pstmt.setString(16, board.getB_anschk());
			pstmt.executeUpdate();
			
			isWrite = 1;
			System.out.println("疫뀐옙占쎈쾺疫뀐옙 占쎄쉐�⑨옙");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("疫뀐옙占쎈쾺疫뀐옙 占쎈뼄占쎈솭");
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return isWrite;
	}
	
	public int deleteBoard(int b_id, String b_pwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String pwd="";
		int isDelete = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select b_pwd from qna_board where b_id=?");
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				pwd =rs.getString(1);
				pstmt = conn.prepareStatement("DELETE FROM qna_board WHERE b_id = ?");
				pstmt.setInt(1, b_id);
				isDelete = pstmt.executeUpdate();			
			}else {
				isDelete = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return isDelete;
	}
	
	public int adminDeleteBoard(int b_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int isDelete = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from qna_board where b_id=?");
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				pstmt = conn.prepareStatement("DELETE FROM qna_board WHERE b_id = ?");
				pstmt.setInt(1, b_id);
				isDelete = pstmt.executeUpdate();			
			}else {
				isDelete = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return isDelete;
	}
	
	public int editBoard(QnABean board) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String pwd="";
		int isEdit = 0;

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select b_pwd from qna_board where b_id=?");
			pstmt.setInt(1, board.getB_id());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				pwd = rs.getString(1);
				if (pwd.equals(board.getB_pwd())) {
					pstmt = conn.prepareStatement("UPDATE qna_board SET b_title = ?, b_content = ?, "
							+ "b_secret = ?, b_category = ?, b_ip = ?, b_fname = ?, b_fsize = ?, b_rfname = ? WHERE b_id = ?");
					pstmt.setString(1, board.getB_title());
					pstmt.setString(2, board.getB_content());
					pstmt.setString(3, board.getB_secret());
					pstmt.setString(4, board.getB_category());
					pstmt.setString(5, board.getB_ip());
					pstmt.setString(6, board.getB_fname());
					pstmt.setInt(7, board.getB_fsize());
					pstmt.setString(8, board.getB_rfname());
					pstmt.setInt(9, board.getB_id());
					isEdit = pstmt.executeUpdate();	
				} else {
					isEdit = 0;
				}
			} 			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return isEdit;
	}	

	public QnABean getFileName(int bid) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		QnABean board = null;
		
		try {
			conn = getConnection();
			sql = "select b_fname, b_rfname from qna_board where b_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bid);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				board = new QnABean();
				board.setB_fname(rs.getString(1));
				board.setB_rfname(rs.getString(2));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return board;
	}
	
	//�꽴占썹뵳�딆쁽 占쎈뼗癰귨옙占쎌뱽 占쎌맄占쎈립 筌욌뜄揆 �뵳�딅뮞占쎈뱜�몴占� �겫�뜄�쑎占쎌궎占쎈뮉 筌롫뗄�꺖占쎈굡 - 0502 筌욊쑴�뒠
	public ArrayList<QnABean> getAdminBoardList(String user_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<QnABean> boards = new ArrayList<QnABean>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM qna_board WHERE u_id != ? "
										+ "AND b_anschk = 0 "
										+ "ORDER BY b_id desc");
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				QnABean qbean = new QnABean();
				qbean.setB_id(rs.getInt("b_id"));
				qbean.setU_id(rs.getString("u_id"));
				qbean.setB_category(rs.getString("b_category"));
				qbean.setB_view(rs.getInt("b_view"));
				qbean.setB_title(rs.getString("b_title"));
				qbean.setB_content(rs.getString("b_content"));
				qbean.setB_ip(rs.getString("b_ip"));
				qbean.setB_pwd(rs.getString("b_pwd"));
				qbean.setB_date(rs.getTimestamp("b_date"));
				qbean.setB_secret(rs.getString("b_secret"));
				qbean.setB_ref(rs.getInt("b_ref"));
				qbean.setB_level(rs.getInt("b_level"));
				qbean.setB_step(rs.getInt("b_step"));
				qbean.setB_fname(rs.getString("b_fname"));
				qbean.setB_fsize(rs.getInt("b_fsize"));
				qbean.setB_rfname(rs.getString("b_rfname"));
				qbean.setB_anschk(rs.getString("b_anschk"));
				boards.add(qbean);
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return boards;
	}
	
	//占쎌뵠沃섓옙 占쎈뼗癰귨옙占쎌뱽 占쎌읅占쏙옙 疫뀐옙占쎌뱽 �뤃�됲뀋占쎈릭占쎈뮉 筌롫뗄�꺖占쎈굡 - 0502 筌욊쑴�뒠
	
	  public int alreadyAnswered(QnABean board) throws Exception { 
		  Connection conn = null; 
		  PreparedStatement pstmt = null; 
		  ResultSet rs = null; 
		  int isAnswered = 0;
	  
		  try { 
			  conn = getConnection(); 
			  pstmt = conn.prepareStatement("select b_id from qna_board where b_ref=?");
				pstmt.setInt(1, board.getB_ref());
				rs = pstmt.executeQuery();
			  
			  if(rs.next()) {
				  if (board.getB_id() == board.getB_ref()) { 
					  pstmt = conn.prepareStatement("UPDATE qna_board SET b_anschk= ? WHERE b_id=?");
					  pstmt.setString(1, "1");
					  pstmt.setInt(2, board.getB_id());
					  isAnswered = pstmt.executeUpdate();
				  	}
			  } else { 
				  isAnswered = 0; 
			  } 
		  } catch (Exception e) { 
			  e.printStackTrace(); 
		  } finally { 
			  try { 
				  if(rs != null) rs.close(); 
				  if(pstmt != null) pstmt.close();
				  if(conn != null) conn.close(); 
			} catch (Exception e2) { 
				e2.printStackTrace();
		  	} 
		  }
	  
		  return isAnswered; 
	  }
	
	  
}
