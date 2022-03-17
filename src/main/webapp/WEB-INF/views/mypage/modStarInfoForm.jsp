<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("utf-8"); %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }"/>
<c:set var="star_cd" value="${starInfo.star_cd }" />
<c:set var="star_nickname" value="${starInfo.star_nickname }" />
<c:set var="area" value="${starInfo.area }" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<title>스타 정보 수정</title>

	<link href="${contextPath }/resources/myPage/modStarInfo/modStarInfo_bootstrap.min.css" rel="stylesheet">
	<script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/d3a24d5be2.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		function execDaumPostcode() {
			new daum.Postcode({
				oncomplete: function(data) {
					// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var roadAddr = data.roadAddress; // 도로명 주소 변수
					var extraRoadAddr = ''; // 참고 항목 변수

					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
						extraRoadAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if(data.buildingName !== '' && data.apartment === 'Y'){
						extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if(extraRoadAddr !== ''){
						extraRoadAddr = ' (' + extraRoadAddr + ')';
					}

					// 주소 정보를 해당 필드에 넣는다.
					document.getElementById("areaModify").value = roadAddr;
				}
			}).open();
		}
	</script>
	<script type="text/javascript">
		/* 닉네임 변경 */
		function fn_checkNickname(star_cd) {
			var nickname = $("#nickname").val();

			var nickLength = nickname.length;
			var engCheck = /[a-z]/;
			var numCheck = /[0-9]/;
			var specialCheck = /[~!@#$%^&*()_+|<>?:{}]/;

			if (nickname == null || nickname == "") {
				alert("변경할 닉네임을 입력해주세요.");

			} else if (nickname.search(/\s/) != -1) {
				alert("닉네임은 빈 칸을 포함할 수 없습니다.");

			} else if (nickLength<2 || nickLength>9) {
				alert("닉네임은 한글 및 영어 2자~9자 입니다.");

			} else if (specialCheck.test(nickname)) {
				alert("닉네임은 특수문자를 포함 할 수 없습니다.");

			} else {
				$.ajax({
					type:"post",
					async: false,
					url:"http://221.148.239.155:8080/develocket/mypage/checkNickname.do",
					dataType: "text",
					data: {nickname: nickname, star_cd: star_cd},
					success:function(result){
						if(result == "0"){
							alert("닉네임 변경이 완료되었습니다.");

						} else {
							alert("중복된 닉네임입니다.");
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
		}

		/* 주소 저장 */
		  function fn_areaModify(star_cd) {
         var area = $("#areaModify").val(); 
         
         if (area == null || area == "") {
            alert("주소를 검색해주세요.");
            
         } else {
            $.ajax({ 
               type:"post", 
               async: false,
               url:"http://221.148.239.155:8080/develocket/mypage/areaModify.do", 
               dataType: "text",
               data: {area: area, star_cd: star_cd}, 
               success:function(result){ 
                  if(result == "0"){ 
                     alert("활동지역 변경이 완료되었습니다."); 
                     
                  } else { 
                     alert("활동지역 변경에 실패했습니다."); 
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
      }

		/* 스타 탈퇴 */
		function fn_checkPwd() {
			$("#addInput").append("<br><input type='password' id='checkPwd' placeholder='비밀번호를 입력하고 확인을 눌러주세요.'>");
			$("#addInput").append("<input type='button' id='deleteStar' value='확인'>");


			$("#deleteStar").click(function() {
				var password = $("#checkPwd").val();
				if(checkPwd == "") {
					alert("비밀번호를 입력해주세요.");

				} else {
					var password = password;
					var star_cd = '<c:out value="${star_cd}"/>';

					// 비밀번호 확인
					$.ajax({
						type:"post",
						async: false,
						url:"http://221.148.239.155:8080/develocket/mypage/checkPwd.do",
						dataType: "text",
						data: {star_cd: star_cd, password: password},
						success:function(result){
							if(result == "ok"){

								// 스타 제거
								$.ajax({
									type:"post",
									async: false,
									url:"http://221.148.239.155:8080/develocket/mypage/deleteStar.do",
									dataType: "text",
									data: {star_cd: star_cd},
									success:function(result){
										if(result == "success"){
											alert("스타 탈퇴가 완료되었습니다.");
											location.href="http://221.148.239.155:8080/develocket/";
										} else {
											alert("스타 탈퇴에 실패했습니다.");
										}
									},
									error: function(data, textStatus) {
										alert("에러가 발생했습니다.");
									}
								});

							} else {
								alert("비밀번호가 올바르지 않습니다.");
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
			})
		}

	</script>
</head>
<body>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<div class="containers bootstrap snippets bootdeys modMemberInfo">
	<h1>
		<b>스타 정보 수정</b>
	</h1>
</div>
<div class="containers bootstrap snippets bootdeys modMemberInfo">
	<div class="row">
		<div class="col-xs-12 col-sm-9">
			<form class="form-horizontal">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4 class="panel-title">나의 스타정보</h4>
					</div>

					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-2 control-label">닉네임</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" placeholder="${star_nickname }" id="nickname">
								<button type="button" id="id_check" onclick="fn_checkNickname(${star_cd})" class="btns btns-primarys">닉네임 변경</button>
								<div style="font-size: 13px; color: rgb(160, 160, 160);">
									닉네임은 한글과 영어를 포함해 2자 이상 9자 이하만 가능합니다.
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">현재 활동지역</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" value="${area }" disabled id="area">
								<input type="text" class="form-control" placeholder="주소 검색을 클릭해 변경할 주소를 입력해주세요." disabled id="areaModify">
								<button type="button" onclick="execDaumPostcode()" class="btns btns-defaults">주소 검색</button>
								<button type="button" onclick="fn_areaModify(${star_cd})" class="btns btns-primarys">활동지역 변경</button>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="" align="right">
							<button type="button" id="withdrawStar" onclick="fn_checkPwd()" class="btns btns-defaults">스타 탈퇴</button>
							<div style="display: block; width: 100%; float: left; font-size: 13px; color: rgb(160, 160, 160);">
								스타 탈퇴의 경우, 스타로 등록한 정보가 사라지며 로켓은 유지됩니다.
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<link href="${contextPath }/resources/myPage/modStarInfo/modStarInfo_style.css" rel="stylesheet">

<script type="text/javascript">

</script>
</body>
</html>