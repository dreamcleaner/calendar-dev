<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
			<img src="${resourceUrl}/images/allevent.png"/>
		</div>
		<table class="table table-hover">
			<tr>
				<th>날짜</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성자</th>
				<th>좋아요</th>
				<th>이벤트 등급</th>
				<sec:authorize access="hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')">
				<th>참여하기</th>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
				<th>삭제하기</th>
				</sec:authorize>
			</tr>
			<c:forEach var="allEvent" items="${allEvent}">
				<tr>
					<td>${allEvent.when.time}</td>
					<td>${allEvent.summary}</td>
					<td>${allEvent.description}</td>
					<td>${allEvent.owner.id}</td>
					<td>${allEvent.numLikes}</td>
					<td>${allEvent.eventLevel}</td>
					<sec:authorize access="hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')">
					<c:url var="joinUrl" value="/events/joinEvent?a=${allEvent.id}" />
            		<td><a id="joinLink" href="${joinUrl}">join</a></td>
            		</sec:authorize>
            		<sec:authorize access="hasRole('ROLE_ADMIN')">
            		<c:url var="deleteEventUrl" value="/events/deleteEvent?a=${allEvent.id}" />
            		<td><a id="deleteEventLink" href="${deleteEventUrl}">delete</a></td>
            		</sec:authorize>
				</tr>
			</c:forEach>
		</table>
	</div>

	<jsp:include page="./includes/footer.jsp"/>
</div>
</body>
</html>