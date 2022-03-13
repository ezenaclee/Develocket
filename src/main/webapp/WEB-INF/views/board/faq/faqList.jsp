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
	
	<link href='${contextPath }/resources/board/faqList/faqList_bootstrap.min.css' rel='stylesheet'>
	<link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css' rel='stylesheet'>
	<script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
	<link rel="stylesheet" href="${contextPath }/resources/board/faqList/faqList_style.css">
	<script src="https://kit.fontawesome.com/d3a24d5be2.js" ></script>	
</head>
<body oncontextmenu='return false' class='snippet-body'>
    <div class="container mb-5 mt-5">
        <div class="card">
            <div class="row">
                <div class="col-md-12">
                    <h3 class="text-center mb-5s"> <b>자주 묻는 질문</b> </h3>
                    <div style="text-align: center; display: block; height: 50px; width: 100%; padding: 6px 0px; margin-bottom: 20px;">
                        궁금하신 내용을 한 번에 확인하세요
                    </div>
                    <hr>

                    <div class="row">
                        <div class="col-md-12">

                            <div class="media mt-3" onclick="location.href='${contextPath}/faq/faqView1.do'">
                                <a href="#" >
                                    <span style="height: 60px; font-size: 25px; color: #F34F30; margin-right: 30px; text-align: center;"><i class="fa-solid fa-f"></i><i class="fa-solid fa-a"></i><i class="fa-solid fa-q"></i></span>
                                </a>
                                <div class="media-body">                                
                                    <p style="font-size: 30px; font-weight: 700;">아이디/비밀번호가 기억나지 않아요</p>
                                </div>
                            </div><hr>

                            <div class="media mt-3" onclick="location.href='${contextPath}/faq/faqView2.do'">
                                <a href="#" >
                                    <span style="height: 60px; font-size: 25px; color: #F34F30; margin-right: 30px;"><i class="fa-solid fa-f"></i><i class="fa-solid fa-a"></i><i class="fa-solid fa-q"></i></span>                            </a>
                                <div class="media-body">                                
                                    <p style="font-size: 30px; font-weight: 700;">로켓/스타와 어떻게 거래하나요?</p>
                                </div>
                            </div><hr>

                            <div class="media mt-3" onclick="location.href='${contextPath}/faq/faqView3.do'">
                                <a href="#" >
                                    <span style="height: 60px; font-size: 25px; color: #F34F30; margin-right: 30px;"><i class="fa-solid fa-f"></i><i class="fa-solid fa-a"></i><i class="fa-solid fa-q"></i></span>                            </a>
                                <div class="media-body">                                
                                    <p style="font-size: 30px; font-weight: 700;">견적은 어떻게 보내나요?</p>
                                </div>
                            </div><hr>

                            <div class="media mt-3" onclick="location.href='${contextPath}/faq/faqView4.do'">
                                <a href="#" >
                                    <span style="height: 60px; font-size: 25px; color: #F34F30; margin-right: 30px;"><i class="fa-solid fa-f"></i><i class="fa-solid fa-a"></i><i class="fa-solid fa-q"></i></span>                            </a>
                                <div class="media-body">                                
                                    <p style="font-size: 30px; font-weight: 700;">요청서는 무엇인가요? 작성은 어떻게 하나요?</p>
                                </div>
                            </div><hr>

                            <div class="media mt-3" onclick="location.href='${contextPath}/faq/faqView5.do'">
                                <a href="#" >
                                    <span style="height: 60px; font-size: 25px; color: #F34F30; margin-right: 30px;"><i class="fa-solid fa-f"></i><i class="fa-solid fa-a"></i><i class="fa-solid fa-q"></i></span>                            </a>
                                <div class="media-body">                                
                                    <p style="font-size: 30px; font-weight: 700;">스타에게 리뷰는 어떻게 남기나요?</p>
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