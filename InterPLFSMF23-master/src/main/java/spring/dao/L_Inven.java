package spring.dao;

import java.sql.Date;

public class L_Inven {

	//basic method
	private String planID;
	private String lineID;
	private String prodNo;
	private String materNo;
	private String materName;
	private int materPrice;
	private int materQty;
	
	public L_Inven(String planID, String lineID, String prodNo, String materNo, String materName, int materPrice,
			int materQty) {
		this.planID = planID;
		this.lineID = lineID;
		this.prodNo = prodNo;
		this.materNo = materNo;
		this.materName = materName;
		this.materPrice = materPrice;
		this.materQty = materQty;
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

	public String getMaterNo() {
		return materNo;
	}

	public void setMaterNo(String materNo) {
		this.materNo = materNo;
	}

	public String getMaterName() {
		return materName;
	}

	public void setMaterName(String materName) {
		this.materName = materName;
	}

	public int getMaterPrice() {
		return materPrice;
	}

	public void setMaterPrice(int materPrice) {
		this.materPrice = materPrice;
	}

	public int getMaterQty() {
		return materQty;
	}

	public void setMaterQty(int materQty) {
		this.materQty = materQty;
	}
}
