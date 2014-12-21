<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<c:set var="pageTitle" value="Welcome to myCalendar!" scope="request"/>
<html>
<head>
	<title>myCalendar: <c:out value="${pageTitle}" /> </title>
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    <c:url var="resourceUrl" value="/resources"/>
    <link href="${resourceUrl}/bootstrap-3.3.1/css/bootstrap.css" rel="stylesheet"/>
    <link href="${resourceUrl}/css/custom.css" rel="stylesheet"/>
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
</head>
<body class="header" onload='document.loginForm.id.focus();'>
<div class="container">
<jsp:include page="./includes/header.jsp"/>
    <c:if test="${message != null}">
        <div class="alert alert-danger" id="message"><c:out value="${message}"/></div>
    </c:if>
    <div id="allevent-all">
    	<div id="small-title">
			<img src="${resourceUrl}/images/login.png"/>
		</div>
		<c:if test="${not empty error}">
			<div class="alert alert-danger">${error}</div>
		</c:if>
		<c:if test="${not empty msg}">
			<div class="alert alert-info">${msg}</div>
		</c:if>
		<c:url value="/j_spring_security_check" var="loginUrl" />
		<form name='loginForm' action="${loginUrl}" method='POST' role="form">
			<div class="form-group">
				<label for="exampleInputEmail1">Email address</label> 
				<input type='text' name='email' class="form-control" id="exampleInputEmail1" placeholder="Enter email" />
			</div>
			<div class="form-group">
				<label for="exampleInputPassword1">Password</label> 
				<input type='password' name='password' class="form-control" id="exampleInputPassword1" placeholder="Password" />
			</div>
			
			<button type="submit" class="btn btn-default">Login</button>
		</form>
	</div>


<jsp:include page="./includes/footer.jsp"/>
</div>
</body>
</html>