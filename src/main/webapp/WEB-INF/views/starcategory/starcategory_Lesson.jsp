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
                    <span>LESSON</span></h2>

            </div>
            <div class="category_card">

                <ul class="category_list2">
                    <li class="category_item">
                        <a class="category_link" href="${contextPath }/starcategory/starcategory_detail.do?cate_m=악기">
                            <img src="${contextPath }/resources/image/category/4-1/develocket_spaceman-instrument.png">
                            <!-- <span class="category_text">악기</span> -->
                        </a>
                    </li>
                    <li class="category_item">
                        <a class="category_link" href="${contextPath }/starcategory/starcategory_detail.do?cate_m=음악">
                            <img src="${contextPath }/resources/image/category/4-1/develocket_spaceman-music.png">
                            <!-- <span class="category_text">음악</span> -->
                        </a>
                    </li>
                    <li class="category_item">
                        <a class="category_link" href="${contextPath }/starcategory/starcategory_detail.do?cate_m=댄스/무용">
                            <img src="${contextPath }/resources/image/category/4-1/develocket_spaceman-dance.png">
                            <!-- <span class="category_text">댄스/무용</span> -->
                        </a>
                    </li>
                    <li class="category_item">
                        <a class="category_link" href="${contextPath }/starcategory/starcategory_detail.do?cate_m=사진/영상">
                            <img src="${contextPath }/resources/image/category/4-1/develocket_spaceman-picture.png">
                            <!-- <span class="category_text">사진/영상</span> -->
                        </a>
                    </li>
                    <li class="category_item">
                        <a class="category_link" href="${contextPath }/starcategory/starcategory_detail.do?cate_m=주식">
                            <img src="${contextPath }/resources/image/category/4-1/develocket_spaceman-stock.png">
                            <!-- <span class="category_text">주식</span> -->
                        </a>
                    </li>
                    <li class="category_item">
                        <a class="category_link" href="${contextPath }/starcategory/starcategory_detail.do?cate_m=스포츠">
                            <img src="${contextPath }/resources/image/category/4-1/develocket_spaceman-sport.png">
                            <!-- <span class="category_text">스포츠</span> -->
                        </a>
                    </li>
                    <li class="category_item">
                        <a class="category_link" href="${contextPath }/starcategory/starcategory_detail.do?cate_m=미술">
                            <img src="${contextPath }/resources/image/category/4-1/develocket_spaceman-picture.png">
                            <!-- <span class="category_text">미술</span> -->
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