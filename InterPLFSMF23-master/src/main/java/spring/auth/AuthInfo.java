package spring.auth;

public class AuthInfo {

	private String id;
	private String name;
	private boolean admin;

	public AuthInfo() {
		
	}
	
	public AuthInfo(String id, String name, boolean admin) {
		this.id = id;
		this.name = name;
		this.admin = admin;
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public boolean getAdmin() {
		return admin;
	}
}
