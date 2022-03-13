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
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	
	<title>공지사항</title>
	
	<style type="text/css">
		.faq .imag {
			width: 66%;
		}
		
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
<body class="faq">
	
	<div align="center" style="margin-top: 30px; ">
		<img class="imag" alt="이미지" src="${contextPath}/resources/board/notice/image/notice/notice2/notice2.png">		
	</div>
	<div style="width: 80%; padding-bottom: 20px;">
		<button style="float: right;" class="btns" onclick="location.href='${contextPath}/notice/noticeList.do'">목록 보기</button>		
	</div>
</body>
</html>