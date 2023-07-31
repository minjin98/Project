<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
	<%
		//session checker
		if(session.getAttribute("authInfo") != null){
			response.sendRedirect("main");
		}
	%>
	<head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Login</title>
        <link href="${path}/resources/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="bg-primary">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">Login</h3></div>
                                    <div class="card-body">
                                         <form:form modelAttribute="loginCommand">
                                            <div class="form-floating mb-3">
                                                <form:input class="form-control" placeholder="Your ID" path="id" />
                                                <label for="inputID">ID를 입력해 주세요</label>
                                                <form:errors path="id"/>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <form:password class="form-control" placeholder="Password" path="password" />
                                                <label for="inputPassword">비밀번호를 입력해 주세요</label>
                                                <form:errors path="password"/>
									     		<form:errors />
                                            </div>
                                            <div class="form-check mb-3">
                                                <form:checkbox class="form-check-input" path="rememberId"/> 
                                                <label class="form-check-label" for="rememberId">ID 저장</label>
                                            </div>
                                            <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                                <input type="submit" class="btn btn-primary" value="Login" />
                                            </div>
                                        </form:form>
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