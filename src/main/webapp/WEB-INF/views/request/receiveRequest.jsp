<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" /> 
<c:set var="popupRequestVO" value="${popupRequestVO }" />
<c:set var="requestVO" value="${requestVO }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>요청서</title>

	<link href='${contextPath }/resources/receive/receive/receivebootstrap.min.css' rel='stylesheet'>
	<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js' rel='stylesheet'>
	<link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css' rel='stylesheet'>
	<script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
	<link rel="stylesheet" href="${contextPath }/resources/receive/receive/receivestyle.css">

	<script type="text/javascript">

		function fn_agree() {
			if (!checkPrice(form.price.value)) {
				return;
            }
			else {
				$('#form').submit();
			}
		}
		
		function fn_refuse() {
			$('#form').attr("action", "${contextPath }/request/refuseContract.do")
			$('#form').submit();
		}
		
		function checkExistData(value, dataName) {
            if (value == "") {
                alert(dataName + " 입력해주세요!");
                return false;
            }
			else {
				return true;
			}

        }
		
		function checkPrice(price) {
            if (!checkExistData(price, "금액을")) {
				return false;
			}
            else {
				return true;
			}
        }
	</script>
</head>
<body class="receiveBody">
<form action="${contextPath }/request/agreeRequest.do" method="post" id="form" name="form">
	<div class="container d-flex justify-content-center align-items-center height">
		<div class="card py-3 card1" style="height: 600px;">
			<div class="p-3 px-4 py-2">
				<span class="font-weight-normal quote">
					<div style="display: block;">
						<c:choose>
							<c:when test="${popupRequestVO.profile_img != null }">
								<img src="${contextPath }/rocketInfo/download.do?imageFileName=${popupRequestVO.profile_img}&rocket_cd=${popupRequestVO.rocket_cd}" alt="로켓 프로필 사진" class="profile-photo-lg">
							</c:when>
							<c:otherwise>
								<img src="${contextPath}/resources/image/common/develocket_spaceman.png" alt="로켓 프로필 사진" class="profile-photo-lg">
							</c:otherwise>
						</c:choose>
						<input type="text" class="mb-2 rocketName" value="${popupRequestVO.name} 님의 요청입니다" disabled/>
					</div>

					<div style="display: block; font-size: 13px; font-weight: 600; text-align: center;">
						${popupRequestVO.cate_l } ${popupRequestVO.cate_m } ${popupRequestVO.cate_s }
					</div>
					<p align="center">요청을 확인하고 견적서를 작성해주세요</p>
				</span>
				<span class="font-weight-normal quote">
                    <b>기간</b>
                </span>
				<input type="text" class="form-control mb-2" value="${popupRequestVO.period_a }"  disabled/>
				<span class="font-weight-normal quote">
                    <b>레벨</b>
                </span>
				<input type="text" class="form-control mb-2" value="${popupRequestVO.level_a }" disabled/>
				<span class="font-weight-normal quote">
                    <b>횟수</b>
                </span>
				<input type="text" class="form-control mb-2" value="${popupRequestVO.times_a }" disabled/>
				<span class="font-weight-normal quote">
                    <b>요청사항</b>
                </span>
				<div class="form">
					<textarea class="form-control mb-3 description-area" disabled>${popupRequestVO.add_comments_a }</textarea>
				</div>
				<!-- <div class="text-center" style="height: 46px; font-size: 14px;">

                </div> -->
			</div>
			<c:choose>
				<c:when test="${popupRequestVO.status_info == '1' }">
					<div style="display: block; width: 200%; padding-bottom: 200px;" align="center">
						<div class="text-center" style="z-index: 1; position: relative;">
							<button class="btns btn-danger send" type="button" onclick="fn_agree()">승낙</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button class="btns btn-reject send" type="button" onclick="fn_refuse()">거절</button>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div style="display: block; width: 200%; padding-bottom: 200px;" align="center">
						<div class="text-center" style="z-index: 1; position: relative;">
							<span>답변을 완료한 글입니다.</span>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="card py-3 card2" style="height: 600px; ">
			<input type="hidden" name="contract_cd" value="${popupRequestVO.contract_cd }">
			<input type="hidden" name="survey_cd" value="${popupRequestVO.survey_cd }">
			<div class="p-3 d-flex align-items-center justify-content-center p-3s">

				<h5><b>스타 견적서</b></h5>

			</div>
			<p align="center" style="font-size: small;">승낙하실 경우 견적서를 작성후<br>승낙버튼을 클릭해주세요</p>
			<c:choose>
				<c:when test="${popupRequestVO.status_info == '1' }">
					<div class="p-3 px-4 py-2 ">
								<span class="font-weight-normal quote">
									<b>견적금액</b>
								</span>
						<input type="text" name="price" id="" class="form-control mb-2" placeholder="견적 금액을 작성해주세요" title="예) 00,000원"/>
						<span class="font-weight-normal quote">
									<b>견적안내</b>
								</span>
						<div class="form">
							<textarea name="estimate_comments" class="form-control mb-3 description-area" placeholder="견적 안내사항을 작성해주세요"></textarea>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="p-3 px-4 py-2 ">
								<span class="font-weight-normal quote">
									<b>견적금액</b>
								</span>
						<input type="text" name="price" class="form-control mb-2" value="${requestVO.price }원" disabled/>
						<span class="font-weight-normal quote">
									<b>견적안내</b>
								</span>
						<div class="form">
							<textarea name="estimate_comments" class="form-control mb-3 description-area" disabled>${requestVO.estimate_comments }</textarea>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</form>
</body>
</html>