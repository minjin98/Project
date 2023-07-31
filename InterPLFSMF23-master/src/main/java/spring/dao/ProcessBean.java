package spring.dao;

import java.sql.Date;

public class ProcessBean{

	private String prodName;
	private String good_count;
	private String bad_count;
	private String issue_count;
	private String process_gauge;
	private String goodprod_rate;
	private String badprod_rate;
	private String leadtime;
	private String cycletime;
	private String materialname;
	private String materialqty;
	private String issueNo;
	private String issueInfo;
	private String timeStamp;
	private int num;
	private String prodNo;
	private Date startDate;
	private Date endDate;
	private String name;
	private String lineID;
	private String proCheck;

	
	// DEFAULT 생성자
	public ProcessBean() {}
	
	public ProcessBean(String prodName, String good_count, String bad_count, String issue_count) 
	{
		this.prodName = prodName;
		this.good_count = good_count;
		this.bad_count = bad_count;
		this.issue_count = issue_count;
	}

	public ProcessBean(String goodprod_rate, String badprod_rate)
	{
		this.goodprod_rate = goodprod_rate;
		this.badprod_rate = badprod_rate;
	}
	

	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public String getGood_count() {
		return good_count;
	}
	public void setGood_count(String good_count) {
		this.good_count = good_count;
	}
	public String getBad_count() {
		return bad_count;
	}
	public void setBad_count(String bad_count) {
		this.bad_count = bad_count;
	}
	public String getIssue_count() {
		return issue_count;
	}
	public void setIssue_count(String issue_count) {
		this.issue_count = issue_count;
	}

	public String getProcess_gauge() {
		return process_gauge;
	}

	public void setProcess_gauge(String process_gauge) {
		this.process_gauge = process_gauge;
	}
	public String getGoodprod_rate() {
		return goodprod_rate;
	}
	public void setGoodprod_rate(String goodprod_rate) {
		this.goodprod_rate = goodprod_rate;
	}
	public String getBadprod_rate() {
		return badprod_rate;
	}
	public void setBadprod_rate(String badprod_rate) {
		this.badprod_rate = badprod_rate;
	}
	public String getLeadtime() {
		return leadtime;
	}
	public void setLeadtime(String leadtime) {
		this.leadtime = leadtime;
	}
	

	public String getCycletime() {
		return cycletime;
	}

	public void setCycletime(String cycletime) {
		this.cycletime = cycletime;
	}

	public String getMaterialname() {
		return materialname;
	}

	public void setMaterialname(String materialname) {
		this.materialname = materialname;
	}

	public String getMaterialqty() {
		return materialqty;
	}

	public void setMaterialqty(String materialqty) {
		this.materialqty = materialqty;
	}

	public String getIssueNo() {
		return issueNo;
	}

	public void setIssueNo(String issueNo) {
		this.issueNo = issueNo;
	}

	public String getIssueInfo() {
		return issueInfo;
	}

	public void setIssueInfo(String issueInfo) {
		this.issueInfo = issueInfo;
	}

	public String getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(String timeStamp) {
		this.timeStamp = timeStamp;
	}

	
	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getProdNo() {
		return prodNo;
	}

	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startdate) {
		this.startDate = startdate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLineID() {
		return lineID;
	}

	public void setLineID(String lineID) {
		this.lineID = lineID;
	}

	public String getProCheck() {
		return proCheck;
	}

	public void setProCheck(String proCheck) {
		this.proCheck = proCheck;
	}
	

}