<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="spring.auth.AuthInfo, java.util.List, spring.dao.ProcessBean" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:useBean id ="prod" class="spring.dao.ProcessDao"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>공정진행</title>
        <link href="${path}/resources/css/styles.css" rel="stylesheet" />
        <link href="${path}/resources/css/customstyle.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script type="text/javascript" src="https://fastly.jsdelivr.net/npm/echarts@5.4.2/dist/echarts.min.js"></script>
        <script type="text/javascript" src="${path}/resources/js/jquery-3.6.0.js"></script>
    </head>
    <%
    	String oneline = prod.selectOneLine();
    	String twoline = prod.selectTwoLine();
    	String threeline = prod.selectThreeLine();
    %>
     <%--드롭다운 메뉴 선택시 해당 value 값 ProcessController에 전송 --%> 
        <script>
	        function checkNoti(){
				$.ajax({
	       			type:"post",  
	       			url:"http://localhost:8584/SMFPlatform/manage/noticheck.do",
	       			success:function (data, textStatus) {
						if(JSON.parse(data)){
							document.getElementById("notification-icon").innerHTML = '<i class="fa fa-bell"></i>'
						}else{
							document.getElementById("notification-icon").innerHTML = '<i class="fa fa-bell-slash"></i>'
						}
	       			},
	       			complete:function(data,textStatus){
	       			},
	       			error:function(data, textStatus){
	          			alert("에러발생: " + data);
	       			},
	    		});
			}
        
	        $(document).ready(function() {
	        	checkNoti();
		        $("#procid").change(function() {
		        	var procid = $("#procid").val();
		  			<%--alert(procid);--%>
		  			var formProc = $("#procForm");
		  			formProc.submit();
		        });
			});
        </script>
    <body class="sb-nav-fixed">
        <!-- Top Nav Area -->
        <script src="resources/js/kor_clock.js"></script>
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="main">Platform Name</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle"><i class="fas fa-bars"></i></button>
            <!-- Navbar Clock -->
            <div class="navbar-clock justify-content-end align-items-md-end text-end" id="navbar-clock">
		        <div id="date" class="date"></div>
		        <div id="time" class="time"></div>
            </div>
            <!-- Navbar-->
            <!-- Notification Icon for Admin User -->
            <c:if test="${sessionScope.authInfo.getAdmin()}">
	            <ul class="navbar-nav justify-content-end align-items-md-end">
		            <li class="nav-item">
		            	<a class="nav-link" id="navbarDropdown" href="${path}/manage/approvalpage" role="button"  aria-expanded="false">
		            		<span id="notification-icon"></span>
		            	</a>
		            </li>
	            </ul>
            </c:if>
            <ul class="navbar-nav justify-content-end align-items-md-end">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="${path}/settings">Settings</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <!-- contents for admin -->
                        <c:if test="${sessionScope.authInfo.getAdmin()}">
	                        <li><a class="dropdown-item" href="${path}/manage">Manage Settings</a></li>
	                        <li><hr class="dropdown-divider" /></li>
                        </c:if>
                        <li><a class="dropdown-item" href="${path}/logout">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <!-- Side and Main Area-->
        <div id="layoutSidenav">
            <!-- Side Nav Area-->
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Menu</div>
                            <a class="nav-link" href="${path}/boards/plan.do">
                                <div class="sb-nav-link-icon"><i class="fa fa-list-ol"></i></div>
                                계획관리
                            </a>
                            <a class="nav-link" href="${path}/inventory">
                                <div class="sb-nav-link-icon"><i class="fa fa-archive"></i></div>
                                재고관리
                            </a>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fa fa-industry"></i></div>
                                생산관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="${path}/processorder">공정명령</a>
                                    <a class="nav-link" href="${path}/processres">공정결과</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts2" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fa fa-file"></i></div>
                                보고서
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts2" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="${path}/preport/pr_product">상품별 보고서</a>
                                    <a class="nav-link" href="${path}/preport/pr_line">라인별 보고서</a>
                                </nav>
                            </div>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        ${sessionScope.authInfo.getName()}
                    </div>
                </nav>
            </div>
            <!-- Inner Contents Area(main) -->
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                    <div class = "row">
                    	<div class="col-md-4">
                        	<h1 class="mt-4">공정결과</h1>
                        </div>
                        <div class="col-md-4">
                        	<h1 class="mt-4"></h1>
                        </div>
                        <div class="col-md-4">
                 			 	<form id="procForm" action="${path}/process" method="get">
				                	<select id="procid" name = "procid"> <!-- 공정선택 -->
				                		<option>공정선택</option> 
				                		<%--<option value = "${oneline}">1공정</option>
								        <option value = "${twoline}">2공정</option>
								        <option value = "${threeline}">3공정</option> --%>
								        <option value = "<%=oneline%>">1공정</option>
								        <option value = "<%=twoline%>">2공정</option>
								        <option value = "<%=threeline%>">3공정</option>
								    </select>     
				                </form>
				        </div>    
                        </div>
                    </div>
                      <div class="row" style="width:100%; padding-left: 10px;">
                        <div class="col-md-3">
                            <section class ="widget header"; style="width: 100%; border: 4px solid rgb(241, 237, 225) " >
                                <header>
                                    <h4>
                                        <span style = "font-size: 20px;">제품명</span>
                                    </h4>
                                </header>
                                   
                                <div class = "body" style="height: 50px; min-height: 50px;" id="total">
                                    <div class = "chart_content" id = "total1" style = "height: inherit; font-size : 35px;
                                    padding-top: 12.5px; padding-bottom: 12.5px;">
                                        <ul class= "multi_val">
                                            <ul style ="text-align : center; line-height : 25px; width : 100%;" class ="vertical multi-val-el">
                                               <span class="multi-val-label"></span> 
                                               <span class="multi-val-value multi-val-value-0">
                                                    <span class="multi_value_text" style ="color:black;font-size:30px;">
                                                   	<span>${prodName}</span>
                                                    </span>
                                            </ul>
                                        </ul>
                                    </div>
                                </div>
                            </section>
                        </div>
                        
                        <div class="col-md-3">
                            <section class ="widget header"; style="width: 100%; border: 4px solid rgb(241, 237, 225) " >
                                <header>
                                    <h4>
                                        <span style = "font-size: 20px;">양품생산수량</span>
                                    </h4>
                                </header>
                                <div class = "body" style="height: 50px; min-height: 50px;" id="total">
                                    <div class = "chart_content" id = "total1" style = "height: inherit; font-size : 35px;
                                    padding-top: 12.5px; padding-bottom: 12.5px;">
                                        <ul class= "multi_val">
                                            <ul style ="text-align : center; line-height : 25px; width : 100%;" class ="vertical multi-val-el">
                                               <span class="multi-val-label"></span> 
                                               <span class="multi-val-value multi-val-value-0">
                                                    <span class="multi_value_text" style ="color:#0059ff;font-size:inherit;">
                                                    <span>${goodProd}</span>
                                                    </span>
                                                    <span class = "multi_value_unit">EA</span>
                                               </span>
                                            </ul>
                                        </ul>
                                    </div>
                                </div>
                            </section>
                        </div>
                        <div class="col-md-3">
                            <section class ="widget header"; style="width: 100%; border: 4px solid rgb(241, 237, 225) " >
                                <header>
                                    <h4>
                                        <span style = "font-size: 20px;">불량생산수량</span>
                                    </h4>
                                </header>
                                <div class = "body" style="height: 50px; min-height: 50px;" id="total">
                                    <div class = "chart_content" id = "total1" style = "height: inherit; font-size : 35px;
                                    padding-top: 12.5px; padding-bottom: 12.5px;">
                                        <ul class= "multi_val">
                                            <ul style ="text-align : center; line-height : 25px; width : 100%;" class ="vertical multi-val-el">
                                               <span class="multi-val-label"></span> 
                                               <span class="multi-val-value multi-val-value-0">
                                                    <span class="multi_value_text" style ="color:red;font-size:inherit;">
                                                    	<span>${badProd}</span>
                                                    </span>
                                                    <span class = "multi_value_unit">EA</span>
                                               </span>
                                            </ul>
                                        </ul>
                                    </div>
                                </div>
                            </section>
                        </div>
                        <div class="col-md-3" >
                            <section class ="widget header"; style="width: 100%; border: 4px solid rgb(241, 237, 225) " >
                                <header>
                                    <h4>
                                        <span style = "font-size: 20px;">이슈 발생 건수</span>
                                    </h4>
                                </header>
                                <div class = "body" style="height: 50px; min-height: 50px;" id="total">
                                    <div class = "chart_content" id = "total1" style = "height: inherit; font-size : 35px;
                                    padding-top: 12.5px; padding-bottom: 12.5px;">
                                        <ul class= "multi_val">
                                            <ul style ="text-align : center; line-height : 25px; width : 100%;" class ="vertical multi-val-el">
                                               <span class="multi-val-label"></span> 
                                               <span class="multi-val-value multi-val-value-0">
                                                    <span class="multi_value_text" style ="color:orange;font-size:inherit;">
                                                		<span>${issueCount}</span>
                                                    </span>
                                                    <span class = "multi_value_unit">건</span>
                                               </span>
                                            </ul>
                                        </ul>
                                    </div>
                                </div>
                            </section>
                        </div>
                      
                    <div class="row" style ="width:100%">
                    <div class="col-xl-6" style = "width : 25%; heigth : 300px; padding:20px">
                            <div class="card mb-4" style = "width :100%">
                            <!-- <div class="card mb-4"> -->
                                    <div class="card-header">
                                        <i class="fas fa-chart-bar me-1"></i>
                                        가동률
                                    </div>
                                    <div class="card-body"><canvas id="myGaugeChart" width="100%" ></canvas></div>
                            </div>
                   	 </div>
                        <div class="col-xl-6" style = "width : 25%; heigth : 300px; padding:20px">
                            <div class="card mb-4" style = "width : 100%">
                                    <div class="card-header">
                                        <i class="fas fa-chart-bar me-1"></i>
                                        수율
                                    </div>
                                    <div class="card-body">
                                    	<canvas id="myPieChart" width="100%" height ="95"></canvas>
                                    </div>
                            </div>
                   	 </div>
                   	 <!-- 움직이는 차트 만들기 -->
                   	  <div class="col-xl-6" style = "width : 18%; heigth : 200px; padding-top: 20px; padding-left:20px">
                            <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-bar me-1"></i>
                                        소비 재고 차트(大)
                                    </div>
                                    <div class="card-body"><canvas id="myBarChart2" width="100%" height="70"></canvas></div>
                            </div>
                   	 </div>
                   	 <div class="col-xl-6" style = "width : 23%; heigth : 200px; padding-top: 20px; padding-left:5px">
                            <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-bar me-1"></i>
                                        소비 재고 차트(小)
                                    </div>
                                    <div class="card-body"><canvas id="myBarChart3" width="100%" height="70"></canvas></div>
                            </div>
                   	 </div>
                   	 <div class="col-xl-6" style = "width : 9%; heigth : 200px; padding-top: 20px; padding-left:5px">
                            <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-bar me-1"></i>
                                        공통자재
                                    </div>
                                    <div class="card-body"><canvas id="myBarChart4" width="100%" height="70"></canvas></div>
                            </div>
                   	 </div>
                 
                 <div class = "row">
	                 <div class="col-xl-6" style = "width : 50%">
	                 	<div class="card mb-4">
                        	<div class="card-header">
                            	<i class="fas fa-chart-bar me-1"></i>
                            	바차트
                        	</div>
                        <div class="card-body"><canvas id="myBarChart" width="100%" height="30"></canvas></div>
	                 	</div>
                    </div>        
             	 	<div class="col-xl-6" style ="padding-left:35px">
                    	<div class="card mb-4">
	                        <div class="card-header">
	                        	<i class="fas fa-table me-1"></i>
	                        	데이터테이블
	                        </div>
	                        <div class="card-body">
	                        	<table id="datatablesSimple">
	                            	<thead>
		                                <tr>
		                                    <th>이슈이름</th>
		                                    <th>이슈내용</th>
		                                    <th>발생일자</th>
		                                </tr>
	                            	</thead>
                                    <tbody>
                                       <c:forEach var="issue" items="${issueList}" >
	                                        <tr>
	                                           <td>${issue.issueNo}</td>
	                                            <td>${issue.issueInfo}</td>
    	                                        <td>${issue.timeStamp}</td>
	                                           
	                                        </tr>
										</c:forEach>
                                    </tbody>
                                      	<tfoot>
                                        <tr>
                                            <th>이슈</th>
                                            <th>이슈내용</th>
                                            <th>발생일자</th>
                                        </tr>
                                    </tfoot>
                                </table>
                       		</div>
                	 	</div>
               		</div>
               </div>
             </main>
         </div>
     </div>
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
     <script src="resources/js/scripts.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
     <script src="${path}/resources/js/chart-gauge.js"></script>
     <script src="${path}/resources/js/chart-bar-leadtime.js"></script>
     <script src="${path}/resources/js/chart-bar-produce.js"></script>
     <script src="${path}/resources/js/chart-bar-produce2.js"></script>
     <script src="${path}/resources/js/chart-bar-produce3.js"></script>
     <script src="${path}/resources/js/chart-pie.js"></script>
     <script src="${path}/resources/js/chart-datatables.js"></script>
     <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
     <script src="${path}/resources/js/datatables-simple-demo.js"></script>
     <script>
     	
     	<c:if test="${not empty process_gauge}">
     		var process_gauge_val = parseFloat(${process_gauge.process_gauge});
     		gaugeChart(process_gauge_val);
 		</c:if>
 		
 		<c:if test="${not empty process_rate}">
 		<c:forEach var = "proc" items ="${process_rate}">
 			var process_rate_val = [parseInt(${proc.goodprod_rate}),parseInt(${proc.badprod_rate})];
 			pieChart(process_rate_val);
 		</c:forEach>
 		</c:if>
		
 		<%--ProcessController에서 재전송 받은 procid 사용--%>
     	<c:if test="${not empty procid}">
     		fn_start("${procid}");
 		</c:if>
     	
 		<c:if test="${not empty procid}">
 			fn_chart3("${procid}");
		</c:if>
 		
		<c:if test="${not empty procid}">
			fn_chart4("${procid}");
		</c:if>
		
		<c:if test="${not empty procid}">
			fn_chart5("${procid}");
		</c:if>
		
		</script>
  </body>
</html>
