<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="spring.auth.AuthInfo" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>TEST</title>
        <link href="${path}/resources/css/styles.css" rel="stylesheet" />
        <link href="${path}/resources/css/customstyle.css" rel="stylesheet" />
        <link href="${path}/resources/css/bootstrap.css" rel="stylesheet" />
		<link href="${path}/resources/css/style.css" rel="stylesheet" />
		<script src="${path}/resources/js/jquery-3.6.0.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <link rel="shortcut icon" href="favicon.ico">
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
                        <h1 class="mt-4" "text-center">제품 선택</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active"></li>
                        </ol>
                    </div>
	            	<div class="container-fluid px-4">
	            		<div class="row text-center">
	            			<div class="col-lg-4">
	                           <div class="card mb-4">
	                                <div class="card-header">
	                                    <i class="fa-solid fa-keyboard me-1"></i>
	                                    KBD001
	                                </div>
	                                <div class="card-body">
	                                	<p>청축 키보드</p>
										<strong>사용하는 라인</strong>
										<p>KBB01</p>
										<p>KBB02</p>
	                                </div>
	                                <div class="card-footer small text-muted">
	                                	<form action = "${path}/preport/product.do" method = "post">
				                    		<span>계획코드</span>
				                    		<select name="planID">
						                    	<c:forEach var="pnames" items="${p_names}">
						                    		<c:if test="${pnames.prodNo == 'KBD001'}">
						                        		<option value="${pnames.planID}">${pnames.planID}</option>
						                        	</c:if>
						                        </c:forEach>
					                        </select>
					                        <input type="hidden" name="prodNo" value="KBD001">
					                        <input type="submit" value="이동">
				                        </form>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="col-lg-4">
	                           <div class="card mb-4">
	                                <div class="card-header">
	                                    <i class="fa-solid fa-keyboard me-1"></i>
	                                    KBD002
	                                </div>
	                                <div class="card-body">
	                                	<p>갈축 키보드</p>
										<strong>사용하는 라인</strong>
										<p>KBB01</p>
										<p>KBB02</p>
	                                </div>
	                                <div class="card-footer small text-muted">
	                                	<form action = "${path}/preport/product.do" method = "post">
				                    		<span>계획코드</span>
				                    		<select name="planID">
						                    	<c:forEach var="pnames" items="${p_names}">
						                    		<c:if test="${pnames.prodNo == 'KBD002'}">
						                        		<option value="${pnames.planID}">${pnames.planID}</option>
						                        	</c:if>
						                        </c:forEach>
					                        </select>
					                        <input type="hidden" name="prodNo" value="KBD002">
					                        <input type="submit" value="이동">
				                        </form>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="col-lg-4">
	                           <div class="card mb-4">
	                                <div class="card-header">
	                                    <i class="fa-solid fa-keyboard me-1"></i>
	                                     KBD003
	                                </div>
	                                <div class="card-body">
	                                	<p>적축, 흑축 키보드</p>
										<strong>사용하는 라인</strong>
										<p>KBB01</p>
										<p>KBB02</p>
	                                </div>
	                                <div class="card-footer small text-muted">
	                                	<form action = "${path}/preport/product.do" method = "post">
				                    		<span>계획코드</span>
				                    		<select name="planID">
						                    	<c:forEach var="pnames" items="${p_names}">
						                    		<c:if test="${pnames.prodNo == 'KBD003'}">
						                        		<option value="${pnames.planID}">${pnames.planID}</option>
						                        	</c:if>
						                        </c:forEach>
					                        </select>
					                        <input type="hidden" name="prodNo" value="KBD003">
					                        <input type="submit" value="이동">
				                        </form>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="col-lg-4">
	                           <div class="card mb-4">
	                                <div class="card-header">
	                                    <i class="fa-regular fa-keyboard me-1"></i>
	                                    KC001
	                                </div>
	                                <div class="card-body">
	                                	<p>염료승화 키캡</p>
										<strong>사용하는 라인</strong>
										<p>KCS01</p>
										<p>KCS02</p>
	                                </div>
	                                <div class="card-footer small text-muted">
	                                	<form action = "${path}/preport/product.do" method = "post">
				                    		<span>계획코드</span>
				                    		<select name="planID">
						                    	<c:forEach var="pnames" items="${p_names}">
						                    		<c:if test="${pnames.prodNo == 'KC001'}">
						                        		<option value="${pnames.planID}">${pnames.planID}</option>
						                        	</c:if>
						                        </c:forEach>
					                        </select>
					                        <input type="hidden" name="prodNo" value="KC001">
					                        <input type="submit" value="이동">
				                        </form>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="col-lg-4">
	                           <div class="card mb-4">
	                                <div class="card-header">
	                                    <i class="fa-regular fa-keyboard me-1"></i>
	                                    KC002
	                                </div>
	                                <div class="card-body">
	                                	<p>이중사출 키캡</p>
										<strong>사용하는 라인</strong>
										<p>KCS01</p>
										<p>KCS02</p>
	                                </div>
	                                <div class="card-footer small text-muted">
	                                	<form action = "${path}/preport/product.do" method = "post">
				                    		<span>계획코드</span>
				                    		<select name="planID">
						                    	<c:forEach var="pnames" items="${p_names}">
						                    		<c:if test="${pnames.prodNo == 'KC002'}">
						                        		<option value="${pnames.planID}">${pnames.planID}</option>
						                        	</c:if>
						                        </c:forEach>
					                        </select>
					                        <input type="hidden" name="prodNo" value="KC002">
					                        <input type="submit" value="이동">
				                        </form>
	                                </div>
	                            </div>
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
        
        <div>
        <form>
	<p>계획번호 선택</p>
	<select name = "planID">
	<c:forEach var="lnames" items="${l_names}">
		<option value="${lnames.planID}">${lnames.planID}</option>
	</c:forEach>
	</select>
</form>
        </div>
    </body>
</html>
