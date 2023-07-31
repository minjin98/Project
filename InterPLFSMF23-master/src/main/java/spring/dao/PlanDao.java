/*
 * BoardDAO : Oracle JDBC
 */
package spring.dao;

//import java.io.BufferedInputStream;
//import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.util.Vector;

//import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import config.db.*;
import config.db.DBConnectionMgr;
import spring.plan.BomInfo;
import spring.plan.PlanInfo;
import spring.plan.ProdInfo;
import spring.plan.PlanTable;

public class PlanDao {
	private static final String SAVEFOLDER = "D:\\Temp\\boards\\fileuploads";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 5 * 1024 * 1024; // 5MB
	private static final int DOWNLOAD_BUFFER_SIZE = 1024 * 8; // 8KB 

	private DBConnectionMgr pool;

	public PlanDao() {
		try {
			pool = DBConnectionMgr.getInstance();
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// BOM 
	public Vector<BomInfo> getBomList(String prodNo) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    Vector<BomInfo> bomList = new Vector<BomInfo>();
	    
	    try {
	        con = pool.getConnection();
//	        sql = "SELECT b.prodNo, b.materNo, b.materQty, m.materPrice, i.qty "
//	                + "FROM BOM b "
//	                + "JOIN material m ON b.materNo = m.materNo "
//	                + "JOIN inventory i ON i.materNo = m.materNo "
//	                + "WHERE b.prodNo = ?";
	        sql = "SELECT b.prodNo, b.materNo, b.materQty, m.materPrice, SUM(i.qty) AS qty "
	                + "FROM BOM b "
	                + "JOIN material m ON b.materNo = m.materNo "
	                + "JOIN inventory i ON i.materNo = m.materNo "
	                + "WHERE b.prodNo = ? "
	                + "GROUP BY b.prodNo, b.materNo, b.materQty, m.materPrice";
	        System.out.println("sql = " + sql);
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, prodNo);
	        System.out.println("pstmt = " + pstmt);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	        	BomInfo bom = new BomInfo();
	        	bom.setProdNo(rs.getString("prodNo"));
	            bom.setMaterNo(rs.getString("materNo"));
	            bom.setMaterQty(rs.getInt("materQty"));
	            bom.setMaterPrice(rs.getInt("materprice"));
	            bom.setQty(rs.getInt("qty"));
	            bomList.add(bom);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    
	    return bomList;
	}
	
	// 상품 리스트
	private Vector<ProdInfo> getProdList() {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    Vector<ProdInfo> prodList = new Vector<ProdInfo>();
	    
	    try {
	        con = pool.getConnection();
	        sql = "SELECT prodName, prodNo FROM product";
	        pstmt = con.prepareStatement(sql);
	        rs = pstmt.executeQuery();
	        
	        while (rs.next()) {
	        	ProdInfo prod = new ProdInfo();
	        	prod.setProdNo(rs.getString("prodNo"));
	            prod.setProdName(rs.getString("prodName"));
	            prodList.add(prod);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    
	    return prodList;
	}
	
	// 상품 option
	public String prodOptions() {
	    Vector<ProdInfo> prodList = getProdList();
	    StringBuilder options = new StringBuilder();
	    
	    for (ProdInfo prod : prodList) {
	        options.append("<option value=\"" + prod.getProdNo() + "\">" + prod.getProdName() + "</option>");
	    }
	    
	    return options.toString();
	}

	
	// 게시판 리스트
		public Vector<PlanInfo> getBoardList(String keyField, String keyWord, int start, int end) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<PlanInfo> vlist = new Vector<PlanInfo>();
			try {
				con = pool.getConnection();
				if (keyWord.equals("null") || keyWord.equals("")) {	//검색
					sql = "SELECT rownum, b.* "
							+ "	FROM (SELECT rownum rnum, b.*"
							+ "		FROM (SELECT * FROM board ORDER BY ref desc, pos)b"
							+ "		)b"
							+ "		WHERE rnum BETWEEN ? AND ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, end);
				} else {
					sql = "SELECT rownum, b.*"
							+ "	FROM (SELECT rownum rnum, b.*"
							+ "		FROM (SELECT * FROM board WHERE " + keyField + " like ? ORDER BY ref desc, pos)b"
							+ "		)b"
							+ "		WHERE rnum BETWEEN ? AND ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%");
					pstmt.setInt(2, start);
					pstmt.setInt(3, end);
				}
				rs = pstmt.executeQuery();
				while (rs.next()) {
					PlanInfo bean = new PlanInfo();
					bean.setNum(rs.getInt("num"));
					bean.setPlanID(rs.getString("planID"));
					bean.setEmpName(rs.getString("empName"));
					bean.setProdName(rs.getString("prodName"));
					bean.setProdNo(rs.getString("prodNo"));
					bean.setStartdate(rs.getDate("startdate"));
					bean.setEnddate(rs.getDate("enddate"));
					bean.setRef(rs.getInt("ref"));
					bean.setPos(rs.getInt("pos"));
					bean.setDepth(rs.getInt("depth"));
					bean.setRegdate(rs.getString("regdate"));
					bean.setContent(rs.getString("content"));
					vlist.add(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		//총 게시물수
		public int getTotalCount(String keyField, String keyWord) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount = 0;
			try {
				con = pool.getConnection();
				if (keyWord.equals("null") || keyWord.equals("")) {
					sql = "select count(num) from Board";
					pstmt = con.prepareStatement(sql);
				} else {
					sql = "select count(num) from  Board where " + keyField + " like ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%");
				}
				rs = pstmt.executeQuery();
				if (rs.next()) {
					totalCount = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return totalCount;
		}
		
		// 게시물 입력
		public MultipartRequest insertBoard(HttpServletRequest req) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			MultipartRequest multi = null;
			int filesize = 0;
			String filename = null;
			try {
				con = pool.getConnection();
				sql = "select board_seq.nextval from dual";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				int ref = 1;
				
				if (rs.next()) {
					ref = rs.getInt(1); //첫 번째 열의 값
				}
				File file = new File(SAVEFOLDER);
				if (!file.exists()) {
					file.mkdirs();
				}
				multi = new MultipartRequest(req, SAVEFOLDER,MAXSIZE, ENCTYPE,
						new DefaultFileRenamePolicy());

				if (multi.getFilesystemName("filename") != null) {
					filename = multi.getFilesystemName("filename");
					filesize = (int) multi.getFile("filename").length();
				}
				String content = multi.getParameter("content");
				if (multi.getParameter("contentType").equalsIgnoreCase("TEXT")) {
					content = UtilMgr.replace(content, "<", "&lt;");
				}
				sql = "insert into Board(num,planID,empName,content,prodName,prodNo,startdate,enddate,ref,pos,depth,regdate,pass,ip,filename,filesize)"
						+"values(board_seq.currval,?,?, ?, ?, ?, ?, ?, ?, 0, 0, sysdate, ?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("planID"));
				pstmt.setString(2, multi.getParameter("empName"));
				pstmt.setString(3, content);
				pstmt.setString(4, multi.getParameter("prodName"));
				pstmt.setString(5, multi.getParameter("prodNo"));
				pstmt.setDate(6, java.sql.Date.valueOf(multi.getParameter("startdate")));
				pstmt.setDate(7, java.sql.Date.valueOf(multi.getParameter("enddate")));
				pstmt.setInt(8, ref);
				pstmt.setString(9, multi.getParameter("pass"));
				pstmt.setString(10, multi.getParameter("ip"));
				pstmt.setString(11, filename);
				pstmt.setInt(12, filesize);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);	//DB리소스 반환
			}
			
			return multi;
		}
		
		// insert process_plan table
		// public void insertPlan(HttpServletRequest req) throws IOException {
		public void insertPlan(MultipartRequest request) throws IOException {
			// MultipartRequest request = new MultipartRequest(req, SAVEFOLDER,MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());
			
		    Connection con = null;
		    PreparedStatement pstmt = null;
		    String sql = null;
		    String check_yn = "N";
		    
		    try {
		        con = pool.getConnection();
		        sql = "INSERT INTO process_plan(planID, prodNo, prodQty, lineID, startdate, enddate, empNo, check_yn) " +
		              "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		        pstmt = con.prepareStatement(sql);
		        pstmt.setString(1, request.getParameter("planID"));
		        pstmt.setString(2, request.getParameter("prodNo"));		
		        pstmt.setInt(3, Integer.parseInt(request.getParameter("prodCnt")));
		        pstmt.setString(4, request.getParameter("lineID"));
		        pstmt.setDate(5, java.sql.Date.valueOf(request.getParameter("startdate")));
				pstmt.setDate(6, java.sql.Date.valueOf(request.getParameter("enddate")));
		        pstmt.setString(7, request.getParameter("empName"));
		        pstmt.setString(8, check_yn);
		        
		        pstmt.executeUpdate();
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        pool.freeConnection(con, pstmt);
		    }
		}


		// 게시물 리턴
		public PlanInfo getBoard(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			PlanInfo bean = new PlanInfo();
			try {
				con = pool.getConnection();
				sql = "select * from Board where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean.setNum(rs.getInt("num"));
					bean.setPlanID(rs.getString("planID"));
					bean.setEmpName(rs.getString("empName"));
					bean.setProdName(rs.getString("prodName"));
					bean.setProdNo(rs.getString("prodNo"));
					bean.setStartdate(rs.getDate("startdate"));
					bean.setEnddate(rs.getDate("enddate"));
					bean.setContent(rs.getString("content"));
					bean.setPos(rs.getInt("pos"));
					bean.setRef(rs.getInt("ref"));
					bean.setDepth(rs.getInt("depth"));
					bean.setRegdate(rs.getString("regdate"));
					bean.setPass(rs.getString("pass"));
					bean.setFilename(rs.getString("filename"));
					bean.setFilesize(rs.getInt("filesize"));
					bean.setIp(rs.getString("ip"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
		
		public PlanTable getPlan(String planID) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			PlanTable bean2 = new PlanTable();
			try {
				con = pool.getConnection();
				sql = "SELECT planID, lineID, prodQty, check_yn FROM process_plan WHERE planID = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, planID);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean2.setPlanID(rs.getString("planID"));
					bean2.setLineID(rs.getString("lineID"));
					bean2.setProdQty(rs.getInt("prodQty"));
					bean2.setCheck_yn(rs.getString("check_yn"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean2;
		}

		// 게시물 삭제
		public void deleteBoard(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			try {
				con = pool.getConnection();
				sql = "select filename from Board where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if (rs.next() && rs.getString(1) != null) {
					if (!rs.getString(1).equals("")) {
						File file = new File(SAVEFOLDER + "/" + rs.getString(1));
						if (file.exists())
							UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
					}
				}
				sql = "delete from Board where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
		
		// 게시물 삭제
		public void deletePlan(String planID) {
			System.out.println("deletePlan:planID=" + planID);
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			//ResultSet rs = null;
			try {
				con = pool.getConnection();
				sql = "delete FROM process_plan WHERE planID=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, planID);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}

		// 게시물 수정
		public void updateBoard(PlanInfo bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "update Board set planID = ?, empName = ?, prodName=?, startdate= ?, enddate= ?, content = ? where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getPlanID());
				pstmt.setString(2, bean.getEmpName());
				pstmt.setString(3, bean.getProdName());
				pstmt.setDate(4, bean.getStartdate());
				pstmt.setDate(5, bean.getEnddate());
				pstmt.setString(6, bean.getContent());
				pstmt.setInt(7, bean.getNum());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}

		// 게시물 답변
		public void replyBoard(PlanInfo bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert into Board (num,planID,empName,content,prodName,startdate,enddate,ref,pos,depth,regdate,pass,ip)";
				sql += "values(board_seq.nextval,?,?,?,?,?,?,?,?,?,sysdate,?,?)";
				int depth = bean.getDepth() + 1;
				int pos = bean.getPos() + 1;
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getPlanID());
				pstmt.setString(2, bean.getEmpName());
				pstmt.setString(3, bean.getContent());
				pstmt.setString(4, bean.getProdName());
				pstmt.setDate(5, bean.getStartdate());
				pstmt.setDate(6, bean.getEnddate());
				pstmt.setInt(7, bean.getRef());
				pstmt.setInt(8, pos);
				pstmt.setInt(9, depth);
				pstmt.setString(10, bean.getPass());
				pstmt.setString(11, bean.getIp());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}

		// 답변에 위치값 증가
		public void replyUpBoard(int ref, int pos) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "update Board set pos = pos + 1 where ref = ? and pos > ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, pos);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
				
		//파일 다운로드
			public void downLoad(HttpServletRequest req, HttpServletResponse res,
					JspWriter out, PageContext pageContext) {
				try {
					req.setCharacterEncoding("UTF-8");
					String filename = req.getParameter("filename");
					String filePath = SAVEFOLDER + File.separator+ filename;
					//File file = new File(UtilMgr.con(SAVEFOLDER + File.separator+ filename)); 현재 con에서 문제가 발생하므로 모든 문자타입을 UTF-8로 맞추고 변환기를 사용하지 않는다
					File file = new File(filePath);
				
					res.setHeader("Accept-Ranges", "bytes");
					String strClient = req.getHeader("User-Agent");
					
					
					String downfileName = new String(filename.getBytes("UTF-8"), "ISO-8859-1"); //UTF-8방식의 파일명을 바이트로 변환 후 iso-8859-1(윈도우 한글 코덱)으로 변경
			
					
					
					if (strClient.indexOf("MSIE6.0") != -1) {	//IE버전 판별(현재는 별 의미없음)
						res.setContentType("application/smnet;charset=UTF-8");
						res.setHeader("Content-Disposition", "filename=" + filename + ";");
					} else {
						res.setContentType("application/smnet;charset=UTF-8");
						res.setHeader("Content-Disposition", "attachment;filename="+ downfileName + ";");
					}
					
					out.clear();
					out = pageContext.pushBody();
					
					if (file.isFile()) {	//파일 버퍼에 관련된 소스
						/*
						BufferedInputStream fin = new BufferedInputStream(
								new FileInputStream(file));
						BufferedOutputStream outs = new BufferedOutputStream(
								res.getOutputStream());
						int read = 0;
						while ((read = fin.read(b)) != -1) {
							outs.write(b, 0, read);
						}*/
						
						FileInputStream fin = new FileInputStream(file);	//파일 읽기 객체 생성 (스트림)
						OutputStream outs = res.getOutputStream();			//응답 객체의 출력 스트림 객체
						
						//byte b[] = new byte[(int) file.length()]; 파일용량 전체를 버퍼 메로리로 사용할 경우 고용량 파일의 경우 리소스 낭비가 사료됨
						byte[] buffer = new byte[DOWNLOAD_BUFFER_SIZE]; //고정된 버퍼값을 사용
						
						while(true) {
							int readlen = fin.read(buffer);				//버퍼에 있는 파일 용량 읽기
							//System.out.println("read : len " + readlen);
							if(readlen < 0) {
								break;
							}
							
							outs.write(buffer, 0, readlen);
						}
						outs.close();
						fin.close();
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			//파일(사진) 다운로드
			public void downImage(HttpServletRequest req, HttpServletResponse res,
					JspWriter out, PageContext pageContext) {
				try {
					req.setCharacterEncoding("UTF-8");
					String filename = req.getParameter("filename");
					String filePath = SAVEFOLDER + File.separator+ filename;
					File file = new File(filePath);
					
					res.setHeader("Accept-Ranges", "bytes");
					
					if (file.isFile()) {	//파일 버퍼에 관련된 소스
						
						FileInputStream fin = new FileInputStream(file);	
						OutputStream outs = res.getOutputStream();			
						
						byte[] buffer = new byte[DOWNLOAD_BUFFER_SIZE]; 
						
						while(true) {
							int readlen = fin.read(buffer);				
							System.out.println("read : len " + readlen);
							if(readlen < 0) {
								break;
							}
							
							outs.write(buffer, 0, readlen);
						}
						outs.close();
						fin.close();
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		//페이징 및 블럭 테스트를 위한 게시물 저장 메소드 
		public void post1000(){
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert into Board(empName,planID,content,prodName,startdate,enddate,ref,pos,depth,regdate,pass,ip,filename,filesize)";
				sql+="values('aaa','planid', 'bbb', 'ccc', now(), now(), 0, 0, 0, now(), '1111', '127.0.0.1', null, 0);";
				pstmt = con.prepareStatement(sql);
				for (int i = 0; i < 1000; i++) {
					pstmt.executeUpdate();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
		
		// main
		public static void main(String[] args) {
			new PlanDao().post1000();
			System.out.println("SUCCESS");
		}
	}