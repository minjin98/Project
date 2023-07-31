package controller.manage;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import controller.login.LoginCommandValidator;
import spring.dao.ApprovalPlan;
import spring.dao.User;
import spring.manage.ManageService;

@Controller
@RequestMapping("/manage")
public class ManageController {
	private ManageService manageS;
	
	public void setManageS(ManageService manageS) {
		this.manageS = manageS;
	}

	@RequestMapping("")
    public String manage() {
    	return "manage/manage";
    }
	
	@RequestMapping("/usermanagement")
    public String manageUser(Model model, ManageUserCommand manageUserCommand) {
		System.out.println("[REQUEST] /usermanagement");
		List<User> list = manageS.allUserList();
		model.addAttribute("userlist",list);
    	return "manage/manageUser";
    }
	
	@PostMapping("/usermanagement/register.do")
	public void newUser(HttpServletRequest httpServletRequest, HttpServletResponse response, ManageUserCommand manageUserCommand, Errors errors, Model model) throws ServletException, IOException{
		System.out.println("[POST] /register.do");
		httpServletRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		System.out.println("[register User req]" + httpServletRequest.getParameter("empNo")
		+ httpServletRequest.getParameter("name")
		+ httpServletRequest.getParameter("id")
		+ httpServletRequest.getParameter("password"));
		
		manageUserCommand.setEmpNo(httpServletRequest.getParameter("empNo"));
		manageUserCommand.setName(httpServletRequest.getParameter("name"));
		manageUserCommand.setId(httpServletRequest.getParameter("id"));
		manageUserCommand.setPassword(httpServletRequest.getParameter("password"));
		manageUserCommand.setPasswordCheck(httpServletRequest.getParameter("passwordCheck"));
		manageUserCommand.setRank(httpServletRequest.getParameter("rank"));
		
		System.out.println("[register User]" + manageUserCommand.getEmpNo()
		+ manageUserCommand.getName()
		+ manageUserCommand.getPassword()
		+ manageUserCommand.getRank());
		
		new LoginCommandValidator().validate(manageUserCommand, errors);
		if (errors.hasErrors()) {
			System.out.println("[Validator] has error");
			writer.print("fail");
			return;
        }
		
		manageS.insertUser(manageUserCommand);
		writer.print("success");
	}
	
	@RequestMapping("/userlist.json")
	public void alluserJson(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		JSONArray usersArray = new JSONArray();
		JSONObject jsonInfo = new JSONObject();
		
		List<User> list = manageS.allUserList();
		for(User user : list) {
			JSONArray userInfo = new JSONArray();
			userInfo.add(user.getEmpNo());
			userInfo.add(user.getName());
			userInfo.add(user.getId());
			userInfo.add(user.getRank());
			userInfo.add(manageS.userRegiDate(user));
			userInfo.add(manageS.userAdminString(user));
			usersArray.add(userInfo);
		}
		
		jsonInfo.put("data", usersArray);
		String data = jsonInfo.toJSONString();
		//System.out.print(data);
		writer.print(data);
	}
	
	@RequestMapping("/noticheck.do")
	public void managerNoti(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		PrintWriter writer = response.getWriter();
		writer.print(manageS.planNotification());
	}
	
	@RequestMapping("/duplicateidcheck.do")
	public void idDupCheck(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		System.out.println("[JSON REQUEST]duplicateidcheck id: " + request.getParameter("id"));
		System.out.println("[JSON RESPONSE]duplicateidcheck data: " + manageS.idDuplicate(request.getParameter("id")));
		
		PrintWriter writer = response.getWriter();
		writer.print(manageS.idDuplicate(request.getParameter("id")));
	}
	

	@RequestMapping("/ranklist.json")
	public void rankJson(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		JSONArray ranksArray = new JSONArray();
		JSONObject jsonInfo = new JSONObject();
		
		List<String> list = manageS.rankList();
		for(String rank : list) {
			System.out.println(rank);
			ranksArray.add(rank);
		}
		
		writer.print(ranksArray);
	}
	
	@RequestMapping("/userdata.json")
	public void userJson(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		String id = request.getParameter("id");

		User user = manageS.getUserById(id);

		JSONObject userInfo = new JSONObject();
		userInfo.put("empno",user.getEmpNo());
		userInfo.put("name",user.getName());
		userInfo.put("id",user.getId());
		userInfo.put("password",user.getPassword());
		userInfo.put("rank",user.getRank());
		userInfo.put("admin",user.isAdmin());

		String data = userInfo.toJSONString();
		//System.out.print(data);
		writer.print(data);
	}
	
	@RequestMapping("/deleteuser.do")
	public void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String id = request.getParameter("id");
		
		System.out.println("[DELETE User] id : " + id);
		manageS.deleteUser(id);
	}
	
	@RequestMapping("/updateuser.do")
	public void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		boolean admin = false;
		
		if(request.getParameter("admin").equals("true")) {
			admin = true;
		}
		
		User user = new User(request.getParameter("empno"),
				request.getParameter("id"),
				request.getParameter("password"),
				request.getParameter("name"),
				request.getParameter("rank"),
				admin);
		
		System.out.println("[UPDATE User] id : " + request.getParameter("id"));
		manageS.updateUser(user);
	}
	
	@RequestMapping("/approvalpage")
	public String manageApproval() {
		return "manage/managePlan";
	}
	
	@RequestMapping("/notcheckedprocess.json")
	public void processListJson(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		JSONArray plansArray = new JSONArray();
		JSONObject jsonInfo = new JSONObject();
		
		List<ApprovalPlan> list = manageS.getApprovalPlanList();
		for(ApprovalPlan plan : list) {
			JSONArray planInfo = new JSONArray();
			planInfo.add(plan.getPlanid());
			planInfo.add(plan.getLineid());
			planInfo.add(plan.getProdname());
			planInfo.add(plan.getQty());
			planInfo.add(manageS.planPeriodDate(plan));
			planInfo.add(plan.getRank());
			planInfo.add(plan.getName());
			plansArray.add(planInfo);
		}
		
		jsonInfo.put("data", plansArray);
		String data = jsonInfo.toJSONString();
		//System.out.print(data);
		writer.print(data);
	}
	
	@RequestMapping("/approveplan.do")
	public void approvePlanDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String planid = request.getParameter("planid");
		manageS.planChecked(planid);
	}
}
