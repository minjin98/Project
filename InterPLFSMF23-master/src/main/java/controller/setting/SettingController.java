package controller.setting;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.auth.AuthInfo;
import spring.manage.ManageService;

@Controller
@RequestMapping("/settings")
public class SettingController {
	private ManageService manageService;
	
	public void setManageService(ManageService manageService) {
		this.manageService = manageService;	
	}
	
	@RequestMapping
	public String setting() {
		return "settings/settings";
	}
	
	@RequestMapping("/changepassword")
	public String changePassword() {
		return "settings/changePassword";
	}
	
	@RequestMapping("/changepassword.do")
	public void doChangePassword(HttpServletRequest request, HttpSession session, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		AuthInfo authInfo;
		authInfo = (AuthInfo)session.getAttribute("authInfo");
		String id = authInfo.getId();
		
		System.out.println("[passChange]");
		System.out.println("[JDBC Req] id: " + id);
		manageService.changePassword(id, request.getParameter("password"));
		
		PrintWriter writer = response.getWriter();
		writer.print("true");
	}
	
	@RequestMapping("/passcheck.do")
	public void doCheckPassword(HttpServletRequest request, HttpSession session, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		AuthInfo authInfo;
		authInfo = (AuthInfo)session.getAttribute("authInfo");
		String id = authInfo.getId();
		
		boolean status;
		System.out.println("[passCheck]");
		System.out.println("[JDBC Req] id: " + id);
		status = manageService.passwordCheck(id, request.getParameter("password"));
		
		PrintWriter writer = response.getWriter();
		writer.print(status);
	}
}
