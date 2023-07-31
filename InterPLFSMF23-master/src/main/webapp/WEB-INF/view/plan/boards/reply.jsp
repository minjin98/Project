<%@ page contentType="text/html; charset=UTF-8" %>
<%-- read.jsp에서session.setAttribute("bean", bean);에서 저장한
이름 bean과 동일한 이름을 사용하여야 한다 
--%>
<jsp:useBean id="bean" class="spring.plan.PlanInfo" scope="session"/>
<%
	//useBean을 사용하지 않고 session.getAttribute("bean")로 가져 올 수 있다.
	// boards.BoardBean bean = (boards.BoardBean)session.getAttribute("bean");
	String nowPage = request.getParameter("nowPage");
	String prodName = bean.getProdName();
	String content = bean.getContent(); 
%>
<html>
<head>
<title>JSPBoard</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFCC">
<div align="center">
<br><br>
 <table width="600" cellpadding="3">
  <tr>
   <td bgcolor="#CCCC00" height="21" align="center">답변하기</td>
  </tr>
</table>
<form method="post" action="boardReply.do" >
<table width="600" cellpadding="7">
 <tr>
  <td>
   <table>
    <tr>
     <td width="20%">성 명</td>
     <td width="80%">
	  <input name="name" size="30" maxlength="20"></td>
    </tr>
    <tr>
     <td>제 목</td>
     <td>
	  <input name="prodName" size="50" value="답변 : <%=prodName%>" maxlength="50"></td> 
    </tr>
	<tr>
     <td>내 용</td>
     <td>
	  <textarea name="content" rows="12" cols="50">
      	<%=content %>
      	========답변 글을 쓰세요.=======
      	</textarea>
      </td>
    </tr>
    <tr>
     <td>비밀 번호</td> 
     <td>
	  <input type="password" name="pass" size="15" maxlength="15"></td> 
    </tr>
    <tr>
     <td colspan="2" height="5"><hr/></td>
    </tr>
	<tr> 
     <td colspan="2">
	  <input type="submit" value="답변등록" >
      <input type="reset" value="다시쓰기">
      <input type="button" value="뒤로" onClick="history.back()"></td>
    </tr> 
   </table>
  </td>
 </tr>
</table>
 <input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>" >
 <input type="hidden" name="nowPage" value="<%=nowPage%>">
 <input type="hidden" name="ref" value="<%=bean.getRef()%>">
 <input type="hidden" name="pos" value="<%=bean.getPos()%>">
 <input type="hidden" name="depth" value="<%=bean.getDepth()%>">
</form> 
</div>
</body>
</html>