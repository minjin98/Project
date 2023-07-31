package spring.dao;

public class P_Names {
	
	//basic method
	private String planID;
	private String prodNo;
	private String prodName;
	private String empNo;
	private String Name;
	
	public P_Names(String planID, String prodNo, String prodName, String empNo, String name) {
		this.planID = planID;
		this.prodNo = prodNo;
		this.prodName = prodName;
		this.empNo = empNo;
		this.Name = name;
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
