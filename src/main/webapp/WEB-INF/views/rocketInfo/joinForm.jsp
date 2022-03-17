<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" />

<!DOCTYPE html>
<html class="joinForm">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="${contextPath }/resources/rocketInfo/joinForm/style.css">

	<title>회원가입</title>

	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">

	/* 02.23 */
		//이름 유효성 검사  OK
		function fn_checkName() {
			//02.23
			var name = $('#rocket_name').val();
			var name_chk = document.getElementById("rocket_name");
			if(name_chk.value == "") {
				alert("이름을 입력하세요.");
				name_chk.focus();
				return false;
			}
			var nameRegExp = /^[가-힣]{2,5}$/;
			if (!nameRegExp.test(name)) {
				alert("이름이 올바르지 않습니다.");
				return false;
			}
			return true; //확인이 완료되었을 때
		}


		var idchkcount = 0;
		//아이디 유효성 검사
		function fn_checkId() {

			var rocket_id = $('#rocket_id').val();
			var checkNumberid = rocket_id.search(/[0-9]/g);
			var checkEnglishid = rocket_id.search(/[a-z]/ig);
			var rocket_id2 = document.getElementById("rocket_id");
			if(!/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,15}$/.test(rocket_id)){
				alert('아이디는 숫자+영문자 조합으로 6자리 이상 사용해야 합니다.');
				rocket_id2.value = null;
				rocket_id2.focus();
				return false;
			}
			else if(checkNumberid <0 || checkEnglishid <0){
				alert("아이디는 숫자와 영문자를 혼용하여야 합니다.");
				rocket_id2.value = null;
				rocket_id2.focus();
				return false;
			}
			else if(rocket_id.search(/\s/) != -1){
				alert("아이디는 공백 없이 입력해주세요.");
				rocket_id2.value = null;
				rocket_id2.focus();
				return false;
			}

			else{
				$.ajax({
					type:'post',
					url:"http://221.148.239.155:8080/develocket/rocketInfo/checkid.do",
					dataType: "text",
					data:{id:rocket_id},
					success:function(count){
						if(count != 1) {
							alert("사용할 수 있는 ID입니다.");
							/*$('#id_check').prop("disabled", true);*/
							/*$('#rocket_id').prop("readonly", true);*/
							idchkcount++;
						} else {
							alert("사용할 수 없는 ID입니다.");
						}
					},
					error:function(){
						alert("에러입니다.");
					}
				});

				return true;

			}

			return true;
		}


		//비밀번호 유효성검사 OK
		function fn_checkpw(){

			var pw = $("#rocket_password").val();
			var id = $("#rocket_id").val();
			var checkNumber = pw.search(/[0-9]/g);
			var checkEnglish = pw.search(/[a-z]/ig);

			var rocket_password = document.getElementById("rocket_password");
			var chk_password = document.getElementById("chk_password");

			if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/.test(pw)){
				alert('비밀번호는 숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.');
				rocket_password.value = null;
				chk_password.value = null;
				rocket_password.focus();
				return false;
			}else if(checkNumber <0 || checkEnglish <0){
				alert("비밀번호는 숫자와 영문자를 혼용하여야 합니다.");
				rocket_password.value = null;
				chk_password.value = null;
				rocket_password.focus();
				return false;
			}else if(/(\w)\1\1\1/.test(pw)){
				alert('비밀번호는 같은 문자를 4번 이상 사용하실 수 없습니다.');
				rocket_password.value = null;
				chk_password.value = null;
				rocket_password.focus();
				return false;
			}else if(pw.search(/\s/) != -1){
				alert("비밀번호는 공백 없이 입력해주세요.");
				rocket_password.value = null;
				chk_password.value = null;
				rocket_password.focus();
				return false;
			}else if(pw.search(id) > -1){
				alert("비밀번호에 아이디가 포함되었습니다.");
				rocket_password.value = null;
				chk_password.value = null;
				rocket_password.focus();
				return false;
			}else if (rocket_password.value != chk_password.value) {
				alert("두 비밀번호가 맞지 않습니다.");
				chk_password.value = null;
				chk_password.focus();
				return false;
			} else {

				console.log("통과");
				return true;
			}

			return true;
		}


		//이메일 유효성검사 OK
		var sendemailchkcount = 0;
		function fn_sendEmail() {
			var email = $("#email").val();

			$.ajax({
				//http://221.148.239.155:8080/develocket/inquiry/removeModImage.do
				url:"${contextPath}/rocketInfo/checkemail.do",
				type:'post',
				data:{email:email},
				success:function(count){
					if(count != 1) {
						$.ajax({
							type:"post",
							async: false,
							url:"http://221.148.239.155:8080/develocket/email/mailCheck?email=" + email,
							cache : false,
							success:function(data){
								if(data == "error"){
									alert("이메일 주소가 올바르지 않습니다. 유효한 이메일 주소를 입력해주세요.");
									$("#email").attr("autofocus",true);
									$(".successEmailChk").text("유효한 이메일 주소를 입력해주세요.");
									$(".successEmailChk").css("color","red");
								}else{
									alert("인증번호 발송이 완료되었습니다.\n입력한 이메일에서 인증번호 확인을 해주십시오.");
									$("#email2").attr("disabled",false);
									$("#emailChk2").css("display","inline-block");
									$(".successEmailChk").text("인증번호를 입력한 뒤 이메일 인증을 눌러주십시오.");
									$(".successEmailChk").css("color","green");
									code = data;
									sendemailchkcount++;
								}
							}
						});
					} else {
						alert("이미 가입된 이메일입니다.");
					}
				},
				error:function(){
					alert("에러입니다.");
				}
			});

		}

		var emailcodechkcount = 0;
		function fn_emailCheck() {
			if($("#email2").val() == code){
				$(".successEmailChk").text("인증번호가 일치합니다.");
				$(".successEmailChk").css("color","green");
				$("#emailDoubleChk").val("true");
				$("#email2").attr("disabled",true);
				//$("#sm_email").attr("disabled",true);
				emailcodechkcount++;
			}else{
				$(".successEmailChk").text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
				$(".successEmailChk").css("color","red");
				$("#emailDoubleChk").val("false");
				$("#email2").attr("autofocus",true);
			}
		}

		$(document).on("keyup", "#phone", function() { 
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^01[0|1]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 
			});
		
		var phonechkcount = 0;
		function fn_checkphonenum() {

			var phone = $('#phone').val();
			var regPhone = /^01([0|1])-?([0-9]{3,4})-?([0-9]{4})$/;
		
			if (phone == "") {
				alert("번호를 입력해주세요");
				return false;
			}
			else if(!regPhone.test(phone)){
				alert("휴대폰 번호를 올바른 형식으로 입력해주세요.");
				return false;
			}
			else {
				$.ajax({
					//http://221.148.239.155:8080/develocket/inquiry/removeModImage.do
					url:"http://221.148.239.155:8080/develocket/rocketInfo/checkphone.do",
					type:'post',
					data:{phone_number:phone},
					success:function(count){
						if(count != 1) {
							alert("확인되었습니다.");
							$('#phonechk').prop("disabled", true);
							$('#phone').prop("readonly", true);
							phonechkcount++;
						} else {
							alert("이미 가입된 휴대폰번호입니다.");
						}
					},
					error:function(){
						alert("에러입니다.");
					}
				});

			}
			return true;

		}

		//CheckBox
		function checkbox_Check(){
	        if ($("input:checkbox[name=pointCheck]").is(":checked") == true) {
	                //체크가 되어있을때.  
	                return true;
	        } else {
	                //체크가 안되어있을때.
	                alert("필수 약관에 동의해 주세요.");
	                return false;
	        }
	    }
		
		function checkbox_Check2(){
	        if ($("input:checkbox[name=pointCheck2]").is(":checked") == true) {
	                //체크가 되어있을때.  
	                return true;
	        } else {
	                //체크가 안되어있을때.
	                alert("필수 약관에 동의해 주세요.");
	                return false;
	        }
	    }
		
		//모든 함수 검사
		function checkAll(){

			if (!fn_checkName(form.name.value)) {
				return false;
			}
			if (idchkcount == 0) {
				alert("아이디 중복체크를 해주세요.")
				return false;
			}
			if (phonechkcount == 0) {
				alert("휴대전화번호 확인을 해주세요.")
				return false;
			}
			if (!fn_checkpw(form.password.value, form.password2.value)) {
				return false;
			}
			if (sendemailchkcount == 0) {
				alert("이메일 인증번호 보내기를 해주세요.")
				return false;
			}
			if (emailcodechkcount == 0) {
				alert("이메일 인증번호 확인을 해주세요.")
				return false;
			}
			if (!checkbox_Check()){
				return false;
			}
			if (!checkbox_Check2()){
				return false;
			}

			alert("회원가입이 완료되었습니다. 감사합니다!")
			return true;
		}

	</script>

	</script>
</head>
<body>

<!-- partial:index.partial.html -->
<div class="form_wrapper">
	<div class="form_container">
		<div class="title_container">
			<h2>디벨로켓에 오신 것을 환영합니다</h2>
		</div>
		<div class="row clearfix">
			<div class="">
				<form action="${contextPath }/rocketInfo/join.do" method="post" name="form" onsubmit="return checkAll()">
					<div class="input_field"> <span><i aria-hidden="true" class="fa-solid fa-id-card"></i></span>
						<input type="text" name="name" id="rocket_name" placeholder="이름" title="이름은 2자 이상 8자 이하로 설정해주시기 바랍니다." maxlength="20" required autofocus />
					</div>
					<div class="row clearfix" >
						<div class="col_half">
							<div class="input_field"> <span><i aria-hidden="true" class="fa-solid fa-circle-info"></i></span>
								<input type="text" name="id" id="rocket_id" placeholder="아이디" title="영문자, 소문자 입력가능, 최대 10자 까지 입력" required style="width: 145%;"/>
							</div>
						</div>
						<div class="col_half" >
							<div class="input_field">
								<input type="button" id="id_check" value="중복체크" onclick="fn_checkId()" style="width: 70%;"/>
							</div>
						</div>
					</div>

					<div class="row clearfix" >
						<div class="col_half">
							<div class="input_field"> <span><i aria-hidden="true" class="fa-solid fa-mobile-screen-button"></i></span>
								<input onkeyup="action_keyup()" type="text" name="phone_number" id="phone" placeholder="휴대폰 번호" required style="width: 145%;"/>
							</div>
						</div>
						<div class="col_half" >
							<div class="input_field">
								<input type="button" id="phonechk" value="확인" onclick="fn_checkphonenum()" style="width: 70%;"/>
							</div>
						</div>
					</div>

					<div class="input_field"> <span><i aria-hidden="true" class="fa fa-lock"></i></span>
						<input type="password" id="rocket_password" name="password" placeholder="비밀번호" title="비밀번호는 총 8자 까지 입력가능" required />
					</div>
					<div class="input_field"> <span><i aria-hidden="true" class="fa fa-lock"></i></span>
						<input type="password" id="chk_password" name="password2" placeholder="비밀번호 확인" required />
					</div>
					<div class="input_field"> <span><i aria-hidden="true" class="fa fa-envelope"></i></span>
						<input type="email" id="email" name="email" placeholder="example@decelocket.com" title="아이디 비밀번호 분실시 필요한 정보이므로, 정확하게 기입해 주십시오." required />
					</div>
					<div class="input_field">
						<input class="button" type="button" onclick="fn_sendEmail()" value="인증번호 보내기" />
					</div>

					<div>
						<span id="emailChk2" class="doubleChk"></span>
						<span class="point successEmailChk"></span>
						<input type="hidden" id="emailDoubleChk"/>
					</div>

					<div class="row clearfix">

						<div class="col_half">
							<div class="input_field">
								<input type="text" id="email2" name="email2" placeholder="인증번호 입력" disabled required style="width: 110%;"/>
							</div>
						</div>
						<div class="col_half">
							<div class="input_field">
								<input type="button" name="name" value="인증하기" onclick="fn_emailCheck()">
							</div>
						</div>

					</div>
					<div class="input_field checkbox_option">
						<input type="checkbox" id="cb1" name="pointCheck">
						<label for="cb1">이용약관, 개인정보 수집 및 이용 동의(필수)</label>
					</div>
					<div class="input_field checkbox_option">
						<input type="checkbox" id="cb2" name="pointCheck2">
						<label for="cb2">만 14세 이상(필수)</label>
					</div>
					<input class="button" type="submit" value="회원가입" />
					<input class="button" type="reset" value="다시입력" />
				</form>
			</div>
		</div>
	</div>
</div>

<!-- partial -->
<script src="https://kit.fontawesome.com/d3a24d5be2.js" crossorigin="anonymous"></script>

</body>
</html>