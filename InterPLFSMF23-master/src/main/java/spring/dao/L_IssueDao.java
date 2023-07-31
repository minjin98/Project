package spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class L_IssueDao {
	
	private static JdbcTemplate jdbcTemplate;

	public L_IssueDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	static public List<L_Issue> selectAll() { //l_issue 뷰 전체 조회
		List<L_Issue> results = jdbcTemplate.query(
				"select * from l_issue", 
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
				});
		return results;
	}
	
	static public List<L_Issue> select(String lineID, String planID) { //l_issue 뷰에서 lineID, planID을 조건으로 받아올 수 있도록 함 
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
}
