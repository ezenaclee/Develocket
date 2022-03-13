<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" />

<!DOCTYPE html>
<html class="loginFormHtml">
<head>
	<meta charset="UTF-8">

	<!-- Required meta tags -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">

	<link rel="stylesheet" href="${contextPath }/resources/rocketInfo/loginForm/fonts/icomoon/style.css">

	<link rel="styleshe;et" href="${contextPath }/resources/rocketInfo/loginForm/css/owl.carousel.min.css">

	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="${contextPath }/resources/rocketInfo/loginForm/css/bootstrap.min.css">

	<!-- Style -->
	<link rel="stylesheet" href="${contextPath }/resources/rocketInfo/loginForm/css/style.css">

	<title>로그인</title>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

	<c:choose>
		<c:when test="${param.result == 'loginFailed' }">
			<script type="text/javascript">
				window.onload = function() {
					alert("아이디나 비밀번호가 틀립니다. 다시 로그인 하세요!");
				}
			</script>
		</c:when>
	</c:choose>

	<script type="text/javascript">
		function fn_checkAll() {
			if (!checkID(form.id.value)) {
				return false;
			}
			else if (!checkPassword(form.password.value)) {
				return false;
			}

			return true;
		}


		function checkExistData(value, dataName) {
			if (value == "") {
				alert(dataName + " 입력해주세요!");
				return false;
			}
			return true;
		}

		function checkID(id) {
			if (!checkExistData(id, "아이디가 비어있습니다."))
				return false;

			return true;
		}

		function checkPassword(password) {
			if (!checkExistData(password, "비밀번호가 비어있습니다."))
				return false;

			return true;
		}

		function fn_update() {
			alert("추후 업데이트 예정입니다!")
		}

	</script>

</head>
<body>

<div class="content">
	<div class="container">
		<div class="row justify-content-center">
			<!-- <div class="col-md-6 order-md-2">
              <img src="images/undraw_file_sync_ot38.svg" alt="Image" class="img-fluid">
            </div> -->
			<div class="col-md-6 contents">
				<div class="row justify-content-center">
					<div class="col-md-12">
						<div class="form-block">
							<div class="mb-4">
								<h3>Login to <strong>Develocket</strong></h3>
								<p class="mb-4">Welcome Home!</p>
							</div>
							<form action="${contextPath }/rocketInfo/login.do" method="post" onsubmit="return fn_checkAll();" name="form">
								<div class="form-group first">
									<label for="username">Username</label>
									<input type="text" class="form-control" id="username" name="id">

								</div>
								<div class="form-group last mb-4">
									<label for="password">Password</label>
									<input type="password" class="form-control" id="password" name="password">

								</div>

								<div class="d-flex mb-5 align-items-center" style="text-align: center;">
									<span><a href="${contextPath }/rocketInfo/searchIDPasswordForm.do" class="forgot-pass">아이디/비밀번호 찾기</a></span>
									<span class="ml-auto"><a href="${contextPath }/rocketInfo/joinForm.do" class="forgot-pass">계정이 없으신가요?</a></span>
								</div>

								<input type="submit" value="Log In" class="btn btn-pill text-white btn-block btn-primary">

								<span class="d-block text-center my-4 text-muted"> or log in with</span>

								<div class="social-login text-center">
									<a href="${url}" class="facebook">
										<span class=" mr-3" style="font-size: 24px;"><b>N</b></span>
									</a>
									<a href="#" class="twitter" onclick="fn_update()">
										<span class=" mr-3" style="font-size: 24px;"><b>K</b></span>
									</a>

								</div>
							</form>
						</div>
					</div>
				</div>

			</div>

		</div>
	</div>
</div>


<script src="${contextPath }/resources/rocketInfo/loginForm/js/jquery-3.3.1.min.js"></script>
<script src="${contextPath }/resources/rocketInfo/loginForm/js/popper.min.js"></script>
<script src="${contextPath }/resources/rocketInfo/loginForm/js/bootstrap.min.js"></script>
<script src="${contextPath }/resources/rocketInfo/loginForm/js/main.js"></script>

</body>
</html>