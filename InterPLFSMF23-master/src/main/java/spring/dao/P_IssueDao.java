package spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class P_IssueDao {
	
	private static JdbcTemplate jdbcTemplate;

	public P_IssueDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	static public List<P_Issue> selectAll() { //p_issue 뷰 전체 조회
		List<P_Issue> results = jdbcTemplate.query(
				"select * from p_issue", 
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
				});
		return results;
	}
	
	static public List<P_Issue> select(String prodNo, String planID) { //p_issue 뷰 전체 조회 //static을 붙여줬더니 오류가 안남(설명 듣기)
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
}
