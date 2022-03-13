<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
%>

<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" />
<c:set var="rocket_cd" value="${rocket_cd }" />
<c:set var="star_field_cd" value="${star_field_cd }" />
<c:set var="contract_cd" value="${contract_cd }" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<title>리뷰작성</title>

	<link href='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css' rel='stylesheet'>
	<link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css' rel='stylesheet'>
	<script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
	<link rel="stylesheet" href="${contextPath }/resources/review/reviewForm/style.css">


	<script>
		function fn_touch(count) {
			$("#rating").attr("value",count);
		}

		function fn_send() {
			$("#form").submit();
		}
	</script>

</head>
<body oncontextmenu='return false' class='snippet-body'>

<form action="${contextPath }/review/joinReview.do" id="form" method="post">
	<input type="hidden" value="0" id="rating" name="rating">
	<input type="hidden" name="rocket_cd" value="${rocket_cd }">
	<input type="hidden" name="star_field_cd" value="${star_field_cd }">
	<input type="hidden" name="contract_cd" value="${contract_cd }">
	<div class="card">
		<div class="row">
			<div class="col-2">
				<img src="${contextPath }/resources/image/common/mainLogo2.png" alt="스타프로필사진" width="70" class="rounded-circle mt-2">
				<input type="text" value="스타" style="width: 160%; text-align: center; font-size: 14px; font-weight: bold; border: none;">
			</div>
			<div class="col-10">
				<div class="comment-box ml-2">
					<h5 style="font-weight: bold;">리뷰를 작성해주세요</h5>

					<div class="rating">
						<input type="radio" id="5" onclick="fn_touch('5')"><label for="5">☆</label>
						<input type="radio" id="4" onclick="fn_touch('4')"><label for="4">☆</label>
						<input type="radio" id="3" onclick="fn_touch('3')"><label for="3">☆</label>
						<input type="radio" id="2" onclick="fn_touch('2')"><label for="2">☆</label>
						<input type="radio" id="1" onclick="fn_touch('1')"><label for="1">☆</label>
					</div>
					<div class="comment-area"> <textarea class="form-control" name="review_content" placeholder="소중한 리뷰는 큰 힘이 됩니다" rows="4"></textarea> </div>
					<div class="comment-btns mt-2">
						<div class="row">
							<div class="col-6">
								<div class="pull-left"> <button class="btn btn-success btn-sm">취소</button> </div>
							</div>
							<div class="col-6">
								<div class="pull-right">
									<button class="btn btn-success send btn-sm" onclick="fn_send()" >등록 <i class="fa fa-long-arrow-right ml-1"></i></button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</form>

<%-- <script type='text/javascript' src='${contextPath }/resources/reviewForm/bootstrap.bundle.min.js'></script> --%>
<script type='text/javascript' src='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js'></script>
<script type='text/javascript' src=''></script>
<script type='text/javascript' src=''></script>
<script type='text/Javascript'></script>

</body>
</html>