<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("utf-8"); %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }"/>
<c:set var="check" value="${check }"/>
<!DOCTYPE html>
<html class="recheckPW">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>비밀번호 재확인</title>

	<link rel="stylesheet" href="${contextPath}/resources/myPage/recheckPassword/style.css">

	<script type="text/javascript">

	</script>
</head>
<body>
<form action="${contextPath }/mypage/rechkPwd.do" method="post" onsubmit="return rechk()">
	<c:choose>
		<c:when test="${isLogOn == true && rocketInfoVO != null }">
			<div class="form_wrapper">
				<div class="form_container">
					<div class="title_container">
						<h1>비밀번호 재확인</h1>
						<small>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한 번 확인합니다<br>
							비밀번호는 다른 사람에게 노출되지 않도록 주의해주시길 바랍니다
						</small>
					</div>
					<div class="row clearfix">
						<div class="">
							<form style="width: 100%;">
								<div class="input_field"> <span><i aria-hidden="true" class="fa-solid fa-circle-info"></i></span>
									<input type="text" name="id" value="${mypageVO.id}" required disabled/>
								</div>
								<div class="input_field"> <span><i aria-hidden="true" class="fa fa-lock"></i></span>
									<input type="password" name="password" placeholder="현재 비밀번호를 입력해주세요" required autocomplete="off" />
									<input type="hidden" name="check" value="${check}">
								</div>
								<div class="input_field">
									<input class="button" type="submit" value="확인" />
								</div>

							</form>
						</div>
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
</form>
<!-- partial -->
<script src="https://kit.fontawesome.com/d3a24d5be2.js" crossorigin="anonymous"></script>

</body>
</html>