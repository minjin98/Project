package spring.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;

import controller.manage.ManageUserCommand;


public class MainDao {

	/*
	 * Dao for Oracle DB
	 */
	
	private JdbcTemplate jdbcTemplate;

	public MainDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	/*-----------------------------------------------------------------User Data-----------------------------------------------------------*/
	
	public User selectById(String id) { //ID로 User 조회
		Object[] where = new Object[] {id};
		List<User> results = jdbcTemplate.query(
				"select * from e_user where id = ?", where,
				new RowMapper<User>() {
					@Override
					public User mapRow(ResultSet rs, int rowNum) throws SQLException {
						User user = new User(
								rs.getString("empno"),
								rs.getString("id"),
								rs.getString("pw"),
								rs.getString("name"),
								rs.getString("rank"),
								(1 == rs.getLong("admin")),
								rs.getTimestamp("regidate").toLocalDateTime());
						user.setuserNo(rs.getLong("userNo"));
						return user;
					}
				});
		return results.isEmpty() ? null : results.get(0);
	}
	
	public List<User> selectAll() { //User 전체 조회
		List<User> results = jdbcTemplate.query(
				"select * from e_user", 
				new RowMapper<User>() {
					@Override
					public User mapRow(ResultSet rs, int rowNum) throws SQLException {
						User user = new User(
								rs.getString("empno"),
								rs.getString("id"),
								rs.getString("pw"),
								rs.getString("name"),
								rs.getString("rank"),
								(1 == rs.getLong("admin")),
								rs.getTimestamp("regidate").toLocalDateTime());
						user.setuserNo(rs.getLong("userNo"));
						return user;
					}
				});
		
		return results;
	}
	
	public void insertUser(ManageUserCommand user) { //신규 User 입력
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(
						"insert into e_user (userno, empno, name, id, pw, rank) " +
						"values (user_seq.NEXTVAL, ?, ?, ?, ?, ?)");
				pstmt.setString(1, user.getEmpNo());
				pstmt.setString(2, user.getName());
				pstmt.setString(3, user.getId());
				pstmt.setString(4, user.getPassword());
				pstmt.setString(5, user.getRank());
				return pstmt;
			}
		});
	}
	
	public User selectIdPwMatch(String id, String pw) { //ID, PW 공통 조회
		Object[] where = new Object[] {id, pw};
		List<User> results = jdbcTemplate.query(
				"select * from e_user where id = ? and pw = ?", where,
				new RowMapper<User>() {
					@Override
					public User mapRow(ResultSet rs, int rowNum) throws SQLException {
						User user = new User(
								rs.getString("empno"),
								rs.getString("id"),
								rs.getString("pw"),
								rs.getString("name"),
								rs.getString("rank"),
								(1 == rs.getLong("admin")),
								rs.getTimestamp("regidate").toLocalDateTime());
						user.setuserNo(rs.getLong("userNo"));
						return user;
					}
				});
		return results.isEmpty() ? null : results.get(0);
	}
	
	public void updatePassword(String id, String pw) { //PW 변경
		jdbcTemplate.update(
				"update e_user set pw = ? where id = ?", pw, id);
	}
	
	public void updateUser(User user) { //정보 변경
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(
						"update e_user set empno = ?, name = ?, pw = ?, rank = ?, admin = ? where id = ?");
				pstmt.setString(1, user.getEmpNo());
				pstmt.setString(2, user.getName());
				pstmt.setString(3, user.getPassword());
				pstmt.setString(4, user.getRank());
				pstmt.setString(5, user.getAdmin());
				pstmt.setString(6, user.getId());
				return pstmt;
			}
		});
	}
	
	public List<String> rankList() { //등록된 Rank 전체 조회
		List<String> results = jdbcTemplate.query(
				"select distinct rank from e_user", 
				new RowMapper<String>() {
					@Override
					public String mapRow(ResultSet rs, int rowNum) throws SQLException {
						return rs.getString("rank");
					}
				});
		return results;
	}
	
	public void deleteUser(String id) { //사용자 삭제
		jdbcTemplate.update(
				"delete from e_user where id = ?", id);
	}

	/*-----------------------------------------------------------------Inventory Data-----------------------------------------------------------*/
	
	public List<LOT> selectAllLOT() { //LOT 전체 조회
		List<LOT> results = jdbcTemplate.query(
				"SELECT LOT,PRODNAME,MATERNAME,QTY,WHSENAME FROM (SELECT *  FROM inventory i LEFT JOIN product p ON i.prodno = p.prodno "
				+ "LEFT JOIN material m ON i.materno = m.materno) it, warehouse w WHERE it.whseno=w.whseno", 
				new RowMapper<LOT>() {
					@Override
					public LOT mapRow(ResultSet rs, int rowNum) throws SQLException {
						LOT lot = new LOT(
								rs.getString("LOT"),
								rs.getString("prodname"),
								rs.getString("matername"),
								rs.getInt("qty"),
								rs.getString("whsename"));
						return lot;
					}
				});
		
		return results;
	}
	
	public LOT selectLOT(String lot) { //LOT 전체 조회
		Object[] where = new Object[] {lot};
		List<LOT> results = jdbcTemplate.query(
				"SELECT * FROM inventory WHERE lot = ?", where, 
				new RowMapper<LOT>() {
					@Override
					public LOT mapRow(ResultSet rs, int rowNum) throws SQLException {
						LOT lot = new LOT();
						lot.setLotNo(rs.getString("lot"));
						lot.setProdNo(rs.getString("prodno"));
						lot.setMaterNo(rs.getString("materno"));
						lot.setQty(rs.getInt("qty"));
						lot.setWarehouseNo(rs.getString("whseno"));
						return lot;
					}
				});
		
		return results.get(0);
	}
	
	public List<LOTprod> selectRProdByLOT(String lot){ //LOT로 ResProduct조회
		Object[] where = new Object[] {lot};
		List<LOTprod> results = jdbcTemplate.query(
				"SELECT i.LOT,PRODNAME,SERIALNO,PROCESSID,CYCLETIME,STATUS FROM INVENTORY i JOIN RESULT_PROD rp on i.LOT = rp.LOT "
				+ "LEFT JOIN product p ON p.PRODNO = i.PRODNO WHERE i.LOT = ?", where,
				new RowMapper<LOTprod>() {
					@Override
					public LOTprod mapRow(ResultSet rs, int rowNum) throws SQLException {
						LOTprod prod = new LOTprod(
								rs.getString("LOT"),
								rs.getString("prodname"),
								rs.getString("serialno"),
								rs.getString("processid"),
								rs.getInt("cycletime"),
								rs.getInt("status"));
						return prod;
					}
				});
		
		return results;
	}
	
	public List<Warehouse> selectAllWareHs() { //warehouse 전체조회
		List<Warehouse> results = jdbcTemplate.query(
				"SELECT * FROM warehouse", 
				new RowMapper<Warehouse>() {
					@Override
					public Warehouse mapRow(ResultSet rs, int rowNum) throws SQLException {
						Warehouse wh = new Warehouse(
								rs.getString("whseno"),
								rs.getString("whseloc"),
								rs.getString("whsename"));
						return wh;
					}
				});
		
		return results;
	}
	
	public List<Product> selectAllProduct() { //Material 전체조회
		List<Product> results = jdbcTemplate.query(
				"SELECT * FROM product", 
				new RowMapper<Product>() {
					@Override
					public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
						Product pd = new Product(
								rs.getString("prodno"),
								rs.getString("prodname"),
								rs.getInt("prodprice"),
								rs.getString("category"),
								rs.getInt("leadtime"));
						return pd;
					}
				});
		
		return results;
	}
	
	public List<Material> selectAllMaterial() { //Material 전체조회
		List<Material> results = jdbcTemplate.query(
				"SELECT * FROM material", 
				new RowMapper<Material>() {
					@Override
					public Material mapRow(ResultSet rs, int rowNum) throws SQLException {
						Material mt = new Material(
								rs.getString("materno"),
								rs.getString("matername"),
								rs.getInt("materprice"),
								rs.getString("unit"));
						return mt;
					}
				});
		
		return results;
	}
	
	public List<LOT> selectEAMaterialQty() { //Material 갯수 조회
		List<LOT> results = jdbcTemplate.query(
				"SELECT * FROM INVENTORY i LEFT JOIN MATERIAL m ON m.MATERNO = i.MATERNO WHERE i.materno IS NOT NULL AND m.UNIT  = 'EA'", 
				new RowMapper<LOT>() {
					@Override
					public LOT mapRow(ResultSet rs, int rowNum) throws SQLException {
						LOT mt = new LOT();
						mt.setMaterialName(rs.getString("matername"));
						mt.setQty(rs.getInt("qty"));
						return mt;
					}
				});
		
		return results;
	}
	
	public void insertprodlot(LOT lot) { 
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(
						"insert into inventory (lot, prodno, qty, whseno) " +
						"values (?, ?, ?, ?)");
				pstmt.setString(1, lot.getLotNo());
				pstmt.setString(2, lot.getProdNo());
				pstmt.setInt(3, lot.getQty());
				pstmt.setString(4, lot.getWarehouseNo());
				return pstmt;
			}
		});
	}
	
	public void insertmaterlot(LOT lot) { 
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(
						"insert into inventory (lot, materno, qty, whseno) " +
						"values (?, ?, ?, ?)");
				pstmt.setString(1, lot.getLotNo());
				pstmt.setString(2, lot.getMaterNo());
				pstmt.setInt(3, lot.getQty());
				pstmt.setString(4, lot.getWarehouseNo());
				return pstmt;
			}
		});
	}
	
	public void updatelot(LOT lot) { //정보 변경
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(
						"update inventory set prodno = ?, materno = ?, qty = ?, whseno = ? where lot = ?");
				pstmt.setString(1, lot.getProdNo());
				pstmt.setString(2, lot.getMaterNo());
				pstmt.setInt(3, lot.getQty());
				pstmt.setString(4, lot.getWarehouseNo());
				pstmt.setString(5, lot.getLotNo());
				return pstmt;
			}
		});
	}
	
	public void insertproduct(Product prod) { 
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(
						"insert into product (prodno, prodname, prodprice, category, leadtime) " +
						"values (?, ?, ?, ? ,?)");
				pstmt.setString(1, prod.getProdno());
				pstmt.setString(2, prod.getProdname());
				pstmt.setInt(3, prod.getProdprice());
				pstmt.setString(4, prod.getCategory());
				pstmt.setInt(5, prod.getLeadtime());
				return pstmt;
			}
		});
	}
	
	public void insertmaterial(Material mater) { 
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(
						"insert into material (materno, matername, materprice, unit) " +
						"values (?, ?, ?, ?)");
				pstmt.setString(1, mater.getNo());
				pstmt.setString(2, mater.getName());
				pstmt.setInt(3, mater.getPrice());
				pstmt.setString(4, mater.getUnit());
				return pstmt;
			}
		});
	}
	
	public void insertwarehouse(Warehouse wh) { 
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(
						"insert into inventory (whseno, whseloc, whsename) " +
						"values (?, ?, ?)");
				pstmt.setString(1, wh.getWareNo());
				pstmt.setString(2, wh.getWareLocation());
				pstmt.setString(3, wh.getWareName());
				return pstmt;
			}
		});
	}
	
	/*-----------------------------------------------------------------Plan Data-----------------------------------------------------------*/
	
	public List<ApprovalPlan> selectApprovalPlan(String check) { //미결제 계획 조회
		Object[] where = new Object[] {check};
		List<ApprovalPlan> results = jdbcTemplate.query(
				"SELECT PLANID, LINEID, prodname, PRODQTY,  STARTDATE, ENDDATE, RANK, name FROM PROCESS_PLAN pp "
				+ "LEFT JOIN E_USER u ON pp.EMPNO = u.EMPNO "
				+ "LEFT JOIN PRODUCT p ON p.PRODNO = pp.PRODNO "
				+ "WHERE CHECK_YN = ?", where,
				new RowMapper<ApprovalPlan>() {
					@Override
					public ApprovalPlan mapRow(ResultSet rs, int rowNum) throws SQLException {
						ApprovalPlan plan = new ApprovalPlan(
								rs.getString("planid"),
								rs.getString("lineid"),
								rs.getString("prodname"),
								rs.getInt("prodqty"),
								rs.getTimestamp("startdate").toLocalDateTime(),
								rs.getTimestamp("enddate").toLocalDateTime(),
								rs.getString("rank"),
								rs.getString("name"));
						return plan;
					}
				});
		
		return results;
	}
	
	public int selectPlanQty(String planid) { //미결제 계획 조회
		Object[] where = new Object[] {planid};
		List<ApprovalPlan> results = jdbcTemplate.query(
				"SELECT * FROM process_plan WHERE planid = ?", where,
				new RowMapper<ApprovalPlan>() {
					@Override
					public ApprovalPlan mapRow(ResultSet rs, int rowNum) throws SQLException {
						ApprovalPlan plan = new ApprovalPlan();
						plan.setQty(rs.getInt("prodqty"));
						return plan;
					}
				});
		
		return results.get(0).getQty();
	}
	
	public List<ApprovalPlan> selectPlanWithName() { //계획 조회
		List<ApprovalPlan> results = jdbcTemplate.query(
				"SELECT PLANID, LINEID, prodname, PRODQTY,  STARTDATE, ENDDATE, RANK, name FROM PROCESS_PLAN pp "
				+ "LEFT JOIN E_USER u ON pp.EMPNO = u.EMPNO "
				+ "LEFT JOIN PRODUCT p ON p.PRODNO = pp.PRODNO ", 
				new RowMapper<ApprovalPlan>() {
					@Override
					public ApprovalPlan mapRow(ResultSet rs, int rowNum) throws SQLException {
						ApprovalPlan plan = new ApprovalPlan(
								rs.getString("planid"),
								rs.getString("lineid"),
								rs.getString("prodname"),
								rs.getInt("prodqty"),
								rs.getTimestamp("startdate").toLocalDateTime(),
								rs.getTimestamp("enddate").toLocalDateTime(),
								rs.getString("rank"),
								rs.getString("name"));
						return plan;
					}
				});
		
		return results;
	}
	
	public List<ApprovalPlan> selectPlanProdNQty() { //prodName, prodQty 조회
		List<ApprovalPlan> result = jdbcTemplate.query(
				"SELECT p.prodName, SUM(pp.prodQty) AS totalQty "
				+ "FROM process_plan pp "
				+ "JOIN product p ON pp.prodNo = p.prodNo "
				+ "GROUP BY p.prodName, pp.prodNo "
, 
				new RowMapper<ApprovalPlan>() {
					@Override
					public ApprovalPlan mapRow(ResultSet rs, int rowNum) throws SQLException {
						ApprovalPlan planinfo = new ApprovalPlan(
								rs.getString("prodname"),
								rs.getInt("totalqty")
								);
						System.out.println("[MainDao.selectPlanProdNQty:planinfo=]"+planinfo);
						return planinfo;
					}
				});
		
		return result;
	}
	public void planChecked(String planid) { //계획 결제 입력
			jdbcTemplate.update(
					"update process_plan set check_yn = 'Y' where planid = ?", planid);	
	}
	
	public boolean planNotification() { //계획 결제 확인
		int needCheckP = jdbcTemplate.queryForObject(
				"SELECT count(*) FROM PROCESS_PLAN WHERE CHECK_YN = 'N'",
					Integer.class);
		return needCheckP != 0 ? true : false;
	}
	
	
	
	/*-----------------------------------------------------------------Report Data-----------------------------------------------------------*/
	
	public List<P_Names> selectPN(String prodNo, String planID) { //p_name 뷰 전체 조회 후 한 건만 뽑아서 사용
		List<P_Names> results = jdbcTemplate.query(
				"select * from p_names where prodNo = ? and planID = ?", 
				new RowMapper<P_Names>() {
					@Override
					public P_Names mapRow(ResultSet rs, int rowNum) throws SQLException {
						P_Names p_names = new P_Names(
								rs.getString("PlanID"),
								rs.getString("ProdNo"),
								rs.getString("ProdName"),
								rs.getString("empNo"),
								rs.getString("Name"));
						return p_names;
					}
				}, prodNo, planID);
		return results;
	}
	
	public List<P_Inven> selectPIV(String prodNo, String planID) { //p_inven 뷰에서 전체 조회 후 한 건만 뽑아서 조회
		List<P_Inven> results = jdbcTemplate.query(
				"select * from p_inven where prodNo = ? and planID =?", 
				new RowMapper<P_Inven>() {
					@Override
					public P_Inven mapRow(ResultSet rs, int rowNum) throws SQLException {
						P_Inven p_inven = new P_Inven(
								rs.getString("PlanID"),
								rs.getString("ProdNo"),
								rs.getString("materNo"),
								rs.getString("materName"),
								rs.getInt("materPrice"),
								rs.getInt("materQty"));
						return p_inven;
					}
				}, prodNo, planID);
		//return results.isEmpty() ? null : results.get(0);
		return results;
	}
	
	public List<P_PR> selectPPR(String prodNo, String planID) { //p_pr 뷰 전체 조회 후 한건만 뽑아서 사용
		List<P_PR> results = jdbcTemplate.query(
				"select * from p_pr where prodNo = ? and planID = ?", 
				new RowMapper<P_PR>() {
					@Override
					public P_PR mapRow(ResultSet rs, int rowNum) throws SQLException {
						P_PR p_pr = new P_PR(
								rs.getString("PlanID"),
								rs.getString("ProdNo"),
								rs.getDate("startdate"),
								rs.getDate("enddate"),
								rs.getInt("passedQty"),
								rs.getInt("failedQty"));
						return p_pr;
					}
				}, prodNo, planID);
		return results;
	}
	
	public List<P_Issue> selectPIS(String prodNo, String planID) { //p_issue 뷰 전체 조회 //static을 붙여줬더니 오류가 안남(설명 듣기)
		List<P_Issue> results = jdbcTemplate.query(
				"select * from p_issue where prodNo = ? and planID = ?", 
				new RowMapper<P_Issue>() {
					@Override
					public P_Issue mapRow(ResultSet rs, int rowNum) throws SQLException {
						P_Issue p_issue = new P_Issue(
								rs.getString("PlanID"),
								rs.getString("ProdNo"),
								rs.getInt("arm_Seq"),
								rs.getString("issueNo"),
								rs.getString("issueName"),
								rs.getString("issueInfo"),
								rs.getDate("timestamp"));
						return p_issue;
					}
				}, prodNo, planID);
		return results;
	}
	
	public List<L_PR> selectLPR(String lineID, String planID) { //p_pr 뷰 전체 조회 후 한건만 뽑아서 사용
		List<L_PR> results = jdbcTemplate.query(
				"select * from l_pr where lineID = ? and planID = ?", 
				new RowMapper<L_PR>() {
					@Override
					public L_PR mapRow(ResultSet rs, int rowNum) throws SQLException {
						L_PR l_pr = new L_PR(
								rs.getString("PlanID"),
								rs.getString("LineID"),
								rs.getString("ProdNo"),
								rs.getDate("startdate"),
								rs.getDate("enddate"),
								rs.getInt("passedQty"),
								rs.getInt("failedQty"));
						return l_pr;
					}
				}, lineID, planID);
		return results;
	}
	
	public List<L_Names> selectLN(String lineID, String planID) { //l_names 뷰 전체 조회 후 한 건만 뽑아서 사용
		List<L_Names> results = jdbcTemplate.query(
				"select * from l_names where lineID = ? and planID = ?", 
				new RowMapper<L_Names>() {
					@Override
					public L_Names mapRow(ResultSet rs, int rowNum) throws SQLException {
						L_Names l_names = new L_Names(
								rs.getString("PlanID"),
								rs.getString("ProdNo"),
								rs.getString("ProdName"),
								rs.getString("LineID"),
								rs.getString("Status"),
								rs.getString("empNo"),
								rs.getString("Name"));
						return l_names;
					}
				}, lineID, planID);
		return results;
	}
	
	public List<L_Issue> selectLIS(String lineID, String planID) { //p_issue 뷰 전체 조회 //static을 붙여줬더니 오류가 안남(설명 듣기)
		List<L_Issue> results = jdbcTemplate.query(
				"select * from l_issue where lineID = ? and planID = ?", 
				new RowMapper<L_Issue>() {
					@Override
					public L_Issue mapRow(ResultSet rs, int rowNum) throws SQLException {
						L_Issue l_issue = new L_Issue(
								rs.getString("PlanID"),
								rs.getString("LineID"),
								rs.getString("ProdNo"),
								rs.getInt("arm_Seq"),
								rs.getString("issueNo"),
								rs.getString("issueName"),
								rs.getString("issueInfo"),
								rs.getDate("timestamp"));
						return l_issue;
					}
				}, lineID, planID);
		return results;
	}
	
	public List<L_Inven> selectLIV(String lineID, String planID) { //p_inven 뷰에서 전체 조회 후 한 건만 뽑아서 조회
		List<L_Inven> results = jdbcTemplate.query(
				"select * from l_inven where lineID = ? and planID = ?", 
				new RowMapper<L_Inven>() {
					@Override
					public L_Inven mapRow(ResultSet rs, int rowNum) throws SQLException {
						L_Inven l_inven = new L_Inven(
								rs.getString("PlanID"),
								rs.getString("LineID"),
								rs.getString("ProdNo"),
								rs.getString("materNo"),
								rs.getString("materName"),
								rs.getInt("materPrice"),
								rs.getInt("materQty"));
						return l_inven;
					}
				}, lineID, planID);
		//return results.isEmpty() ? null : results.get(0);
		return results;
	}
	
	/*-----------------------------------------------------------------Process Data-----------------------------------------------------------*/
	
	public List<Issue> selectAllIssue() { //Material 전체조회
		List<Issue> results = jdbcTemplate.query(
				"SELECT * FROM PROCESS_ISSUE pi LEFT JOIN PROCESS po ON pi.PLANID = po.PLANID "
				+ "LEFT JOIN ISSUE i ON i.ISSUENO = pi.ISSUENO "
				+ "LEFT JOIN process_plan pp oN pi.PLANID = pp.PLANID", 
				new RowMapper<Issue>() {
					@Override
					public Issue mapRow(ResultSet rs, int rowNum) throws SQLException {
						Issue is = new Issue(
								rs.getString("planid"),
								rs.getString("lineid"),
								rs.getString("issueno"),
								rs.getString("issuename"),
								rs.getString("issueinfo"),
								rs.getTimestamp("timestamp").toLocalDateTime());
						return is;
					}
				});
		
		return results;
	}
	
	public int countQcPass(String processid) {
		Object[] where = new Object[] {processid};
		int result = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM result_prod where processid = ? AND status = 0", where, Integer.class);

		return result;
	}
	
	public int countQcFail(String processid) {
		Object[] where = new Object[] {processid};
		int result = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM result_prod where processid = ? AND status = 1", where, Integer.class);

		return result;
	}
	
	public String selectprocessId(String planid) {
		Object[] where = new Object[] {planid};
		String result = jdbcTemplate.queryForObject("SELECT processid FROM process where planid = ?", where, String.class);
		return result;
	}
}
