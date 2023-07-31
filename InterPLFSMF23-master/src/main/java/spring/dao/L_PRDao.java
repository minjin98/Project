package spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class L_PRDao {
	
	private static JdbcTemplate jdbcTemplate;

	public L_PRDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	static public List<L_PR> selectAll() { //l_pr 전체 조회
		List<L_PR> results = jdbcTemplate.query(
				"select * from l_pr", 
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
				});
		return results;
	}
	
	static public List<L_PR> select(String lineID, String planID) { //l_pr 뷰에서 lineID, planID을 조건으로 받아올 수 있도록 함 
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
}
