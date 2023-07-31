package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import spring.auth.AuthInfo;

public class AdminCheckInterceptor implements HandlerInterceptor {

	/*
	 * Interceptor for check admin access rights
	 */
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession(false); 
		if (session != null) {	
			Object authInfo = session.getAttribute("authInfo");	
			if (authInfo != null) {
				AuthInfo auth = new AuthInfo();
				auth = (AuthInfo)authInfo;
				if(auth.getAdmin()) {
					return true;
				}
			}
		}
		response.sendRedirect(request.getContextPath() + "/main");
		return false;
	}

}
