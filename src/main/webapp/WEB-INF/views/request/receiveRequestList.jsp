<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="star_cd" value="${star_cd }" />
<c:set var="receiveRequestVOList" value="${receiveRequestVOList }" />
<c:set var="view_check_all" value="${view_check_all }" />
<!DOCTYPE html>
<html class="receiveList">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<script src="${contextPath}/resources/receive/receiveList/jquery-1.10.2.min.js"></script>
	<link href="${contextPath}/resources/receive/receiveList/bootstrap.min.css" rel="stylesheet">
	<script src="${contextPath}/resources/receive/receiveList/bootstrap.min.js"></script>
	<title>받은 요청</title>
	
	<script type="text/javascript">

		function isEmpty(el){
			return !$.trim(el.html())
		}
		
		window.onload = function() {
			if (isEmpty($('#all_section'))) {
				var innerHtml = '<div class="nearby-user"><div class="row"><div class="col-md-2 col-sm-2"></div><div class="col-md-7 col-sm-7" style="text-align: center;"><h5 class="profile-link"><b>받은 요청서가 없습니다</b></h5><p>스타프로필을 수정하여 매력을 어필하세요!</p></div></div></div>';

				$('#all_section').append(innerHtml);
			}
		}
		
	
		function fn_popup(contract_cd, status_info, view_check) {
			
			var url = "${contextPath}/request/receiveRequest.do?contract_cd=" + contract_cd + "&status_info=" + status_info + "&view_check=" + view_check;
            var name = "견적 보기";
            var option = "width = 800, height = 500, top = 100, left = 200, location = no";

            
            window.open(url, name, option);

			document.location.reload();
		}
		
		
		function fn_invisibleRefuse(_contract_cd) {
			$.ajax({
				type: "post",
				async: false,
				url: "http://221.148.239.155:8080/develocket/request/makeInvisibleRefuse.do",
				dataType: "text",
				data: {contract_cd: _contract_cd, status_info: "-2"},
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
				url: "http://221.148.239.155:8080/develocket/request/makeInvisibleEnd.do",
				dataType: "text",
				data: {contract_cd: _contract_cd, hide_check: "b"},
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

			var _star_cd = '${star_cd}';

			$.ajax({
				type: "post",
				async: false,
				url: "http://221.148.239.155:8080/develocket/request/readAll.do",
				dataType: "text",
				data: {star_cd: _star_cd},
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
		
	</script>
</head>
<body>
<div class="container">

	<div class="row">
		<!-- 최상단 화면(고정) -->
		<div style="display: block; padding: 30px 20px; width: 80%;">
			<h2 style="font-size: 3.5rem; font-weight: 700;">받은 요청</h2>
			<h5 style="color: darkgrey; padding-left: 7px;">로켓이 보낸 요청서입니다.</h5>
		</div>

		<div style="display: block; width: 20%; padding-top: 80px;">
			<c:if test="${view_check_all == '0'}">
				<button class="btn btn-primary btn-out pull-right" onclick="fn_readAll()">모두 읽기</button>
			</c:if>
		</div>

		<!-- 요청 들어온 경우 화면 -->
		<div class="col-md-8 divS">
			<div id="all_section" class="people-nearby">
				<c:choose>
					<c:when test="${star_cd == '0' }">
						<div class="nearby-user">
							<div class="row">
								<div class="col-md-2 col-sm-2"></div>
								<div class="col-md-7 col-sm-7" style="text-align: center;">
									<h5 class="profile-link"><b>스타만 사용가능합니다.</b></h5>
									<p>스타가 되어 재능을 나눠보세요!</p>

								</div>
								<div class="col-md-3 col-sm-3">
									<button class="btn btn-primary pull-right" onclick="location.href='${contextPath }/starInfo/joinStarForm.do'">스타 등록하기</button>
								</div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${not empty receiveRequestVOList && receiveRequestVOList != null }">
								<c:forEach var="receiveRequestVO" items="${receiveRequestVOList }" >
									<c:if test="${receiveRequestVO.status_info >= 0 or receiveRequestVO.status_info == '-1' }">

										<div class="nearby-user">
											<div class="row">
												<div class="col-md-2 col-sm-2">
													<c:choose>
														<c:when test="${receiveRequestVO.profile_img != null }">
															<img src="${contextPath }/rocketInfo/download.do?imageFileName=${receiveRequestVO.profile_img}&rocket_cd=${receiveRequestVO.rocket_cd}" alt="로켓프로필사진" class="profile-photo-lg imgs">
														</c:when>
														<c:otherwise>
															<img src="${contextPath}/resources/image/common/develocket_spaceman.png" alt="기본 강스타 사진" class="profile-photo-lg imgs">
														</c:otherwise>
													</c:choose>
												</div>
												<div class="col-md-7 col-sm-7">
													<h5>
														<a class="profile-link">${receiveRequestVO.name}</a>
														<c:if test="${(receiveRequestVO.status_info == '1' or receiveRequestVO.status_info == '0') and receiveRequestVO.view_check == '0' }">
															<span style="color: red">
																new
															</span>
														</c:if>
													</h5>
													<p>${receiveRequestVO.cate_l } ${receiveRequestVO.cate_m } ${receiveRequestVO.cate_s }</p>
													<c:choose>
														<c:when test="${receiveRequestVO.status_info == '1' }">
															<p class="text-muted">요청현황 : 로켓으로부터 요청이 왔습니다.</p>
														</c:when>
														<c:when test="${receiveRequestVO.status_info == '2' }">
															<p class="text-muted">요청현황 : 답변완료</p>
														</c:when>
														<c:when test="${receiveRequestVO.status_info >= 3 }">
															<c:choose>
																<c:when test="${receiveRequestVO.status_info == '6' }">
																	<p class="text-muted">요청현황 : 거래가 종료되었습니다.</p>
																</c:when>
																<c:otherwise>
																	<p class="text-muted">요청현황 : 채팅방이 오픈되었습니다.</p>
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:when test="${receiveRequestVO.status_info == '0' or receiveRequestVO.status_info == '-1' }">
															<p class="text-muted">요청현황 : 거래가 불발되었습니다.</p>
														</c:when>
													</c:choose>

												</div>
												<div class="col-md-3 col-sm-3">
													<button class="btn btn-primary pull-rights" onclick="fn_popup('${receiveRequestVO.contract_cd}', '${receiveRequestVO.status_info }', '${receiveRequestVO.view_check }')">요청서 보기</button>
													<c:if test="${receiveRequestVO.status_info == '-1' or receiveRequestVO.status_info == '0' }">
														<button class="btn btn-primary btn-out pull-right" onclick="fn_invisibleRefuse('${receiveRequestVO.contract_cd}')" >
															나가기
														</button>
													</c:if>
													<c:if test="${receiveRequestVO.status_info == '6' }">
														<button class="btn btn-primary btn-out pull-right" onclick="fn_invisibleEnd('${receiveRequestVO.contract_cd}')" >
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
											<h5 class="profile-link"><b>받은 요청서가 없습니다</b></h5>
											<p>스타프로필을 수정하여 매력을 어필하세요!</p>
										</div>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
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