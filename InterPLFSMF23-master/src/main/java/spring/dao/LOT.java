package spring.dao;

public class LOT {

	/*
	 * Bean for contains inventory(LOT) data
	 */
	
	//basic method
	private String lotNo;
	private String prodName;
	private String materialName;
	private String prodNo;
	private String materNo;
	private int qty;
	private String warehouseName;
	private String warehouseNo;
	
	public LOT() {
	}
	
	public LOT(String lotno, String prodname, String materialname, int qty, String whsename) {
		this.lotNo = lotno;
		this.prodName = prodname;
		this.materialName = materialname;
		this.qty = qty;
		this.warehouseName = whsename;
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

	public String getMaterialName() {
		return materialName;
	}

	public void setMaterialName(String materialName) {
		this.materialName = materialName;
	}

	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}

	public String getStringQty() {
		return Integer.toString(qty);
	}
	
	public String getWarehouseName() {
		return warehouseName;
	}

	public void setWarehouseName(String warehouseName) {
		this.warehouseName = warehouseName;
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

	public String getWarehouseNo() {
		return warehouseNo;
	}

	public void setWarehouseNo(String warehouseNo) {
		this.warehouseNo = warehouseNo;
	}
	
}
