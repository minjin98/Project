package spring.dao;

import java.sql.Date;

public class L_Issue {
	
	//basic method
	private String planID;
	private String lineID;
	private String prodNo;
	private int arm_Seq;
	private String issueNo;
	private String issueName;
	private String issueInfo;
	private Date timestamp;
	
	public L_Issue(String planID, String lineID, String prodNo, int arm_Seq, String issueNo, String issueName,
			String issueInfo, Date timestamp) {
		this.planID = planID;
		this.lineID = lineID;
		this.prodNo = prodNo;
		this.arm_Seq = arm_Seq;
		this.issueNo = issueNo;
		this.issueName = issueName;
		this.issueInfo = issueInfo;
		this.timestamp = timestamp;
	}

	public String getPlanID() {
		return planID;
	}

	public void setPlanID(String planID) {
		this.planID = planID;
	}

	public String getLineID() {
		return lineID;
	}

	public void setLineID(String lineID) {
		this.lineID = lineID;
	}

	public String getProdNo() {
		return prodNo;
	}

	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}

	public int getArm_Seq() {
		return arm_Seq;
	}

	public void setArm_Seq(int arm_Seq) {
		this.arm_Seq = arm_Seq;
	}

	public String getIssueNo() {
		return issueNo;
	}

	public void setIssueNo(String issueNo) {
		this.issueNo = issueNo;
	}

	public String getIssueName() {
		return issueName;
	}

	public void setIssueName(String issueName) {
		this.issueName = issueName;
	}

	public String getIssueInfo() {
		return issueInfo;
	}

	public void setIssueInfo(String issueInfo) {
		this.issueInfo = issueInfo;
	}

	public Date getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}

}
