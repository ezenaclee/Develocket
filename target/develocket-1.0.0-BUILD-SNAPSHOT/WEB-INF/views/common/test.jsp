<%@page import="org.json.JSONArray"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.Reader"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<%
    JSONParser parser = new JSONParser();

    Reader reader = null;
    try {
        reader = new FileReader("C:\\workspace-spring\\Develocket_Lee\\src\\main\\webapp\\resources\\json\\field.json");

    } catch (FileNotFoundException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }

    org.json.simple.JSONObject jsonSimpleObject = null;
    try {
        jsonSimpleObject = (org.json.simple.JSONObject) parser.parse(reader);
    } catch (Exception e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }

    List<String> cateSList = new ArrayList<>();

    // json파일을 String 형식으로 변환함
    JSONObject jsonObject = new JSONObject(jsonSimpleObject.toJSONString());

    // 대분류 목록을 List로 만듬
    Iterator<String> iterator = jsonObject.keys();
    while (iterator.hasNext()) {
        String large = iterator.next().toString();

        JSONObject jsonObject2 = (JSONObject) jsonObject.get(large);
        Iterator<String> iterator2 = jsonObject2.keys();

        while (iterator2.hasNext()) {
            String middle = iterator2.next().toString();

            JSONArray jsonArray = jsonObject2.getJSONArray(middle);

            if (jsonArray != null) {
                for (int i = 0; i < jsonArray.length(); i++) {
                    cateSList.add(jsonArray.get(i).toString());
                }
            }
        }
    }
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="category" value="<%=cateSList  %>"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="assets/img/favicon.ico">
    <title>Mediumish - A Medium style template by WowThemes.net</title>

    <!-- Bootstrap core CSS -->
    <link href="${contextPath}/resources/css/common/bootstrap.min.css" rel="stylesheet">
    <!-- Fonts -->
    <link
            href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
            rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Righteous" rel="stylesheet">
    <link
            href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap"
            rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="${contextPath}/resources/css/common/mediumish.css" rel="stylesheet">

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">


</head>

<body>
<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
                <input class="form-control mr-sm-2" type="text" placeholder="검색" id="searchInput">
                <span class="search-icon">
                        <svg class="svgIcon-use" width="25" height="25" viewbox="0 0 25 25">
                            <path
                                    d="M20.067 18.933l-4.157-4.157a6 6 0 1 0-.884.884l4.157 4.157a.624.624 0 1 0 .884-.884zM6.5 11c0-2.62 2.13-4.75 4.75-4.75S16 8.38 16 11s-2.13 4.75-4.75 4.75S6.5 13.62 6.5 11z"></path>
                        </svg>
                    </span>
            </form>

            <!-- End Search -->

            <label for="autocomplete">autocomplete test: </label>
            <input id="autocomplete">

            <script>
                window.onload
                $(function () {
                    var category = "<c:out value='${category}'/>";
                    console.log("category 값 확인 : ", category);

                    $("#autocomplete").autocomplete({
                        source: ["자바", "파이썬", "헤어관리", "미술치료"]
                    });
                });
            </script>

            <input type="hidden" id="category" value="">

            <!-- Begin Menu -->
            <c:choose>
                <c:when test="${isLogOn == true && rocketInfoVO != null }">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="${contextPath }/chat/chatList.do">채팅<span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${contextPath }/request/receiveEstimateList.do">받은견적</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${contextPath }/request/receiveRequestList.do">받은요청</a>
                        </li>
                    </ul>
                    <div class="dropdown">
                        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img id="profile-img" src="${contextPath}/resources/image/common/kangstar.jpg" alt="profile">
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item" href="${contextPath }/rocketInfo/logout.do">로그아웃</a>
                            <a class="dropdown-item" href="${contextPath }/mypage/modStarInfoForm.do">스타 정보 수정</a>
                            <a class="dropdown-item" href="${contextPath }/starInfo/joinStarForm.do">스타등록</a>
                            <c:forEach var="star_field_cd" items="${starFieldCDList }" varStatus="cnt" >
                                <a class="dropdown-item" href="${contextPath }/starField/starFieldView.do?star_field_cd=${star_field_cd}">
                                    스타프로필${cnt.count }
                                </a>
                            </c:forEach>
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
<!-- End Nav ================================================== -->

<!-- Bootstrap core JavaScript ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="${contextPath}/resources/js/jquery.min.js"></script>
<script
        src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"
        integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb"
        crossorigin="anonymous"></script>
<script src="C:/workspace-spring/Develocket_Lee/src/main/webapp/resources/js/bootstrap.min.js"></script>
<script src="${contextPath}/resources/js/ie10-viewport-bug-workaround.js"></script>

</body>
</html>

