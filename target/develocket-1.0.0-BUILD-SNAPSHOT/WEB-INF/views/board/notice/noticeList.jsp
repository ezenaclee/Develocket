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
	<title>공지사항 목록</title>
	
	<link href='${contextPath }/resources/board/notice/noticeList/noticeList_style.css' rel='stylesheet'>
	<link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css' rel='stylesheet'>
	<script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
	<link rel="stylesheet" href="${contextPath }/resources/board/notice/noticeList/noticeList_style.css">
	<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>	
</head>
<body oncontextmenu='return false' class='snippet-body'>
    <div class="container mb-5 mt-5">
        <div class="card">
            <div class="row">
                <div class="col-md-12">
                    <h3 class="text-center mb-5s"> <b>공지사항</b> </h3>
                    <div style="text-align: center; display: block; height: 50px; width: 100%; padding: 6px 0px; margin-bottom: 20px;">
                        공지사항을 전해드립니다
                    </div>
                    <hr>

                    <div class="row">
                        <div class="col-md-12">

                            <div class="media mt-3" onclick="location.href='${contextPath }/notice/noticeView1.do'">
                                <a href="#" >
                                    <img class="mr-3 rounded-circle" style="border: 1px solid rgba(226, 226, 226, 0.664);" alt="Bootstrap Media Preview" src="${contextPath }/resources/image/common/mainLogo.png" />
                                </a>
                                <div class="media-body">
                                    <div class="row">
                                        <div class="col-8 d-flex">
                                            <h5>관리자</h5> &nbsp;  &nbsp;<span>[2022-02-25]</span>
                                        </div>                                  
                                    </div> 
                                    <p style="font-size: 24px; font-weight: 700;">프로필 내 개인정보 작성 기준 안내</p>
                                </div>
                            </div><hr>

                            <div class="media mt-3" onclick="location.href='${contextPath }/notice/noticeView2.do'">
                                <a href="#" >
                                    <img class="mr-3 rounded-circle" style="border: 1px solid rgba(226, 226, 226, 0.664);" alt="Bootstrap Media Preview" src="${contextPath }/resources/image/common/mainLogo.png" />
                                </a>
                                <div class="media-body">
                                    <div class="row">
                                        <div class="col-8 d-flex">
                                            <h5>관리자</h5> &nbsp;  &nbsp;<span>[2022-02-25]</span>
                                        </div>                                  
                                    </div> 
                                    <p style="font-size: 24px; font-weight: 700;">삼일절 고객센터 휴무안내</p>
                                </div>
                            </div><hr>

                            <div class="media mt-3" onclick="location.href='${contextPath }/notice/noticeView3.do'">
                                <a href="#" >
                                    <img class="mr-3 rounded-circle" style="border: 1px solid rgba(226, 226, 226, 0.664);" alt="Bootstrap Media Preview" src="${contextPath }/resources/image/common/mainLogo.png" />
                                </a>
                                <div class="media-body">
                                    <div class="row">
                                        <div class="col-8 d-flex">
                                            <h5>관리자</h5> &nbsp;  &nbsp;<span>[2022-02-25]</span>
                                        </div>                                  
                                    </div> 
                                    <p style="font-size: 24px; font-weight: 700;">디벨로켓 긴급 점검 안내</p>
                                </div>
                            </div><hr>

                            <div class="media mt-3" onclick="location.href='${contextPath }/notice/noticeView4.do'">
                                <a href="#" >
                                    <img class="mr-3 rounded-circle" style="border: 1px solid rgba(226, 226, 226, 0.664);" alt="Bootstrap Media Preview" src="${contextPath }/resources/image/common/mainLogo.png" />
                                </a>
                                <div class="media-body">
                                    <div class="row">
                                        <div class="col-8 d-flex">
                                            <h5>관리자</h5> &nbsp;  &nbsp;<span>[2022-02-25]</span>
                                        </div>                                  
                                    </div> 
                                    <p style="font-size: 24px; font-weight: 700;">허위 리뷰 작성 및 리뷰 조작 모니터링 강화</p>
                                </div>
                            </div><hr>

                            <div style="width: 100%; padding-bottom: 20px;">
                                <button style="float: right;" class="btns" onclick="location.href='${contextPath}/'">홈페이지 가기</button>		
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type='text/javascript' src=''></script>
    <script type='text/javascript' src=''></script>
    <script type='text/Javascript'></script>
</body>
</html>