<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="spring.plan.PlanInfo"%>
<%@page import="spring.plan.PlanTable"%>
<%-- <%@page import="spring.plan.BomInfo"%>
<%@page import="spring.plan.ProdInfo"%> --%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Vector"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:useBean id="bMgr" class="spring.dao.PlanDao" />
<%
	  request.setCharacterEncoding("UTF-8");
	  int num = Integer.parseInt(request.getParameter("num"));
	  
	  String nowPage = request.getParameter("nowPage");
	  String keyField = request.getParameter("keyField");
	  String keyWord = request.getParameter("keyWord");
	  
	  PlanInfo bean = bMgr.getBoard(num);//게시물 가져오기
	  	  String planID = bean.getPlanID();
		  String empname = bean.getEmpName();
		  String prodName = bean.getProdName();
		  String prodNo = bean.getProdNo();
	      String regdate = bean.getRegdate();							
		  Date startdate = bean.getStartdate();
		  Date enddate = bean.getEnddate();
		  String content = bean.getContent();
		  String filename = bean.getFilename();
		  int filesize = bean.getFilesize();
		  String ip = bean.getIp();
		  
	  	  session.setAttribute("bean", bean);//게시물을 세션에 저장
	  
	  PlanTable bean2 = bMgr.getPlan(planID);
	  	  String lineID = bean2.getLineID();
	  	  int prodQty = bean2.getProdQty();
	  	  String check_yn = bean2.getCheck_yn();
		  	
%>
<html>

<style>
	.table_padding{
		margin-left: 30px;
	}

</style>

<head>
<title>조회</title>
<link href="${path}/resources/css/style_bd.css" rel="stylesheet" type="text/css">
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script><!-- bootstrap icon -->
<link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css"><!-- bootstrap card style -->
<script type="text/javascript">
	function plan(){
	    document.planFrm.submit();
	 } 
	
	function down(filename){
		 document.downFrm.filename.value=filename;
		 document.downFrm.submit();
	}
</script>
</head>
<body>

<br/><br/>
<main>
    <div class="container-fluid px-4">
		<div class="card mb-4">
		  <div class="card-header">
		      <i class="fa-solid fa-pencil"></i>
	     		조회
	  	</div>
		<div class="card-body">
			<table align="center" width="700" cellspacing="3">
				 <tr>
				  	<td bgcolor="#4B69EE" height="25" align="center"></td>
				 </tr>
				 <tr>
				  <td>
				   <table cellpadding="3" cellspacing="0" width="500"> 
					    <tr> 
					  		<td align="center" bgcolor="#FFFFFF" width="10%"> 등록날짜 </td>
					  		<td align="center" bgcolor="#FFFFFF" width="50%"><%=regdate%></td>
					  	</tr>
					    <tr>
					  		<td align="center" bgcolor="#FFFFFF" width="10%"> 담당자 </td>
					  		<td align="center" bgcolor="#FFFFFF" width="50%"><%=empname%></td>
					 	</tr>
					 		<td align="center" bgcolor="#FFFFFF" width="10%"> 생산기간 </td>
					  		<td align="center" bgcolor="#FFFFFF" width="50%"><%=startdate%> ~ <%=enddate%></td>
						 <tr> 
						    <td align="center" bgcolor="#FFFFFF"> 생산상품</td>
						    <td align="center" bgcolor="#FFFFFF" width="50%"><%=prodName%></td>
						 </tr>
						 <tr>
						    <td align="center" bgcolor="#FFFFFF"> 상품코드</td>
						    <td align="center" bgcolor="#FFFFFF" width="50%"><%=prodNo%></td>
						 </tr>
						 <tr>
						    <td align="center" bgcolor="#FFFFFF"> PlanID</td>
						    <td align="center" bgcolor="#FFFFFF" width="50%"><%=planID%></td>
						 </tr>
						 <tr>
						    <td align="center" bgcolor="#FFFFFF"> LineID</td>
						    <td align="center" bgcolor="#FFFFFF" width="50%"><%=lineID%></td>
						 </tr>
						 <tr>
						    <td align="center" bgcolor="#FFFFFF"> 생산계획</td>
						    <td align="center" bgcolor="#FFFFFF" width="50%"><%=prodQty%></td> 
						 </tr>
						 <tr>
						    <td align="center" bgcolor="#FFFFFF"> 결제유무</td>
						    <td align="center" bgcolor="#FFFFFF" width="50%"><%=check_yn%></td> 
						 </tr>
						 <tr> 
						    <td align="center" bgcolor="#FFFFFF"> 비 고</td>
						    <td align="center"  bgcolor="#FFFFFF" width="50%"><%=content%></td>
						 </tr>
						 <tr> 
						     <td align="center" bgcolor="#FFFFFF">첨부파일</td>
						     <td align="center" bgcolor="#FFFFFF" colspan="3">
						     <% if( filename !=null && !filename.equals("")) {%> <%--파일 이름이(파일이)있는 경우 --%>
						  		<a href="javascript:down('<%=filename%>')"><%=filename%></a>
						  		 &nbsp;&nbsp;<font color="blue">(<%=filesize%>KBytes)</font>  
						  		 <%} else{%> 등록된 파일이 없습니다.<%}%>
						     </td>
						 </tr>
						 <tr> 
						 	<td colspan="4"><br/><pre>결제 부탁드립니다!</pre><br/></td>
						 </tr>
<!-- 						 <tr>
						     <td colspan="4" align="right">
						     	홍길동
						     </td>
						 </tr> -->
				   </table>
				  </td>
				 </tr>
				 <tr>
				  <td align="center" colspan="2"> 
				 <hr/>
					 [ <a href="javascript:plan()" >Back</a> | 
					 <a href="update.do?nowPage=<%=nowPage%>&num=<%=num%>" >Edit</a> |
					 <a href="reply.do?nowPage=<%=nowPage%>" >Reply</a> |
					 <a href="delete.do?nowPage=<%=nowPage%>&num=<%=num%>&planID=<%=planID%>">Delete</a> ]<br/>
				  </td>
				 </tr>
			</table>
		</div><!-- card-body -->
	</div><!-- card mb-4 -->
</div>

</main>
			<form name="downFrm" action="download.do" method="post">
				<input type="hidden" name="filename">
			</form>
			
			<form name="planFrm" method="post" action="plan.do">
				<input type="hidden" name="nowPage" value="<%=nowPage%>">
				<%if(!(keyWord==null || keyWord.equals(""))){ %>
				<input type="hidden" name="keyField" value="<%=keyField%>">
				<input type="hidden" name="keyWord" value="<%=keyWord%>">
				<%}%>
			</form>
</body>
</html>