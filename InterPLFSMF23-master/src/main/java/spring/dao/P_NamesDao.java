package spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class P_NamesDao {
	
	private static JdbcTemplate jdbcTemplate;

	public P_NamesDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	static public List<P_Names> selectAll() { //p_names 전체 조회
		List<P_Names> results = jdbcTemplate.query(
				"select * from p_names", 
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
				});
		return results;
	}
	
	public static List<P_Names> select(String prodNo, String planID) { //p_name 뷰 전체 조회 후 한 건만 뽑아서 사용
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

}
