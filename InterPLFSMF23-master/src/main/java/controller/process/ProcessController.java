package controller.process;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import spring.dao.ProcessBean;
import spring.dao.ProcessDao;

@Controller
public class ProcessController {
private ProcessDao processDao;
	
	public ProcessController(ProcessDao processDao) {
		this.processDao = processDao;
	}
	
	@RequestMapping("/processres")
	public String processmain() {
		return "process/processmain";
	}
	
	@RequestMapping("/processorder")
	public String processordermain(Model model) {
		List<ProcessBean>orderlist = processDao.select_plan();
		model.addAttribute("orderlist", orderlist);
		System.out.println("orderlist 실행");
		return "process/processordermain";
	}
	
	@GetMapping("/ORDelete")
	public String deleteProcess(Model model, @RequestParam("num") Integer num) {
		System.out.println("[ProcessOrController] deleteProcess: prodNo=" + num);
		processDao.deleteProcess(num);
		System.out.println("deleprocess 완료 2");
		
		List<ProcessBean>orderlist = processDao.select_plan();
		model.addAttribute("orderlist", orderlist);
		return "process/processordermain";
	}
	@GetMapping("/ORCancel")
	public String cancel(Model model, @RequestParam("num") Integer num) {
		System.out.println("[ProcessOrController] cancel: prodNo=" + num);
		processDao.cancel(num);
		System.out.println("cancel 완료");
		
		List<ProcessBean>orderlist = processDao.select_plan();
		model.addAttribute("orderlist", orderlist);
		return "process/processordermain";
	}
	
	@GetMapping("/ORstart")
	public String insertLine(Model model, @RequestParam("prodNo") String prodNo,@RequestParam("value") String value) {
		System.out.println("[ProcessOrController] insertLine : prodNo=" + prodNo);
		System.out.println("[ProcessOrController] insertLine : value=" + value);
		
		
		String insertProdNo = prodNo;
		processDao.insertLineid(value, prodNo);
		model.addAttribute("insertProdNo", insertProdNo);
		return "process/processmain";	
	}
	
	@GetMapping("/process") // 주소창에 /process 입력시 실행
    public String single_value(Model model,@RequestParam("procid") String procid) {
		System.out.println("[ProcessController] /process : procid=" + procid);
		
		// 뷰파일에 procid를 저장하기 위해 재전송
		model.addAttribute("procid", procid);
		
		String prodName = processDao.selectProdName(procid);
		model.addAttribute("prodName", prodName);
		System.out.println("[ProcessController] /process : prodName=" + prodName);
		
		System.out.println("procid : " + procid);
		String goodProd = processDao.selectGood_prod(procid);
		model.addAttribute("goodProd", goodProd);
		
		String badProd = processDao.selectBad_prod(procid);
		model.addAttribute("badProd", badProd);
		
		String issueCount = processDao.selectIssue_count(procid);
		model.addAttribute("issueCount", issueCount);
		
		List<ProcessBean> issueList = processDao.selectIssueAll(procid);
		if(issueList != null) {
			model.addAttribute("issueList", issueList);
			System.out.println("issueList" + issueList);
		}
		
		List<ProcessBean> process_gauge = processDao.selectGauge(procid);
		if(process_gauge != null) {
			model.addAttribute("process_gauge", process_gauge.get(0));
			System.out.println("ProcessController.single_value(): /process : process_gauge=" + process_gauge.get(0).getProcess_gauge());
		}
		List<ProcessBean> process_rate = processDao.select_rate(procid);
		if(process_rate != null) {
			model.addAttribute("process_rate", process_rate);
			System.out.println("process_rate" + process_rate);
		}
	
		return "process/processmain";
	}

	
	@PostMapping("/process2")
	public void doChart_time(HttpServletRequest request, HttpServletResponse response, @RequestParam("procid") String procid) throws ServletException, IOException{
		System.out.println("[timechart/procid] : " + procid);
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		String process_leadtime = processDao.selectleadtime(procid);
		System.out.println("Leadtime : " + process_leadtime);
		
		List<ProcessBean>process_cycletime = processDao.select_cycletime(procid);
		/*int count = processDao.count(); 
		System.out.println("Cycletime : " + count);*/
		
		JSONArray chart = new JSONArray();
		chart.add(process_leadtime);
		
		for(ProcessBean p : process_cycletime) {
			chart.add(p.getCycletime());
		}
		
		String jsonInfo = chart.toJSONString();
		System.out.println(jsonInfo);
		writer.print(jsonInfo);
		
	}

	@PostMapping("/process3")
	public void doChart_material(HttpServletRequest request, HttpServletResponse response,@RequestParam("procid")String procid) throws ServletException, IOException{
		System.out.println("[timechart]");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		List<ProcessBean>process_material = processDao.select_material(procid);
		System.out.println("Material : " + process_material);
		JSONArray chart = new JSONArray();
		for(ProcessBean p : process_material) {
			chart.add(p.getMaterialname());
		}
		for(ProcessBean p : process_material) {
			chart.add(p.getMaterialqty());
		}
		String jsonInfo = chart.toJSONString();
		System.out.println(jsonInfo);
		writer.print(jsonInfo);
	}

	@PostMapping("/process4")
	public void doChart_material2(HttpServletRequest request, HttpServletResponse response,@RequestParam("procid")String procid) throws ServletException, IOException{
		System.out.println("[timechart]");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		List<ProcessBean>process_material = processDao.select_material(procid);
		System.out.println("Material : " + process_material);
		JSONArray chart = new JSONArray();
		for(ProcessBean p : process_material) {
			chart.add(p.getMaterialname());
		}
		for(ProcessBean p : process_material) {
			chart.add(p.getMaterialqty());
		}
		String jsonInfo = chart.toJSONString();
		System.out.println(jsonInfo);
		writer.print(jsonInfo);
	}
	
	@PostMapping("/process5")
	public void doChart_material3(HttpServletRequest request, HttpServletResponse response,@RequestParam("procid")String procid) throws ServletException, IOException{
		System.out.println("[timechart]");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		List<ProcessBean>process_material = processDao.select_material(procid);
		System.out.println("Material : " + process_material);
		JSONArray chart = new JSONArray();
		for(ProcessBean p : process_material) {
			chart.add(p.getMaterialname());
		}
		for(ProcessBean p : process_material) {
			chart.add(p.getMaterialqty());
		}
		String jsonInfo = chart.toJSONString();
		System.out.println(jsonInfo);
		writer.print(jsonInfo);
	}
	

	
	@ExceptionHandler({EmptyResultDataAccessException.class})
	public  String emptyResultDataAccessException() {
		return "process/processmain";
	}

}
