package spring.dao;

import java.sql.Date;

public class L_PR {
	
	//basic method
	private String planID;
	private String lineID;
	private String prodNo;
	private Date startdate;
	private Date enddate;
	private int passedQty;
	private int failedQty;
	
	public L_PR(String planID, String lineID, String prodNo, Date startdate, Date enddate, int passedQty,
			int failedQty) {
		super();
		this.planID = planID;
		this.lineID = lineID;
		this.prodNo = prodNo;
		this.startdate = startdate;
		this.enddate = enddate;
		this.passedQty = passedQty;
		this.failedQty = failedQty;
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

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public int getPassedQty() {
		return passedQty;
	}

	public void setPassedQty(int passedQty) {
		this.passedQty = passedQty;
	}

	public int getFailedQty() {
		return failedQty;
	}

	public void setFailedQty(int failedQty) {
		this.failedQty = failedQty;
	}

}
