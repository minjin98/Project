package spring.dao;

public class Product{

	private String prodno;
	private String prodname;
	private int prodprice;
	private String category;
	private int leadtime;
	
	public Product() {
	}
	
	public Product(String prodno, String prodname, int prodprice, String category, int leadtime) {
		super();
		this.prodno = prodno;
		this.prodname = prodname;
		this.prodprice = prodprice;
		this.category = category;
		this.leadtime = leadtime;
	}
	public String getProdno() {
		return prodno;
	}
	public void setProdno(String prodno) {
		this.prodno = prodno;
	}
	public String getProdname() {
		return prodname;
	}
	public void setProdname(String prodname) {
		this.prodname = prodname;
	}
	public int getProdprice() {
		return prodprice;
	}
	public void setProdprice(int prodprice) {
		this.prodprice = prodprice;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getLeadtime() {
		return leadtime;
	}
	public void setLeadtime(int leadtime) {
		this.leadtime = leadtime;
	}
	
	

}
