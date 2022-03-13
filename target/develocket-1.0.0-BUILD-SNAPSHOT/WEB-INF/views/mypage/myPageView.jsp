<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" />
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>마이페이지</title>

	<script src="${contextPath }/resources/myPage/myPageView/jquery-1.10.2.min.js"></script>
	<link href="${contextPath }/resources/myPage/myPageView/bootstrap.min.css" rel="stylesheet">
	<script src="${contextPath }/resources/myPage/myPageView/bootstrap.min.js"></script>
	<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Montserrat&amp;display=swap"rel="stylesheet'>
	<link href="${contextPath }/resources/myPage/myPageView/style.css" rel="stylesheet">
	
	<script type="text/javascript">
		function fn_modMemberInfo(check) {
            if (check == 'rocket') {
                location.href = "${contextPath}/mypage/recheckPassword.do?check=" + check;
            }
            else {
                $.ajax({
                    type    : "post",
                    async   : false,
                    url     : "http://localhost:8080/develocket/mypage/checkStarCD.do",
                    dataType: "text",
                    success : function (result, textStatus) {
                        if (result == "exist") {
                            location.href = "${contextPath}/mypage/recheckPassword.do?check=" + check;
                        }
                        else {
                            if (!confirm("등록된 스타 정보가 없습니다. 스타등록창으로 이동하시겠습니까?")) {

                            }
                            else {
                                location.href = "${contextPath }/starInfo/joinStarForm.do";
                            }
                        }

                    },
                    error   : function (data, textStatus) {
                        alert("스타정보 수정창으로 이동 중 오류가 발생했습니다.")
                    },
                    complete: function (data, textStatus) {}
                });
            }
		}
	</script>
</head>
<body>
<script src="https://kit.fontawesome.com/d3a24d5be2.js"></script>
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.1/css/all.min.css'>
<div class="containers profile myPage">
	<c:choose>
		<c:when test="${isLogOn == true && rocketInfoVO != null }">
		<div class="row">
			<div class="col-md-12">
				<div class="well well-small clearfix">
					<div class="row">
						<div class="col-md-2">
							<c:choose>
								<c:when test="${not empty rocketInfoVO.profile_img and rocketInfoVO.profile_img != null }">
									<a href="#">
										<img class="img-polaroid img-responsive" src="${contextPath }/rocketInfo/download.do?imageFileName=${rocketInfoVO.profile_img}&rocket_cd=${rocketInfoVO.rocket_cd}"  alt="프로필사진" />
									</a>
								</c:when>
								<c:otherwise>
									<a href="#">
										<img class="img-polaroid img-responsive" src="${contextPath}/resources/image/common/develocket_spaceman.png"  alt="프로필사진" />
									</a>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="col-md-4">
							<h2><input type="text" style="border: none;" value="${mypageVO.name}" disabled></h2>
							<ul class="list-unstyled">
								<li><i class="fa-solid fa-mobile-screen-button"></i> <input type="text" style="border: none;" value="${mypageVO.id}" disabled></li>
								<li><i class="fa-solid fa-mobile-screen-button"></i> <input type="text" style="border: none;" value="${mypageVO.phone_number}" disabled></li>
								<li><i class="fa-solid fa-envelope"></i> <input type="text" style="border: none;" value="${mypageVO.email}" disabled></li>
							</ul>
						</div>
						<div class="col-md-6">
							<ul class="list-inline stats" style="float: right;">
								<li>
									<span>
										<div class="btn-container">
											<c:choose>
												<c:when test="${rocketInfoVO.password == 'Naver'}">
													<button onclick="location.href='${contextPath}/mypage/modMemberInfo.do'">
														<span class="text" style="font-size: 15px;">
															로켓정보수정
														</span>
														<div class="icon-container">
															<div class="icon icon--left">
																<svg>
																	<use xlink:href="#arrow-right"></use>
																</svg>
															</div>
															<div class="icon icon--right">
																<svg>
																	<use xlink:href="#arrow-right"></use>
																</svg>
															</div>
														</div>
													</button>
												</c:when>
												<c:otherwise>
													<button onclick="fn_modMemberInfo('rocket')">
														<span class="text" style="font-size: 15px;">
															로켓정보수정
														</span>
														<div class="icon-container">
															<div class="icon icon--left">
																<svg>
																	<use xlink:href="#arrow-right"></use>
																</svg>
															</div>
															<div class="icon icon--right">
																<svg>
																	<use xlink:href="#arrow-right"></use>
																</svg>
															</div>
														</div>
													</button>
												</c:otherwise>
											</c:choose>
									    </div>
								    </span>
								</li>
									<div style="padding: 7px;"></div>
								<li>
									<span>
										<div class="btn-container">
											<c:choose>
												<c:when test="${rocketInfoVO.password == 'Naver'}">
													<button onclick="location.href='${contextPath}/mypage/modStarInfoForm.do'">
														<span class="text" style="font-size: 15px;">
															스타정보수정
														</span>
														<div class="icon-container">
															<div class="icon icon--left">
																<svg>
																	<use xlink:href="#arrow-right"></use>
																</svg>
															</div>
															<div class="icon icon--right">
																<svg>
																	<use xlink:href="#arrow-right"></use>
																</svg>
															</div>
														</div>
													</button>
												</c:when>
												<c:otherwise>
													<button onclick="fn_modMemberInfo('star')">
														<span class="text" style="font-size: 15px;">
															스타정보수정
														</span>
														<div class="icon-container">
															<div class="icon icon--left">
																<svg>
																	<use xlink:href="#arrow-right"></use>
																</svg>
															</div>
															<div class="icon icon--right">
																<svg>
																	<use xlink:href="#arrow-right"></use>
																</svg>
															</div>
														</div>
													</button>
												</c:otherwise>
											</c:choose>
										</div>
									</span>
								</li>
							</ul>
						</div><!--/span6-->
					</div><!--/row-->
				</div>
				<!--Body content-->
			</div>
		</div>
</div>
		</c:when>
		<c:otherwise>
			<script>
				alert("로그인이 필요합니다. 로그인창으로 이동합니다.");
				self.close();
				parent.location.replace("${contextPath }/rocketInfo/loginForm.do");
			</script>
		</c:otherwise>
	</c:choose>



<svg style="display: none;">
	<symbol id="arrow-right" viewBox="0 0 20 10">
		<path d="M14.84 0l-1.08 1.06 3.3 3.2H0v1.49h17.05l-3.3 3.2L14.84 10 20 5l-5.16-5z"></path>
	</symbol>
</svg>
<script type="text/javascript">


</script>
<!-- partial -->
<script src='https://cdnjs.cloudflare.com/ajax/libs/gsap/3.1.1/gsap.min.js'></script>
</body>
</html>