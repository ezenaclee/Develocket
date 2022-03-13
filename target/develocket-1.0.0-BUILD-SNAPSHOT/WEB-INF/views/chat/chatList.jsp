<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" />
<c:set var="rocketChatVOList" value="${rocketChatVOList }" />
<c:set var="starChatVOList" value="${starChatVOList }" />
<c:set var="isStarChat" value="${isStarChat }" />
<c:set var="rocket_cd" value="${rocket_cd }" />
<c:set var="star_cd" value="${star_cd }" />
<c:set var="view_check_all_rocket" value="${view_check_all_rocket }" />
<c:set var="view_check_all_star" value="${view_check_all_star }" />
<!DOCTYPE html>
<html class="receiveList">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>채팅리스트</title>

	<script src="${contextPath}/resources/chat/chatList/jquery-1.10.2.min.js"></script>
	<link href="${contextPath}/resources/chat/chatList/bootstrap.min.css" rel="stylesheet">
	<script src="${contextPath}/resources/chat/chatList/bootstrap.min.js"></script>
	<link rel="stylesheet" href="${contextPath}/resources/chat/button/normalize.min.css">
	<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Raleway:900'>
	
	<script type="text/javascript">

		window.onload = function() {

			function isEmpty(el){
				return !$.trim(el.html())
			}

			var isStarChat = '${isStarChat}';
			if (isStarChat == 'no') {
				if (isEmpty($('#rocket_all_section'))) {

					var innerHtml = '<div class="nearby-user"><div class="row"><div class="col-md-2 col-sm-2"></div><div class="col-md-7 col-sm-7" style="text-align: center;"><h5 class="profile-link"><b>오픈된 채팅방이 없습니다</b></h5><p>스타에게 견적을 요청해보세요!</p></div><div class="col-md-3 col-sm-3"><button class="btn btn-primary pull-right" onclick="location.href=' + '\'${contextPath }/starcategory/starcategory_IT.do\'' + '">견적 요청하기</button></div></div></div>';

					$('#rocket_all_section').append(innerHtml);
				}
			}
			else {
				if (isEmpty($('#star_all_section'))) {
					var innerHtml = '<div class="nearby-user"><div class="row"><div class="col-md-2 col-sm-2"></div><div class="col-md-7 col-sm-7" style="text-align: center;"><h5 class="profile-link"><b>개설된 채팅이 없습니다</b></h5><p>스타프로필을 수정하여 재능을 어필하세요!</p></div></div></div>';

					$('#star_all_section').append(innerHtml);
				}
			}
		}

		function fn_openChatRoom(contract_cd, user_cd, view_check, isStarChat) {
			var url = "${contextPath}/chat/chatRoom.do?contract_cd=" + contract_cd + "&user_cd=" + user_cd  + "&view_check=" + view_check + "&isStarChat=" + isStarChat;
            var name = "견적 보기";
            var option = "width = 800, height = 720, top = 100, left = 200, location = no";
            
            window.open(url, name, option);
            
            location.reload(true);
		}
	
		function fn_moveChat(check) {

			location.href = "${contextPath }/chat/chatList.do?isStarChat=" + check;
		}

		function fn_invisibleEnd(_contract_cd, _hide_check) {
			$.ajax({
				type: "post",
				async: false,
				url: "http://localhost:8080/develocket/request/makeInvisibleEnd.do",
				dataType: "text",
				data: {contract_cd: _contract_cd, hide_check: _hide_check},
				success: function(result, textStatus) {
					alert("채팅방을 나갔습니다.");
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

		function fn_readAll(_isStar) {
			$.ajax({
				type: "post",
				async: false,
				url: "http://localhost:8080/develocket/chat/readAll.do",
				dataType: "text",
				data: {isStar: _isStar},
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
<body class="buttons1">
<div class="container">
	<div class="row">
		<!-- 최상단 화면(고정) -->
		<c:choose>
			<c:when test="${isStarChat == 'no' }">
				<div style="display: block; padding: 30px 20px; width: 100%; border-bottom: 1px solid #f1f2f2">
					<h2 style="font-size: 3rem; font-weight: 700;">로켓 채팅 리스트</h2>
					<h5 style="color: darkgrey; padding-left: 7px;">로켓 또는 스타의 채팅 내역을 선택해주세요</h5>
				</div>
			</c:when>
			<c:otherwise>
				<div style="display: block; padding: 30px 20px; width: 100%; border-bottom: 1px solid #f1f2f2">
					<h2 style="font-size: 3rem; font-weight: 700;">스타 채팅 리스트</h2>
					<h5 style="color: darkgrey; padding-left: 7px;">로켓 또는 스타의 채팅 내역을 선택해주세요</h5>
				</div>
			</c:otherwise>
		</c:choose>
		<div align="center" class="buttons2">
			<c:choose>
				<c:when test="${isStarChat == 'no' }">
					<input type="radio" id="rocket" name="selectChat" value="rocket" onclick="fn_moveChat('no')" checked>
					<input type="radio" id="star" name="selectChat" value="star" onclick="fn_moveChat('yes')">
				</c:when>
				<c:otherwise>
					<input type="radio" id="rocket" name="selectChat" value="rocket" onclick="fn_moveChat('no')">
					<input type="radio" id="star" name="selectChat" value="star" onclick="fn_moveChat('yes')" checked>
				</c:otherwise>
			</c:choose>
			<div>
				SELECT CHAT
			</div>
			<div>
				<label for="rocket">🚀</label>
				<label for="star">⭐️</label>
			</div>
		</div>
		<c:choose>
			<c:when test="${isStarChat == 'no' }">
				<c:if test="${view_check_all_rocket == '0' }">
					<div style="display: block; width: 15%; padding-top: 40px;">
						<button class="btn btn-primary btn-out pull-right" type="button" onclick="fn_readAll('no')">
							모두 읽기
						</button>
					</div>
				</c:if>
				<div class="col-md-8">
					<div id="rocket_all_section" class="people-nearby">
						<c:choose>
							<c:when test="${not empty rocketChatVOList && rocketChatVOList != null }">
								<c:forEach var="rocketChatVO" items="${rocketChatVOList }">
									<c:if test="${not empty rocketChatVO }">
										<div class="nearby-user">
											<div class="row">
												<div class="col-md-2 col-sm-2" onclick="fn_openChatRoom('${rocketChatVO.contract_cd}','${rocket_cd}r', '${rocketChatVO.view_check}', '${isStarChat }')">
													<c:choose>
														<c:when test="${not empty rocketChatVO.profile_img and rocketChatVO.profile_img != null}">
															<img src="${contextPath }/starField/download.do?imageFileName=${rocketChatVO.profile_img}&star_field_cd=${rocketChatVO.star_field_cd}" alt="user" class="profile-photo-lg">
														</c:when>
														<c:otherwise>
															<img src="${contextPath}/resources/image/common/develocket_spaceman.png" alt="user" class="profile-photo-lg">
														</c:otherwise>
													</c:choose>
												</div>
												<div class="col-md-7 col-sm-7" onclick="fn_openChatRoom('${rocketChatVO.contract_cd}','${rocket_cd}r', '${rocketChatVO.view_check}', '${isStarChat }')">
													<h5>
														<a class="profile-link">${rocketChatVO.star_nickname }님</a>
														<c:if test="${rocketChatVO.status_info == '3' and rocketChatVO.view_check == '0' }">
															<span style="color: red">
																new
															</span>
														</c:if>
													</h5>
													<p>${rocketChatVO.cate_l } ${rocketChatVO.cate_m } ${rocketChatVO.cate_s }</p>
													<p class="text-muted">
														<c:choose>
															<c:when test="${rocketChatVO.status_info == '5' }">
																리뷰작성을 완료하였습니다.
															</c:when>
															<c:when test="${rocketChatVO.status_info == '6' }">
																거래가 종료되었습니다.
															</c:when>
															<c:otherwise>
																${rocketChatVO.message }
															</c:otherwise>
														</c:choose>
													</p>
												</div>
												<div class="col-md-3 col-sm-3">
													<c:if test="${rocketChatVO.status_info == '6' }">
														<button class="btn btn-primary btn-out pull-right" onclick="fn_invisibleEnd('${rocketChatVO.contract_cd}', 'c')">
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
											<h5 class="profile-link"><b>오픈된 채팅방이 없습니다</b></h5>
											<p>스타에게 견적을 요청해보세요!</p>
										</div>
										<div class="col-md-3 col-sm-3">
											<button class="btn btn-primary pull-right" onclick="location.href='${contextPath}/starcategory/starcategory_IT.do'">견적 요청하기</button>
										</div>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<c:if test="${view_check_all_star == '0' }">
					<div style="display: block; width: 15%; padding-top: 40px;">
						<button class="btn btn-primary btn-out pull-right" type="button" onclick="fn_readAll('yes')">
							모두 읽기
						</button>
					</div>
				</c:if>
				<div class="col-md-8">
					<div id="star_all_section" class="people-nearby">
						<c:choose>
							<c:when test="${star_cd == '0' }">
								<div class="nearby-user">
									<div class="row">
										<div class="col-md-2 col-sm-2"></div>
										<div class="col-md-7 col-sm-7" style="text-align: center;">
											<h5 class="profile-link"><b>스타만 사용 가능합니다</b></h5>
											<p>스타가 되어 재능을 나눠보세요!</p>

										</div>
										<div class="col-md-3 col-sm-3">
											<button class="btn btn-primary pull-right" onclick="location.href='${contextPath }/starInfo/joinStarForm.do'">
												스타 등록하기
											</button>
										</div>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${not empty starChatVOList && starChatVOList != null }">
										<c:forEach var="starChatVO" items="${starChatVOList }">
											<c:if test="${not empty starChatVO }">
												<div class="nearby-user" onclick="fn_openChatRoom('${starChatVO.contract_cd}','${star_cd}s', '${starChatVO.view_check}', 'yes')">
													<div class="row">
														<div class="col-md-2 col-sm-2">
															<c:choose>
																<c:when test="${not empty starChatVO.profile_img and starChatVO.profile_img != null}">
																	<img src="${contextPath }/rocketInfo/download.do?imageFileName=${starChatVO.profile_img}&rocket_cd=${starChatVO.rocket_cd}" alt="user" class="profile-photo-lg">
																</c:when>
																<c:otherwise>
																	<img src="${contextPath}/resources/image/common/develocket_spaceman.png" alt="user" class="profile-photo-lg">
																</c:otherwise>
															</c:choose>
														</div>
														<div class="col-md-7 col-sm-7">
															<h5>
																<a class="profile-link">${starChatVO.name } 님</a>
																<c:if test="${starChatVO.status_info == '3' and starChatVO.view_check == '0' }">
																	<span style="color: red">
																		new
																	</span>
																</c:if>
															</h5>
															<p>${starChatVO.cate_l } ${starChatVO.cate_m } ${starChatVO.cate_s }</p>
															<p class="text-muted">
																<c:choose>
																	<c:when test="${starChatVO.status_info == '5' }">
																		리뷰작성을 완료하였습니다.
																	</c:when>
																	<c:when test="${starChatVO.status_info == '6' }">
																		거래가 종료되었습니다.
																	</c:when>
																	<c:otherwise>
																		${starChatVO.message }
																		<%-- 빨간색 글씨를 위한 조건이었던거 같음 --%>
																		<%--<c:choose>
																			<c:when test="${starChatVO.view_check == '0' or starChatVO.view_check == '1r'}">
																				${starChatVO.message }
																			</c:when>
																			<c:otherwise>
																				${starChatVO.message }
																			</c:otherwise>
																		</c:choose>--%>
																	</c:otherwise>
																</c:choose>
															</p>
														</div>
														<div class="col-md-3 col-sm-3">
															<c:if test="${starChatVO.status_info == '6' }">
																<button class="btn btn-primary btn-out pull-right" onclick="fn_invisibleEnd('${starChatVO.contract_cd}', 'd')">
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
													<h5 class="profile-link"><b>개설된 채팅이 없습니다</b></h5>
													<p>스타프로필을 수정하여 재능을 어필하세요!</p>
												</div>
											</div>
										</div>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<link rel="stylesheet" href="${contextPath}/resources/chat/chatList/style.css">
<link rel="stylesheet" href="${contextPath}/resources/chat/button/style.css">
<script type="text/javascript">

</script>
</body>
</html>