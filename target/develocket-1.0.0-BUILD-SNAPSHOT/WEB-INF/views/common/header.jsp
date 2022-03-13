<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<c:set var="viewCheckMap" value="${viewCheckMap }"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta
        name="viewport"
        content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="assets/img/favicon.ico">
    <title>Mediumish - A Medium style template by WowThemes.net</title>   	
    
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script> 
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>    
	<script src="${contextPath }/resources/js/autocomplete.js"></script>
	<script src="https://kit.fontawesome.com/d3a24d5be2.js"></script>
	
	<style type="text/css">
	
	.fa-bell{
	    font-size: 5px;
	    color: #F34F30;
	}
	
	.ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-state-active.ui-button:hover {
		background: #f77057;
		border: 0px solid #000000;
	  
	}
	#ui-id-1/* , .ui-menu-item-wrapper, .ui-state-active */ {
		border: 1px solid #e0e0e0;
	   	border-radius:10px;
	   	position: fixed;
	    z-index:21474836;
	    font-size: 15px;    
	    padding: 3px;
	    
	}
	.ui-menu-item-wrapper {
	   border-radius:7px;   
	   border: 1px solid #e0e0e0;
	   margin-bottom: 3px;
	}
	
	</style>
</head>
<body>
<!-- Begin Nav ================================================== -->
<nav
        class="navbar navbar-toggleable-md navbar-light bg-white fixed-top mediumnavigation">
    <button
            class="navbar-toggler navbar-toggler-right"
            type="button"
            data-toggle="collapse"
            data-target="#navbarsExampleDefault"
            aria-controls="navbarsExampleDefault"
            aria-expanded="false"
            aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="container">
        <!-- Begin Logo -->
        <a class="navbar-brand" href="${contextPath}">
            <img src="${contextPath}/resources/image/common/develocketlogo-text.png" alt="logo">
        </a>
        <!-- End Logo -->
        <div class="collapse navbar-collapse" id="navbarsExampleDefault">
            <!-- Begin Search -->
            <form class="form-inline my-2 my-lg-0">
                <label for="autocomplete"></label>
				<input class="form-control mr-sm-2" id="autocomplete" placeholder="검색" type="text">
                <span class="search-icon">
                        <svg class="svgIcon-use" width="25" height="25" viewbox="0 0 25 25">
                            <path
                                    d="M20.067 18.933l-4.157-4.157a6 6 0 1 0-.884.884l4.157 4.157a.624.624 0 1 0 .884-.884zM6.5 11c0-2.62 2.13-4.75 4.75-4.75S16 8.38 16 11s-2.13 4.75-4.75 4.75S6.5 13.62 6.5 11z"></path>
                        </svg>
                    </span>
            </form>
            <!-- End Search -->
            <!-- Begin Menu -->
            <c:choose>
                <c:when test="${isLogOn == true && rocketInfoVO != null }">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active">
                        	<c:if test="${viewCheckMap.viewCheck3Rocket == '0' or viewCheckMap.viewCheck3Rocket == '1s'
                        	            or viewCheckMap.viewCheck3Star == '0' or viewCheckMap.viewCheck3Star == '1r'}">
                                <span class="-count1"><i class="fa-solid fa-bell"></i></span>
                            </c:if>
                            <a class="nav-link" href="${contextPath }/chat/chatList.do">채팅<span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item">
                        	<c:if test="${viewCheckMap.viewCheck2 == '0' or viewCheckMap.viewCheck0Rocket == '0'}">
                                <span class="-count"><i class="fa-solid fa-bell"></i></span>
                            </c:if>
                            <a class="nav-link" href="${contextPath }/request/receiveEstimateList.do">받은견적</a>
                        </li>
                        <li class="nav-item">
                        	<c:if test="${viewCheckMap.viewCheck1 == '0' or viewCheckMap.viewCheck0Star == '0'}">
                                <span class="-count"><i class="fa-solid fa-bell"></i></span>
                            </c:if>
                            <a class="nav-link" href="${contextPath }/request/receiveRequestList.do">받은요청</a>
                        </li>
                    </ul>
                    <div class="dropdown">
                        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <c:choose>
                                <c:when test="${not empty rocketInfoVO.profile_img and rocketInfoVO.profile_img != null }">
                                    <img id="profile-img" src="${contextPath }/rocketInfo/download.do?imageFileName=${rocketInfoVO.profile_img}&rocket_cd=${rocketInfoVO.rocket_cd}"  alt="프로필사진" />
                                </c:when>
                                <c:otherwise>
                                    <img id="profile-img" src="${contextPath}/resources/image/common/develocket_spaceman.png"  alt="마이페이지를 통해 프로필을 등록해주세요." />
                                </c:otherwise>
                            </c:choose>
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <span class="dropdown-item">${rocketInfoVO.name} 님</span>
                            <a class="dropdown-item" href="${contextPath }/mypage/myPageView.do">마이페이지</a>
                            <a class="dropdown-item" href="${contextPath }/starInfo/joinStarForm.do">스타등록</a>
                            <c:forEach var="star_field_cd" items="${starFieldCDList }" varStatus="cnt">
                                <a class="dropdown-item"
                                   href="${contextPath }/starField/starFieldView.do?star_field_cd=${star_field_cd}">
                                    스타프로필${cnt.count }
                                </a>
                            </c:forEach>
                            <a class="dropdown-item" href="${contextPath }/rocketInfo/logout.do">로그아웃</a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="${contextPath }/rocketInfo/loginForm.do">로그인<span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${contextPath }/rocketInfo/joinForm.do">회원가입</a>
                        </li>
                    </ul>
                </c:otherwise>
            </c:choose>
            <!-- End Menu -->

        </div>
    </div>
</nav>
</body>
</html>











