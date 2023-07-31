package spring.dao;

public class L_Names {
	
	//basic method
	private String planID;
	private String prodNo;
	private String prodName;
	private String lineID;
	private String status;
	private String empNo;
	private String Name;
	
	public L_Names(String planID, String prodNo, String prodName, String lineID, String status, String empNo,
			String name) {
		this.planID = planID;
		this.prodNo = prodNo;
		this.prodName = prodName;
		this.lineID = lineID;
		this.status = status;
		this.empNo = empNo;
		Name = name;
	}

	public String getPlanID() {
		return planID;
	}

	public void setPlanID(String planID) {
		this.planID = planID;
	}

	public String getProdNo() {
		return prodNo;
	}

	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public String getLineID() {
		return lineID;
	}

	public void setLineID(String lineID) {
		this.lineID = lineID;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}
}
