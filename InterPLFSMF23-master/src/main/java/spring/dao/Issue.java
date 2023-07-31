package spring.dao;

import java.time.LocalDateTime;

public class Issue {
	private String planID;
	private String lineID;
	private String issueNo;
	private String issueName;
	private String issueInfo;
	private LocalDateTime time;
	
	public Issue(String planID, String lineID, String issueNo, String issueName, String issueInfo, LocalDateTime time) {
		super();
		this.planID = planID;
		this.lineID = lineID;
		this.issueNo = issueNo;
		this.issueName = issueName;
		this.issueInfo = issueInfo;
		this.time = time;
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

	public LocalDateTime getTime() {
		return time;
	}

	public void setTime(LocalDateTime time) {
		this.time = time;
	}
	
}
