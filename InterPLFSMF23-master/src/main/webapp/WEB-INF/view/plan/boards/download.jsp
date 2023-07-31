<%@page contentType="application; charset=UTF-8"%>
<jsp:useBean id="bMgr" class="spring.dao.PlanDao" />
<%
	  bMgr.downLoad(request, response, out, pageContext);
%>