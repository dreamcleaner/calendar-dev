<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<c:set var="pageTitle" value="Welcome to myCalendar!" scope="request"/>
<html lang="en">
<head>
	<title>myCalendar: <c:out value="${pageTitle}"/> </title>
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    <c:url var="resourceUrl" value="/resources"/>
    <link href="${resourceUrl}/bootstrap-3.3.1/css/bootstrap.css" rel="stylesheet"/>
    <link href="${resourceUrl}/bootstrap-3.3.1/css/bootstrap-datetimepicker.css" rel="stylesheet"/>    
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
        <div class="alert alert-success" id="message"><c:out value="${message}"/></div>
    </c:if>
   
	<div id="allevent-all">
		<div id="small-title">
			<img src="${resourceUrl}/images/createevent.png"/>
		</div>
		<form:form action="createevent" method="post" commandName="eventForm" role="form">
			<div class="form-group">
				<label for="exampleInputEmail1">summary</label> 
				<form:input path="summary" class="form-control" id="exampleInputEmail1" placeholder="summary" />
			</div>
			<div class="form-group">
				<label for="exampleInputPassword1">description</label> 
				<form:input path="description" class="form-control" id="exampleInputEmail1" placeholder="description" />
			</div>
			<div class="form-group">
					<label for="exampleInputPassword1">When</label> 
					<div class="row">
						<div class='col-md-6'>
							<div class="form-group">
								<div class='input-group date' id='datetimepicker1'>
									<input type="text" name="value" class="form-control" /> <span
										class="input-group-addon"> <span
										class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			<button type="submit" class="btn btn-default">Submit</button>
		</form:form>
	</div>


		
		<jsp:include page="./includes/footer.jsp"/>
</div>
<script type="text/javascript" src="${resourceUrl}/javascript/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${resourceUrl}/bootstrap-3.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${resourceUrl}/javascript/moment.js"></script>
<script type="text/javascript" src="${resourceUrl}/javascript/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
$(function () {
    $('#datetimepicker1').datetimepicker();
});
</script>
</body>
</html>