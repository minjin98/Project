package controller.plan;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oreilly.servlet.MultipartRequest;

import spring.dao.PlanDao;
import spring.plan.PlanInfo;
import spring.plan.PlanTable;

@Controller
@RequestMapping("/boards")
public class PlanController {

	
	@GetMapping(value={ "/", "/plan.do" } )
	public String boards(Model model) {
		System.out.println("[BoardController] : GET:/plan.do");
		return "plan/boards/plan";
	}

	@PostMapping("/plan.do")
	public String listPost(Model model) {
		System.out.println("[BoardController] : POST:/plan.do");
		return "plan/boards/plan";
	}
	
	@GetMapping("/read.do")
	public String read(Model model) {
		System.out.println("[BoardController] : GET:/boards/read.do");
		return "plan/boards/read";
	}
	
	@GetMapping("/update.do")
	public String update(Model model) {
		System.out.println("[BoardController] : GET:/boards/update.do");
		return "plan/boards/update";
	}

	@GetMapping("/reply.do")
	public String reply(Model model) {
		System.out.println("[BoardController] : GET:/boards/reply.do");
		return "plan/boards/reply";
	}

	@RequestMapping("/delete.do")
	public String delete(@RequestParam(value="planID", required = false) String planID, Model model) {
		System.out.println("[BoardController] : /boards/delete.do");
		System.out.println("planID="+planID);
		model.addAttribute("planID", planID);
		return "plan/boards/delete";
	}
	
	@PostMapping("/download.do")
	public String download(Model model) {
		System.out.println("[BoardController] : POST:/boards/download.do");
		return "plan/boards/download";
	}

	/*
	 * @GetMapping("/popup.do") public String popup(Model model) {
	 * System.out.println("[BoardController] : GET:/boards/popupForm.do"); return
	 * "plan/boards/popup"; }
	 *
	 *
	 * @GetMapping("/writePost.do") public String writePost(Model model) {
	 * System.out.println("[BoardController] : /writePost.do"); return
	 * "plan/boards/writePost"; }
	 */

	@PostMapping("/boardPost.do")	// @GetMapping("/writePost.do")에서 요청
	public String boardPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("[BoardController] : POST:/boardPost.do");
		request.setCharacterEncoding("UTF-8");
		PlanDao bMgr = new PlanDao();
		MultipartRequest multi =  bMgr.insertBoard(request);
		bMgr.insertPlan(multi);
		return "redirect:/boards/plan.do";
	}
	
	@PostMapping("/boardReply.do")	// @GetMapping("/writePost.do")에서 요청
	public String boardReply(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		System.out.println("[BoardController] : POST:/boardReply.do");
		request.setCharacterEncoding("UTF-8");
		PlanDao bMgr = new PlanDao();
		PlanInfo reBean = new PlanInfo();
		reBean.setEmpName(request.getParameter("empname"));
		reBean.setPlanID(request.getParameter("planID"));
		reBean.setProdName(request.getParameter("prodName"));
		reBean.setContent(request.getParameter("content"));
		reBean.setRef(Integer.parseInt(request.getParameter("ref"))); 
		reBean.setPos(Integer.parseInt(request.getParameter("pos"))); 
		reBean.setDepth(Integer.parseInt(request.getParameter("depth"))); 
		reBean.setPass(request.getParameter("pass"));
		reBean.setIp(request.getParameter("ip"));

		bMgr.replyUpBoard(reBean.getRef(), reBean.getPos());
		bMgr.replyBoard(reBean);
		
		String nowPage = request.getParameter("nowPage");
		// response.sendRedirect("list.jsp?nowPage="+nowPage);
		return "redirect:/plan.do?nowPage="+nowPage;
	}	
	
	@PostMapping("/boardUpdate.do")
	protected String boardUpdate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("[BoardController] : POST:/boards/boardUpdate.do");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter(); 

		PlanDao bMgr = new PlanDao();
		PlanInfo bean = (PlanInfo) session.getAttribute("bean");
		String nowPage = request.getParameter("nowPage");

		PlanInfo upBean = new PlanInfo();
		upBean.setNum(Integer.parseInt(request.getParameter("num")));
		upBean.setPlanID(request.getParameter("planID"));
		upBean.setEmpName(request.getParameter("empname"));
		upBean.setProdName(request.getParameter("prodName"));
		upBean.setContent(request.getParameter("content"));
		upBean.setPass(request.getParameter("pass"));
		upBean.setIp(request.getParameter("ip"));

		String upPass = upBean.getPass();
		String inPass = bean.getPass();

		if (upPass.equals(inPass)) {
			bMgr.updateBoard(upBean);
			String url = "redirect:plan/boards/read.do?nowPage=" + nowPage + "&num=" + upBean.getNum();
			// response.sendRedirect(url);
			return url;
		} 
		else {
			out.println("<script>");
			out.println("alert('입력하신 비밀번호가 아닙니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return null;
	}
		

	
} 
