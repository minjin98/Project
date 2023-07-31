package spring.statistics;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import spring.dao.ApprovalPlan;
import spring.dao.Issue;
import spring.dao.LOT;
import spring.dao.MainDao;
import spring.dao.User;

public class StatisticsService {
	private MainDao mainDao;
	
	public void setmainDao(MainDao mainDao) {
		this.mainDao = mainDao;
	}
	
	public String getIssueDate(Issue is) {
		String date;
		LocalDateTime timestamp = is.getTime();
		
		date = timestamp.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		
		return date;
	}
	
	public String planPeriodDate(ApprovalPlan plan) {
		String date;
		LocalDateTime stdate = plan.getStartdate();
		LocalDateTime eddate = plan.getEnddate();
		
		date = stdate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) + " ~ " + 
				eddate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
		return date;
	}
	
	public List<Issue> getIssueList(){
		return mainDao.selectAllIssue();
	}
	
	public List<ApprovalPlan> getPlanList() {
		return mainDao.selectPlanWithName();
	}
	
	public List<ApprovalPlan> getPlanchartInfoList(){
		return mainDao.selectPlanProdNQty();
	}
	
	public List<LOT> getInvenMaterQtyList(){
		return mainDao.selectEAMaterialQty();
	}

	public double[] getPlanpercentage(String planid) {
		String procid = mainDao.selectprocessId(planid);
		double target = (double)mainDao.selectPlanQty(planid);
		double qcp = (double)mainDao.countQcPass(procid);
		double qcf = (double)mainDao.countQcFail(procid);
		
//		System.out.println(target);
//		System.out.println(qcp);
//		System.out.println(qcf);
		
		double total = (qcp+qcf)/target*100;
		double qcpp = qcp/target*100;
		double qcfp = qcf/target*100;
		
		double[] percents = {Math.round(total*100)/100.0,Math.round(qcpp*100)/100.0,Math.round(qcfp*100)/100.0};
//		System.out.println(percents[0]);
//		System.out.println(percents[1]);
//		System.out.println(percents[2]);
		return percents;
	}
}
