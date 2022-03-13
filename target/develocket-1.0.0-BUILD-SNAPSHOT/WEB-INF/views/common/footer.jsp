<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
</head>
<body>
<div class="container">
	<div class="footer" align="left" style="height: 150px;">
		<div style="display: inline-block;">
			<a class="footer-brand pull-left" href="${contextPath }/">
				<img src="${contextPath}/resources/image/common/develocketlogo-text.png" alt="logo">
			</a>
			<p  style="margin-top: 60px; margin-left: 0px;">
				Copyright &copy; 2022 Develocket
			</p>
		</div>
		<div class="pull-right" style="display: inline-block; ">
			<div class="foot_ul" style="display: block; float: left; ">
				<ul style="list-style: none;">
					<li>
						<b style="font-weight: 700; font-size:15px; color:black; margin-bottom: 10px;">Develocket 소개</b>
					</li>
					<li>
						<a href="${contextPath }/board/intro.do">회사소개</a>
					</li>

				</ul>
			</div>
			<div class="foot_ul" style="display: block; float: right;">
				<ul style="list-style: none;">
					<li>
						<b style="font-weight: 700; font-size:15px; color:black; margin-bottom: 10px;">고객센터</b>
					</li>
					<li>
						<a href="${contextPath }/notice/noticeList.do">공지사항</a>
					</li>
					<li>
						<a href="${contextPath }/faq/faqList.do">자주묻는질문</a>
					</li>
					<li>
						<a href="${contextPath }/board/useGuide.do">이용안내</a>
					</li>
					<li>
						<a href="${contextPath }/inquiry/inquiryList.do">1:1 문의</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>

</body>
</html>