<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("utf-8"); %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>자주 묻는 질문</title>
	
	<%-- <link href='${contextPath }/resources/board/faqList/faqList_bootstrap.min.css' rel='stylesheet'> --%>
	<link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css' rel='stylesheet'>
	<script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
	<%-- <link rel="stylesheet" href="${contextPath }/resources/board/faqList/faqList_style.css"> --%>
	<script src="https://kit.fontawesome.com/d3a24d5be2.js" ></script>	
</head>
<body oncontextmenu='return false' class='snippet-body'>
<div class="container">
    <div class="mainheading">
        <img src="${contextPath}/resources/image/common/banner-infor.png" alt="banner" style="width: 100%;">
    </div>
    <!-- End Site Title ================================================== -->

    <!-- Begin Featured ================================================== -->
    <section class="featured-posts">
        <div class="section-title">
            <h2>
                <span>로켓이용안내</span></h2>
        </div>
        <img src="${contextPath}/resources/image/common/rocketinfor.png" alt="rocketinfor">
    </section>
    <!-- End Featured ================================================== -->
    <!-- Begin List Posts ================================================== -->
    <section class="recent-posts">
        <div class="section-title">
            <h2>
                <span>스타이용안내</span></h2>
        </div>
        <img src="${contextPath}/resources/image/common/starinfor.png" alt="starinfor">
    </section>
</div>
</body>
</html>