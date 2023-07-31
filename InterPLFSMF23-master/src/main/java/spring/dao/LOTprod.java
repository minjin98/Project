package spring.dao;

public class LOTprod {
	/*
	 * Bean for contains inventory(LOT) res product data
	 */
	
	//basic method
	private String lotNo;
	private String prodName;
	private String serialNo;
	private String processid;
	private int cycleTime;
	private int status;
	
	public LOTprod(String lotno, String prodname, String serialno, String processid, int cycletime, int status) {
		this.lotNo = lotno;
		this.prodName = prodname;
		this.serialNo = serialno;
		this.processid = processid;
		this.cycleTime = cycletime;
		this.status = status;
	}

	public String getLotNo() {
		return lotNo;
	}

	public void setLotNo(String lotNo) {
		this.lotNo = lotNo;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	public int getCycleTime() {
		return cycleTime;
	}

	public void setCycleTime(int cycleTime) {
		this.cycleTime = cycleTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getProcessid() {
		return processid;
	}

	public void setProcessid(String processid) {
		this.processid = processid;
	}
	
	public String getStatusPF(){
		if(this.status == 1) {
			return "F";
		}
		return "P";
	}
}
