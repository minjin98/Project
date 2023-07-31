package spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class L_InvenDao {
	
	private static JdbcTemplate jdbcTemplate;

	public L_InvenDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	static public List<L_Inven> selectAll() { //l_inven 전체 조회
		List<L_Inven> results = jdbcTemplate.query(
				"select * from l_inven", 
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
				});
		return results;
	}
	
	public static List<L_Inven> select(String lineID, String planID) { //l_inven 뷰에서 lineID, planID을 조건으로 받아올 수 있도록 함 
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
}
