<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>   
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
<body class="header">
<div class="container">
<jsp:include page="./includes/header.jsp"/>
    <c:if test="${message != null}">
        <div class="alert alert-danger" id="message"><c:out value="${message}"/></div>
    </c:if>
    <div id="allevent-all">
    	<div id="small-title">
			<img src="${resourceUrl}/images/signup.png"/>
		</div>
		<form:form action="signup" method="post" commandName="userForm" role="form">
			<div class="form-group">
				<label for="exampleInputEmail1">Email address</label> 
				<form:input path="email" class="form-control" id="exampleInputEmail1" placeholder="Enter email" />
			</div>
			<div class="form-group">
				<label for="exampleInputPassword1">Password</label> 
				<form:password path="password" class="form-control" id="exampleInputPassword1" placeholder="Password" />
			</div>
			<div class="form-group">
				<label for="exampleInputEmail1">Name</label> 
				<form:input path="name" class="form-control" id="exampleInputEmail1" placeholder="Enter name" />
			</div>
			<button type="submit" class="btn btn-default">Submit</button>
		</form:form>
	</div>

	
	
<jsp:include page="./includes/footer.jsp"/>
</div>
</body>
</html>