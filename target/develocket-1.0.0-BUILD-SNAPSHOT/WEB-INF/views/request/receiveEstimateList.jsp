<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" /> 
<c:set var="receiveEstimateVOList" value="${receiveEstimateVOList }" />
<c:set var="view_check_all" value="${view_check_all }" />
<!DOCTYPE html>
<html class="receiveList">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<script src="${contextPath}/resources/receive/receiveList/jquery-1.10.2.min.js"></script>
	<link href="${contextPath}/resources/receive/receiveList/bootstrap.min.css" rel="stylesheet">
	<script src="${contextPath}/resources/receive/receiveList/bootstrap.min.js"></script>
	<title>받은 견적</title>
	
	<style type="text/css">
		div {
			display: block;
		}
	</style>
	
	<script type="text/javascript">

		function isEmpty(el){
			return !$.trim(el.html())
		}

		window.onload = function() {
			if (isEmpty($('#all_section'))) {

				var innerHtml = '<div class="nearby-user"><div class="row"><div class="col-md-2 col-sm-2"></div><div class="col-md-7 col-sm-7" style="text-align: center;"><h5 class="profile-link"><b>보낸 요청서가 없습니다</b></h5><p>요청서를 작성하시고 스타에게 견적을 받아보세요!</p></div></div></div>';

				$('#all_section').append(innerHtml);
			}
		}
		
		function fn_popup(contract_cd, status_info, view_check) {
			var url = "${contextPath}/request/receiveEstimate.do?contract_cd=" + contract_cd + "&status_info=" + status_info + "&view_check=" + view_check;
            var name = "견적 보기";
            var option = "width = 800, height = 500, top = 100, left = 200, location = no";
            
            window.open(url, name, option);

			document.location.reload();
		}
		
		function fn_invisibleRefuse(_contract_cd) {
			$.ajax({
				type: "post",
				async: false,
				url: "http://localhost:8080/develocket/request/makeInvisibleRefuse.do",
				dataType: "text",
				data: {contract_cd: _contract_cd, status_info: "-1"},
				success: function(result, textStatus) {
					alert("나가기를 완료했습니다.");
					document.location.reload();
					
				},
				error: function(data, textStatus) {
					alert("오류가 발생했습니다. 다시 시도해주세요!")
				},
				complete: function(data, textStatus) {
					//
				}
			});
		}

		function fn_invisibleEnd(_contract_cd) {
			$.ajax({
				type: "post",
				async: false,
				url: "http://localhost:8080/develocket/request/makeInvisibleEnd.do",
				dataType: "text",
				data: {contract_cd: _contract_cd, hide_check: "a"},
				success: function(result, textStatus) {
					alert("나가기를 완료했습니다.");
					document.location.reload();

				},
				error: function(data, textStatus) {
					alert("오류가 발생했습니다. 다시 시도해주세요!")
				},
				complete: function(data, textStatus) {
					//
				}
			});
		}

		function fn_readAll() {
			$.ajax({
				type: "post",
				async: false,
				url: "http://localhost:8080/develocket/request/readAll.do",
				dataType: "text",
				data: {star_cd: "r"},
				success: function(result, textStatus) {
					alert("모두 읽기를 완료했습니다.");
					document.location.reload();

				},
				error: function(data, textStatus) {
					alert("오류가 발생했습니다. 다시 시도해주세요!")
				},
				complete: function(data, textStatus) {
					//
				}
			});
		}

		function fn_survey() {
			location.href = "${contextPath}/starcategory/starcategory_IT.do"
		}
	</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div style="display: block; padding: 30px 20px; width: 80%;">
				<h2 style="font-size: 3.5rem; font-weight: 700;">받은 견적</h2>
				<h5 style="color: darkgrey; padding-left: 7px;">스타가 보낸 견적서 입니다.</h5>
			</div>
			<div style="display: block; width: 20%; padding-top: 80px;">
				<c:if test="${view_check_all == '0'}">
					<button class="btn btn-primary btn-out pull-right" onclick="fn_readAll()">모두 읽기</button>
				</c:if>
			</div>
			<div class="col-md-8 divS">
				<div id="all_section" class="people-nearby">
					<c:choose>
						<c:when test="${not empty receiveEstimateVOList && receiveEstimateVOList != null }">
							<c:forEach var="receiveEstimateVO" items="${receiveEstimateVOList }">
								<c:if test="${receiveEstimateVO.status_info >= 0 or receiveEstimateVO.status_info == '-2' }">
									<div class="nearby-user">
										<div class="row">
											<div class="col-md-2 col-sm-2">
												<c:choose>
													<c:when test="${receiveEstimateVO.profile_img != null }">
														<img onclick="location.href='${contextPath }/starField/starFieldView.do?star_field_cd=${receiveEstimateVO.star_field_cd}';"  alt="스타프로필사진" class="profile-photo-lg imgs"
															 src="${contextPath }/starField/download.do?imageFileName=${receiveEstimateVO.profile_img}&star_field_cd=${receiveEstimateVO.star_field_cd}">
													</c:when>
													<c:otherwise>
														<img onclick="location.href='${contextPath }/starField/starFieldView.do?star_field_cd=${receiveEstimateVO.star_field_cd}';"
															 src="${contextPath}/resources/image/common/develocket_spaceman.png" alt="기본 강스타 사진" class="profile-photo-lg imgs">
													</c:otherwise>
												</c:choose>
											</div>
											<div class="col-md-7 col-sm-7">
												<h5>
													<a href="#" class="profile-link">${receiveEstimateVO.star_nickname}</a>
													<c:if test="${receiveEstimateVO.status_info == '2' && receiveEstimateVO.view_check == '0' }">
														<span style="color: red">
															new
														</span>
													</c:if>
												</h5>
												<p>${receiveEstimateVO.cate_l } ${receiveEstimateVO.cate_m } ${receiveEstimateVO.cate_s }</p>
												<c:choose>
													<c:when test="${receiveEstimateVO.status_info == '1' }">
														<p class="text-muted">
															견적현황 : 스타님이 검토중입니다.
														</p>
													</c:when>
													<c:when test="${receiveEstimateVO.status_info == '2' }">
														<p class="text-muted">
															견적현황 : 견적이 도착했습니다.
														</p>
													</c:when>
													<c:when test="${receiveEstimateVO.status_info >= 3 }">
														<c:choose>
															<c:when test="${receiveEstimateVO.status_info == '6' }">
																<p class="text-muted">
																	견적현황 : 거래가 종료되었습니다.
																</p>
															</c:when>
															<c:otherwise>
																<p class="text-muted">
																	견적현황 : 채팅방이 오픈되었습니다.
																</p>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:when test="${receiveEstimateVO.status_info == '0' or receiveEstimateVO.status_info == '-2' }">
														<p class="text-muted">
															견적현황 : 거래가 불발되었습니다.
														</p>
													</c:when>
												</c:choose>
											</div>
											<div class="col-md-3 col-sm-3">
												<c:choose>
													<c:when test="${receiveEstimateVO.status_info == '1' }">
														<button class="btn btn-primary pull-right" disabled>견적서 보기</button>
													</c:when>
													<c:otherwise>
														<button class="btn btn-primary pull-right" onclick="fn_popup('${receiveEstimateVO.contract_cd}', '${receiveEstimateVO.status_info }', '${receiveEstimateVO.view_check }')">견적서 보기</button>
													</c:otherwise>
												</c:choose>
												<c:if test="${receiveEstimateVO.status_info == '-2' or receiveEstimateVO.status_info == '0' }">
													<button class="btn btn-primary btn-out pull-right" onclick="fn_invisibleRefuse('${receiveEstimateVO.contract_cd}')" >
														나가기
													</button>
												</c:if>
												<c:if test="${receiveEstimateVO.contract_cd}">
													<button class="btn btn-primary btn-out pull-right" onclick="fn_invisibleEnd('${receiveEstimateVO.contract_cd}')" >
														나가기
													</button>
												</c:if>
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="nearby-user">
								<div class="row">
									<div class="col-md-2 col-sm-2"></div>
									<div class="col-md-7 col-sm-7" style="text-align: center;">
										<h5 class="profile-link"><b>보낸 요청서가 없습니다</b></h5>
										<p>요청서를 작성하시고 스타에게 견적을 받아보세요!</p>
									</div>
									<div class="col-md-3 col-sm-3">
										<button class="btn btn-primary pull-right" onclick="fn_survey()">스타 목록 보러 가기</button>
									</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
<link rel="stylesheet" href="${contextPath}/resources/receive/receiveList/style.css">

<script type="text/javascript">

</script>
</body>
</html>