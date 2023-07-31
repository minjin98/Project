package spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class P_PRDao {
	
	private static JdbcTemplate jdbcTemplate;

	public P_PRDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	static public List<P_PR> selectAll() { //p_pr 전체 조회
		List<P_PR> results = jdbcTemplate.query(
				"select * from p_pr", 
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
				});
		return results;
	}
	
	static public List<P_PR> select(String prodNo, String planID) { //p_pr 뷰 전체 조회 후 한건만 뽑아서 사용
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
}
