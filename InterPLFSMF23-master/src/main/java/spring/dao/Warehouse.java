package spring.dao;

public class Warehouse {
	/*
	 * Bean for contains warehouse data
	 */
	
	//basic method
	private String wareNo;
	private String wareName;
	private String wareLocation;
	
	public Warehouse() {
	}
	
	public Warehouse(String wareNo, String wareName, String wareLocation) {
		this.wareNo = wareNo;
		this.wareName = wareName;
		this.wareLocation = wareLocation;
	}

	public String getWareNo() {
		return wareNo;
	}

	public void setWareNo(String wareNo) {
		this.wareNo = wareNo;
	}

	public String getWareName() {
		return wareName;
	}

	public void setWareName(String wareName) {
		this.wareName = wareName;
	}

	public String getWareLocation() {
		return wareLocation;
	}

	public void setWareLocation(String wareLocation) {
		this.wareLocation = wareLocation;
	}
}
