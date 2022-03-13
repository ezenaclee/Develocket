<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" />
<c:set var="inquiryList" value="${inquiryMap.inquiryList }" />
<c:set var="totalInquiry" value="${inquiryMap.totalInquiry }" />
<c:set var="section" value="${inquiryMap.section }" />
<c:set var="pageNum" value="${inquiryMap.pageNum }" />
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<title>1:1 문의 게시판</title>

	<link href='${contextPath}/resources/inquiry/inquiryList/inquiryList_bootstrap.min.css' rel='stylesheet'>
	<link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css' rel='stylesheet'>
	<script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
	<link rel="stylesheet" href="${contextPath}/resources/inquiry/inquiryList/inquiryList_style.css">
	<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>
	<link rel="stylesheet" href="${contextPath}/resources/inquiry/inquiryList/pagingCSS/style.css">

	<script type="text/javascript">
		function fn_inquiryForm(isLogOn, inquiryForm, loginForm) {
			if (isLogOn != '' && isLogOn != 'false') {
				location.href = inquiryForm;
			}
			else {
				alert("로그인 후 글쓰기가 가능합니다.");
				// 로그인이 완료되면 action에 지정한 inquiryForm으로 이동함
				location.href = loginForm + '?action=/inquiry/inquiryForm.do';
			}
		}

		function fn_funfun() {

		}

	</script>

</head>
<body oncontextmenu='return false' class='snippet-body'>
	<div class="container mb-5 mt-5" align="center">
		<div class="card">
			<div class="row">
				<div class="col-md-12">
					<h3 class="text-center mb-5s"> <b>1:1 문의</b> </h3>
					<div style="display: block; height: 50px; width: 100%; padding: 6px 0px; margin-bottom: 20px;">
						<button onclick="fn_inquiryForm('${isLogOn}','${contextPath}/inquiry/inquiryForm.do','${contextPath}/rocketInfo/loginForm.do')"
								style="float: right;" class="btns" >문의등록</button>
					</div>
					<hr>
					<div class="row">
						<div class="col-md-12">
							<c:choose>
								<c:when test="${empty inquiryList }">
									<div class="media">
										<div class="media-bodys">
											<div class="row">
												<div style="width: 100%; margin-top: 7px;" align="center">
													<h5>등록된 글이 없습니다.</h5>
												</div>
											</div>
											<hr>
										</div>
									</div>
								</c:when>
								<c:when test="${not empty inquiryList }">
									<c:forEach var="inquiryVO" items="${inquiryList }" varStatus="inquiryNum">
										<c:choose>
											<c:when test="${inquiryVO.level > 1 }">
												<div class="media mt-3" onclick="location.href='${contextPath}/inquiry/inquiryVeiw.do?inquiry_cd=${inquiryVO.inquiry_cd}'">
													<c:forEach begin="2" end="${inquiryVO.level }" step="1">
														<span style="padding-left: 60px"></span>
													</c:forEach>
													<a href="#" >
														<c:choose>
															<c:when test="${not empty inquiryVO.profile_img and inquiryVO.profile_img != null}">
																<img class="mr-3 rounded-circle" alt="Bootstrap Media Preview" src="${contextPath }/rocketInfo/download.do?imageFileName=${inquiryVO.profile_img}&rocket_cd=${inquiryVO.rocket_cd}" />
															</c:when>
															<c:otherwise>
																<img class="mr-3 rounded-circle" alt="Bootstrap Media Preview" src="${contextPath}/resources/image/common/develocket_spaceman.png" />
															</c:otherwise>
														</c:choose>
													</a>
													<div onclick="fn_funfun()" class="media-body">
														<div class="row">
															<div class="col-8 d-flex">
																<h5>${inquiryVO.id }</h5> &nbsp;&nbsp; <span>[${inquiryVO.write_date }]</span>
															</div>
														</div>
														<p align="left">${inquiryVO.inquiry_title}</p>
													</div>
												</div>
												<hr>
											</c:when>
											<c:otherwise>
												<div class="media mt-3" onclick="location.href='${contextPath}/inquiry/inquiryVeiw.do?inquiry_cd=${inquiryVO.inquiry_cd}'">
													<a href="#" >
														<c:choose>
															<c:when test="${not empty inquiryVO.profile_img and inquiryVO.profile_img != null}">
																<img class="mr-3 rounded-circle" alt="Bootstrap Media Preview" src="${contextPath }/rocketInfo/download.do?imageFileName=${inquiryVO.profile_img}&rocket_cd=${inquiryVO.rocket_cd}" />
															</c:when>
															<c:otherwise>
																<img class="mr-3 rounded-circle" alt="Bootstrap Media Preview" src="${contextPath}/resources/image/common/develocket_spaceman.png" />
															</c:otherwise>
														</c:choose>
													</a>
													<div class="media-body">
														<div class="row">
															<div class="col-8 d-flex">
																<h5>${inquiryVO.id }</h5> &nbsp;&nbsp; <span>[${inquiryVO.write_date }]</span>
															</div>
														</div>
														<p align="left">${inquiryVO.inquiry_title}</p>
													</div>
												</div>
												<hr>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:when>
							</c:choose>
							<hr>



							<div class="paging" style="display: block; width: 100%;" align="center">
								<ul class="pagination modal-2">
									<c:if test="${totalInquiry != 0 && totalInquiry != null }">
										<c:choose>
											<c:when test="${totalInquiry > 100 }">		<!-- 글개수가 100개 초과인 경우 -->
												<c:forEach var="page" begin="1" end="10" step="1" >
													<c:if test="${section > 1 && page == 1 }">
														<li><a class="prev" href="${contextPath}/inquiry/inquiryList.do?section=${section - 1}&pageNum=${(section - 1) * 10 + 1}">&laquo</a></li>
													</c:if>

													<li><a href="${contextPath}/inquiry/inquiryList.do?section=${section}&pageNum=${page}">${(section - 1) * 10 + page }</a></li>>

													<c:if test="${page == 10 }">
														<li><a class="next" href="${contextPath}/inquiry/inquiryList.do?section=${section + 1}&pageNum=${section * 10 + 1}">&raquo;</a></li>
													</c:if>
												</c:forEach>
											</c:when>
											<c:when test="${totalInquiry == 100 }">		<!-- 등록된 글개수가 100개인 경우 -->
												<c:forEach var="page" begin="1" end="10" step="1" >
													<li><a href="${contextPath}/inquiry/inquiryList.do?section=${section}&pageNum=${page}">${page }</a></li>
												</c:forEach>
											</c:when>
											<c:when test="${totalInquiry < 100 }">
												<c:forEach var="page" begin="1" end="${totalInquiry / 10 + 1 }" step="1" >
													<c:choose>
														<c:when test="${page == pageNum }">
															<li><a class="active" href="${contextPath}/inquiry/inquiryList.do?section=${section}&pageNum=${page}">${page }</a></li>
														</c:when>
														<c:otherwise>
															<li><a class="no-uline" href="${contextPath}/inquiry/inquiryList.do?section=${section}&pageNum=${page}">${page }</a></li>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</c:when>
										</c:choose>
									</c:if>
								</ul>
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