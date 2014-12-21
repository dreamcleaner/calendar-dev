<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
			<img src="${resourceUrl}/images/myevent.png"/>
		</div>
		<table class="table table-hover">
			<tr>
				<th>날짜</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성자</th>
				<th>좋아요</th>
				<th>이벤트등급</th>
				<th>삭제하기</th>
			</tr>
			<c:forEach var="ownerEvent" items="${ownerEvent}">
				<tr>
					<td>${ownerEvent.when.time}</td>
					<td>${ownerEvent.summary}</td>
					<td>${ownerEvent.description}</td>
					<td>${ownerEvent.owner.id}</td>
					<td>${ownerEvent.numLikes}</td>
					<td>${ownerEvent.eventLevel}</td>
					<c:url var="deleteEventUrl" value="/events/deleteEvent?a=${ownerEvent.id}" />
            		<td><a id="deleteEventLink" href="${deleteEventUrl}">delete</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div id="allevent-all">
		<div id="small-title">
			<img src="${resourceUrl}/images/participate.png"/>
		</div>
		<table class="table table-hover">
			<tr>
				<th>날짜</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성자</th>
				<th>좋아요</th>
				<th>이벤트등급</th>
				<th>그만두기</th>
			</tr>
			<c:forEach var="attendEvent" items="${attendEvent}">
				<tr>
					<td>${attendEvent.when.time}</td>
					<td>${attendEvent.summary}</td>
					<td>${attendEvent.description}</td>
					<td>${attendEvent.owner.id}</td>
					<td>${attendEvent.numLikes}</td>
					<td>${attendEvent.eventLevel}</td>
					<c:url var="dropAttendeeUrl" value="/events/my/dropAttendee?a=${attendEvent.id}" />
            		<td><a id="dropAttendeeLink" href="${dropAttendeeUrl}">drop</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<jsp:include page="./includes/footer.jsp"/>
</div>
</body>
</html>