
package goods;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import cart.CartBean;
import cart.CartDBBean;



public class GoodsDBBean {
	private static GoodsDBBean instance = new GoodsDBBean();
	
	// UserDBBean 객체 생성하는 메서드 - 0418 근지
	public static GoodsDBBean getInstance() {
		return instance;
	}
	
	// db와 연결하는 메서드 - 0418 근지
	public Connection getConnection() throws Exception {
		Connection conn = null;
		conn = ((DataSource)(new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
		return conn;
	}
	
	public ArrayList<GoodsBean> myList() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select * from mylist order by 2 desc";
		GoodsBean goods = null;
		ArrayList<GoodsBean> mylist = new ArrayList<GoodsBean>();
		 Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			int count = 0;
			while (rs.next()) {
				if(count<5) {
					
					goods = new GoodsBean();
					goods.setProduct_number(rs.getInt("product_number"));
					rs.getString(2);
					mylist.add(goods);	
				}else {
					query = " DELETE FROM mylist" + 
							" WHERE product_number = ? and product_date = ?";
					pstmt = conn.prepareStatement(query);
					pstmt.setInt(1, rs.getInt(1));
					pstmt.setString(2, rs.getString(2));
					pstmt.executeUpdate();
					System.out.println("삭제되었습니다.");
				}
				count ++;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return mylist;
	}
	
	
	public int insertMyList(int product_number) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re = -1;
		String query = "INSERT into mylist VALUES(?,?)";
		GoodsBean goods = null;
		ArrayList<GoodsBean> mylist = new ArrayList<GoodsBean>();
		 Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, product_number);
			pstmt.setString(2, String.valueOf(timestamp));
			re = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return re;
	}
	
	
	// product_number 일치하는 goods의 정보를 얻어오는 메서드 - 0418 근지
	public GoodsBean getGoods(int product_number) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String query = "select * from product where product_number=?";
			GoodsBean goods = null;
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, product_number);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					goods = new GoodsBean();
					goods.setProduct_number(rs.getInt("product_number"));
					goods.setCategory_code(rs.getString("category_code"));
					goods.setProduct_name(rs.getString("product_name"));
					goods.setProduct_price(rs.getInt("product_price"));
					goods.setProduct_stock(rs.getInt("product_stock"));
					goods.setProduct_desc(rs.getString("product_desc"));
					goods.setProduct_date(rs.getTimestamp("product_date"));
					goods.setProduct_hits(rs.getInt("product_hits"));
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return goods;
		}
	
	// product_number 일치하는 goods의 이미지를 얻어오는 메서드 - 0429 근지
	public GoodsBean getGoodsImg(int product_number) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select * from product_imagefile where product_number=?";
		GoodsBean goods = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, product_number);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				goods = new GoodsBean();
				goods.setFile_number(rs.getInt("file_number"));
				goods.setProduct_number(rs.getInt("product_number"));
				goods.setOrgin_file_name(rs.getString("orgin_file_name"));
				goods.setStored_file_name(rs.getString("stored_file_name"));
				goods.setStored_thumbnail(rs.getString("stored_thumbnail"));
				goods.setDelegate_thumbnail(rs.getString("delegate_thumbnail"));
				goods.setFile_size(rs.getInt("file_size"));
				goods.setCreate_date(rs.getTimestamp("create_date"));
				goods.setDelete_check(rs.getString("delete_check"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return goods;
	}
					
	public int deleteGoods(int product_number) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = null;
		int re = -1;
		try {
			conn = getConnection();
			query = " delete from product where product_number = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, product_number);
			re =pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
				try {
					if(pstmt!=null) pstmt.close();
					if(conn!=null) conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
		return re;
	}
		
		
		
		//세부이미지                       //이미지한개일때 이미지삭제하려고 참이면 한개 false 두개
	public int updateGoods(GoodsBean goods, boolean stored_thumbnail, boolean imgs) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 String query = null;
		int re = -1;
		try {
			conn = getConnection();
			
			if(stored_thumbnail == false) {
				 query = "update product" + 
						" set Product_name = ?"
						+ ",Product_price = ?"
						+ ",Product_desc = ?"
						+ ",Category_code  = ?" + 
						"where product_number = ?";
				pstmt = conn.prepareStatement(query);
			    pstmt.setString(1, goods.getProduct_name());
			    pstmt.setInt(2, goods.getProduct_price());
			    pstmt.setString(3, goods.getProduct_desc());
			    pstmt.setString(4, goods.getCategory_code());
			    pstmt.setInt(5, goods.getProduct_number());
				re = pstmt.executeUpdate();
				
				query = "select file_number,stored_file_name"
						+ " from product_imagefile where product_number = ?";
				
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, goods.getProduct_number());
				rs = pstmt.executeQuery();
				
				re =-1;
				int count = 0;
				while(rs.next()) {  
					count ++;
					int file_number = rs.getInt("file_number");
					if(goods.getStored_file_name() !=null) {
						if(rs.getString("stored_file_name")!= null){
							query = "update product_imagefile" + 
									" set orgin_file_name = ?, stored_file_name = ?" + 
									" where file_number = ?";
							pstmt = conn.prepareStatement(query);
							pstmt.setString(1, goods.getOrgin_file_name());
							pstmt.setString(2, goods.getStored_file_name());
							pstmt.setInt(3, file_number);
							re = pstmt.executeUpdate();
						}
					}
					
					 if(imgs == false && count ==2) {
						  query = " delete from product_imagefile where stored_thumbnail is not null and product_number = ?";
							pstmt = conn.prepareStatement(query);
							pstmt.setInt(1, goods.getProduct_number());
							 pstmt.executeUpdate();
					  }
				}
				
			
				  if(re == -1) {   //대표이미지가없을때처리 
					  query = "select file_number " +
							  		" from product_imagefile where product_number = ?"
							  		+ " order by file_number"; 
					  pstmt = conn.prepareStatement(query); 
					  pstmt.setInt(1, goods.getProduct_number());
					  rs = pstmt.executeQuery();
					
					  if(rs.next()) {
						  query = "update product_imagefile" + 
									" set orgin_file_name = ?, stored_file_name = ?" + 
									" where file_number = ?";
						  pstmt = conn.prepareStatement(query);
						  pstmt.setString(1, goods.getOrgin_file_name());
						  pstmt.setString(2, goods.getStored_file_name());
						  pstmt.setInt(3, rs.getInt("file_number"));
						  re = pstmt.executeUpdate();
					  }
					  
				  }
			}else {
				//System.out.println("상품이미지가두개입니다 DBB 안에있는 if 문");
				
				query = "select file_number,orgin_file_name,stored_file_name,stored_thumbnail"
						+ " from product_imagefile where product_number = ?"
						+ " order by file_number";
				
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, goods.getProduct_number());
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					
					if(goods.getStored_thumbnail() != null) {
						
						if(rs.getString("stored_thumbnail") != null) {
							query = "update product_imagefile" + 
									" set orgin_file_name = ?, stored_thumbnail = ?" + 
									" where file_number = ?"
									+ " order by file_number";
							  pstmt = conn.prepareStatement(query);
							  pstmt.setString(1, goods.getOrgin_file_name() );
							  pstmt.setString(2, goods.getStored_thumbnail() );
							  pstmt.setInt(3, rs.getInt("file_number"));
							  re = pstmt.executeUpdate();
						}
					}
					
					
				}
				 //상품 stored_thumbnail 이미지가없어서 추가
				if(re == -1) {
					
					query = "select MAX(file_number) from product_imagefile";
					 
					  pstmt = conn.prepareStatement(query);
					  rs = pstmt.executeQuery();
					
					  if(rs.next()) {
						   int file_number = rs.getInt(1);
						   file_number = file_number+1;
						
						  query = "insert into product_imagefile(file_number,product_number"
									+ ",orgin_file_name"
									+ ",stored_thumbnail"
									+ ") values (?,?,?,?)";
						  pstmt = conn.prepareStatement(query);
						  pstmt.setInt(1, file_number);
						  pstmt.setInt(2, goods.getProduct_number());
						  pstmt.setString(3, goods.getOrgin_file_name());
						  pstmt.setString(4, goods.getStored_thumbnail());
						  re = pstmt.executeUpdate();
						  
					  }
					
					
				}
				
		}
			 
			
			
//			re = 1;
			
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
	
	/////////////
	
	
	public int insertGoodss(GoodsBean goods, boolean stored_thumbnail) throws Exception { 
	  	Connection conn = null;
		PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 String query;
		 int product_number = 0;
			// 결과 출력
		 Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			int re = -1;
			int file_number = 0;
	  try { 
		  
		  
		  conn = getConnection();
		  query = "select MAX(product_number) from product";
			 
		  pstmt = conn.prepareStatement(query);
		  rs = pstmt.executeQuery();
		 
		  if(rs.next()) {
			  product_number =   rs.getInt(1);
		  }else {
			  product_number = 0;
		  }
		  
	  		if(stored_thumbnail == false) {

				  product_number=product_number+1;
				
				   query = "insert into product(product_number,category_code,product_name,product_price,product_stock"
							+ ",product_desc,product_date,product_hits,product_ordered_count) "
							+ " values (?,?,?,?,?,?,?,?,?)";
				   
				  pstmt = conn.prepareStatement(query);
				  pstmt.setInt(1, product_number) ;
				  pstmt.setString(2, goods.getCategory_code());
				  pstmt.setString(3, goods.getProduct_name());
				  pstmt.setInt(4, goods.getProduct_price());
				  pstmt.setInt(5, goods.getProduct_stock());
				  pstmt.setString(6, goods.getProduct_desc());
				  pstmt.setTimestamp(7, timestamp);
				  pstmt.setInt(8, 0);
				  pstmt.setInt(9, 0);
			
				  re = pstmt.executeUpdate(); 
				  
				  
				  query = "insert into product_imagefile(file_number,product_number"
							+ ",orgin_file_name"
							+ ",stored_file_name"
							+ ",create_date) values (?,?,?,?,?)";
				  
				  pstmt = conn.prepareStatement(query);
				  pstmt.setInt(1, product_number) ;
				  pstmt.setInt(2, product_number);
				  pstmt.setString(3, goods.getOrgin_file_name());
				  pstmt.setString(4, goods.getStored_file_name());
				  pstmt.setTimestamp(5, timestamp);
				  re = pstmt.executeUpdate(); 
				  re = 1;
			  }else {
				  
				  if(product_number==0) {
					  product_number = 1;
				  }
				  
				  
				  query = "select MAX(file_number) from product_imagefile";
					 
				  pstmt = conn.prepareStatement(query);
				  rs = pstmt.executeQuery();
				 
				  if(rs.next()) {
					  file_number =   rs.getInt(1);
				  }else {
					  file_number = 0;
				  }
				  file_number=file_number+1;
				  
				  
				   query = "insert into product_imagefile(file_number,product_number"
							+ ",orgin_file_name"
							+ ",stored_thumbnail"
							+ ",create_date) values (?,?,?,?,?)";
				  pstmt = conn.prepareStatement(query);
				  pstmt.setInt(1, file_number) ;
				  pstmt.setInt(2, product_number);
				  pstmt.setString(3, goods.getOrgin_file_name());
				  pstmt.setString(4, goods.getStored_file_name());
				  pstmt.setTimestamp(5, timestamp);
				  
				  re = pstmt.executeUpdate(); 
			  }
		
		  
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

	// 상품의 조회수를 올리는 메서드	-0429근지
	public void hitUp(int product_number) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = null;
		try {
			conn = getConnection();
			query = " update product set product_hits=product_hits+1 where product_number = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, product_number);
			pstmt.executeUpdate();
			
			System.out.println("조회수1증가");
		}catch (Exception e) {
			System.out.println("조회수증가안됨");
			e.printStackTrace();
		}finally {
				try {
					if(pstmt!=null) pstmt.close();
					if(conn!=null) conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
	}	
	
	// 상품 구매시 구매 카운트를 증가시키는 메서드	-0429근지
	public void orderedCountUp(int product_count, int product_number) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = null;
		try {
			conn = getConnection();
			query = " update product set product_ordered_count = product_ordered_count + ? where product_number = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, product_count);
			pstmt.setInt(2, product_number);
			pstmt.executeUpdate();
			
			System.out.println("구매수증가");
		}catch (Exception e) {
			System.out.println("구매수증가안됨");
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}	
	
	
	// 상품 구매시 구매 카운트를 증가시키는 메서드	-0429근지
	public void orderedCountUpArray(String[] cart_num_arr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = null;
		try {
			conn = getConnection();
			
			// 배열 크기만큼 저장	-0425근지
			for (int i = 0; i < cart_num_arr.length; i++) {
				int cart_num = Integer.parseInt(cart_num_arr[i]);
				CartDBBean cart_db = CartDBBean.getInstance();
				CartBean cart = cart_db.getCart_one(cart_num);
				
			query = " update product set product_ordered_count = product_ordered_count + ? where product_number = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, cart.getProduct_count());
			pstmt.setInt(2, cart.getProduct_number());
			pstmt.executeUpdate();
			}
			
			System.out.println("구매수-배열-증가");
		}catch (Exception e) {
			System.out.println("구매수-배열-증가안됨");
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}	
	
	// 많이 팔린 순으로 상품 들고오기 -0429근지
	public ArrayList<GoodsBean> getCategoryProductList_best(String category_code,String pageNumber ) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet pageSet = null;
		int dbCount=0;
		int absolutePage=1;
		
		String query = "select product_number"
							+ ",category_code"
							+ ",product_name"
							+ ",product_price"
							+ ",product_stock"
							+ ",product_desc"
							+ ",product_date"
							+ ",product_hits"
							+ " from product"
							+ "	where category_code = ?"
							+ " order by product_ordered_count desc";
		String query2="select count(product_number) from product where category_code = ?";
		ArrayList<GoodsBean> ProductArr = new ArrayList<GoodsBean>();
		GoodsBean product = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query2, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pstmt.setString(1, category_code);
			pageSet = pstmt.executeQuery();
			
			if (pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			
			if (dbCount % GoodsBean.pageSize == 0) {	//80
				GoodsBean.pageCount = dbCount / GoodsBean.pageSize;
			} else {	//84
				GoodsBean.pageCount = dbCount / GoodsBean.pageSize + 1;
			}
			
			if (pageNumber != null) {
				GoodsBean.pageNum = Integer.parseInt(pageNumber);
				//1: 0*10+1=1, 2: 1*10+1=11
				absolutePage = (GoodsBean.pageNum - 1) * GoodsBean.pageSize + 1;
			}
			
			rs = pstmt.executeQuery(query);
			if (rs.next()) {
				//System.out.println("값이있음?");
				rs.absolute(absolutePage);
				int count = 0;
			//System.out.println("여기까지는들어옴?");
			while (count < GoodsBean.pageSize) {
				product = new GoodsBean();
				product.setProduct_number(rs.getInt("product_number"));
				product.setCategory_code(rs.getString("category_code"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_stock(rs.getInt("product_stock"));
				product.setProduct_desc(rs.getString("product_desc"));
				product.setProduct_date(rs.getTimestamp("product_date")); 
				product.setProduct_hits(rs.getInt("product_hits"));
				//System.out.println(rs.getInt("product_number"));
				
				ProductArr.add(product);
				if (rs.isLast()) {
					break;
				} else {
					rs.next();
				}
 				
 				count++;
			}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return ProductArr;
	}
	
	// 조회순으로 상품 들고오기 -0502근지
	public ArrayList<GoodsBean> getCategoryProductList_hits(String category_code,String pageNumber) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		ResultSet pageSet = null;
		int dbCount=0;
		int absolutePage=1;
		String query = "select product_number"
				+ ",category_code"
				+ ",product_name"
				+ ",product_price"
				+ ",product_stock"
				+ ",product_desc"
				+ ",product_date"
				+ ",product_hits"
				+ " from product"
				+ "	where category_code = ?"
				+ " order by product_hits desc";
		String query2="select count(product_number) from product where category_code = ?";
		ArrayList<GoodsBean> ProductArr = new ArrayList<GoodsBean>();
		GoodsBean product = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query2, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pstmt.setString(1, category_code);
			pageSet = pstmt.executeQuery();
			
			if (pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			
			if (dbCount % GoodsBean.pageSize == 0) {	//80
				GoodsBean.pageCount = dbCount / GoodsBean.pageSize;
			} else {	//84
				GoodsBean.pageCount = dbCount / GoodsBean.pageSize + 1;
			}
			
			if (pageNumber != null) {
				GoodsBean.pageNum = Integer.parseInt(pageNumber);
				//1: 0*10+1=1, 2: 1*10+1=11
				absolutePage = (GoodsBean.pageNum - 1) * GoodsBean.pageSize + 1;
			}
			
			rs = pstmt.executeQuery(query);
			
			if (rs.next()) {
				//System.out.println("값이있음?");
				rs.absolute(absolutePage);
				int count = 0;
				
				while (count < GoodsBean.pageSize) {
					product = new GoodsBean();
					product.setProduct_number(rs.getInt("product_number"));
					product.setCategory_code(rs.getString("category_code"));
					product.setProduct_name(rs.getString("product_name"));
					product.setProduct_price(rs.getInt("product_price"));
					product.setProduct_stock(rs.getInt("product_stock"));
					product.setProduct_desc(rs.getString("product_desc"));
					product.setProduct_date(rs.getTimestamp("product_date")); 
					product.setProduct_hits(rs.getInt("product_hits"));
					//System.out.println(rs.getInt("product_number"));
					
					ProductArr.add(product);
					if (rs.isLast()) {
						break;
					} else {
						rs.next();
					}
	 				
	 				count++;
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return ProductArr;
	}
	
	// 가격 높은 순으로 상품 들고오기 -0502근지
	public ArrayList<GoodsBean> getCategoryProductList_price_desc(String category_code,String pageNumber) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet pageSet = null;
		int dbCount=0;
		int absolutePage=1;
		String query = "select product_number"
				+ ",category_code"
				+ ",product_name"
				+ ",product_price"
				+ ",product_stock"
				+ ",product_desc"
				+ ",product_date"
				+ ",product_hits"
				+ " from product"
				+ "	where category_code = ?"
				+ " order by product_price desc";
		
		String query2="select count(product_number) from product where category_code = ?";
		ArrayList<GoodsBean> ProductArr = new ArrayList<GoodsBean>();
		GoodsBean product = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query2, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pstmt.setString(1, category_code);
			pageSet = pstmt.executeQuery();
			

			if (pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			
			if (dbCount % GoodsBean.pageSize == 0) {	//80
				GoodsBean.pageCount = dbCount / GoodsBean.pageSize;
			} else {	//84
				GoodsBean.pageCount = dbCount / GoodsBean.pageSize + 1;
			}
			
			if (pageNumber != null) {
				GoodsBean.pageNum = Integer.parseInt(pageNumber);
				//1: 0*10+1=1, 2: 1*10+1=11
				absolutePage = (GoodsBean.pageNum - 1) * GoodsBean.pageSize + 1;
			}
			
			rs = pstmt.executeQuery(query);
			
			if (rs.next()) {
				//System.out.println("값이있음?");
				rs.absolute(absolutePage);
				int count = 0;
			
				while (count < GoodsBean.pageSize) {
					product = new GoodsBean();
					product.setProduct_number(rs.getInt("product_number"));
					product.setCategory_code(rs.getString("category_code"));
					product.setProduct_name(rs.getString("product_name"));
					product.setProduct_price(rs.getInt("product_price"));
					product.setProduct_stock(rs.getInt("product_stock"));
					product.setProduct_desc(rs.getString("product_desc"));
					product.setProduct_date(rs.getTimestamp("product_date")); 
					product.setProduct_hits(rs.getInt("product_hits"));
					//System.out.println(rs.getInt("product_number"));
					
					ProductArr.add(product);
					if (rs.isLast()) {
						break;
					} else {
						rs.next();
					}
					count++;
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return ProductArr;
	}
	
	// 가격 낮은 순으로 상품 들고오기 -0502근지
	public ArrayList<GoodsBean> getCategoryProductList_price(String category_code,String pageNumber) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet pageSet = null;
		int dbCount=0;
		int absolutePage=1;
		String query = "select product_number"
				+ ",category_code"
				+ ",product_name"
				+ ",product_price"
				+ ",product_stock"
				+ ",product_desc"
				+ ",product_date"
				+ ",product_hits"
				+ " from product"
				+ "	where category_code = ?"
				+ " order by product_price";
	
		String query2="select count(product_number) from product where category_code = ?";
		
		ArrayList<GoodsBean> ProductArr = new ArrayList<GoodsBean>();
		GoodsBean product = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query2, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pstmt.setString(1, category_code);
			pageSet = pstmt.executeQuery();
			
		
			

			if (pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			
			if (dbCount % GoodsBean.pageSize == 0) {	//80
				GoodsBean.pageCount = dbCount / GoodsBean.pageSize;
			} else {	//84
				GoodsBean.pageCount = dbCount / GoodsBean.pageSize + 1;
			}
			
			if (pageNumber != null) {
				GoodsBean.pageNum = Integer.parseInt(pageNumber);
				//1: 0*10+1=1, 2: 1*10+1=11
				absolutePage = (GoodsBean.pageNum - 1) * GoodsBean.pageSize + 1;
			}
			
			rs = pstmt.executeQuery(query);
			
			if (rs.next()) {
				//System.out.println("값이있음?");
				rs.absolute(absolutePage);
				int count = 0;
				
				while (count < GoodsBean.pageSize) {
					product = new GoodsBean();
					product.setProduct_number(rs.getInt("product_number"));
					product.setCategory_code(rs.getString("category_code"));
					product.setProduct_name(rs.getString("product_name"));
					product.setProduct_price(rs.getInt("product_price"));
					product.setProduct_stock(rs.getInt("product_stock"));
					product.setProduct_desc(rs.getString("product_desc"));
					product.setProduct_date(rs.getTimestamp("product_date")); 
					product.setProduct_hits(rs.getInt("product_hits"));
					//System.out.println(rs.getInt("product_number"));
					
					ProductArr.add(product);
					if (rs.isLast()) {
						break;
					} else {
						rs.next();
					}
	 				
	 				count++;
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return ProductArr;
	}
	
	
	// 많이 팔린 순으로 상품 이미지 들고오기 -0429근지 
	public ArrayList<GoodsBean> getProductimg_best(ArrayList<GoodsBean> ProductlistArr) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//System.out.println(ProductlistArr.size());
		if(ProductlistArr.size()!=0) {
			//System.out.println("@@@@배열의크기는 상품의번호는"+ProductlistArr.get(0).getProduct_number());
		}
		
		
		String query = "select file_number"
							+ ",product_number"
							+ ",orgin_file_name"
							+ ",stored_file_name"
							+ ",stored_thumbnail"
							+ ",delegate_thumbnail"
							+ ",file_size"
							+ ",create_date"
							+ ",delete_check"
							+ " from product_imagefile"
							+ " where product_number = ?";
//		System.out.println(ProductlistArr.size());
		ArrayList<GoodsBean> ProductimgArr = new ArrayList<GoodsBean>();
		GoodsBean product = null;
		
		try {
			conn = getConnection();
			for (int j = 0; j < ProductlistArr.size(); j++) {
				pstmt = conn.prepareStatement(query);
				//System.out.println("상품번호는 "+ ProductlistArr.get(j).getProduct_number());
				int number = ProductlistArr.get(j).getProduct_number();
				pstmt.setInt(1, number);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					product = new GoodsBean();
					
					if(rs.getString("stored_file_name") != null){
						product.setFile_number(rs.getInt("file_number"));
						product.setProduct_number(rs.getInt("product_number"));
						product.setOrgin_file_name(rs.getString("orgin_file_name"));
						product.setStored_file_name(rs.getString("stored_file_name"));
						//product.setStored_thumbnail(rs.getString("stored_thumbnail"));
						//product.setDelegate_thumbnail(rs.getString("delegate_thumbnail"));
						product.setFile_size(rs.getInt("file_size"));
						product.setCreate_date(rs.getTimestamp("create_date"));
						//product.setDelete_check(rs.getString("delete_check"));
						ProductimgArr.add(product);
					}else {
						product.setFile_number(rs.getInt("file_number"));
						product.setProduct_number(rs.getInt("product_number"));
						product.setOrgin_file_name("이미지없음");
						product.setStored_file_name("이미지없음");
						//product.setStored_thumbnail("이미지없음");
						//product.setDelegate_thumbnail("이미지없음");
						product.setFile_size(0);
						product.setCreate_date(null);
						//product.setDelete_check("이미지없음");
						ProductimgArr.add(product);
						
					}
//					System.out.println("");
					
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return ProductimgArr;
	}

	//전체상품리스트반환 - 판매순	-0501근지
		public ArrayList<GoodsBean> getProductlist_best(String pageNumber) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ResultSet pageSet = null;
			int dbCount=0;
			int absolutePage=1;
//			System.out.println("들어옴?");
			String query = "select product_number"
								+ ",category_code"
								+ ",product_name"
								+ ",product_price"
								+ ",product_stock"
								+ ",product_desc"
								+ ",product_date"
								+ ",product_hits"
								+ " from product"
								+ " order by product_ordered_count desc";
			String query2="select count(product_number) from product";
			ArrayList<GoodsBean> ProductArr = new ArrayList<GoodsBean>();
			GoodsBean product = null;
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(query2, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				pageSet = pstmt.executeQuery();
			
				if (pageSet.next()) {
					dbCount = pageSet.getInt(1);
					pageSet.close();
				}
				
				if (dbCount % GoodsBean.pageSize == 0) {	//80
					GoodsBean.pageCount = dbCount / GoodsBean.pageSize;
				} else {	//84
					GoodsBean.pageCount = dbCount / GoodsBean.pageSize + 1;
				}
				
				if (pageNumber != null) {
					GoodsBean.pageNum = Integer.parseInt(pageNumber);
					//1: 0*10+1=1, 2: 1*10+1=11
					absolutePage = (GoodsBean.pageNum - 1) * GoodsBean.pageSize + 1;
				}
				
				rs = pstmt.executeQuery(query);
				
				if (rs.next()) {
					rs.absolute(absolutePage);
					int count = 0;
					
					while (count < GoodsBean.pageSize) {
						product = new GoodsBean();
						product.setProduct_number(rs.getInt("product_number"));
						product.setCategory_code(rs.getString("category_code"));
						product.setProduct_name(rs.getString("product_name"));
						product.setProduct_price(rs.getInt("product_price"));
						product.setProduct_stock(rs.getInt("product_stock"));
						product.setProduct_desc(rs.getString("product_desc"));
						product.setProduct_date(rs.getTimestamp("product_date"));
						product.setProduct_hits(rs.getInt("product_hits"));
						//System.out.println(rs.getInt("product_number"));
						
						ProductArr.add(product);
						if (rs.isLast()) {
							break;
						} else {
							rs.next();
						}
		 				
		 				count++;
					}
				}
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return ProductArr;
		}

		//전체상품리스트반환 - 조회순	-0501근지
		public ArrayList<GoodsBean> getProductlist_hits(String pageNumber) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ResultSet pageSet = null;
			int dbCount=0;
			int absolutePage=1;
//			System.out.println("들어옴?");
			String query = "select product_number"
								+ ",category_code"
								+ ",product_name"
								+ ",product_price"
								+ ",product_stock"
								+ ",product_desc"
								+ ",product_date"
								+ ",product_hits"
								+ " from product"
								+ " order by product_hits desc";
			String query2="select count(product_number) from product";
			ArrayList<GoodsBean> ProductArr = new ArrayList<GoodsBean>();
			GoodsBean product = null;
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(query2, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				pageSet = pstmt.executeQuery();
				
				if (pageSet.next()) {
					dbCount = pageSet.getInt(1);
					pageSet.close();
				}
				
				if (dbCount % GoodsBean.pageSize == 0) {	//80
					GoodsBean.pageCount = dbCount / GoodsBean.pageSize;
				} else {	//84
					GoodsBean.pageCount = dbCount / GoodsBean.pageSize + 1;
				}
				
				if (pageNumber != null) {
					GoodsBean.pageNum = Integer.parseInt(pageNumber);
					//1: 0*10+1=1, 2: 1*10+1=11
					absolutePage = (GoodsBean.pageNum - 1) * GoodsBean.pageSize + 1;
				}
				
				rs = pstmt.executeQuery(query);
				//System.out.println("여기까지는들어옴?");
				
				if (rs.next()) {
					rs.absolute(absolutePage);
					int count = 0;
					
					while (count < GoodsBean.pageSize) {
						product = new GoodsBean();
						product.setProduct_number(rs.getInt("product_number"));
						product.setCategory_code(rs.getString("category_code"));
						product.setProduct_name(rs.getString("product_name"));
						product.setProduct_price(rs.getInt("product_price"));
						product.setProduct_stock(rs.getInt("product_stock"));
						product.setProduct_desc(rs.getString("product_desc"));
						product.setProduct_date(rs.getTimestamp("product_date"));
						product.setProduct_hits(rs.getInt("product_hits"));
						//System.out.println(rs.getInt("product_number"));
						
						ProductArr.add(product);
						ProductArr.add(product);
						if (rs.isLast()) {
							break;
						} else {
							rs.next();
						}
		 				
		 				count++;
					}
				}
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return ProductArr;
		}
		
		//전체상품리스트반환 - 높은가격순	-0501근지
		public ArrayList<GoodsBean> getProductlist_price_desc(String pageNumber) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ResultSet pageSet = null;
			int dbCount=0;
			int absolutePage=1;
//			System.out.println("들어옴?");
			String query = "select product_number"
								+ ",category_code"
								+ ",product_name"
								+ ",product_price"
								+ ",product_stock"
								+ ",product_desc"
								+ ",product_date"
								+ ",product_hits"
								+ " from product"
								+ " order by product_price desc";
			String query2="select count(product_number) from product";
			ArrayList<GoodsBean> ProductArr = new ArrayList<GoodsBean>();
			GoodsBean product = null;
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(query2, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				pageSet = pstmt.executeQuery();
			
				if (pageSet.next()) {
					dbCount = pageSet.getInt(1);
					pageSet.close();
				}
				
				if (dbCount % GoodsBean.pageSize == 0) {	//80
					GoodsBean.pageCount = dbCount / GoodsBean.pageSize;
				} else {	//84
					GoodsBean.pageCount = dbCount / GoodsBean.pageSize + 1;
				}
				
				if (pageNumber != null) {
					GoodsBean.pageNum = Integer.parseInt(pageNumber);
					//1: 0*10+1=1, 2: 1*10+1=11
					absolutePage = (GoodsBean.pageNum - 1) * GoodsBean.pageSize + 1;
				}
				
				rs = pstmt.executeQuery(query);
				
				if (rs.next()) {
					rs.absolute(absolutePage);
					int count = 0;
					
					while (count < GoodsBean.pageSize) {
					product = new GoodsBean();
					product.setProduct_number(rs.getInt("product_number"));
					product.setCategory_code(rs.getString("category_code"));
					product.setProduct_name(rs.getString("product_name"));
					product.setProduct_price(rs.getInt("product_price"));
					product.setProduct_stock(rs.getInt("product_stock"));
					product.setProduct_desc(rs.getString("product_desc"));
					product.setProduct_date(rs.getTimestamp("product_date"));
					product.setProduct_hits(rs.getInt("product_hits"));
					//System.out.println(rs.getInt("product_number"));
					
					ProductArr.add(product);
					if (rs.isLast()) {
						break;
					} else {
						rs.next();
					}
	 				
	 				count++;
				}
				}
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return ProductArr;
		}
		
		//전체상품리스트반환 - 낮은가격순	-0501근지
		public ArrayList<GoodsBean> getProductlist_price(String pageNumber) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ResultSet pageSet = null;
			int dbCount=0;
			int absolutePage=1;
//			System.out.println("들어옴?");
			String query = "select product_number"
								+ ",category_code"
								+ ",product_name"
								+ ",product_price"
								+ ",product_stock"
								+ ",product_desc"
								+ ",product_date"
								+ ",product_hits"
								+ " from product"
								+ " order by product_price";
			String query2="select count(product_number) from product";
			ArrayList<GoodsBean> ProductArr = new ArrayList<GoodsBean>();
			GoodsBean product = null;
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(query2, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				pageSet = pstmt.executeQuery();;
			
				if (pageSet.next()) {
					dbCount = pageSet.getInt(1);
					pageSet.close();
				}
				
				if (dbCount % GoodsBean.pageSize == 0) {	//80
					GoodsBean.pageCount = dbCount / GoodsBean.pageSize;
				} else {	//84
					GoodsBean.pageCount = dbCount / GoodsBean.pageSize + 1;
				}
				
				if (pageNumber != null) {
					GoodsBean.pageNum = Integer.parseInt(pageNumber);
					//1: 0*10+1=1, 2: 1*10+1=11
					absolutePage = (GoodsBean.pageNum - 1) * GoodsBean.pageSize + 1;
				}
				
				rs = pstmt.executeQuery(query);
				
				if (rs.next()) {
					rs.absolute(absolutePage);
					int count = 0;
					
					while (count < GoodsBean.pageSize) {
						
					
					product = new GoodsBean();
					product.setProduct_number(rs.getInt("product_number"));
					product.setCategory_code(rs.getString("category_code"));
					product.setProduct_name(rs.getString("product_name"));
					product.setProduct_price(rs.getInt("product_price"));
					product.setProduct_stock(rs.getInt("product_stock"));
					product.setProduct_desc(rs.getString("product_desc"));
					product.setProduct_date(rs.getTimestamp("product_date"));
					product.setProduct_hits(rs.getInt("product_hits"));
					//System.out.println(rs.getInt("product_number"));
					
					ProductArr.add(product);
					if (rs.isLast()) {
						break;
					} else {
						rs.next();
					}
	 				
	 				count++;
					}
				}
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return ProductArr;
		}
	
	//아래쪽부터 찬희한거@@@@@@@@@@@@@@@@@@@@@@@@@@@@// 수정하면 다바꿔야해서 수정안함
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	//상품category_code 상품 종류 리스트
		
		
		
		
		public ArrayList<GoodsBean> getCategoryProductList(String category_code,String pageNumber) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ResultSet pageSet = null;
			int dbCount=0;
			int absolutePage=1;
			
			String query = "select product_number"
								+ ",category_code"
								+ ",product_name"
								+ ",product_price"
								+ ",product_stock"
								+ ",product_desc"
								+ ",product_date"
								+ ",product_hits"
								+ " from product"
								+ "	where category_code = ?"
								+ " order by product_number desc ";
			String query2="select count(product_number) from product where category_code = ?";
			
			
			ArrayList<GoodsBean> ProductArr = new ArrayList<GoodsBean>();
			GoodsBean product = null;
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(query2, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				pstmt.setString(1, category_code);
				pageSet = pstmt.executeQuery();
			
				if (pageSet.next()) {
					dbCount = pageSet.getInt(1);
					pageSet.close();
				}
				
				if (dbCount % GoodsBean.pageSize == 0) {	//80
					GoodsBean.pageCount = dbCount / GoodsBean.pageSize;
				} else {	//84
					GoodsBean.pageCount = dbCount / GoodsBean.pageSize + 1;
				}
				
				if (pageNumber != null) {
					GoodsBean.pageNum = Integer.parseInt(pageNumber);
					//1: 0*10+1=1, 2: 1*10+1=11
					absolutePage = (GoodsBean.pageNum - 1) * GoodsBean.pageSize + 1;
				}
				
				rs = pstmt.executeQuery(query);
			
				//System.out.println("여기까지는들어옴?");
				if (rs.next()) {
					rs.absolute(absolutePage);
					int count = 0;
					
					while (count < GoodsBean.pageSize) {
						product = new GoodsBean();
						product.setProduct_number(rs.getInt("product_number"));
						product.setCategory_code(rs.getString("category_code"));
						product.setProduct_name(rs.getString("product_name"));
						product.setProduct_price(rs.getInt("product_price"));
						product.setProduct_stock(rs.getInt("product_stock"));
						product.setProduct_desc(rs.getString("product_desc"));
						product.setProduct_date(rs.getTimestamp("product_date")); 
						product.setProduct_hits(rs.getInt("product_hits"));
						//System.out.println(rs.getInt("product_number"));
						
						ProductArr.add(product);
						if (rs.isLast()) {
							break;
						} else {
							rs.next();
						}
		 				
		 				count++;
						
					}
				}
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return ProductArr;
		}
		

	
	//검색 
	public ArrayList<GoodsBean> getsearch(String searchtext) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String producttext = "product";
		
		String query = "select product_number"
				+ ",category_code"
				+ ",product_name"
				+ ",product_price"
				+ ",product_stock"
				+ ",product_desc"
				+ ",product_date"
				+ ",product_hits"
				+ " from  " + producttext + 
						" where product_name like ? or product_desc like ?";
	
		ArrayList<GoodsBean> ProductArr = new ArrayList<GoodsBean>();
		GoodsBean product = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1,"%" +searchtext+"%" );
			
			pstmt.setString(2,"%" + searchtext+"%" );
			
			rs = pstmt.executeQuery();
			
			//System.out.println("여기까지는들어옴?");
			while (rs.next()) {
				
				product = new GoodsBean();
				product.setProduct_number(rs.getInt("product_number"));
				product.setCategory_code(rs.getString("category_code"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_stock(rs.getInt("product_stock"));
				product.setProduct_desc(rs.getString("product_desc"));
				product.setProduct_date(rs.getTimestamp("product_date"));
				product.setProduct_hits(rs.getInt("product_hits"));
				/*
				 * System.out.print(rs.getString("product_name"));
				 * System.out.println(rs.getString("product_desc"));
				 */
				ProductArr.add(product);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return ProductArr;
	}
	
	
	

	
	//상품이미지  불러오기 세부이미지까지
	public ArrayList<GoodsBean> getGoodsimg(int product_number) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
//		System.out.println("들어옴?");
		
//		query = "select stored_thumbNail,file_size from product_imagefile where product_number = ?";
		
		String query = "select file_number"
							+ ",product_number"
							+ ",orgin_file_name"
							+ ",stored_file_name"
							+ ",stored_thumbnail"
							+ ",delegate_thumbnail"
							+ ",file_size"
							+ ",create_date"
							+ ",delete_check"
							+ " from product_imagefile"
							+ " where product_number = ?"
							+ " order by file_number";
		ArrayList<GoodsBean> getGoodsimgs = new ArrayList<GoodsBean>();
		GoodsBean product = null;
			
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, product_number);
			rs = pstmt.executeQuery();
		
			
			while (rs.next()) {
				product = new GoodsBean();
			
				if(rs.getString("stored_file_name") != null){
					product.setOrgin_file_name(rs.getString("orgin_file_name"));
					product.setStored_file_name(rs.getString("stored_file_name"));		
					product.setFile_size(rs.getInt("file_size"));
					getGoodsimgs.add(product);
				}else if(rs.getString("stored_thumbnail") != null) {
					product.setOrgin_file_name(rs.getString("orgin_file_name"));
					product.setStored_thumbnail(rs.getString("stored_thumbnail"));
					product.setFile_size(rs.getInt("file_size"));
					getGoodsimgs.add(product);
				}else if( rs.getString("orgin_file_name") == null){
					product.setFile_number(rs.getInt("file_number"));
					product.setProduct_number(rs.getInt("product_number"));
					product.setOrgin_file_name("이미지없음");
					product.setStored_file_name("이미지없음");
					product.setStored_thumbnail("이미지없음");
					product.setDelegate_thumbnail("이미지없음");
					product.setFile_size(0);
					product.setCreate_date(null);
					product.setDelete_check("이미지없음");
					getGoodsimgs.add(product);		
				}
				
				
			}
			
		} catch(Exception e) {
			System.out.println("이미지 로드 실패");
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return getGoodsimgs;
	}
	
	
	//
	
	
	
	//전체상품리스트반환
		public ArrayList<GoodsBean> getProductlist(String pageNumber) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ResultSet pageSet = null;
			int dbCount=0;
			int absolutePage=1;
			
			String query = "select product_number"
								+ ",category_code"
								+ ",product_name"
								+ ",product_price"
								+ ",product_stock"
								+ ",product_desc"
								+ ",product_date"
								+ ",product_hits"
								+ " from product"
								+ " order by product_number desc";
			String query2="select count(product_number) from product";
			
			
			ArrayList<GoodsBean> ProductArr = new ArrayList<GoodsBean>();
			GoodsBean product = null;
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(query2, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				pageSet = pstmt.executeQuery();
				
				
				if (pageSet.next()) {
					dbCount = pageSet.getInt(1);
					pageSet.close();
				}
				
				if (dbCount % GoodsBean.pageSize == 0) {	//80
					GoodsBean.pageCount = dbCount / GoodsBean.pageSize;
				} else {	//84
					GoodsBean.pageCount = dbCount / GoodsBean.pageSize + 1;
				}
				
				if (pageNumber != null) {
					GoodsBean.pageNum = Integer.parseInt(pageNumber);
					//1: 0*10+1=1, 2: 1*10+1=11
					absolutePage = (GoodsBean.pageNum - 1) * GoodsBean.pageSize + 1;
				}
				
				rs = pstmt.executeQuery(query);
				
				//System.out.println("여기까지는들어옴?");
				if (rs.next()) {
					rs.absolute(absolutePage);
					int count = 0;
					
					while (count < GoodsBean.pageSize) {
					//System.out.println(rs.getInt("product_number"));
					product = new GoodsBean();
					product.setProduct_number(rs.getInt("product_number"));
					product.setCategory_code(rs.getString("category_code"));
					product.setProduct_name(rs.getString("product_name"));
					product.setProduct_price(rs.getInt("product_price"));
					product.setProduct_stock(rs.getInt("product_stock"));
					product.setProduct_desc(rs.getString("product_desc"));
					product.setProduct_date(rs.getTimestamp("product_date"));
					product.setProduct_hits(rs.getInt("product_hits"));
					//System.out.println(rs.getInt("product_number"));
					
					ProductArr.add(product);
					if (rs.isLast()) {
						break;
					} else {
						rs.next();
					}
	 				
	 				count++;
					}
				}
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return ProductArr;
		}
		
		//상품 이미지 리스트 
		public ArrayList<GoodsBean> getProductimg(ArrayList<GoodsBean> ProductlistArr) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			//System.out.println(ProductlistArr.size());
			if(ProductlistArr.size()!=0) {
				//System.out.println("@@@@배열의크기는 상품의번호는"+ProductlistArr.get(0).getProduct_number());
			}
			
			
			String query = "select file_number"
								+ ",product_number"
								+ ",orgin_file_name"
								+ ",stored_file_name"
								+ ",stored_thumbnail"
								+ ",delegate_thumbnail"
								+ ",file_size"
								+ ",create_date"
								+ ",delete_check"
								+ " from product_imagefile"
								+ " where product_number = ?"
								+ " order by file_number";
//			System.out.println(ProductlistArr.size());
			ArrayList<GoodsBean> ProductimgArr = new ArrayList<GoodsBean>();
			GoodsBean product = null;
			
			try {
				conn = getConnection();
				for (int j = 0; j < ProductlistArr.size(); j++) {
					pstmt = conn.prepareStatement(query);
					//System.out.println("상품번호는 "+ ProductlistArr.get(j).getProduct_number());
					int number = ProductlistArr.get(j).getProduct_number();
					pstmt.setInt(1, number);
					rs = pstmt.executeQuery();
					
					if (rs.next()) {
						product = new GoodsBean();
						
						if(rs.getString("stored_file_name") != null){
							product.setFile_number(rs.getInt("file_number"));
							product.setProduct_number(rs.getInt("product_number"));
							product.setOrgin_file_name(rs.getString("orgin_file_name"));
							product.setStored_file_name(rs.getString("stored_file_name"));
							//product.setStored_thumbnail(rs.getString("stored_thumbnail"));
							//product.setDelegate_thumbnail(rs.getString("delegate_thumbnail"));
							product.setFile_size(rs.getInt("file_size"));
							product.setCreate_date(rs.getTimestamp("create_date"));
							//product.setDelete_check(rs.getString("delete_check"));
							ProductimgArr.add(product);
						}else {
							product.setFile_number(rs.getInt("file_number"));
							product.setProduct_number(rs.getInt("product_number"));
							product.setOrgin_file_name("이미지없음");
							product.setStored_file_name("이미지없음");
							//product.setStored_thumbnail("이미지없음");
							//product.setDelegate_thumbnail("이미지없음");
							product.setFile_size(0);
							product.setCreate_date(null);
							//product.setDelete_check("이미지없음");
							ProductimgArr.add(product);
							
						}
//						System.out.println("");
						
					}
				}
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return ProductimgArr;
		}
		
		
		

}
