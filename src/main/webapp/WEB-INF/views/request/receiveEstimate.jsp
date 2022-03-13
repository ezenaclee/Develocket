<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" /> 
<c:set var="estimateVO" value="${estimateVO }" />  
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>견적서</title>

	<link href='${contextPath }/resources/receive/receive/receivebootstrap.min.css' rel='stylesheet'>
	<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js' rel='stylesheet'>
	<link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css' rel='stylesheet'>
	<script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
	<link rel="stylesheet" href="${contextPath }/resources/receive/receive/receivestyle.css">

	<script type="text/javascript">
		function fn_refuse() {
			$('#form').attr("action", "${contextPath }/request/refuseContract.do")
			$('#form').submit();
		}
	</script>
</head>
<body class="receiveBody">
<form action="${contextPath }/request/agreeEstimate.do" method="post" id="form" name="form">
	<div class="container d-flex justify-content-center align-items-center height">
		<div class="card py-3 card1" style="height: 600px;">
			<div class="p-3 px-4 py-2">
				<div class="p-3 d-flex align-items-center justify-content-center p-3s">
					<h5><b>나의 요청서</b></h5>
				</div>

				<span class="font-weight-normal quote">
	                    <b>기간</b>
	                </span>
				<input type="text" class="form-control mb-2" value="${estimateVO.period_a }"  disabled/>
				<span class="font-weight-normal quote">
	                    <b>레벨</b>
	                </span>
				<input type="text" class="form-control mb-2" value="${estimateVO.level_a }" disabled/>
				<span class="font-weight-normal quote">
	                    <b>횟수</b>
	                </span>
				<input type="text" class="form-control mb-2" value="${estimateVO.times_a }" disabled/>
				<span class="font-weight-normal quote">
	                    <b>요청사항</b>
	                </span>
				<div class="form">
					<textarea class="form-control mb-3 description-area" disabled>${estimateVO.add_comments_a }</textarea>
				</div>
			</div>
			<input type="hidden" name="contract_cd" value="${estimateVO.contract_cd }">
			<c:choose>
				<c:when test="${estimateVO.status_info >= 3 }">
					<div style="display: block; width: 200%; padding-bottom: 200px;" align="center">
						<div class="text-center" style="z-index: 1; position: relative;">
							<span>채팅방이 오픈되었습니다</span>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div style="display: block; width: 200%; padding-bottom: 200px;" align="center">
						<div class="text-center" style="z-index: 1; position: relative;">
							<button class="btns btn-danger send" type="submit">수락</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button class="btns btn-reject send" onclick="fn_refuse()">거절</button>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="card py-3 card2" style="height: 600px; ">
			<c:choose>
				<c:when test="${estimateVO.profile_img != null }">
		                <span class="font-weight-normal quote">
		                    <div style="display: block;">
		                        <img src="${contextPath }/starField/download.do?imageFileName=${estimateVO.profile_img}&star_field_cd=${estimateVO.star_field_cd}" alt="로켓 프로필 사진" class="profile-photo-lg">
		                        <input type="text" class="mb-2 rocketName" value="${estimateVO.star_nickname } 님의 견적입니다" disabled/>
		                    </div>
							<br>
							<br>
							<br>
		                    <div style="display: block; font-size: 13px; font-weight: 600; text-align: center;">
		                        ${estimateVO.cate_l } ${estimateVO.cate_m } ${estimateVO.cate_s }
		                    </div>
							<br>
		                    <p align="center">견적서를 확인하고 진행여부를 선택해주세요</p>
		                </span>
				</c:when>
				<c:otherwise>
                	<span class="font-weight-normal quote">
	                    <div style="display: block;">
	                        <img src="${contextPath }/resources/image/common/kangstar.jpg" alt="로켓 프로필 사진" class="profile-photo-lg">
	                        <input type="text" class="mb-2 rocketName" value="${estimateVO.star_nickname } 님의 견적입니다" disabled/>
	                    </div>
						<br>
						<br>
						<br>
	                    <div style="display: block; font-size: 13px; font-weight: 600; text-align: center;">
	                        ${estimateVO.cate_l } ${estimateVO.cate_m } ${estimateVO.cate_s }
	                    </div>
						<br>
	                    <p align="center">견적서를 확인하고 진행여부를 선택해주세요</p>
	                </span>
				</c:otherwise>
			</c:choose>
			<p align="center" style="font-size: small;">수락하실 경우 견적서를 작성후<br>수락버튼을 클릭해주세요</p>
			<div class="p-3 px-4 py-2 ">
	                <span class="font-weight-normal quote">
	                    <b>견적금액</b>
	                </span>
				<input type="text" name="price" id="" class="form-control mb-2" value="${estimateVO.price }" disabled/>
				<span class="font-weight-normal quote">
	                    <b>견적안내</b>
	                </span>
				<div class="form">
					<textarea name="estimate_comments" class="form-control mb-3 description-area" disabled>${estimateVO.estimate_comments }</textarea>
				</div>
			</div>
		</div>
	</div>
</form>
</body>
</html>