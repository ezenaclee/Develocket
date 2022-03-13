<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="${contextPath }/resources/rocketInfo/searchIDPasswordForm/style.css">

	<title>아이디 비밀번호 찾기</title>

	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

	<script type="text/javascript">

		/* 이메일 */
		function fn_sendEmail() {

			var email = $("#email").val();

			$.ajax({
				type:"post",
				async: false,
				url:"http://localhost:8080/develocket/rocketInfo/searchID.do",
				dataType: "text",
				data: {email: email},
				success:function(result){
					if(result == "null"){
						alert("이메일을 다시 확인해주세요.");

					} else {
						alert("아이디가 이메일로 전송되었습니다.");
						location.href="http://localhost:8080/develocket/email/send_id";
					}
				},
				error: function(data, textStatus) {
					alert("에러가 발생했습니다.");
				},
				complete: function(data, textStatus) {
					//
				}
			});
		}


		// 비밀번호 찾기
		function fn_findPwd() {
			var email = $("#email2").val();
			var id = $("#id").val();

			$.ajax({
				type:"post",
				async: false,
				url:"http://localhost:8080/develocket/rocketInfo/updatePassword.do",
				data: {"email" : email, "id" : id},
				dataType: "text",
				success:function(result) {
					if(result == "0"){
						alert("아이디와 이메일을 다시 확인해주세요.");

					} else {
						alert("임시 비밀번호가 이메일로 전송되었습니다.");
						location.href="http://localhost:8080/develocket/email/send_pwd";
					}
				},
				error: function(data, textStatus) {
					alert("에러" + data, textStatus);

				},
				complete: function(data, textStatus) {
					//
				}
			});
		}

	</script>
</head>
<body>
<!-- partial:index.partial.html -->
<div class="form_wrapper">
	<div class="form_container">
		<div class="title_container">
			<h2>아이디를 잊으셨나요?</h2>
			<small>회원가입에 사용한 이메일을 입력해주세요 <br>
				아이디를 이메일로 전송해드립니다
			</small>
		</div>
		<div class="row clearfix" >
			<div class="">
				<form name="find_id" method="post" style="width: 100%;">
					<div class="input_field"> <span><i aria-hidden="true" class="fa fa-envelope"></i></span>
						<input type="email" name="email" id="email" placeholder="example@decelocket.com" required />
					</div>
					<div class="input_field">
						<input class="button" type="submit" onclick="fn_sendEmail()" value="아이디 찾기" />
					</div>
					<br>
					<br>
					<br>

				</form>

				<form  name="find_pwd" method="post">

					<div class="title_container2" >
						<h2>비밀번호를 잊으셨나요?</h2>
						<small>회원가입에 사용한 아이디와 이메일을 입력해주세요<br>
							비밀번호를 이메일로 전송해드립니다
						</small>
					</div>
					<div class="input_field"> <span><i aria-hidden="true" class="fa-solid fa-circle-info"></i></span>
						<input type="text" name="id" id="id" placeholder="아이디" required />
					</div>
					<div class="input_field"> <span><i aria-hidden="true" class="fa fa-envelope"></i></span>
						<input type="email" name="email2" id="email2" placeholder="example@decelocket.com" required />
					</div>
					<div class="input_field">
						<input class="button" type="submit" onclick="fn_findPwd()" value="비밀번호 찾기" />
					</div>

				</form>

			</div>
		</div>
	</div>
</div>

<!-- partial -->
<script src="https://kit.fontawesome.com/d3a24d5be2.js" crossorigin="anonymous"></script>
</body>
</html>