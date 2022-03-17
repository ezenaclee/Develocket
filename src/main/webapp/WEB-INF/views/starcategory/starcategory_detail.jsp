<%@page import="org.json.JSONArray" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.Map" %>
<%@page import="java.io.FileNotFoundException" %>
<%@page import="org.json.simple.parser.ParseException" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@page import="org.json.JSONObject" %>
<%@page import="java.io.FileReader" %>
<%@page import="java.io.Reader" %>
<%@page import="org.json.simple.parser.JSONParser" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    JSONParser parser = new JSONParser();

    Reader reader = null;
    try {
        reader = new FileReader("C:\\develocket\\Develocket\\src\\main\\webapp\\resources\\json\\field.json");

    } catch (FileNotFoundException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }

    org.json.simple.JSONObject jsonSimpleObject = null;
    try {
        jsonSimpleObject = (org.json.simple.JSONObject) parser.parse(reader);
    } catch (Exception e) {
        e.printStackTrace();
    }

    JSONObject jsonObject = new JSONObject(jsonSimpleObject.toJSONString());

    List<String> largeFieldList = new ArrayList<String>();
    Map<String, List<String>> middleMap = new HashMap<String, List<String>>();
    List<String> middleKeyList = new ArrayList<>();
    Map<String, List<String>> smallMap = new HashMap<String, List<String>>();

    Iterator<String> iterator = jsonObject.keys();
    while (iterator.hasNext()) {
        String field = iterator.next().toString();
        largeFieldList.add(field);
    }


    for (String large : largeFieldList) {
        List<String> tempList = new ArrayList<String>();

        JSONObject jsonObject2 = (JSONObject) jsonObject.get(large);
        Iterator<String> iteratorM = jsonObject2.keys();
        while (iteratorM.hasNext()) {
            String field = iteratorM.next().toString();
            tempList.add(field);
        }
        middleMap.put(large, tempList);

        for (String middleKey : tempList) {
            middleKeyList.add(middleKey);
        }

    }

    for (String large : largeFieldList) {
        List<String> middleList = middleMap.get(large);
        JSONObject jsonObject2 = jsonObject.getJSONObject(large);

        for (String middle : middleList) {
            List<String> tempList = new ArrayList<String>();
            JSONArray jsonArray = jsonObject2.getJSONArray(middle);

            if (jsonArray != null) {
                for (int i = 0; i < jsonArray.length(); i++) {
                    tempList.add(jsonArray.get(i).toString());
                }
            }
            smallMap.put(middle, tempList);
        }

    }

    String[] field_L = {"IT", "건강/미용", "학업", "레슨"};
    String[] cityList = {"서울", "부산", "인천", "대구", "광주", "대전", "울산"};
    String[] seoul = {"종로구", "중구", "용산구", "성동구", "광진구", "동대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구", "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구", "영등포구", "동작구", "관악구", "서초구", "강남구", "송파구", "강동구"};
    String[] busan = {"중구", "서구", "동구", "영도구", "부산진구", "동래구", "남구", "북구", "강서구", "해운대구", "사하구", "금정구", "연제구", "수영구", "사상구", "기장군"};
    String[] incheon = {"중구", "동구", "남구", "연수구", "남동구", "부평구", "계양구", "서구", "강화군", "옹진군"};
    String[] daegu = {"중구", "동구", "서구", "남구", "북구", "수성구", "달서구", "달성군"};
    String[] gwangju = {"동구", "서구", "남구", "북구", "광산구"};
    String[] daejeon = {"동구", "중구", "서구", "유성구", "대덕구"};
    String[] ulsan = {"중구", "남구", "동구", "북구", "울주군"};

    List<List<String>> areaList = new ArrayList<>();
    areaList.add(List.of(seoul));
    areaList.add(List.of(busan));
    areaList.add(List.of(incheon));
    areaList.add(List.of(daegu));
    areaList.add(List.of(gwangju));
    areaList.add(List.of(daejeon));
    areaList.add(List.of(ulsan));

%>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }"/>
<c:set var="field_L" value="<%= field_L %>"/>
<c:set var="field_M" value="<%= middleMap %>"/>
<c:set var="field_S" value="<%= smallMap %>"/>
<c:set var="cityList" value="<%= cityList %>"/>
<c:set var="areaList" value="<%= areaList %>"/>
<c:set var="previewVOList" value="${previewVOList }"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>카테고리 상세</title>
    <!-- Custom styles for this template -->
    <link href="${contextPath }/resources/css/starcategory/starcategory-detail.css" rel="stylesheet">
    <script type="text/javascript">

        window.onload = function () {
            fn_random();
        }

	    var begin_num = 8;
	    var end_num = 8;
	    function moreList() {
	
	        var size = ${fn:length(starLineUpVOList)};
	        end_num += 4;
	
	        if (end_num >= size) {
	            end_num = size;
	            $('#moreList').empty();
	        }
	
	        for (var i = begin_num; i < end_num; i++) {
	            $('#starLineUpVO' + i).css("display", "block");
	        }
	        begin_num = end_num;
	    }
	   	
    </script>

    <style>
        .btns {
            display: inline-block;
            font-weight: 400;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;

            user-select: none;
            border: 1px solid transparent;
            padding: 0.5rem 0.75rem;
            font-size: 1rem;
            line-height: 1.25;
            border-radius: 0.25rem;
            transition: all 0.15s ease-in-out;
            margin-bottom: 5px;
            margin-right: 10px;
        }

        .btns {
            color: #fff;
            background-color: #F34F30;
            border-color: #F34F30;
        }
        .btns:hover {
            color: #fff;
            background-color: #f12800;
            border-color: #f12800;
            cursor: pointer;
        }
        .btns.focus,
        .btns:focus {
            box-shadow: 0 0 0 3px rgb(235, 150, 138);
        }
        .btns.disabled,
        .btns:disabled {
            background-color: #F34F30;
            border-color: #F34F30;
        }
        .btns.active,
        .btns:active,
        .show > .btns.dropdown-toggle {
            background-color: #F34F30;
            background-image: none;
            border-color: #F34F30;
        }
    </style>
</head>
<body>
<!-- sidbarmenu category start-->
<div id="mySidenav_category" class="sidenav">
    <a href="javascript:void(0)" class="closebtn" onclick="closeNav_category()">&times;</a>
    <c:forEach var="large" items="${field_L }">
        <a href="#" class="dropdown-btn">${large }</a>
        <div class="dropdown-container">
            <c:forEach var="middle" items="${field_M[large] }">
                <a href="#" class="dropdown-btn">
                	${middle }
                	<button id="kang_dropdown_btn" onclick="location.href='${contextPath }/starcategory/starcategory_detail.do?cate_m=${middle }'">
                        <i class="fa fa-chevron-right" aria-hidden="true"></i>
                    </button>
                </a>
                
                <div class="dropdown-container2">
                    <c:forEach var="small" items="${field_S[middle] }">
                        <a href="#">
                       		${small }
                        	<button id="kang_dropdown_btn2" onclick="location.href='${contextPath }/starcategory/starcategory_detail.do?cate_s=${small }'">
                                <i class="fa fa-chevron-right" aria-hidden="true"></i>
                            </button>
                        </a>
                    </c:forEach>
                </div>
            </c:forEach>
        </div>
    </c:forEach>
</div>
<!-- sidebarmenu end -->

<!-- sidbarmenu map start-->
<div id="mySidenav_map" class="sidenav">
    <a href="javascript:void(0)" class="closebtn" onclick="closeNav_map()">&times;</a>
    <c:forEach var="i" begin="0" end="6" step="1">
        <a href="#" class="dropdown-btn">${cityList[i] }</a>
        <div class="dropdown-container">
            <c:forEach var="area" items="${areaList[i]}">
            	<%
            		String cate_m = request.getParameter("cate_m");
            		String cate_s = request.getParameter("cate_s");
            	%>
            		<c:set var="city" value="${cityList[i] }"/>
            	<%
            		if(cate_m != null) {
            	%>
            		<c:set var="middle" value="<%=cate_m %>"/>
            	<%
            		} else if(cate_s != null) {
            	%>
            		<c:set var="small" value="<%=cate_s %>"/>
            	<%	
            		}
            		
            	%>
            	<c:choose>
            		<c:when test="${not empty middle && middle != null }">
            			<a href="${contextPath }/starcategory/starcategory_detail.do?cate_m=${middle }&area=${city } ${area }" class="dropdown-btn">${area }</a>
            			<% String location = request.getParameter("area"); %>
            			<c:set var="location" value="<%=location %>"/>
            		</c:when>
            		<c:otherwise>
            			<a href="${contextPath }/starcategory/starcategory_detail.do?cate_s=${small }&area=${city } ${area }" class="dropdown-btn">${area }</a>
            			<% String location = request.getParameter("area"); %>
            			<c:set var="location" value="<%=location %>"/>
            		</c:otherwise>
            	</c:choose>
            </c:forEach>
        </div>
    </c:forEach>
</div>

<!-- sidebarmenu end -->

<!-- Begin Site Title ================================================== -->
<div class="container">
    <div class="mainheading">
        <button style="font-size:20px;cursor:pointer" onclick="openNav_category()" id="category_btn">
            <i class="fa fa-bars"></i>
            카테고리
        </button>
        <button style="font-size:20px;cursor:pointer" onclick="openNav_map()" id="address_btn">
            <i class="fa fa-bars"></i>
            지역
        </button>
    </div>
    <div class="section-title">
        <h2>
            <c:choose>
                <c:when test="${not empty param.cate_m}">
                    <span style="font-size: 30px; font-weight: 700;">${param.cate_m}</span>
                </c:when>
                <c:otherwise>
                    <span style="font-size: 30px; font-weight: 700;"> 미선택</span>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${not empty param.area}">
                    <span style="font-size: 30px; font-weight: 700;"> - ${param.area}</span>
                </c:when>
                <c:otherwise>
                    <span style="font-size: 30px; font-weight: 700;"> - 미선택</span>
                </c:otherwise>
            </c:choose>
        </h2>
    </div>
    <!-- End Site Title ================================================== -->
    <section class="featured-posts">
        <div class="section-title">
            <h2>
                <span>RANDOM</span>
                <button class="btn-pill text-white" id="random_btn" onclick="fn_random()" style="float: right;">
                    <i class="fa fa-random"></i>
                </button>

            </h2>
        </div>


        <div class="card-columns listrecent">
            <c:choose>
                <c:when test="${not empty previewVOList && previewVOList != 'null' }">
                    <c:forEach var="i" begin="0" end="${fn:length(previewVOList) - 1}">
                         <div id="random_star_${i}" style="display: none">
                             <div class="card">
                                 <c:choose>
                                     <c:when test="${not empty previewVOList[i].profile_img }">
                                         <a href="${contextPath }/starField/starFieldView.do?star_field_cd=${previewVOList[i].star_field_cd}">
                                             <img class="img-fluid"
                                                  src="${contextPath }/starField/download.do?imageFileName=${previewVOList[i].profile_img}&star_field_cd=${previewVOList[i].star_field_cd}"
                                                  alt="" style="height: 250px">
                                         </a>
                                     </c:when>
                                     <c:otherwise>
                                         <a href="${contextPath }/starField/starFieldView.do?star_field_cd=${previewVOList[i].star_field_cd}">
                                             <img class="img-fluid" src="${contextPath }/resources/image/common/develocket_spaceman.png"
                                                  alt="" style="height: 250px">
                                         </a>
                                     </c:otherwise>
                                 </c:choose>
                                 <div class="card-block">
                                     <h2 class="card-title">
                                         <a href="${contextPath }/starField/starFieldView.do?star_field_cd=${previewVOList[i].star_field_cd}">
                                                 ${previewVOList[i].star_nickname }
                                         </a>
                                     </h2>
                                     <h4 class="card-text">${previewVOList[i].cate_l}-${previewVOList[i].cate_m}-${previewVOList[i].cate_s}</h4>
                                     <c:choose>
                                         <c:when test="${not empty previewVOList[i].short_intro }">
                                             <h4 class="card-text">${previewVOList[i].short_intro }</h4>
                                         </c:when>
                                         <c:otherwise>
                                             <h4 class="card-text">기본 짧은소개글</h4>
                                         </c:otherwise>
                                     </c:choose>
                                 </div>
                             </div>
                         </div>
                    </c:forEach>
                 </c:when>
            </c:choose>
        </div>
    </section>
    <!-- Begin List Posts ================================================== -->
    <section class="recent-posts">
        <div class="section-title">
        	<h2>
                <span>SHINING STARS</span>
                <div class="dropdown">
                    <button class="dropbtn btn-pill text-white" id="drobdown_menu_btn"><i class="fa fa-bars"></i></button>
                    <div class="dropdown-content">
                        <c:choose>
                            <c:when test="${not empty middle && middle != null }">
                                <a href="${contextPath }/starcategory/starcategory_detail.do?cate_m=${middle }&area=${location }&lineup=review">리뷰순</a>
                                <a href="${contextPath }/starcategory/starcategory_detail.do?cate_m=${middle }&area=${location }&lineup=rating">별점순</a>
                                <a href="${contextPath }/starcategory/starcategory_detail.do?cate_m=${middle }&area=${location }&lineup=request">받은요청순</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${contextPath }/starcategory/starcategory_detail.do?cate_s=${small }&area=${location }&lineup=review">리뷰순</a>
                                <a href="${contextPath }/starcategory/starcategory_detail.do?cate_s=${small }&area=${location }&lineup=rating">별점순</a>
                                <a href="${contextPath }/starcategory/starcategory_detail.do?cate_s=${small }&area=${location }&lineup=request">받은요청순</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </h2>
        </div>
        <div class="card-columns listrecent">
            <c:choose>
                <c:when test="${not empty starLineUpVOList && starLineUpVOList != 'null' }">
                    <c:choose>
                        <c:when test="${fn:length(starLineUpVOList) <= 8 }">
                            <c:forEach var="starLineUpVO" items="${starLineUpVOList}">
                                <div class="card">
                                    <c:choose>
                                        <c:when test="${not empty starLineUpVO.profile_img }">
                                            <a href="${contextPath }/starField/starFieldView.do?star_field_cd=${starLineUpVO.star_field_cd}">
                                                <img class="img-fluid"
                                                     src="${contextPath }/starField/download.do?imageFileName=${starLineUpVO.profile_img}&star_field_cd=${starLineUpVO.star_field_cd}"
                                                     alt="" style="height: 250px">
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${contextPath }/starField/starFieldView.do?star_field_cd=${starLineUpVO.star_field_cd}">
                                                <img class="img-fluid" src="${contextPath }/resources/image/common/develocket_spaceman.png"
                                                     alt="" style="height: 250px">
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="card-block">
                                        <h2 class="card-title">
                                            <a href="${contextPath }/starField/starFieldView.do?star_field_cd=${starLineUpVO.star_field_cd}">
                                                    ${starLineUpVO.star_nickname }
                                            </a>
                                        </h2>
                                        <h4 class="card-text">${starLineUpVO.cate_l}-${starLineUpVO.cate_m}-${starLineUpVO.cate_s}</h4>
                                        <c:choose>
                                            <c:when test="${not empty starLineUpVO.short_intro }">
                                                <h4 class="card-text">${starLineUpVO.short_intro }</h4>
                                            </c:when>
                                            <c:otherwise>
                                                <h4 class="card-text">기본 짧은소개글</h4>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="i" begin="0" end="7" step="1">
                                <div class="card">
                                    <c:choose>
                                        <c:when test="${not empty starLineUpVOList[i].profile_img }">
                                            <a href="${contextPath }/starField/starFieldView.do?star_field_cd=${starLineUpVOList[i].star_field_cd}">
                                                <img class="img-fluid"
                                                     src="${contextPath }/starField/download.do?imageFileName=${starLineUpVOList[i].profile_img}&star_field_cd=${starLineUpVOList[i].star_field_cd}"
                                                     alt="" style="height: 250px">
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${contextPath }/starField/starFieldView.do?star_field_cd=${starLineUpVOList[i].star_field_cd}">
                                                <img class="img-fluid" src="${contextPath }/resources/image/common/develocket_spaceman.png"
                                                     alt="" style="height: 250px">
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="card-block">
                                        <h2 class="card-title">
                                            <a href="${contextPath }/starField/starFieldView.do?star_field_cd=${starLineUpVOList[i].star_field_cd}">
                                                    ${starLineUpVOList[i].star_nickname }
                                            </a>
                                        </h2>
                                        <h4 class="card-text">${starLineUpVOList[i].cate_l}-${starLineUpVOList[i].cate_m}-${starLineUpVOList[i].cate_s}</h4>
                                        <c:choose>
                                            <c:when test="${not empty starLineUpVOList[i].short_intro }">
                                                <h4 class="card-text">${starLineUpVOList[i].short_intro }</h4>
                                            </c:when>
                                            <c:otherwise>
                                                <h4 class="card-text">기본 짧은소개글</h4>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:forEach var="i" begin="8" end="${fn:length(starLineUpVOList) - 1}" step="1">
                                <div id="starLineUpVO${i}" style="display: none">
                                    <div class="card">
                                        <c:choose>
                                            <c:when test="${not empty starLineUpVO.profile_img }">
                                                <a href="${contextPath }/starField/starFieldView.do?star_field_cd=${starLineUpVOList[i].star_field_cd}">
                                                    <img class="img-fluid"
                                                         src="${contextPath }/starField/download.do?imageFileName=${starLineUpVOList[i].profile_img}&star_field_cd=${starLineUpVOList[i].star_field_cd}"
                                                         alt="">
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${contextPath }/starField/starFieldView.do?star_field_cd=${starLineUpVOList[i].star_field_cd}">
                                                    <img class="img-fluid" src="${contextPath }/resources/image/common/develocket_spaceman.png"
                                                         alt="">
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="card-block">
                                            <h2 class="card-title">
                                                <a href="${contextPath }/starField/starFieldView.do?star_field_cd=${starLineUpVOList[i].star_field_cd}">
                                                        ${starLineUpVOList[i].star_nickname }
                                                </a>
                                            </h2>
                                            <h4 class="card-text">${starLineUpVOList[i].cate_l}-${starLineUpVOList[i].cate_m}-${starLineUpVOList[i].cate_s}</h4>
                                            <c:choose>
                                                <c:when test="${not empty starLineUpVOList[i].short_intro }">
                                                    <h4 class="card-text">${starLineUpVOList[i].short_intro }</h4>
                                                </c:when>
                                                <c:otherwise>
                                                    <h4 class="card-text">기본 짧은소개글</h4>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <!-- begin post -->
                    <div class="card">
                        <a>
                            <img class="img-fluid" src="${contextPath}/resources/image/common/develocket_spaceman.png" alt="">
                        </a>
                        <div class="card-block">
                            <h2 class="card-title">
                                <a>스타 모집중!!</a>
                            </h2>
                            <h4 class="card-text">조건에 맞는 스타가 없습니다.</h4>
                        </div>
                    </div>
                    <!-- end post -->
                </c:otherwise>
            </c:choose>
        </div>
        <div class="card-columns listrecent">
	    <c:choose>
	        <c:when test="${fn:length(starLineUpVOList) > 8 }">
	            <div id="moreList">
	            	<button class="btns" onclick="moreList()">더보기</button>
            	</div>
	        </c:when>
	    </c:choose>
	    
	</div>
    </section>
</div>
<!-- sidbarmenu script -->

<script>
    function openNav_category() {
        document
            .getElementById("mySidenav_category")
            .style
            .width = "350px";
    }

    function closeNav_category() {
        document
            .getElementById("mySidenav_category")
            .style
            .width = "0";
    }

    function openNav_map() {
        document
            .getElementById("mySidenav_map")
            .style
            .width = "350px";
    }

    function closeNav_map() {
        document
            .getElementById("mySidenav_map")
            .style
            .width = "0";
    }
</script>

<script>
    /*  Loop through all dropdown buttons to toggle between hiding and showing its d
*  ropdown content - This allows the user to have multiple dropdowns without an
* y  conflict

*/
    var dropdown = document.getElementsByClassName("dropdown-btn");
    var i;

    for (i = 0; i < dropdown.length; i++) {
        dropdown[i].addEventListener("click", function () {
            this
                .classList
                .toggle("active");
            var dropdownContent = this.nextElementSibling;
            if (dropdownContent.style.display === "block") {
                dropdownContent.style.display = "none";
            } else {
                dropdownContent.style.display = "block";
            }
        });
    }
</script>

<script type="text/javascript">	

	let array = new Array();
    let temp_array = new Array();

    <c:if test="${not empty previewVOList && previewVOList != 'null' }">
        <c:forEach var="step" begin="0" end="${fn:length(previewVOList) - 1}">
            array.push(${step})
        </c:forEach>
    </c:if>

    function fn_random() {

        <c:if test="${not empty previewVOList && previewVOList != 'null' }">
            <c:forEach var="step" begin="0" end="${fn:length(previewVOList) - 1}">
                $('#random_star_${step}').css("display", "none");
            </c:forEach>
        </c:if>

        let a = 0;
        if (array.length < 4) {
            while (a < 4) {
                let remain_num = array.length;

                <c:if test="${not empty previewVOList && previewVOList != 'null' }">
                    <c:forEach var="step" begin="0" end="${fn:length(previewVOList) - 1}">
                        temp_array.push(${step})
                    </c:forEach>
                </c:if>

                for (let b = 0; b < array.length; b++) {
                    let remain = array[b];
                    $('#random_star_' + remain).css("display", "block");

                    for(let c = 0; c < temp_array.length; c++) {
                        if(temp_array[c] === remain)  {
                            temp_array.splice(c, 1);
                            c--;
                        }
                    }
                    a++;
                }

                array = temp_array;
                temp_array = [];

                for (let d = 0; d < 4 - remain_num; d++) {
                    let random1 = Math.floor(Math.random() * array.length);
                    let random_num1 = array[random1];

                    $('#random_star_' + random_num1).css("display", "block");

                    array.splice(random1, 1);

                    a++;
                }
            }
        }
        else {
            while (a < 4) {
                let random2 = Math.floor(Math.random() * array.length);
                let random_num2 = array[random2];

                $('#random_star_' + random_num2).css("display", "block");

                array.splice(random2, 1);

                a++;
            }
        }
    }

</script>
</body>
</html>