package spring.dao;

public class Material {

	private String no;
	private String name;
	private int	price;
	private String	unit;
	
	public Material() {
	}
	
	public Material(String no, String name, int price, String unit) {
		this.no = no;
		this.name = name;
		this.price = price;
		this.unit = unit;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	
}
