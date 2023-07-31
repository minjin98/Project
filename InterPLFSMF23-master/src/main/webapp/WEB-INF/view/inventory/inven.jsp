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
        <title>재고관리</title>
        <link href="${path}/resources/css/styles.css" rel="stylesheet" />
        <link href="${path}/resources/css/customstyle.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.min.css" rel="stylesheet" />
		<link href="https://cdn.datatables.net/select/1.7.0/css/select.dataTables.min.css" rel="stylesheet" />
		<link href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.dataTables.min.css" rel="stylesheet" />
		<link href="${path}/resources/css/jquery.dataTables.css" rel="stylesheet" type="text/css" >
        <script src="${path}/resources/js/jquery-3.6.0.js"></script>
        <script src="${path}/resources/js/jquery.dataTables.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/select/1.7.0/js/dataTables.select.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js" crossorigin="anonymous"></script>
 		 <!-- script for jq link -->
        <script type="text/javascript" src="${path}/resources/jqwidgets/jqxcore.js"></script>
    	<script type="text/javascript" src="${path}/resources/jqwidgets/jqxbuttons.js"></script>
    	<script type="text/javascript" src="${path}/resources/jqwidgets/jqxwindow.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxscrollbar.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxpanel.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxtabs.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxcheckbox.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxinput.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxlistbox.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxdropdownlist.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxradiobutton.js"></script>
    	<script type="text/javascript" src="${path}/resources/jqwidgets/jqxpasswordinput.js"></script>
    	<script type="text/javascript" src="${path}/resources/jqwidgets/jqxnumberinput.js"></script>
    	<script type="text/javascript" src="${path}/resources/jqwidgets/jqxform.js"></script>
	    <link rel="stylesheet" href="${path}/resources/jqwidgets/styles/jqx.base.css" type="text/css" />
	    <!-- custom js for inventory insert form -->
    	<script type="text/javascript" src="${path}/resources/js/invenform.js"></script>
 		<script>
 		//notification checker
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
 		
	        //lot table id init
	        var inventorylist
	        var popinventorylist
    		var manageprodlist;
	        
	        // lot table reload
	        function reloadinvenList() {
				inventorylist.ajax.reload();
				popinventorylist.ajax.reload();
    		};
    		
    		//lotprod table id init
    		var productlist
    		var lotdata = {lot : "KB0016"}; 
    		function reloadprodList() {
				productlist.ajax.reload();
				manageprodlist.ajax.reload();
    		};
    		
    		//popup elements
    			//재고 입력 팝업
        	var lotinsertPop = (function () {
	            //Adding event listeners
	            function _addEventListeners() {
	                $('#inveninsertbt').click(function () {
	                    $('#lotinsertwindow').jqxWindow('open');
	                });
	            };
	
	            //Creating all page elements which are jqxWidgets
	            function _createElements() {
	            	$('#inveninsertbt').jqxButton({ width: 80, height: 28 });
	            };
	
	            //Creating the window
	            function _createWindow() {
	                var jqxWidget = $('#mainArea');
	                var content = $('#inventorylist');
	                var offset = content.offset();
	
	                $('#lotinsertwindow').jqxWindow({
						autoOpen: false,
	                    position: { x: offset.left+250, y: offset.top } ,
	                    showCollapseButton: false, 
	                    height: 300, width: 500,
	                    initContent: function () {
	                        $('#lotinsertwindow').jqxWindow('focus');
	                    }
	                });
	                $('#lotinsertwindow').jqxWindow('resizable', false);
	                $('#lotinsertwindow').jqxWindow('draggable', true);
	            };
	
	            return {
	                config: {
	                    dragArea: null
	                },
	                init: function () {
	                    //Creating all jqxWindgets except the window
	                    _createElements();
	                    //Attaching event listeners
	                    _addEventListeners();
	                    //Adding jqxWindow
	                    _createWindow();
	                }
	            };
	        } ());
    		
    			//재고 수정 팝업
        	var lotmanagePop = (function () {
	            //Adding event listeners
	            function _addEventListeners() {
	                $('#invenmanagebt').click(function () {
	                    $('#lotmanagewindow').jqxWindow('open');
	                });
	            };
	
	            //Creating all page elements which are jqxWidgets
	            function _createElements() {
	            	$('#invenmanagebt').jqxButton({ width: 80, height: 28 });
	            };
	
	            //Creating the window
	            function _createWindow() {
	                var jqxWidget = $('#mainArea');
	                var content = $('#inventorylist');
	                var offset = content.offset();
	
	                $('#lotmanagewindow').jqxWindow({
						autoOpen: false,
	                    position: { x: offset.left+250, y: offset.top } ,
	                    showCollapseButton: false, 
	                    height: 610, width: 500,
	                    initContent: function () {
	                        $('#lotmanagewindow').jqxWindow('focus');
	                    }
	                });
	                $('#lotmanagewindow').jqxWindow('resizable', false);
	                $('#lotmanagewindow').jqxWindow('draggable', true);
	            };
	
	            return {
	                config: {
	                    dragArea: null
	                },
	                init: function () {
	                    //Creating all jqxWindgets except the window
	                    _createElements();
	                    //Attaching event listeners
	                    _addEventListeners();
	                    //Adding jqxWindow
	                    _createWindow();
	                }
	            };
	        } ());
        	
    			//상품 입력 팝업
        	var prodinsertPop = (function () {
	            //Adding event listeners
	            function _addEventListeners() {
	                $('#prodinsertbt').click(function () {
	                    $('#prodinsertwindow').jqxWindow('open');
	                });
	            };
	
	            //Creating all page elements which are jqxWidgets
	            function _createElements() {
		        	$('#prodinsertbt').jqxButton({ width: 100, height: 28 });
	            };
	
	            //Creating the window
	            function _createWindow() {
	                var jqxWidget = $('#mainArea');
	                var content = $('#inventorylist');
	                var offset = content.offset();
	
	                $('#prodinsertwindow').jqxWindow({
						autoOpen: false,
	                    position: { x: offset.left+250, y: offset.top } ,
	                    showCollapseButton: false, 
	                    height: 590, width: 500,
	                    initContent: function () {
	                    	$('#tab').jqxTabs({ height: '100%', width:  '100%' });
	                        $('#prodinsertwindow').jqxWindow('focus');
	                    }
	                });
	                $('#prodinsertwindow').jqxWindow('resizable', false);
	                $('#prodinsertwindow').jqxWindow('draggable', true);
	            };
	
	            return {
	                config: {
	                    dragArea: null
	                },
	                init: function () {
	                    //Creating all jqxWindgets except the window
	                    _createElements();
	                    //Attaching event listeners
	                    _addEventListeners();
	                    //Adding jqxWindow
	                    _createWindow();
	                }
	            };
	        } ());
        	
    			//재고 관리 팝업
        	var prodmanagePop = (function () {
	            //Adding event listeners
	            function _addEventListeners() {
	                $('#prodmanagebt').click(function () {
	                    $('#prodmanagewindow').jqxWindow('open');
	                });
	            };
	
	            //Creating all page elements which are jqxWidgets
	            function _createElements() {
		        	$('#prodmanagebt').jqxButton({ width: 80, height: 28 });
	            };
	
	            //Creating the window
	            function _createWindow() {
	                var jqxWidget = $('#mainArea');
	                var content = $('#productlist');
	                var offset = content.offset();
	
	                $('#prodmanagewindow').jqxWindow({
						autoOpen: false,
	                    position: { x: offset.left+250, y: offset.top } ,
	                    showCollapseButton: false, 
	                    height: 560, width: 500,
	                    initContent: function () {
	                        $('#prodmanagewindow').jqxWindow('focus');
	                    }
	                });
	                $('#prodmanagewindow').jqxWindow('resizable', false);
	                $('#prodmanagewindow').jqxWindow('draggable', true);
	            };
	
	            return {
	                config: {
	                    dragArea: null
	                },
	                init: function () {
	                    //Creating all jqxWindgets except the window
	                    _createElements();
	                    //Attaching event listeners
	                    _addEventListeners();
	                    //Adding jqxWindow
	                    _createWindow();
	                }
	            };
	        } ());
    		
    		var warehouselist;	
    		var productdblist;
    		var materiallist;
    			
	        $(document).ready(function () {
	        	lotinsertPop.init();
				lotmanagePop.init();
				prodinsertPop.init();
				prodmanagePop.init();
	        	
				initLotForm();
				initLotUpForm();
				initWhForm();
				initMaterForm();
				initProdForm();
				
	        	inventorylist = new DataTable('#inventorylist', { //init datatable
	        		scrollCollapse: true,
	        	    scrollY: '210px',
	        	    pageLength: 25,
	    		    ajax: 'http://localhost:8584/SMFPlatform/inventory/lotlist.json'
	    		});
	        	inventorylist.on('click', 'tbody tr', function () {	//datatable click func
			        let data = inventorylist.row(this).data();
			     	lotdata.lot = data[0];
			     	console.log(lotdata);
			     	reloadprodList();
		        });
	        	
	        	productlist = new DataTable('#productlist', { //init datatable
	        		scrollCollapse: true,
	        	    scrollY: '400px',
	        	    paging: false,
	        	    ajax: {
	        	    	type: "POST",
	        	    	data: function() {
	        	    		return lotdata;
	        	    	},
	        	    	url: 'http://localhost:8584/SMFPlatform/inventory/prodlotlist.json'
	        	    }
	    		});
	        	
	        	popinventorylist = new DataTable('#popinventorylist', { //init datatable
	        		scrollCollapse: true,
	        		paging: false,
	        		info: false,
	        	    scrollY: '210px',
	    		    ajax: 'http://localhost:8584/SMFPlatform/inventory/lotlist.json'
	    		});
	        	popinventorylist.on('click', 'tbody tr', function () {
	        		let data = popinventorylist.row(this).data();
	        		lotfiller(data[0]);
	        	});
	        	warehouselist = new DataTable('#warehouselist', { //init datatable
	        		scrollCollapse: true,
	        		paging: false,
	        		info: false,
	        	    scrollY: '135px',
	    		    ajax: 'http://localhost:8584/SMFPlatform/inventory/warehouselist.json'
	    		});
	        	warehouselist.on('click', 'tbody tr', function () {
	        		let data = warehouselist.row(this).data();
	        		window.navigator.clipboard.writeText(data[0]).then(() => {
			        		alert("창고 코드 " + data[0] + " 복사완료");
	        			});
	        	});
	        	productdblist = new DataTable('#productdblist', { //init datatable
	        		scrollCollapse: true,
	        		paging: false,
	        		info: false,
	        	    scrollY: '135px',
	    		    ajax: 'http://localhost:8584/SMFPlatform/inventory/productnolist.json'
	    		});
	        	productdblist.on('click', 'tbody tr', function () {
	        		let data = productdblist.row(this).data();
	        		window.navigator.clipboard.writeText(data[0]).then(() => {
		        		alert("상품 코드 " + data[0] + " 복사완료");
        			});
	        	});
	        	materiallist = new DataTable('#materiallist', { //init datatable
	        		scrollCollapse: true,
	        		paging: false,
	        		info: false,
	        	    scrollY: '135px',
	    		    ajax: 'http://localhost:8584/SMFPlatform/inventory/materialnolist.json'
	    		});
	        	materiallist.on('click', 'tbody tr', function () {
	        		let data = materiallist.row(this).data();
	        		window.navigator.clipboard.writeText(data[0]).then(() => {
		        		alert("자재 코드 " + data[0] + " 복사완료");
        			});
	        	});
	        	manageprodlist = new DataTable('#manageprodtable', { //init datatable
	        		scrollCollapse: true,
	        		paging: false,
	        	    scrollY: '250px',
	    		    ajax: {
	        	    	type: "POST",
	        	    	data: function() {
	        	    		return lotdata;
	        	    	},
	        	    	url: 'http://localhost:8584/SMFPlatform/inventory/prodlotlist.json'
	        	    },
	        	    buttons: [
	        	        {
	        	            text: 'Select all',
	        	            action: function () {
	        	            	manageprodlist.rows().select();
	        	            }
	        	        },
	        	        {
	        	            text: 'Select none',
	        	            action: function () {
	        	            	manageprodlist.rows().deselect();
	        	            }
	        	        }
	        	    ],
	        	    dom: 'Bfrtip',
	        	    select: true
	    		});
	        	checkNoti();
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
                        <h1 class="mt-4">재고관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">재고관리</li>
                        </ol>
                        <div id="mainArea">
	                        <div class="card mb-4">
		                    	<div class="card-header">
		                        	<i class="fas fa-table me-1"></i>
		                            재고 목록
		                        </div>
		                    	<div class="card-body">
		                    		<table id="inventorylist" class="display" style="width:100%">
		                    			<thead>
								            <tr>
								                <th>LOT</th>
								                <th>상품 이름</th>
								                <th>재료 이름</th>
								                <th>수량</th>
								                <th>보관 위치</th>
								            </tr>
								        </thead>
								        <tfoot>
								            <tr>
								                <th>LOT</th>
								                <th>상품 이름</th>
								                <th>재료 이름</th>
								                <th>수량</th>
								                <th>보관 위치</th>
								            </tr>
								        </tfoot>
		                    		</table>
		                    		<div>
			                    		<button id="inveninsertbt">재고입력</button>
			                    		<button id="invenmanagebt">재고수정</button>
			                    		<button id="prodinsertbt">항목상세입력</button>
		                    		</div>
		                    	</div>
		                    </div>
		                     <div class="card mb-4">
		                    	<div class="card-header">
		                        	<i class="fas fa-table me-1"></i>
		                            재고 상세
		                        </div>
		                    	<div class="card-body">
		                    		<table id="productlist" class="display" style="width:100%">
		                    			<thead>
								            <tr>
								                <th>LOT</th>
								                <th>상품 이름</th>
								                <th>SerialNo</th>
								                <th>PricessID</th>
								                <th>QC</th>
								            </tr>
								        </thead>
		                    		</table>
		                    		<div>
		                    			<button id="prodmanagebt">재고관리</button>
		                    		</div>
		                    	</div>
		                    </div>
		                    <div id="lotinsertwindow">
		                    	<div id="windowHeader">
						            <span>
						            	<i class="fa fa-pencil-square" aria-hidden="true"></i> 재고입력
						            </span>
								</div>
								<div style="overflow: hidden;" id="windowContent">
									<div id='lotinsertform' style="width: auto; height: auto;"></div>
								</div>
		                    </div>
		                    <div id="lotmanagewindow">
		                    	<div id="windowHeader">
						            <span>
						            	<i class="fa fa-pencil-square" aria-hidden="true"></i> 재고수정
						            </span>
								</div>
								<div style="overflow: hidden;" id="windowContent">
									<table id="popinventorylist" class="display" style="width:100%">
		                    			<thead>
								            <tr>
								                <th>LOT</t25h>
								                <th>상품 이름</th>
								                <th>재료 이름</th>
								                <th>수량</th>
								                <th>보관 위치</th>
								            </tr>
								        </thead>
		                    		</table>
		                    		<hr>
		                    		<div id='lotupdateform' style="width: auto; height: auto;"></div>
								</div>
		                    </div>
		                    <div id="prodinsertwindow">
		                    	<div id="windowHeader">
						            <span>
						            	<i class="fa fa-pencil-square" aria-hidden="true"></i> 상품등록
						            </span>
								</div>
								<div style="overflow: hidden;" id="windowContent">
									<div id="tab">
                        				<ul style="margin-left: 20px;">
                            				<li>상품 분류</li>
                            				<li>자재 분류</li>
                            				<li>창고 분류</li>
                            			</ul>
                            			<div>
                            				<table id="productdblist" class="display" style="width:100%">
				                    			<thead>
										            <tr>
										                <th>상품 코드</th>
										                <th>상품 이름</th>
										            </tr>
										        </thead>
		                    				</table>
		                    				<span style="color:red">**열을 눌러 코드 복사</span>
		                    				<hr>
                            				<div id='prodinsertform' style="width: auto; height: auto;"></div>
                            			</div>
                            			<div>
                            				<table id="materiallist" class="display" style="width:100%">
				                    			<thead>
										            <tr>
										                <th>자재 코드</th>
										                <th>자재 이름</th>
										            </tr>
										        </thead>
		                    				</table>
		                    				<span style="color:red">**열을 눌러 코드 복사</span>
		                    				<hr>
                            				<div id='materinsertform' style="width: auto; height: auto;"></div>
                            			</div>
                            			<div>
                            				<table id="warehouselist" class="display" style="width:100%">
				                    			<thead>
										            <tr>
										                <th>창고 코드</th>
										                <th>창고 이름</th>
										                <th>위치</th>
										            </tr>
										        </thead>
		                    				</table>
		                    				<span style="color:red">**열을 눌러 코드 복사</span>
		                    				<hr>
		                    				<div id='warehsinsertform' style="width: auto; height: auto;"></div>
                            			</div>
									</div>
								</div>
		                    </div>
		                    <div id="prodmanagewindow">
		                    	<div id="windowHeader">
						            <span>
						            	<i class="fa fa-pencil-square" aria-hidden="true"></i> 재고관리
						            </span>
								</div>
								<div style="overflow: hidden;" id="windowContent">
									<table id="manageprodtable" class="display" style="width:100%">
		                    			<thead>
								            <tr>
								                <th>LOT</th>
								                <th>상품 이름</th>
								                <th>SerialNo</th>
								                <th>PricessID</th>
								                <th>QC</th>
								            </tr>
								        </thead>
                    				</table>
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
