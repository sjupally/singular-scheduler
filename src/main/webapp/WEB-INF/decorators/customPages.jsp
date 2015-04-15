<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"	prefix="decorator"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
</head>
<link href="<c:url value='/resources/script/jquery-ui.css' />"	type="text/css" rel="stylesheet" />
<script type="text/javascript"	src="<c:url value='/resources/script/jquery.js' />"></script>
<script type="text/javascript"	src="<c:url value='/resources/script/jquery-ui.js' />"></script>
<script type="text/javascript"	src="<c:url value='/resources/script/jquery.pagination.js' />"></script>
<script type="text/javascript"	src="<c:url value='/resources/script/pagination.js' />"></script>
<script type="text/javascript"	src="<c:url value='/resources/script/md5.js' />"></script>
<script type="text/javascript" src="<c:url value='/resources/script/jquery.base64.js' />"></script>
	<link href="<c:url value='/resources/script/bootstrap.css' />" type="text/css" rel="stylesheet" />
<link href="<c:url value='/resources/script/style.css' />" type="text/css" rel="stylesheet" />
<c:choose>
    <c:when test="${!empty displayDefault}">
           <jsp:include page="customLogin.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:include page="master.jsp" />
    </c:otherwise>
</c:choose>

