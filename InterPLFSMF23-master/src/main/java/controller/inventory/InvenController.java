package controller.inventory;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.dao.LOT;
import spring.dao.LOTprod;
import spring.dao.Material;
import spring.dao.Product;
import spring.dao.User;
import spring.dao.Warehouse;
import spring.inventory.InventoryService;

@Controller
@RequestMapping("/inventory")
public class InvenController {
	private InventoryService invenService;
	
	public void setInvenService(InventoryService invenService) {
		this.invenService = invenService;
	}

	@RequestMapping("")
    public String manage() {
    	return "inventory/inven";
    }
 
	@RequestMapping("/lotlist.json")
	public void lotListJson(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		JSONArray lotArray = new JSONArray();
		JSONObject jsonInfo = new JSONObject();
		
		List<LOT> list = invenService.allInvenList();
		for(LOT lot : list) {
			JSONArray lotInfo = new JSONArray();
			lotInfo.add(lot.getLotNo());
			lotInfo.add(lot.getProdName());
			lotInfo.add(lot.getMaterialName());
			lotInfo.add(lot.getStringQty());
			lotInfo.add(lot.getWarehouseName());
			lotArray.add(lotInfo);
		}
			jsonInfo.put("data", lotArray);
			String data = jsonInfo.toJSONString();
			System.out.print(data);
			writer.print(data);
	}
	
	@RequestMapping("/prodlotlist.json")
	public void prodlotListJson(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		JSONArray lotArray = new JSONArray();
		JSONObject jsonInfo = new JSONObject();
		
		String lot = request.getParameter("lot");
		List<LOTprod> list = invenService.lotSelectProductList(lot);
		for(LOTprod prod : list) {
			JSONArray prodInfo = new JSONArray();
			prodInfo.add(prod.getLotNo());
			prodInfo.add(prod.getProdName());
			prodInfo.add(prod.getSerialNo());
			prodInfo.add(prod.getProcessid());
			prodInfo.add(prod.getStatusPF());
			lotArray.add(prodInfo);
		}
			jsonInfo.put("data", lotArray);
			String data = jsonInfo.toJSONString();
			System.out.print(data);
			writer.print(data);
	}
	
	@RequestMapping("/warehouselist.json")
	public void warehsListJson(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		JSONArray whArray = new JSONArray();
		JSONObject jsonInfo = new JSONObject();
		
		List<Warehouse> list = invenService.allWarehouseList();
		for(Warehouse wh : list) {
			JSONArray whInfo = new JSONArray();
			whInfo.add(wh.getWareNo());
			whInfo.add(wh.getWareName());
			whInfo.add(wh.getWareLocation());
			whArray.add(whInfo);
		}
			jsonInfo.put("data", whArray);
			String data = jsonInfo.toJSONString();
			System.out.print(data);
			writer.print(data);
	}
	
	@RequestMapping("/productnolist.json")
	public void productListJson(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		JSONArray prodArray = new JSONArray();
		JSONObject jsonInfo = new JSONObject();
		
		List<Product> list = invenService.allProductList();
		for(Product prod : list) {
			JSONArray whInfo = new JSONArray();
			whInfo.add(prod.getProdno());
			whInfo.add(prod.getProdname());
			prodArray.add(whInfo);
		}
			jsonInfo.put("data", prodArray);
			String data = jsonInfo.toJSONString();
			System.out.print(data);
			writer.print(data);
	}
	
	@RequestMapping("/materialnolist.json")
	public void materialListJson(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		JSONArray materArray = new JSONArray();
		JSONObject jsonInfo = new JSONObject();
		
		List<Material> list = invenService.allMaterialList();
		for(Material mt: list) {
			JSONArray whInfo = new JSONArray();
			whInfo.add(mt.getNo());
			whInfo.add(mt.getName());
			materArray.add(whInfo);
		}
			jsonInfo.put("data", materArray);
			String data = jsonInfo.toJSONString();
			System.out.print(data);
			writer.print(data);
	}
	
	@RequestMapping("/lotdata.json")
	public void userJson(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		String lot = request.getParameter("lot");

		LOT lotdata = invenService.lotData(lot);

		JSONObject lotInfo = new JSONObject();
		lotInfo.put("lotno",lotdata.getLotNo());
		lotInfo.put("prodno",lotdata.getProdNo());
		lotInfo.put("materno",lotdata.getMaterNo());
		lotInfo.put("qty",lotdata.getQty());
		lotInfo.put("whseno",lotdata.getWarehouseNo());

		String data = lotInfo.toJSONString();
		//System.out.print(data);
		writer.print(data);
	}
	

	@RequestMapping("/insertlot.do")
	public void lotinsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		LOT lotbean = new LOT();
		
		lotbean.setLotNo(request.getParameter("lot"));
		lotbean.setProdNo(request.getParameter("prodno"));
		lotbean.setMaterNo(request.getParameter("materno"));
		lotbean.setQty(Integer.parseInt(request.getParameter("qty")));
		lotbean.setWarehouseNo(request.getParameter("whseno"));
		
		invenService.insertlot(lotbean);
		
	}
	
	@RequestMapping("/updatelot.do")
	public void lotupdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		LOT lotbean = new LOT();
		lotbean.setLotNo(request.getParameter("lot"));
		lotbean.setProdNo(request.getParameter("prodno"));
		lotbean.setMaterNo(request.getParameter("materno"));
		lotbean.setQty(Integer.parseInt(request.getParameter("qty")));
		lotbean.setWarehouseNo(request.getParameter("whseno"));
		
		invenService.udatelot(lotbean);
		
	}
	
	@RequestMapping("/insertproduct.do")
	public void productnsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		Product prod = new Product(request.getParameter("prodno"),
					request.getParameter("prodname"),
					Integer.parseInt(request.getParameter("prodprice")),
					request.getParameter("category"),
					Integer.parseInt(request.getParameter("leadtime")));
		
		invenService.insertproduct(prod);
	}
	
	@RequestMapping("/insertmaterial.do")
	public void materinsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		
		Material mater = new Material(request.getParameter("materno"),
					request.getParameter("matename"),
					Integer.parseInt(request.getParameter("materprice")),
					request.getParameter("unit"));
		
		invenService.insertmaterial(mater);
	}
	
	@RequestMapping("/insertwh.do")
	public void warehsinsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		Warehouse wh = new Warehouse(request.getParameter("whseno"),
					request.getParameter("whsename"),
					request.getParameter("whseloc"));
		
		invenService.insertwarehouse(wh);
	}
}
