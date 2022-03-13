<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Develocket</title>
</head>
<body>
<!-- Begin Site Title ================================================== -->
<div class="container">
    <div class="container">
        <div class="mainheading">
            <h1 class="sitetitle">CATEGORY</h1>
        </div>
        <div class="category_card">
            <ul class="category_list">
                <li class="category_item">
                    <a class="category_link" href="${contextPath}/starcategory/starcategory_IT.do">
                        <img src="${contextPath}/resources/image/category/1/develocket-spaceman-it.png">
                        <!-- <span class="category_text">IT</span> -->
                    </a>
                </li>
                <li class="category_item">
                    <a class="category_link" href="${contextPath}/starcategory/starcategory_Health.do">
                        <img src="${contextPath }/resources/image/category/1/develocket-spaceman-category.png">
                        <!-- <span class="category_text">건강</span> --></a>
                </li>
                <li class="category_item">
                    <a class="category_link" href="${contextPath}/starcategory/starcategory_Study.do">
                        <img src="${contextPath }/resources/image/category/1/develocket-spaceman-study.png">
                        <!-- <span class="category_text">학업</span> --></a>
                </li>
                <li class="category_item">
                    <a class="category_link" href="${contextPath}/starcategory/starcategory_Lesson.do">
                        <img src="${contextPath }/resources/image/category/1/develocket-spaceman-lesson.png">
                        <!-- <span class="category_text">레슨</span> --></a>
                </li>
                <li class="category_item">
                    <a class="category_link" href="${contextPath}/starcategory/starcategory_ETC.do">
                        <img src="${contextPath }/resources/image/category/1/develocket-spaceman-etc.png">
                        <!-- <span class="category_text">기타</span> --></a>
                </li>
            </ul>
        </div>
        <!-- End Site Title ================================================== -->

        <!-- Begin Featured ================================================== -->
        <section class="featured-posts">
            <div class="section-title">
                <h2>
                    <span>ETC</span></h2>

            </div>
            <div class="category_card">
                <ul class="category_list2">
                    <li class="category_item_etc">
                        <a class="category_etc">
                            <img src="${contextPath }/resources/image/category/develocket_spaceman-sad.png">
                            <!-- <span class="category_text">준비중입니다 (T_T)</span> -->
                        </a>

                    </li>
                </ul>

            </div>
        </section>
        <!-- End Featured ================================================== -->
    </div>
    <!-- /.container -->

</div>
</body>
</html>