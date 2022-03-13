<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }"/>
<c:set var="starFieldVO" value="${starFieldMap.starFieldVO }"/>
<c:set var="imageFileList" value="${starFieldMap.imageFileList }"/>
<c:set var="starInfoVO" value="${starFieldMap.starInfoVO }"/>
<c:set var="categoryVO" value="${starFieldMap.categoryVO }"/>
<c:set var="reviewVOList" value="${starFieldMap.reviewVOList }"/>
<c:set var="qna1" value="${qna1 }" />
<c:set var="qna2" value="${qna2 }" />
<c:set var="qna3" value="${qna3 }" />
<c:set var="qna4" value="${qna4 }" />
<c:set var="average_rating" value="${average_rating }" />
<c:set var="count" value="${count }" />
<c:set var="owner_rocket_cd" value="${rocket_cd }"/>
<c:set var="login_rocket_cd" value="${rocketInfoVO.rocket_cd }"/>
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

    <!-- jQeury -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script type="text/javascript">

        window.onload = function () {
            fn_moreReview();
        }

        function scrollMasterInfo(id) {
            const topValue = document
                .getElementById(id)
                .offsetTop;
            window.scroll(0, topValue + 30);
        }

        $(document).ready(function () {

            var topBar = $("#profile-bar").offset();

            $(window).scroll(function () {

                var docScrollY = $(document).scrollTop()
                var barThis = $("#profile-bar")
                var contentThis = $("#profile_content")

                if (docScrollY > topBar.top) {
                    barThis.addClass("profile_bar_fix");
                    contentThis.addClass("pd_top");
                } else {
                    barThis.removeClass("profile_bar_fix");
                    contentThis.removeClass("pd_top");
                }

            });

        })

        function fn_moveLogin() {
            alert("로그인이 필요합니다.");

            $("#starFieldForm").attr("action", "${contextPath }/rocketInfo/loginForm.do?action=/starField/starFieldView.do");
            $("#starFieldForm").submit();
        }

        function fn_sendEstimate() {
            alert("설문지로 이동합니다");

            $("#starFieldForm").attr("method", "post");
            $("#starFieldForm").attr("action", "${contextPath }/survey/surveyView.do");
            $("#starFieldForm").submit();
        }

        var begin_num = 0;
        var end_num = 0;
        function fn_moreReview() {

            var size = ${fn:length(reviewVOList)};
            end_num += 3;

            if (end_num >= size) {
                end_num = size;
                $('#moreReview_btn').empty();
            }

            for (var i = begin_num; i < end_num; i++) {
                $('.reviewVO' + i).css("display", "block");
            }
            begin_num = end_num;
        }

    </script>
    <!-- Custom styles for this template -->
    <link href="${contextPath}/resources/css/starField/starfield.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="container">

    <div class="mainheading">
        <h1 class="sitetitle">PROFILE</h1>
        <div class="profile-card">
            <header>
                <a>
                    <c:choose>
                        <c:when test="${not empty starFieldVO.profile_img and starFieldVO.profile_img != null }">
                            <img id="profile-img" src="${contextPath }/starField/download.do?imageFileName=${starFieldVO.profile_img}&star_field_cd=${starFieldVO.star_field_cd}">
                        </c:when>
                        <c:otherwise>
                            <img id="profile-img" src="${contextPath}/resources/image/common/develocket_spaceman.png">
                        </c:otherwise>
                    </c:choose>
                </a>
                <h1>스타닉네임 : ${starInfoVO.star_nickname}</h1>
                <h2>분야 : ${categoryVO.cate_l} ${categoryVO.cate_m} ${categoryVO.cate_s}</h2>
            </header>
            <div class="profile-bio">
                <p>${starFieldVO.short_intro}</p>
            </div>

        </div>
    </div>

    <!-- End Site Title ================================================== -->

    <!-- Begin Featured ================================================== -->
    <section class="featured-posts">
        <div class="section-title prfile" id="profile-bar">
            <!-- <h2> <span>ETC</span></h2> -->
            <form id="starFieldForm" action="${contextPath }/starField/starFieldModify.do" method="post">
                <input type="hidden" name="star_field_cd" value="${starFieldVO.star_field_cd }">
                <input type="hidden" name="star_cd" value="${starFieldVO.star_cd }">
                <input type="hidden" name="cate_cd" value="${starFieldVO.cate_cd }">
                <input type="hidden" name="profile_img" value="${starFieldVO.profile_img }">
                <input type="hidden" name="short_intro" value="${starFieldVO.short_intro }">
                <input type="hidden" name="detail_intro" value="${starFieldVO.detail_intro }">
                <input type="hidden" name="career" value="${starFieldVO.career }">
                <input type="hidden" name="business_img" value="${starFieldVO.business_img }">
                <input type="hidden" name="qna" value="${starFieldVO.qna }">
                <input type="hidden" name="imageFileList" value="${imageFileList }">
                <h2>
	                    <span>
	                        <ul class="profile-links">
                                <li>
                                    <a id="btn1" onclick="scrollMasterInfo('star_information')">
                                        information
                                    </a>
                                </li>

                                <li>
                                    <a id="btn2" onclick="scrollMasterInfo('star_picture')">
                                        picture
                                    </a>

                                </li>

                                <li>
                                    <a id="btn3" onclick="scrollMasterInfo('star_question')">
                                        question
                                    </a>

                                </li>
                                <li>
                                    <a id="btn4" onclick="scrollMasterInfo('star_review')">
                                        review
                                    </a>
                                </li>
	                            <c:choose>
                                    <c:when test="${isLogOn != true || rocketInfoVO == null }">
                                        <a id="btn5" onclick="fn_moveLogin()">
                                            send
                                        </a>
                                        <%--<li>
                                            <input type="button" value="견적보내기" onclick="fn_moveLogin()">
                                        </li>--%>
                                    </c:when>
                                    <c:when test="${owner_rocket_cd != login_rocket_cd}">
                                        <a id="btn5" onclick="fn_sendEstimate()">
                                            send
                                        </a>
                                        <%--<li>
                                            <input type="button" value="견적보내기" onclick="fn_sendEstimate()">
                                        </li>--%>
                                    </c:when>
                                    <c:otherwise>
	                            		<li>
                                            <input id="btn6" style="cursor: pointer; background-color: transparent; border: 0px transparent solid; font-family: Righteous; font-weight: bold;" type="submit" value="modify">
			                            </li>
                                    </c:otherwise>
                                </c:choose>
	                        </ul>
	                    </span>
                </h2>
            </form>
        </div>
        <div class="content" id="profile_content">
            <div id="star_information">
                <div>
                    <h1>스타정보</h1>
                    <div class="inf_div">
                        <c:choose>
                            <c:when test="${not empty starFieldVO.detail_intro}">
                                <h2>${starFieldVO.detail_intro}</h2>
                            </c:when>
                            <c:otherwise>
                                <h2>작성된 글이 없습니다.</h2>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div>
                    <h1>경력</h1>
                    <div class="inf_div">
                        <c:choose>
                            <c:when test="${not empty starFieldVO.career}">
                                <h2>${starFieldVO.career}</h2>
                            </c:when>
                            <c:otherwise>
                                <h2>작성된 글이 없습니다.</h2>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div>
                    <h1>활동지역</h1><%-- 스타 활동지역이 바로 등록되도록 --%>
                    <div class="inf_div">
                        <h2>${starInfoVO.area}</h2>
                    </div>
                </div>
            </div>
            <div id="star_picture">
                <div>
                    <h1>자격증이미지</h1>
                    <div class="star_img">
                        <c:forEach var="careerImgVO" items="${imageFileList}">
                            <img src="${contextPath }/starField/download.do?imageFileName=${careerImgVO.imageFileName}&star_field_cd=${starFieldVO.star_field_cd}">
                        </c:forEach>
                    </div>
                    <h1>사업자등록증</h1>
                    <div class="star_img">
                        <c:choose>
                            <c:when test="${not empty starFieldVO.business_img and starFieldVO.business_img != null}">
                                <img src="${contextPath }/starField/download.do?imageFileName=${starFieldVO.business_img}&star_field_cd=${starFieldVO.star_field_cd}">
                            </c:when>
                            <c:otherwise>
                                <img id="profile-img" src="${contextPath}/resources/image/common/develocket_spaceman.png">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div id="star_question">
                <div>
                    <h1>질문답변</h1>
                    <c:if test="${not empty qna1 and qna1 != 'null' }">
                        <div class="question_div">
                            <h2>💬제공하는 서비스를 어떠한 절차로 전문적으로 진행하나요?</h2>
                            <div class="response_div">
                                <textarea rows="3" cols="65" id="input_box4" name="qna1" placeholder="한줄소개" readonly>${qna1 }</textarea>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${not empty qna2 and qna2 != 'null'}">
                        <div class="question_div">
                            <h2>💬서비스의 견적은 어떤 방식으로 산정 되나요?</h2>
                            <div class="response_div">
                                <textarea rows="3" cols="65" id="input_box5" name="qna2" placeholder="한줄소개" readonly>${qna2 }</textarea>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${not empty qna3 and qna3 != 'null' }">
                        <div class="question_div">
                            <h2>💬완료한 서비스 중 대표적인 서비스는 무엇인가요? 소요 시간은 얼마나 소요 되었나요?</h2>
                            <div class="response_div">
                                <textarea rows="3" cols="65" id="input_box6" name="qna3" placeholder="한줄소개" readonly>${qna3 }</textarea>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${not empty qna4 and qna4 != 'null'}">
                        <div class="question_div">
                            <h2>💬A/S 또는 환불 규정은 어떻게 되나요?</h2>
                            <div class="response_div">
                                <textarea rows="3" cols="65" id="input_box7" name="qna4" placeholder="한줄소개" readonly>${qna4 }</textarea>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
            <div id="star_review">
                <div>
                    <h1>스타리뷰</h1>
                </div>
                <div class="review_content1">
                    <c:choose>

                        <c:when test="${average_rating != 'NaN'}">
                            <span><i class="fa fa-star" aria-hidden="true"></i>${average_rating}</span>
                            <a>${count}개 리뷰</a>
                        </c:when>
                        <c:otherwise>
                            <span><i class="fa fa-star" aria-hidden="true"></i>0</span>
                            <a>리뷰글이 없습니다.</a>
                        </c:otherwise>
                    </c:choose>

                </div>
                <hr class="hr1">
                <div>
                    <c:choose>
                        <c:when test="${not empty reviewVOList and reviewVOList != null}">
                            <div class="review_content2">
                                <c:forEach var="i" begin="0" end="${fn:length(reviewVOList) - 1}" step="1">
                                    <div class="reviewVO${i}" style="display: none">
                                        <span><i class="fa fa-star" aria-hidden="true"></i> ${reviewVOList[i].rating}</span> ${reviewVOList[i].review_date}
                                    </div>
                                    <div class="reviewVO${i}" style="display: none">
                                            ${reviewVOList[i].review_content}
                                    </div>
                                    <hr class="reviewVO${i}" style="display: none; margin-bottom: 10px;">
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="inf_div">
                                작성된 리뷰가 없습니다.
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div id="moreReview_btn">
                        <c:choose>
                            <c:when test="${not empty reviewVOList and reviewVOList != null}">
                                <button id="reviewBtn" class="btn-pill text-white" type="button" onclick="fn_moreReview()">리뷰 더보기</button>
                            </c:when>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
</body>
</html>