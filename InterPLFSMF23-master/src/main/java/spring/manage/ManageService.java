package spring.manage;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import controller.manage.ManageUserCommand;
import spring.dao.ApprovalPlan;
import spring.dao.PlanDao;
import spring.dao.User;
import spring.dao.MainDao;

public class ManageService {
	private MainDao mainDao;
	
	public void setmainDao(MainDao mainDao) {
		this.mainDao = mainDao;
	}

	public List<User> allUserList(){
		List<User> userlist = mainDao.selectAll();
		return userlist;
	}
	
	public void insertUser(ManageUserCommand newUser) {
		mainDao.insertUser(newUser);
	}
	
	public String userAdminString(User user) {
		if(user.isAdmin()) {
			return "true";
		}else {
			return "false";
		}
	}
	
	public String userRegiDate(User user) {
		String regidate;
		LocalDateTime userDate = user.getRegiDate();
		
		regidate = userDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		
		return regidate;
	}
	
	public boolean planNotification() {
		return mainDao.planNotification();
	}
	
	public boolean idDuplicate(String id) {
		return (mainDao.selectById(id) != null) ? true:false ;
	}
	
	public void changePassword(String id, String pw) {
		mainDao.updatePassword(id, pw);
	}
	
	public boolean passwordCheck(String id, String pw) {
		if(mainDao.selectIdPwMatch(id, pw) != null) {
			return true;
		}
		return false;
	}
	
	public User getUserById(String id) {
		User user = mainDao.selectById(id);
		return user;
	}
	
	public List<String> rankList(){
		return mainDao.rankList();
	}
	
	public void deleteUser(String id) {
		mainDao.deleteUser(id);
	}

	public void updateUser(User user) {
		mainDao.updateUser(user);
	}
	
	public List<ApprovalPlan> getApprovalPlanList() {
		return mainDao.selectApprovalPlan("N");
		
	}
	
	public String planPeriodDate(ApprovalPlan plan) {
		String date;
		LocalDateTime stdate = plan.getStartdate();
		LocalDateTime eddate = plan.getEnddate();
		
		date = stdate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) + " ~ " + 
				eddate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
		return date;
	}

	public void planChecked(String planid) {
		mainDao.planChecked(planid);	
	}
}
