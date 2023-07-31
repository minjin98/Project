<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    	<link href="${path}/resources/css/jquery.dataTables.css" rel="stylesheet" type="text/css" >
        <script src="${path}/resources/js/jquery-3.6.0.js"></script>
    	<script src="${path}/resources/js/jquery.dataTables.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
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
	       			}
	    		});
			} 
	    	
	    	//password, id checker
	    	var passchecked = false;
	    	var passExpchecked = false;
	    	var emptychecked = false;
	    	var iddupchecked = false;
	    	
	    	$("#passConfirm").css('display', 'none');
	    	$("#passLength").css('display', 'none');
	    	let passExp = new RegExp('(?=.{6,})');
	    	
	    	function passExpChecker(){
	    		var password = document.getElementById("password");
	    		 if(!passExp.test(password.value)){
	    			 $("#passLength").css('display', 'inline-block');
	    			 passExpchecked = false;
	    		 }else{
	    			 $("#passLength").css('display', 'none');
	    			 passExpchecked = true;
	    		 };
	    	};
	    
	    	function passwordChecker(){
	    		var password = document.getElementById("password");
	    		var confirm_password = document.getElementById("passwordCheck");
	    		if(password.value != confirm_password.value){
	    			$("#passConfirm").css('display', 'inline-block');
	    			passchecked = false;
	    		}else{
	    			$("#passConfirm").css('display', 'none');
	    			passchecked = true;
	    		};
	    	};
			
	    	function idDupChecker(){
	    		var input = document.getElementById("id");
	    		var id = input.value;
	    		
	    		$.ajax({
	       			type:"post",  
	       			url:"http://localhost:8584/SMFPlatform/manage/duplicateidcheck.do",
	       			data:{id:id},
	       			success:function (data, textStatus) {
	       				if(JSON.parse(data)){
							document.getElementById("idCheckMessage").innerHTML = '<p style="color:red">중복된 ID 입니다</p>';
							iddupchecked = false;
						}else{
							document.getElementById("idCheckMessage").innerHTML = '<p>사용가능한 ID 입니다</p>';
							iddupchecked = true;
						}
	       			},
	       			complete:function(data,textStatus){
	       			},
	       			error:function(data, textStatus){
	          			alert("에러발생: " + data);
	       			}
	       		});
	    	};
	    	
	    	function fn_isempty(){
	    		var empno = document.getElementById("empNo");
	    		var id = document.getElementById("id");
	    		var name = document.getElementById("name");
	    		var rank = document.getElementById("rank");
	    		
	    		if (!(empno.value === "" || id.value === "" || name.value === "" || rank.value === "")) {
	    		    emptychecked = true;
	    		  };
	    	};
	    	
	    	//rank dropdown array
    		var options;
            function fetchDataAndSetDropdownOptions() {
                $.ajax({
                  type: 'POST',
                  url: 'http://localhost:8584/SMFPlatform/manage/ranklist.json',
                  dataType: 'json',
                  async: false,
                  success: function(data) {
                    options = data.map(function(item) {
                      return { label: item, value: item };
                    });
                  },
                  error: function(xhr, status, error) {
                    console.error('데이터를 가져오는 중 오류가 발생했습니다:', error);
                  }
                });
              } 

            
            //user update form template
            var template;
            function generateTemplate(){
            	fetchDataAndSetDropdownOptions(); 
            	
            	template = [
                    {
                    	name: 'empno',
                        bind: 'empno',
                        type: 'text',
                        label: '사 번',
                        labelPosition: 'left',
                        labelWidth: '30%',
                        align: 'left',
                        width: '250px',
                        required: true
                    },
                    {
                    	name: 'name',
                        bind: 'name',
                        type: 'text',
                        label: '이 름',
                        labelPosition: 'left',
                        labelWidth: '30%',
                        align: 'left',
                        width: '250px',
                        required: true
                    },
                    {
                    	name: 'id',
                        bind: 'id',
                        type: 'label',
                        label: 'ID',
                        labelPosition: 'left',
                        labelWidth: '30%',
                        align: 'left',
                        width: '250px'
                    },
                    {
                    	name: 'password',
                        bind: 'password',
                        type: 'password',
                        label: '비밀번호',
                        labelPosition: 'left',
                        labelWidth: '30%',
                        align: 'left',
                        width: '250px',
                        required: true
                    },
                    {
                    	name: 'rank',
                        bind: 'rank',
                        type: 'option',
                        label: '직 급',
                        labelPosition: 'left',
                        labelWidth: '30%',
                        align: 'left',
                        width: '250px',
                        required: true,
                        component: 'jqxDropDownList',
                        options:  options
                    },
                    {
                        columns: [
                            {
                                columnWidth: '140px',
                                name: 'admin',
                                bind: 'admin',
                                type: 'boolean',
                                label: '관리자 권한',
                                labelPosition: 'left',
                                align: 'left',
                                labelPadding: {left: 5, top: 5, right: 0, bottom: 5}
                            } 
                        ]
                    },
                    {
                        type: 'blank',
                        rowHeight: '20px',
                    },
                    {
                        name: 'submitButton',
                        type: 'button',
                        text: '사용자 수정',
                        align: 'right',
                        padding: {left: 0, top: 5, bottom: 5, right: 40}
                    },
                    {
                        name: 'deleteButton',
                        type: 'button',
                        text: '사용자 삭제',
                        align: 'right',
                        padding: {left: 0, top: 5, bottom: 5, right: 40}
                    }
                ];
            }
	    	
    		//register user ajax func
    		var usertable;
    		
    		//usertable refresh(DataTables Function)
    		function reloadList() {
				usertable.ajax.reload();
    		};
    	
    		//register function
        	function fn_register() {
        		fn_isempty();
        		if(emptychecked==false){
        			alert("입력되지 않은 값이 있습니다");
        			return;
        		}
        		
        		if(iddupchecked==false){
        			alert("ID를 확인하세요");
        			return;
        		}
        		
        		if((passExpchecked==false) || (passchecked==false)){
        			alert("비밀번호를 확인하세요");
        			return;
        		}else{
	    			var form = $("#registerForm")
		    		var regiuser = form.serialize();
	    			
		    		$.ajax({
		       			type:"post",  
		       			url:form.attr("action"),
		       			data:regiuser,
		       			success:function (data, textStatus) {
		       				alert("입력완료");
		       				reloadList();
		       				$("#registerForm")[0].reset();
		       			},
		       			complete:function(data,textStatus){
		       			},
		       			error:function(data, textStatus){
		          			alert("에러발생: " + data);
		       			},
		    		});
	    		};
        	};

        	//popup elements
        	var singupPop = (function () {
	            //Adding event listeners
	            function _addEventListeners() {
	                $('#register').click(function () {
	                    $('#regiwindow').jqxWindow('open');
	                });
	                $('#regsubmit').click(fn_register);
	            };
	
	            //Creating all page elements which are jqxWidgets
	            function _createElements() {
	                $('#register').jqxButton({ width: 120, height: 40 });
	                $('#regsubmit').jqxButton({ width: '65px' });
	            };
	
	            //Creating the window
	            function _createWindow() {
	                var jqxWidget = $('#jqxWidget');
	                var content = $('#userlist');
	                var offset = content.offset();
	
	                $('#regiwindow').jqxWindow({
						autoOpen: false,
	                    position: { x: offset.left+250, y: offset.top } ,
	                    showCollapseButton: true, 
	                    height: 560, width: 500,
	                    initContent: function () {
	                        $('#regiwindow').jqxWindow('focus');
	                    }
	                });
	                $('#regiwindow').jqxWindow('resizable', false);
	                $('#regiwindow').jqxWindow('draggable', true);
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
        	
        	function fn_update(){
        		
        	}
        	
        	var updatePop = (function () {
	            //Adding event listeners
	            function _addEventListeners() {
	                //$('#updatesubmit').click(fn_update);
	            };
	
	            //Creating all page elements which are jqxWidgets
	            function _createElements() {
	                //$('#updatesubmit').jqxButton({ width: '65px' });
	            };
	
	            //Creating the window
	            function _createWindow() {
	                var jqxWidget = $('#jqxWidget');
	                var content = $('#userlist');
	                var offset = content.offset();
	
	                $('#updatewindow').jqxWindow({
						autoOpen: false,
	                    position: { x: offset.left+250, y: offset.top } ,
	                    showCollapseButton: true, 
	                    height: 380, width: 430,
	                    initContent: function () {
	                        $('#updatewindow').jqxWindow('focus');
	                    }
	                });
	                $('#updatewindow').jqxWindow('resizable', false);
	                $('#updatewindow').jqxWindow('draggable', true);
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
        	
            //init userData with id
            var userData;
            function getUserData(userid){
            	 $.ajax({
                     type: 'POST',
                     url: 'http://localhost:8584/SMFPlatform/manage/userdata.json',
                     data:{id : userid},
                     dataType: 'json',
                     async: false,
                     success: function(data) {
						userData = data;
						console.log(userData);
                     },
                     error: function(xhr, status, error) {
                       console.error('데이터를 가져오는 중 오류가 발생했습니다:', error);
                     }
                   });
            }
            
            function delUser(){
            	var targetid= $("#userUpdateForm").jqxForm('getComponentByName' , "id");
            	console.log(targetid[0].innerHTML);
				
            	$.ajax({
                     type: 'POST',
                     url: 'http://localhost:8584/SMFPlatform/manage/deleteuser.do',
                     data: {id:targetid[0].innerHTML},
                     async: false,
                     success: function(data) {
                     	alert("삭제완료");
                     	reloadList();
                     },
                     error: function(xhr, status, error) {
                       console.error('데이터를 가져오는 중 오류가 발생했습니다:', error);
                     }
                   }); 
            
            }
            
            function updateUser(){
            	var targetempno= $("#userUpdateForm").jqxForm('getComponentByName' , "empno");
            	var targetname= $("#userUpdateForm").jqxForm('getComponentByName' , "name");
            	var targetid= $("#userUpdateForm").jqxForm('getComponentByName' , "id");
            	var targetpass= $("#userUpdateForm").jqxForm('getComponentByName' , "password");
            	var targetrank= $("#userUpdateForm").jqxForm('getComponentByName' , "rank");
            	var targetadmin= $("#userUpdateForm").jqxForm('getComponentByName' , "admin");
            	
            	console.log(targetempno[0].value);
            	console.log(targetname[0].value);
            	console.log(targetid[0].innerHTML);
            	console.log(targetpass[0].value);
            	console.log(targetrank[0].textContent);
            	console.log(targetadmin[0].ariaChecked);
            	
            	var dataset = {
            			empno : targetempno[0].value,
            			name : targetname[0].value ,
            			id : targetid[0].innerHTML ,
            			password : targetpass[0].value ,
            			rank : targetrank[0].textContent ,
            			admin : targetadmin[0].ariaChecked
            	}
            	
            	$.ajax({
                    type: 'POST',
                    url: 'http://localhost:8584/SMFPlatform/manage/updateuser.do',
                    data: dataset,
                    async: false,
                    success: function(data) {
                    	alert("변경완료");
                    	reloadList();
                    },
                    error: function(xhr, status, error) {
                      console.error('데이터를 가져오는 중 오류가 발생했습니다:', error);
                    }
                  }); 
            	
            }
            
        	function initUserForm(userid){
        			getUserData(userid);
        		
        			var userUpdateForm = $('#userUpdateForm');
	        		userUpdateForm.jqxForm({
		                template: template,
		                value: userData,
		                padding: { left: 10, top: 10, right: 0, bottom: 10 }
	            	});
		            var subbtn = userUpdateForm.jqxForm('getComponentByName', 'submitButton');
		            subbtn.on('click', function () {
		            	updateUser();
		            });	
		            var delbtn = userUpdateForm.jqxForm('getComponentByName', 'deleteButton');
		            delbtn.jqxButton({ template: "danger" });
		            delbtn.on('click', function () {
		            	delUser();
		            });	

        	}
        	
        	//page ready js script
	    	$(document).ready(function () {
	        	singupPop.init(); //signup popupwindow init
	        	updatePop.init(); //update popupwindow init 
	    		usertable = new DataTable('#userlist', { //init datatable
	    		    ajax: 'http://localhost:8584/SMFPlatform/manage/userlist.json'
	    		});
	        	usertable.on('click', 'tbody tr', function () {	//datatable click func
			        let data = usertable.row(this).data();
			        if(userUpdateForm){
			        	$('#userUpdateForm').jqxForm('destroy');
			        	document.getElementById("userjqForm").innerHTML = "<div id='userUpdateForm' style='width: 420px; height: auto;'></div>";
			        }
			        generateTemplate();
			        initUserForm(data[2]);
			        $('#updatewindow').jqxWindow('open');
		        });
	        	$("#passConfirm").css('display', 'none'); 
	        	
	        	if(${sessionScope.authInfo.getAdmin()}){
	        		checkNoti();
	        	} //notification check
	        	userUpdateForm = $('#userUpdateForm');
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
                        <h1 class="mt-4">사용자 관리</h1>
                        <ol class="breadcrumb mb-4">
                        	<li class="breadcrumb-item active"><a href="${path}/manage">Manage</a></li>
                            <li class="breadcrumb-item active">사용자 관리</li>
                        </ol>
	    				<div class="card mb-4">
	                    	<div class="card-header">
	                        	<i class="fas fa-table me-1"></i>
	                            사용자 목록
	                        </div>
	                    	<div class="card-body">
			    				<table id="userlist" class="display" style="width:100%">
							        <thead>
							            <tr>
							                <th>사번</th>
							                <th>이름</th>
							                <th>ID</th>
							                <th>rank</th>
							                <th>등록일</th>
							                <th>관리자 권한</th>
							            </tr>
							        </thead>
							        <tfoot>
							            <tr>
							                <th>사번</th>
							                <th>이름</th>
							                <th>ID</th>
							                <th>rank</th>
							                <th>등록일</th>
							                <th>관리자 권한</th>
							            </tr>
							        </tfoot>
							    </table>
							    <div id="jqxWidget">
								    <div>
	       								<input type="button" value="사용자 신규등록" id='register' />	
	       							</div>
							  		<div id="regiwindow">
					                	<div id="windowHeader">
					                    	<span>
					                        	사용자 신규등록
					                    	</span>
					                	</div>
						                <div style="overflow: hidden;" id="windowContent">
	                                        <form:form id="registerForm" modelAttribute="manageUserCommand" action="${path}/manage/usermanagement/register.do" method="post">
	                                            <div class="form-floating mb-3">
	                                                <form:input class="form-control" placeholder="EmpNo" path="empNo" autocomplete="off" />
	                                                <label for="empNo">사번</label>
	                                            </div>
	                                            <div class="form-floating mb-3">
	                                                <form:input class="form-control" placeholder="Name" path="name" autocomplete="off" />
	                                                <label for="name">이름</label>
	                                            </div>
	                                            <div class="form-floating mb-3">
	                                                <form:input class="form-control" placeholder="ID" path="id" id="id" autocomplete="off" onkeyup="idDupChecker()"/>
	                                                <label for="id">ID</label>
	                                                <span id="idCheckMessage"></span>
	                                            </div>
	                                            <div class="form-floating mb-3">
	                                                <form:password class="form-control" placeholder="Password" path="password" id="password" onkeyup="passExpChecker()"/>
	                                                <label for="password">비밀번호</label>
	                                            </div>
	                                            <div class="form-floating mb-3">
	                                                <form:password class="form-control" placeholder="PasswordCheck" path="passwordCheck" id="passwordCheck" onkeyup="passwordChecker()"/>
	                                                <label for="passwordCheck">비밀번호 확인</label>
										     		<span id="passConfirm" display="none">비밀번호가 일치하지 않습니다.</span>
										     		<span id="passLength" display="none">비밀번호는 6자리 이상이어야 합니다.</span>
	                                            </div>
	                                            <div class="form-floating mb-3">
	                                                <form:input class="form-control" placeholder="Rank" path="rank" />
	                                                <label for="rank">직급</label>
	                                            </div>
                                        	</form:form>
  											<input type="button" value="입력" id="regsubmit"/>
						                </div>
							    	</div>
							    	
							    	<div id="updatewindow">
					                	<div id="windowHeader">
					                    	<span>
					                        	사용자 수정
					                    	</span>
					                	</div>
					                	<div id='userjqForm'>
						                	<div id='userUpdateForm' style="width: 420px; height: auto;"></div>
						                </div>
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
