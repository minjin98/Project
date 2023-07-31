package spring.inventory;

import java.util.List;

import spring.dao.LOT;
import spring.dao.LOTprod;
import spring.dao.MainDao;
import spring.dao.Material;
import spring.dao.Product;
import spring.dao.Warehouse;

public class InventoryService {
	private MainDao mainDao;
	
	public void setmainDao(MainDao mainDao) {
		this.mainDao = mainDao;
	}
	
	public List<LOT> allInvenList(){
		return mainDao.selectAllLOT();
	}
	
	public List<LOTprod> lotSelectProductList(String lot){
		return mainDao.selectRProdByLOT(lot);
	}
	
	public List<Warehouse> allWarehouseList(){
		return mainDao.selectAllWareHs();
	}
	
	public List<Material> allMaterialList(){
		return mainDao.selectAllMaterial();
	}
	
	public List<Product> allProductList(){
		return mainDao.selectAllProduct();
	}

	public LOT lotData(String lot) {
		return mainDao.selectLOT(lot);
	}

	public void insertlot(LOT lotbean) {
		if (lotbean.getProdNo() != null) {
			mainDao.insertprodlot(lotbean);
		}else {
			mainDao.insertmaterlot(lotbean);
		}
	}

	public void udatelot(LOT lotbean) {
		mainDao.updatelot(lotbean);
	}
	
	public void insertproduct(Product prod) {
		mainDao.insertproduct(prod);
	}
	
	public void insertmaterial(Material mater) {
		mainDao.insertmaterial(mater);
	}
	
	public void insertwarehouse(Warehouse whse) {
		mainDao.insertwarehouse(whse);
	}
}
