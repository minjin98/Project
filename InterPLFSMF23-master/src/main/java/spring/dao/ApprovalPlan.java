package spring.dao;

import java.time.LocalDateTime;

public class ApprovalPlan {
	private String planid;
	private String lineid;
	private String prodname;
	private int qty;
	private LocalDateTime startdate;
	private LocalDateTime enddate;
	private String rank;
	private String name;
	
	public ApprovalPlan() {}
	
	public ApprovalPlan(String planid, String lineid, String prodname, int qty, 
			LocalDateTime startdate,LocalDateTime enddate, String rank, String name) {

		this.planid = planid;
		this.lineid = lineid;
		this.prodname = prodname;
		this.qty = qty;
		this.startdate = startdate;
		this.enddate = enddate;
		this.rank = rank;
		this.name = name;
	}
	
	public ApprovalPlan(String prodname, int qty) {
		this.prodname = prodname;
		this.qty = qty;
	}

	public String getPlanid() {
		return planid;
	}
	
	public void setPlanid(String planid) {
		this.planid = planid;
	}
	
	public String getLineid() {
		return lineid;
	}
	
	public void setLineid(String lineid) {
		this.lineid = lineid;
	}
	
	public String getProdname() {
		return prodname;
	}
	
	public void setProdname(String prodname) {
		this.prodname = prodname;
	}
	
	public int getQty() {
		return qty;
	}
	
	public void setQty(int qty) {
		this.qty = qty;
	}
	
	public LocalDateTime getStartdate() {
		return startdate;
	}
	
	public void setStartdate(LocalDateTime startdate) {
		this.startdate = startdate;
	}
	
	public LocalDateTime getEnddate() {
		return enddate;
	}
	
	public void setEnddate(LocalDateTime enddate) {
		this.enddate = enddate;
	}
	
	public String getRank() {
		return rank;
	}
	
	public void setRank(String rank) {
		this.rank = rank;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

}
