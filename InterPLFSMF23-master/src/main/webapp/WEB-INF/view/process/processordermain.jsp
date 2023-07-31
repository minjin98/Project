<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="spring.auth.AuthInfo, java.util.List, controller.process.*" %>
<%@ page import="spring.dao.ProcessBean" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>공정명령</title>
        <link href="${path}/resources/css/styles.css" rel="stylesheet" />
        <link href="${path}/resources/css/customstyle.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script type="text/javascript" src="https://fastly.jsdelivr.net/npm/echarts@5.4.2/dist/echarts.min.js"></script>
        <script type="text/javascript" src="${path}/resources/js/jquery-3.6.0.js"></script>
    </head>
    <%-- attr --%>
    <%-- select 태그에서 선택한 값의 value 값을 <a></a> 태그에 실어서 보내기 위함 --%>
    <%-- lineSelect는 <a> 태그의 id --%>
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
	        	/*
		        $("#lineid").change(function() {
		        	var lineid = $("#lineid").val();
		  			alert(lineid);
		  			var lineSelect = $("#lineSelect").attr("href");
		  			lineSelect += lineid;
		  			$("#lineSelect").attr("href", lineSelect);	
		  			var form = $("")
		        });
	        	
		        $("#lineSelect").click(function() { // "lineSelect"가 클릭되었을때 함수 실행
		        	var lineid = $("#lineid").val(); // "lineid의 value 값 저장"
		        	alert("컨트롤러로 값 전달");
		  			var lineSelect = $("#lineSelect").attr("href"); // ID가 "lineSelect"인 태그의 "href" 속성을 변수에 저장
		  			lineSelect += lineid; // 저장된 "href"의 속성에 lineid 값을 붙이기
		  			$("#lineSelect").attr("href", lineSelect); // ID가 "lineSelect"인 태그의 "href" 속성을 lineSelect 변수값으로 교체
		  			//alert($("#lineSelect").attr("href"));
		        });
		        */
			});
        </script>
         <script>
         $(document).ready(function() {
        	 $(".lineSelect").click(function() { // "lineSelect"가 클릭되었을때 함수 실행
		        	var lineid = $(this).prop("id"); // "lineid의 value 값 저장"
		            var sel = $("#line"+lineid).val();
		  			var lineSelect = $(this).attr("href"); // ID가 "lineSelect"인 태그의 "href" 속성을 변수에 저장
		  			lineSelect += sel; // 저장된 "href"의 속성에 lineid 값을 붙이기
		  			$(this).attr("href", lineSelect); // ID가 "lineSelect"인 태그의 "href" 속성을 lineSelect 변수값으로 교체
		        });
        	    $(".cancel").click(function(){
					var cancel = $(this).prop("id");
					alert(cancel+"번 공정을 취소하셨습니다.");
		        })
				
		        
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
                        	<h1 class="mt-4"><span>공정명령</span></h1>
                        	<h4 class="mt-4">공정의 진행 여부 확인</h4>
                        </div>
                        <div class="col-md-4">
                        	<h1 class="mt-4"></h1>
                        </div>
             	 	<div class="col-xl-6" style ="padding-left-right:35px; padding-top:30px; width:100%">
                    	<div class="card mb-4" style="height:500px">
	                        <div class="card-header">
	                        	<i class="fas fa-table me-1"></i>
	                        	데이터테이블
	                        </div>
	                        <div class="card-body">
	                        	<table id="datatablesSimple">
	                            	<thead>
		                                <tr>
		                                	<th>번호</th>
		                                	<th>생산제품</th>
		                                    <th>생산계획기간</th>
		                                    <th>담당자</th>
		                                    <th>라인선택</th>
		                                    <th>진행여부</th>
		                                </tr>
	                            	</thead>
                                    <tbody>
                                    	<c:forEach var = "order" items ="${orderlist}">
	                                    	<tr>
	                                    		<td>${order.num}</td>
	                                    		<td>${order.prodNo}</td>
	                                    		<td>${order.startDate} ~ ${order.endDate}</td>
	                                    		<td>${order.name}</td>
	                                    		<td>
	                                    			<c:if test = "${order.lineID == null}">
		                                    			<select id="lineordernum${order.num}" name="lineid"> <%--select id = lineid로 수정 --%>
														  <option selected>라인선택</option>
														  <option value="1">1번라인</option>
														  <option value="2">2번라인</option>
														  <option value="3">3번라인</option>
														</select>
													</c:if>
													
													<c:if test ="${order.lineID != null}">
													<select id="lineordernum${order.num}" disabled> <%--select id = lineid로 수정 --%>
													  <option selected>${order.lineID}번라인</option>
													</select>
													</c:if>
												</td>
	                                    		<td>
	                                    			<c:if test="${order.proCheck != 'Y'}">
		                                    			<button type="button" class="btn btn-success">
		                                    				<a id="ordernum${order.num}" class="lineSelect" href="/SMFPlatform/ORstart?prodNo=${order.prodNo}&value="; style="text-decoration-line:none; color : white">공정</a> 
		                                    			</button>
		                                    			<button type="button" class="btn btn-danger">
		                                    				<a href="/SMFPlatform/ORDelete?num=${order.num}"; style="text-decoration-line:none; color : white">삭제</a>
		                                    			</button>
	                                    			</c:if>
	                                    			<c:if test="${order.proCheck == 'Y'}">
		                                    				<a id="lineSelected"; style="text-decoration-line:none; color : black">진행중</a>
		                                    					<button type="button" class="btn btn-danger">
		                                    				<a id="${order.num}" class="cancel" href="/SMFPlatform/ORCancel?num=${order.num}"; style="text-decoration-line:none; color : white">취소</a>
		                                    			</button>
	                                    			</c:if>
	                                    		</td>
	                                    	</tr>
                                    	</c:forEach>
                                    </tbody>
                                      	<tfoot>
                                        <tr>
                                            <th>번호</th>
		                                	<th>생산제품</th>
		                                    <th>생산계획기간</th>
		                                    <th>담당자</th>
		                                    <th>라인선택</th>
		                                    <th>진행여부</th>
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
     <script src="resources/js/chart-gauge.js"></script>
     <script src="resources/js/chart-bar-leadtime.js"></script>
     <script src="resources/js/chart-bar-produce.js"></script>
     <script src="resources/js/chart-bar-produce2.js"></script>
     <script src="resources/js/chart-bar-produce3.js"></script>
     <script src="resources/js/chart-pie.js"></script>
     <script src="resources/js/chart-datatables.js"></script>
     <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
     <script src="resources/js/datatables-simple-demo.js"></script>
    
  </body>
</html>
