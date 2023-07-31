<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="spring.auth.AuthInfo" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>TEST2</title>
        <link href="${path}/resources/css/styles.css" rel="stylesheet" />
        <link href="${path}/resources/css/customstyle.css" rel="stylesheet" />
        <script src="${path}/resources/js/jquery-3.6.0.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
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
	        
	        $(document).ready(function () {
	        	if(${sessionScope.authInfo.getAdmin()}){
	        		checkNoti();
	        	}
	        });
	   </script>
    </head>
    <body class="sb-nav-fixed">
        <!-- Top Nav Area -->
        <script src="${path}/resources/js/kor_clock.js"></script>
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="${path}/main">Platform Name</a>
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
                    	<c:forEach var="lnames" items="${l_names}">
                        <h1 class="mt-4">${lnames.lineID}</h1>
                        </c:forEach>
                    </div>
                    <div class="container-fluid px-4">
                    	<div class="row">
	                        <div class="col-xl-3 col-md-6">
	                            <div class="card bg-primary text-white mb-4">
	                                <div class="card-body">제품명 : 
	                                	<c:forEach var="lnames" items="${l_names}">
		                            	<a>${lnames.prodName}</a> <!-- 한 건만 가져오는 것이기 때문에 forEach를 사용 -->
		                            	</c:forEach>
			                        </div>
	                            </div>
	                        </div>
	                        <div class="col-xl-3 col-md-6">
	                            <div class="card bg-warning text-white mb-4">
	                                <div class="card-body">담당자 : 
	                                	<c:forEach var="lnames" items="${l_names}">
			                            <a>${lnames.name}</a>
			                            </c:forEach>
			                        </div>
	                            </div>
	                        </div>
	                        <div class="col-xl-3 col-md-6">
	                            <div class="card bg-success text-white mb-4">
	                                <div class="card-body">시작일 : 
	                                	<c:forEach var="lpr" items="${l_pr}">
		                            	<a>${lpr.startdate}</a>
		                            	</c:forEach>
			                        </div>
	                            </div>
	                        </div>
	                        <div class="col-xl-3 col-md-6">
	                            <div class="card bg-danger text-white mb-4">
	                                <div class="card-body">종료일 : 
	                                	<c:forEach var="lpr" items="${l_pr}">
		                            	<a>${lpr.enddate}</a>
		                            	</c:forEach>
			                        </div>
	                            </div>
	                        </div>
	                    </div>
                        <div class="row">
                        	<!-- 불량률 차트 -->
                            <div class="col-lg-5">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-pie me-1"></i>
                                        불량률
                                    </div>
                                    <div class="card-body"><canvas id="myPieChart" width="100%" height="40"></canvas></div>
                                    <div class="card-footer small text-muted">
                                    	<c:forEach var="lpr" items="${l_pr}">
                                    	양품 : ${lpr.passedQty} &nbsp;&nbsp;&nbsp; 불량품 : ${lpr.failedQty}
                                    	</c:forEach>
                                    </div>
                                </div>
                            </div>
                        	<!-- 이름과 납기 -->
                            <div class="col-lg-7">
                                <div class="card mb-4">
                                    <div class="card-header">
                                    	<i class="fa fa-history me-1"></i>
	                                    발생한 이슈
	                                </div>
	                                <div class="card-body">
		                                <div class="table-responsive">
						                	<table class="table text-nowrap mb-0 align-middle">
						                    	<thead class="text-dark fs-4">
						                      		<tr>
								                        <th class="border-bottom-0">
								                          <h6 class="fw-semibold mb-0">발생번호</h6>
								                        </th>
								                        <th class="border-bottom-0">
								                          <h6 class="fw-semibold mb-0">계획번호</h6>
								                        </th>
								                        <th class="border-bottom-0">
								                          <h6 class="fw-semibold mb-0">코드</h6>
								                        </th>
								                        <th class="border-bottom-0">
								                          <h6 class="fw-semibold mb-0">이슈</h6>
								                        </th>
								                        <th class="border-bottom-0">
								                          <h6 class="fw-semibold mb-0">상세정보</h6>
								                        </th>
								                        <th class="border-bottom-0">
								                          <h6 class="fw-semibold mb-0">시간</h6>
								                        </th>
						                      		</tr>
						                    	</thead>
							                    <tbody>
							                    	<c:forEach var="lissue" items="${l_issue}">
							                      	<tr>
							                        	<td class="border-bottom-0">
							                        		<h6 class="fw-semibold mb-0">${lissue.arm_Seq}</h6>
							                        	</td>
							                        	<td class="border-bottom-0">
							                        		<h6 class="fw-semibold mb-0">${lissue.planID}</h6>
							                        	</td>
							                        	<td class="border-bottom-0">
							                            	<h6 class="fw-semibold mb-1">${lissue.issueNo}</h6>
							                        	</td>
								                        <td class="border-bottom-0">
								                        	<div class="d-flex align-items-center gap-2">
							                            	<span class="badge bg-primary rounded-3 fw-semibold">${lissue.issueName}</span>
							                          		</div>
								                        </td>
							                       		<td class="border-bottom-0">
							                          		<p class="mb-0 fw-normal">${lissue.issueInfo}</p>
							                        	</td>
							                        	<td class="border-bottom-0">
							                          		<h6 class="fw-semibold mb-0">${lissue.timestamp}</h6>
							                        	</td>
							                      	</tr>
							                      	</c:forEach>
						                      	</tbody>
					                  		</table>
					                	</div> 
				                	</div>
                                </div>
                            </div>
                        </div>
                        <!-- 재고 게시판 들어갈 자리 -->
                        <div class="card mb-4" >
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                관련된 재고 확인
                            </div>
                            <div class="card-body" >
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>자재코드</th>
                                            <th>자재명</th>
                                            <th>자재가격</th>
                                            <th>수량</th>
                                        </tr>
                                    </thead>
                                    <tbody>
	                                <c:forEach var="linven" items="${l_inven}">
                                        <tr>
                                            <td>${linven.materNo}</td>
                                            <td>${linven.materName}</td>
                                            <td>${linven.materPrice}</td>
                                            <td>${linven.materQty}</td>
                                        </tr>
    	                            </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="${path}/resources/js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="${path}/resources/js/chart-pie-demo.js"></script>
        <script src="${path}/resources/js/datatables-simple-demo.js"></script>
        <script>
        	<c:forEach var="lpr" items="${l_pr}">
           	drawPieChart([${lpr.passedQty}, ${lpr.failedQty}]);
           	</c:forEach>
        </script>
    </body>
</html>
