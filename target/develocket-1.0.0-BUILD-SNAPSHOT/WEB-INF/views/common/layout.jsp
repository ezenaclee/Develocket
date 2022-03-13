<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!-- 타일즈 사용하기 위해 추가 -->
<%
    request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><tiles:insertAttribute name="title"/></title>
    <!-- icon -->
    <link rel="icon" href="${contextPath }/resources/image/common/develocket_icon.ico">

    <!-- Bootstrap core CSS -->
    <link href="${contextPath}/resources/css/common/bootstrap.min.css" rel="stylesheet">
    <!-- Fonts -->
    <link
            href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
            rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Righteous" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
    <!-- Custom styles for this template -->
    <%--<link href="${contextPath}/resources/css/common/mediumish.css" rel="stylesheet">--%>
    <link href="${contextPath}/resources/css/common/develocket.css" rel="stylesheet" type="text/css">
    <link href="${contextPath}/resources/css/starcategory/starcategory.css" rel="stylesheet" type="text/css">
    <link href="${contextPath}/resources/css/common/alert.css" rel="stylesheet" type="text/css">

</head>
<body>
    <div id="header" style="display: block;">
        <tiles:insertAttribute name="header"/>
    </div>
    <div id="content" style="display: block;">
        <tiles:insertAttribute name="body"/>
    </div>
    <div id="footer" style="display: block;">
        <tiles:insertAttribute name="footer"/>
    </div>

    <!-- Bootstrap core JavaScript ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="${contextPath}/resources/js/jquery.min.js"></script>
    <script
            src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"
            integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb"
            crossorigin="anonymous"></script>
    <script src="${contextPath}/resources/js/bootstrap.min.js"></script>
    <script src="${contextPath}/resources/js/ie10-viewport-bug-workaround.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script> 
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>  
</body>
</html>