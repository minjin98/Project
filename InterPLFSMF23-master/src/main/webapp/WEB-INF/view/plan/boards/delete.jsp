<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="spring.plan.PlanInfo"%>
<jsp:useBean id="bMgr" class="spring.dao.PlanDao" />
<html>
<head>
<title>Delete Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<%
	request.setCharacterEncoding("UTF-8");
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
    String planID = request.getParameter("planID");
    
    System.out.println("[delete.jsp] num="+num);
	System.out.println("[delete.jsp] planID="+ planID);
	
	if (request.getParameter("pass") != null) {
		String inPass = request.getParameter("pass");
		PlanInfo bean = (PlanInfo) session.getAttribute("bean");
		String dbPass = bean.getPass();
		
		if (inPass.equals(dbPass)) {
			bMgr.deleteBoard(num);
			bMgr.deletePlan(planID);
			String url = "plan.do?nowPage=" + nowPage;
			response.sendRedirect(url);
		} 
		else {
%>
<script type="text/javascript">
	alert("입력하신 비밀번호가 아닙니다.");
	history.back();
</script>
<%}
	} else {
%>
<script type="text/javascript">
	function check() {
		if (document.delFrm.pass.value == "") {
			alert("패스워드를 입력하세요.");
			document.delFrm.pass.focus();
			return false;
		}
		document.delFrm.submit();
	}
</script>
</head>
<body bgcolor="#FFFFCC">
	<div align="center">
		<br/><br/>
		<table width="600" cellpadding="3">
			<tr>
				<td bgcolor=#dddddd height="21" align="center">
					사용자의 비밀번호를 입력해주세요!
				</td>
			</tr>
		</table>
		<form name="delFrm" method="post" action="delete.do">
			<table width="600" cellpadding="2">
				<tr>
					<td align="center">
						<table>
							<tr>
								<td align="center">
									<input type="password" name="pass" size="17" maxlength="15">
								</td>
							</tr>
							<tr>
								<td><hr size="1" color="#eeeeee"/></td>
							</tr>
							<tr>
								<td align="center">
									<input type="button" value="삭제완료" onClick="check()"> 
									<input type="reset" value="다시쓰기">
									<input type="button" value="뒤로" onClick="history.go(-1)">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="planID" value="<%=planID%>">
		</form>
	</div>
	<%}%>
</body>
</html>