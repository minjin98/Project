package spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class P_InvenDao {
	
	private static JdbcTemplate jdbcTemplate;

	public P_InvenDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	static public List<P_Inven> selectAll() { //p_inven 전체 조회
		List<P_Inven> results = jdbcTemplate.query(
				"select * from P_Inven", 
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
				});
		return results;
	}
	
	public static List<P_Inven> select(String prodNo, String planID) { //p_inven 뷰에서 전체 조회 후 한 건만 뽑아서 조회
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
}
