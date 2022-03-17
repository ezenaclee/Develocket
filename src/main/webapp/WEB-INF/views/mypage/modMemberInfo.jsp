<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("utf-8"); %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }"/>
<c:set var="mypageVO" value="${mypageVO}" />
<c:set var="profile_img" value="${rocketInfoVO.profile_img}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>회원 정보 수정</title>

	<link href="${contextPath }/resources/myPage/modMemberInfo/modMemberInfo_bootstrap.min.css" rel="stylesheet">
	<script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/d3a24d5be2.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

	<script type="text/javascript">
		//Delete
		function fn_removeMember(url) {

			if (!confirm("계정을 삭제하시겠습니까?")) {

			} else {
				alert("그동안 디벨로켓을 이용해 주셔서 감사합니다.");
				location.href="${contextPath }/mypage/DeleteInfo.do";

			}

		}
		//Cancel
		function fn_backToMyPage(url) {
			if (!confirm("수정을 종료하시겠습니까?")) {

			} else {
				location.href="${contextPath }/mypage/myPageView.do";
			}
		}

		//ReCheckt Origin Password
		function fn_originpw(){
			var originPassword = $("#originPassword").val();

			if(originPassword == ""){
				alert("현재 비밀번호를 입력해주세요.");
				return false;
			}else {
				return true;
			}

		}

		//Check New Password
		function fn_checkpw(){

			var pw = $("#newPassword").val();
			var id = $("#rocket_id").val();
			var checkNumber = pw.search(/[0-9]/g);
			var checkEnglish = pw.search(/[a-z]/ig);

			var rocket_password = document.getElementById("originPassword");
			var newPassword = document.getElementById("newPassword");
			var RecheckNewPassword = document.getElementById("RecheckNewPassword");

			if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/.test(pw)){
				alert('비밀번호는 숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.');
				newPassword.value = null;
				RecheckNewPassword.value = null;
				newPassword.focus();
				return false;
			}else if(checkNumber <0 || checkEnglish <0){
				alert("비밀번호는 숫자와 영문자를 혼용하여야 합니다.");
				newPassword.value = null;
				RecheckNewPassword.value = null;
				newPassword.focus();
				return false;
			}else if(/(\w)\1\1\1/.test(pw)){
				alert('비밀번호는 같은 문자를 4번 이상 사용하실 수 없습니다.');
				newPassword.value = null;
				RecheckNewPassword.value = null;
				newPassword.focus();
				return false;
			}else if(pw.search(/\s/) != -1){
				alert("비밀번호는 공백 없이 입력해주세요.");
				newPassword.value = null;
				RecheckNewPassword.value = null;
				newPassword.focus();
				return false;
			}else if(pw.search(id) > -1){
				alert("비밀번호에 아이디가 포함되었습니다.");
				newPassword.value = null;
				RecheckNewPassword.value = null;
				newPassword.focus();
				return false;
			}else if (newPassword.value != RecheckNewPassword.value) {
				alert("두 비밀번호가 맞지 않습니다.");
				RecheckNewPassword.value = null;
				RecheckNewPassword.focus();
				return false;
			} else {
				return true;
			}
		}

		function fn_modifyPwd() {
			if(!fn_originpw(form.originPassword.value)){
				return false;
			}
			if(!fn_checkpw(form.password.value, form.password2.value)){
				return false;
			}

			return true;
		}


		function isEmpty(el){
			return !$.trim(el.html())
		}

		function fn_readURL(input, id) {
			// 선택된 이미지 파일이 있다면
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#' + id).attr('src', e.target.result);
				};
				reader.readAsDataURL(input.files[0]);
			}

			if (isEmpty($('#div_profile_mod'))) {
				var innterHtml = '<button type="button" class="btns btns-defaults" onclick="fn_changeBasic()">기본프로필로 변경</button>';

				$('#div_profile_mod').append(innterHtml);
			}
		}

		function fn_removeExistImage(_rocket_cd, _profile_img) {

			$.ajax({
				type: "post",
				async: false,
				url: "http://221.148.239.155:8080/develocket/mypage/removeExistImage.do",
				dataType: "text",
				data: {rocket_cd: _rocket_cd, profile_img: _profile_img},
				success: function(result, textStatus) {
					if (result == 'success') {
						alert("이미지를 삭제했습니다.");

						window.location.reload();

						/*$('#exist_profile').empty();
						var innerHtml_profile1 = '<input type="hidden" name="old_profile_img"><img id="profile_img" src="${contextPath}/resources/image/common/develocket_spaceman.png" class="img-circle profile-avatar editImages">';
						$('#exist_profile').append(innerHtml_profile1);

						$('#div_profile').empty();
						var innerHtml_profile2 = '<input type="file" id="file" name="profile_img" value="null" onchange="fn_readURL(this, ' + '\'profile_img\''  + ')">';
						$('#div_profile').append(innerHtml_profile2);

						$('#div_profile_mod').empty();*/

					}
					else {
						alert("다시 시도해주세요.")
					}
				},
				error: function(data, textStatus) {
					alert("에러가 발생했습니다.")
				},
				complete: function(data, textStatus) {
					//
				}
			});
		}

		function fn_changeBasic() {

			$('#profile_img').attr("src", "${contextPath}/resources/image/common/develocket_spaceman.png");

			$('#div_profile').empty();
			var innerHtml = '<input type="file" id="file" name="profile_img" value="null" onchange="fn_readURL(this, ' + '\'profile_img\''  + ')">';
			$('#div_profile').append(innerHtml);

			$('#div_profile_mod').empty();
		}

		$(function () {
			$('#gear').click(function (e) {
				e.preventDefault();
				$('#file').click();
			});
		});

		function changeValue(obj){
			alert(obj.value);
		}

	</script>
	<style>

		#file { display:none; }
		#div_profile { display:none; }
	</style>


</head>
<body>
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
	<c:choose>
		<c:when test="${isLogOn == true && rocketInfoVO != null }">
			<div class="containers bootstrap snippets bootdeys modMemberInfo" style="margin-top: 100px;">
				<h1>
					<b>로켓 정보 수정</b>
				</h1>
			</div>
			<div class="containers bootstrap snippets bootdeys modMemberInfo">
				<div class="row">
					<div class="col-xs-12 col-sm-9">
						<form action="${contextPath }/mypage/modifyProfileImg.do" method="post" enctype="multipart/form-data" class="form-horizontal">
							<input type="hidden" name="rocket_cd" value="${rocketInfoVO.rocket_cd}">
							<div class="panel panel-default">
								<div class="panel-body text-center">
									<div id="exist_profile">
										<input type="hidden" name="old_profile_img" value="${rocketInfoVO.profile_img }">
										<c:choose>
											<c:when test="${not empty rocketInfoVO.profile_img and rocketInfoVO.profile_img != null }">
												<img id="profile_img" src="${contextPath }/rocketInfo/download.do?imageFileName=${rocketInfoVO.profile_img}&rocket_cd=${rocketInfoVO.rocket_cd}" alt="프로필사진" class="img-circle profile-avatar editImages">
											</c:when>
											<c:otherwise>
												<img id="profile_img" src="${contextPath}/resources/image/common/develocket_spaceman.png" alt="프로필사진" class="img-circle profile-avatar editImages">
											</c:otherwise>
										</c:choose>
									</div>
									<i onclick="" class="fa-solid fa-gear" id="gear" style="font-size: 25px; vertical-align: bottom;"></i>
									<div id="div_profile">
										<input type="file" id="file" name="profile_img" value="null" onchange="fn_readURL(this, 'profile_img')">
									</div>
									<div id="div_profile_mod">
										<c:if test="${not empty profile_img and profile_img != null }">
											<button type="button" onclick="fn_removeExistImage(${mypageVO.rocket_cd}, '${rocketInfoVO.profile_img}')" class="btns btns-defaults">
												이미지 삭제
											</button>
										</c:if>
									</div>
								</div>
								<div class="form-group">
									<div class="" align="right" >
										<c:if test="${rocketInfoVO.password != 'Naver'}">
											<button type="button" onclick="fn_removeMember('${contextPath}/modify/myPage.do')" style="float: left;" class="btns btns-defaults">
												계정 삭제
											</button>
										</c:if>
										<button type="submit" class="btns btns-primarys">
											프로필 변경
										</button>
										<button type="button" onclick="fn_backToMyPage('${contextPath }/mypage/myPageView.do')" class="btns btns-defaults">
											뒤로가기
										</button>
									</div>
								</div>
							</div>
						</form>
						<c:if test="${rocketInfoVO.password != 'Naver'}">
							<form name="form" method="post" onsubmit="return fn_modifyMypage()" action="${contextPath }/mypage/ModifySuccess.do" class="form-horizontal">
								<input type="hidden" id="rocket_cd" value="${mypageVO.rocket_cd }">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">내정보</h4>
									</div>
									<div class="panel-body">
										<div class="form-group">
											<label class="col-sm-2 control-label">이름</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" value="${mypageVO.name }" disabled>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">아이디</label>
											<div class="col-sm-10">
												<input type="text" id="rocket_id" class="form-control" value="${mypageVO.id }" disabled>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">Email</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" value="${mypageVO.email }" disabled>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">전화번호</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" value="${mypageVO.phone_number }" disabled>
											</div>
										</div>
									</div>
								</div>

								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">비밀번호 변경</h4>
									</div>
									<div class="panel-body">
										<div class="form-group">
											<label class="col-sm-2 control-label">현재 비밀번호</label>
											<div class="col-sm-10">
												<input type="password" id="originPassword" name="originPassword" required maxlength="15" autocomplete="off" class="form-control" placeholder="현재 비밀번호를 입력해주세요">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">새 비밀번호</label>
											<div class="col-sm-10">
												<input type="password" id="newPassword" name="password" required maxlength="15" autocomplete="off" class="form-control" placeholder="새 비밀번호를 입력해주세요">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">새 비밀번호 확인</label>
											<div class="col-sm-10">
												<input type="password" id="RecheckNewPassword" name="password2" required maxlength="15" autocomplete="off" class="form-control" placeholder="새 비밀번호를 다시 입력해주세요">
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-10 col-sm-offset-2">
												<button type="submit" onclick="fn_modifyPwd()" class="btns btns-primarys">비밀번호 변경하기</button>
											</div>
										</div>
									</div>
								</div>
							</form>
						</c:if>
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



	<!-- ////////////////////////////////////// -->


	<link href="${contextPath }/resources/myPage/modMemberInfo/modMemberInfo_style.css" rel="stylesheet">

	<script type="text/javascript">

	</script>
</body>
</html>