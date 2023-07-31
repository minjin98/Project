package spring.dao;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class User {

	/*
	 * Bean for contains user data
	 */
	
	//basic method
	private Long userNo;
	private String empNo;
	private String id;
	@JsonIgnore
	private String password;
	private String name;
	private String rank;
	private boolean admin;
	private LocalDateTime regiDate;
	
	public User(String empno, 
			String id, 
			String password, 
			String name, 
			String rank, 
			boolean admin, 
			LocalDateTime regidate) {
		this.empNo = empno;
		this.id = id;
		this.password = password;
		this.name = name;
		this.rank = rank;
		this.admin = admin;
		this.regiDate = regidate;
	}
	
	public User(String empno, 
			String id, 
			String password, 
			String name, 
			String rank, 
			boolean admin) {
		this.empNo = empno;
		this.id = id;
		this.password = password;
		this.name = name;
		this.rank = rank;
		this.admin = admin;
	}

	public String getEmpNo() {
		return empNo;
	}

	public String getId() {
		return id;
	}

	public String getPassword() {
		return password;
	}

	public String getName() {
		return name;
	}

	public String getRank() {
		return rank;
	}

	public boolean isAdmin() {
		return admin;
	}

	public LocalDateTime getRegiDate() {
		return regiDate;
	}

	public void setuserNo(Long userNo) {
		this.userNo = userNo;
	}

	public Long getuserNo() {
		return userNo;
	}
	
	public boolean matchPassword(String password) {
		return this.password.equals(password);
	}
	
	public String getAdmin() {
		if(this.admin) {
			return "1";
		}
		return "0";
	}
}
