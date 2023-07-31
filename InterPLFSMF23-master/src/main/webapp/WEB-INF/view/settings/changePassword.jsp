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
        <title>Manage</title>
        <link href="${path}/resources/css/styles.css" rel="stylesheet" />
        <link href="${path}/resources/css/customstyle.css" rel="stylesheet" />
    	<link href="${path}/resources/css/jquery.dataTables.css" rel="stylesheet" />
        <script src="${path}/resources/js/jquery-3.6.0.js"></script>
    	<script src="${path}/resources/js/jquery.dataTables.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- script for jq link -->
        <script type="text/javascript" src="${path}/resources/jqwidgets/jqxcore.js"></script>
    	<script type="text/javascript" src="${path}/resources/jqwidgets/jqxbuttons.js"></script>
    	<link rel="stylesheet" href="${path}/resources/jqwidgets/styles/jqx.base.css" type="text/css" />
        <script>
        	var passchecked = false;
        	var passExpchecked = false;
        	
			let passExp = new RegExp('(?=.{6,})');
	    	
	    	function passExpChecker(){
	    		var password = document.getElementById("newPassword");
	    		 if(!passExp.test(password.value)){
	    			 $("#passLength").css('display', 'inline-block');
	    			 passExpchecked = false;
	    		 }else{
	    			 $("#passLength").css('display', 'none');
	    			 passExpchecked = true;
	    		 };
	    	};
        	
        	function passwordChecker(){
	    		var password = document.getElementById("newPassword");
	    		var confirm_password = document.getElementById("passwordConfirm");
	    		if(password.value != confirm_password.value){
	    			$("#passConfirm").css('display', 'inline-block');
	    			passchecked = false;
	    		}else{
	    			$("#passConfirm").css('display', 'none');
	    			passchecked = true;
	    		};
	    	};
        
        	function changepassword(){
        		var input = document.getElementById("recentPassword");
	    		var pass = input.value;
	    		
	    		$.ajax({
	       			type:"post", 
	       			async:false,
	       			url:"http://localhost:8584/SMFPlatform/settings/passcheck.do",
	       			data:{password:pass},
	       			success:function (data, textStatus) {
	       				if(!JSON.parse(data)){
							alert("현재 비밀번호가 일치하지 않습니다");
							return;
	       				}else{
	       					(function change(){
	       		        		if((passExpchecked==false) || (passchecked==false)){
	       		        			alert("잘못된 신규 비밀번호 입니다");
	       		        			return;
	       		        		}
	       		        		
	       		        		var password = document.getElementById("newPassword").value;
	       		        		
	       		        		$.ajax({
	       			       			type:"post", 
	       			       			async:false,
	       			       			url:"http://localhost:8584/SMFPlatform/settings/changepassword.do",
	       			       			data:{password:password},
	       			       			success:function (data, textStatus) {
	       			       				alert("변경 완료했습니다!");
	       			       				document.location.href = document.location.href;
	       			       			},
	       			       			error:function(data, textStatus){
	       			          			alert("변경처리 에러");
	       			       			}
	       			       		});
	       		        	})();
	       				};
	       			},
	       			error:function(data, textStatus){
	          			alert("아이디 검증 에러");
	       			}
	       		});
        	}	
        	
			function checkNoti(){
				$.ajax({
	       			type:"post",  
	       			url:"http://localhost:8584/SMFPlatform/manage/noticheck.do",
	       			success:function (data, textStatus) {
	       				if(data=="<anonymous>"){
	       					return;
	       				}else if(JSON.parse(data)){
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
	        	$('#submit').jqxButton({theme: "arctic"});
	        	$('#submit').on('click', changepassword);
	        	
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
            <a class="navbar-brand ps-3" href="${path}">Platform Name</a>
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
                        <h1 class="mt-4">등록정보 수정</h1>
                        <ol class="breadcrumb mb-4">
                        	<li class="breadcrumb-item"><a href="${path}/settings">Settings</a></li>
                            <li class="breadcrumb-item active">등록정보 수정</li>
                        </ol>
                        <div class="row justify-content-center">
	                        <div class="col-xl-6">
			    				<div class="card mb-4">
		                            <div class="card-header">
		                                <i class="fa fa-cogs"></i>
		                                등록정보 수정
		                            </div>
		                            <div class="card-body">
		                            	<form id="passwordchange" method='POST'>
				                            <div class="form-floating mb-3">
					                            <input class="form-control" id="recentPassword" type="password" placeholder="현재 비밀번호" />
					                            <label for="inputEmail">현재 비밀번호</label>
				                            </div>
				                            <div class="form-floating mb-3">
					                            <input class="form-control" id="newPassword" type="password" placeholder="새로운 비밀번호" onkeyup="passExpChecker()"/>
					                            <label for="inputPassword">새로운 비밀번호</label>
				                            </div>
				                            <div class="form-floating mb-3">
					                            <input class="form-control" id="passwordConfirm" type="password" placeholder="비밀번호 확인" onkeyup="passwordChecker()"/>
					                            <label for="inputPassword">비밀번호 확인</label>
					                            <span id="passConfirm" display="none">비밀번호가 일치하지 않습니다.</span>
										     	<span id="passLength" display="none">비밀번호는 6자리 이상이어야 합니다.</span>
				                            </div>
		                            	</form>
				                        <button id="submit">비밀번호 변경</button> 
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
    </body>
</html>
