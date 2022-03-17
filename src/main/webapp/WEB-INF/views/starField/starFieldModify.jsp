<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }"/>
<c:set var="star_field_cd" value="${starFieldMap.starFieldVO.star_field_cd }"/>
<c:set var="profile_img" value="${starFieldMap.starFieldVO.profile_img }"/>
<c:set var="short_intro" value="${starFieldMap.starFieldVO.short_intro }"/>
<c:set var="detail_intro" value="${starFieldMap.starFieldVO.detail_intro }"/>
<c:set var="career" value="${starFieldMap.starFieldVO.career }"/>
<c:set var="business_img" value="${starFieldMap.starFieldVO.business_img }"/>
<c:set var="qna1" value="${qna1 }"/>
<c:set var="qna2" value="${qna2 }"/>
<c:set var="qna3" value="${qna3 }"/>
<c:set var="qna4" value="${qna4 }"/>
<c:set var="imageFileList" value="${starFieldMap.imageFileList }"/>
<c:set var="star_nickname" value="${star_nickname }"/>
<c:set var="area" value="${area }"/>
<c:set var="small_category" value="${small_category }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>스타프로필 수정창</title>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">

		function isEmpty(el) {
			return !$.trim(el.html())
		}

		$(function () {
			$('#profile_img').on('click', function () {
				$('#profile_id').trigger('click');
			});

			$('#business_img').on('click', function () {
				$('#business_file').trigger('click');
			});
		});

		// 프로필 이지지, 사업자등록증 이미지 읽어오기
		function readURL(input, id) {
			// 선택된 이미지 파일이 있다면
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function (e) {
					$('#' + id).attr('src', e.target.result);
				};
				reader.readAsDataURL(input.files[0]);
			}

			if (id == 'profile_img') {
				if (isEmpty($('#div_profile_mod'))) {
					let change_button1 = '<input type="button" value="기본프로필로 변경" onclick="fn_changeBasic(' + '\'profile\'' + ')">';

					$('#div_profile_mod').append(change_button1);
				}
			} else if (id == 'business_img') {
				if (isEmpty($('#div_business_mod'))) {
					let change_button2 = '<button type="button" onclick="fn_changeBasic(' + '\'business\'' + ')">이미지 삭제하기</button>';

					$('#div_business_mod').append(change_button2);
				}
			}
		}

		// 자격증 이미지 읽어오기
		function readURL2(input, index) {
			// 선택된 이미지 파일이 있다면
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function (e) {
					$('#preview' + index).attr('src', e.target.result);
				};
				reader.readAsDataURL(input.files[0]);
			}
		}

		// 기존 이미지 개수(수정 이전의 이미지 갯수)
		var pre_img_num = 0;
		// 새로 추가된 이미지 갯수(수정 후 이미지 갯수)
		var img_index = 0;

		var isFirstAddImage = true;

		function fn_addModeImage(_img_index) {
			if (isFirstAddImage == true) {
				pre_img_num = _img_index;
				img_index = ++_img_index;
				isFirstAddImage = false;
			} else {
				++img_index;
			}

			var innerHTML = '';
			innerHTML += '<div class="' + img_index + '" width="200px"  align="left">';
			innerHTML += '<label class="label_btn" for="img_add' + img_index + '">';
			innerHTML += '첨부파일';
			innerHTML += '</label>';
			innerHTML += '<input type="file" style="display: none;" id="img_add' + img_index + '" name="imageFileName' + img_index + '" onchange="readURL2(this, ' + img_index + ')">';
			innerHTML += '<button type="button" class="img_remove" onclick="fn_removeAddedImage(' + img_index + ')">';
			innerHTML += '삭제하기';
			innerHTML += '</button>';
			innerHTML += '</div>';
			innerHTML += '<div class="' + img_index + '">';
			innerHTML += '<img id="preview' + img_index + '" width="200px" height="200px">';
			innerHTML += '</div>';

			$("#tb_addImage").append(innerHTML);
			$("#added_img_num").val(img_index);	// 추가된 이미지 수를 hidden속성의 태그에 저장해서 컨트롤러로 보냄

		}

		function fn_removeAddedImage(img_index) {

			$('.' + img_index).remove();

			var innerHTML = '';
			innerHTML += '<div style="display: none">';
			innerHTML += '<input type="file" name="imageFileName' + img_index + '">';
			innerHTML += '</div>';

			$("#tb_addImage").append(innerHTML);

		}

		function fn_removeModImage(_career_img_cd, _star_field_cd, _imageFileName, rowNum) {

			$.ajax({
				type    : "post",
				async   : false,
				url     : "http://221.148.239.155:8080/develocket/starField/removeModImage.do",
				dataType: "text",
				data    : {career_img_cd: _career_img_cd, star_field_cd: _star_field_cd, imageFileName: _imageFileName},
				success : function (result, textStatus) {
					if (result == 'success') {
						alert("이미지를 삭제했습니다.");

						$('#div_' + rowNum).remove();

						$('#div_exist_career_' + rowNum).empty();
						let empty_career_cd_input = '<input type="hidden" name="career_img_cd"><input type="hidden" name="oldFileName"">';
						$('#div_exist_career_' + rowNum).append(empty_career_cd_input);

						$('#div_sub' + rowNum).empty();
						let empty_career_input = '<input type="file" id="imageFileName' + rowNum + '" name="imageFileName' + rowNum + '" style="display: none">';
						$('#div_sub' + rowNum).append(empty_career_input);

					} else {
						alert("다시 시도해주세요.")
					}
				},
				error   : function (data, textStatus) {
					alert("에러가 발생했습니다.")
				},
				complete: function (data, textStatus) {
					//
				}
			});

		}

		function fn_removeExistImage(_star_field_cd, _image, _item) {

			$.ajax({
				type    : "post",
				async   : false,
				url     : "http://221.148.239.155:8080/develocket/starField/removeExistImage.do",
				dataType: "text",
				data    : {star_field_cd: _star_field_cd, image: _image, item: _item},
				success : function (result, textStatus) {
					if (result == 'success') {
						alert("이미지를 삭제했습니다.");

						if (_item == 'profile') {
							$('#exist_profile').empty();
							var innerHtml_profile1 = '<input type="hidden" name="old_profile_img"><img id="profile_img" width="200px" height="200px"src="${contextPath}/resources/image/common/develocket_spaceman.png">';
							$('#exist_profile').append(innerHtml_profile1);

							$('#div_profile').empty();
							var innerHtml_profile2 = '<input type="file" name="profile_img" onchange="readURL(this,' + '\'profile_img\'' + ')">';
							$('#div_profile').append(innerHtml_profile2);

							$('#div_profile_mod').empty();

						} else if (_item == 'business') {
							$('#exist_business').empty();
							var innerHtml_business1 = '<input type="hidden" name="old_business_img"><img id="business_img" width="200px" height="200px"src="${contextPath}/resources/image/common/develocket_spaceman.png">';
							$('#exist_business').append(innerHtml_business1)

							$('#div_business').empty();
							var innerHtml_business2 = '<input type="file" name="business_img" style="display:none;" value="null" onchange="readURL(this,' + '\'business_img\'' + ')">';
							$('#div_business').append(innerHtml_business2);

							$('#div_business_mod').empty();
						}

					} else {
						alert("다시 시도해주세요.")
					}
				},
				error   : function (data, textStatus) {
					alert("에러가 발생했습니다.")
				},
				complete: function (data, textStatus) {
					//
				}
			});
		}

		function fn_changeBasic(item) {

			if (item == 'profile') {
				$('#profile_img').attr("src", "${contextPath}/resources/image/common/develocket_spaceman.png");

				$('#div_profile').empty();
				var innerHtml = '<input type="file" name="profile_img" onchange="readURL(this,' + '\'profile_img\'' + ')">';
				$('#div_profile').append(innerHtml);

				$('#div_profile_mod').empty();
			} else if (item == 'business') {
				$('#business_img').attr("src", "${contextPath}/resources/image/common/develocket_spaceman.png");
				$('#div_business').empty();

				var innerHtml = '<input type="file" name="business_img" value="null" onchange="readURL(this,' + '\'business_img\'' + ')">';
				$('#div_business').append(innerHtml);
			}

		}

		/* 스타 프로필 삭제 */
		function fn_deleteProfile(star_field_cd) {
			var reply = confirm("스타 프로필을 지우시겠습니까?");
			if (reply == true) {
				$.ajax({
					type    : "post",
					async   : false,
					url     : "http://221.148.239.155:8080/develocket/starField/deleteProfile.do",
					dataType: "text",
					data    : {star_field_cd: star_field_cd},
					success : function (result) {
						if (result == 'success') {
							alert("스타 프로필이 삭제되었습니다.");
							location.href = "http://221.148.239.155:8080/develocket/";

						} else {
							alert("다시 시도해주세요.");
						}
					},
					error   : function (data, textStatus) {
						alert("에러가 발생했습니다.");
					},
					complete: function (data, textStatus) {
						//
					}
				});

			} else {
				return false;
			}
		}
	</script>
	<!-- Custom styles for this template -->
	<link href="${contextPath}/resources/css/starField/starfieldmodify.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="container">
	<form action="${contextPath }/starField/modifyStarField.do" method="post"
		  enctype="multipart/form-data" name="form">
		<div class="mainheading">
			<h1 class="sitetitle">PROFILE</h1>
			<div class="profile-card">
				<header>
					<input type="hidden" name="star_field_cd" value="${star_field_cd }">
					<div id="exist_profile">
						<input type="hidden" name="old_profile_img" value="${profile_img }">
						<c:choose>
							<c:when test="${not empty profile_img && profile_img != null }">
								<img id="profile_img" width="200px" height="200px"
									 src="${contextPath }/starField/download.do?imageFileName=${profile_img}&star_field_cd=${star_field_cd}">
							</c:when>
							<c:otherwise>
								<img id="profile_img" width="200px" height="200px"
									 src="${contextPath}/resources/image/common/develocket_spaceman.png">
							</c:otherwise>
						</c:choose>
					</div>
					<div id="div_profile">
						<input type="file" id="profile_id" name="profile_img" style="display: none"
							   onchange="readURL(this, 'profile_img')">
					</div>
					<div id="div_profile_mod">
						<c:if test="${not empty profile_img and profile_img != null }">
							<button class="btn-pill text-white" id="profile_delete_btn" type="button"
									onclick="fn_removeExistImage(${star_field_cd}, '${profile_img}', 'profile')">
								이미지 삭제
							</button>
						</c:if>
					</div>
					<%-- 데이터 받아오는 값 --%>
					<%--<h1>${star_nickname}</h1>
					<h2>소분류 : ${small_category}</h2>--%>
				</header>
				<div class="profile-bio">
                    <textarea rows="3" cols="65" id="input_box1" name="short_intro"
							  placeholder="한줄소개">${short_intro }</textarea>
					<span style="color:#aaa;" id="counter1">(${short_intro.length()} / 최대 50자)</span>
				</div>
			</div>
		</div>
		<section class="featured-posts">
			<div class="section-title prfile" id="profile-bar">
				<h2>
                    <span>
                        <ul class="profile-links">
                                <li>
                                    <a id="btn1" onclick="scrollMasterInfo('star_information')">
                                        information
                                    </a>
                                </li>

                                <li>
                                    <a id="btn2" onclick="scrollMasterInfo('star_picture')">
                                        picture
                                    </a>
                                </li>

                                <li>
                                    <a id="btn3" onclick="scrollMasterInfo('star_question')">
                                        question
                                    </a>
                                </li>
                        </ul>
                    </span>
				</h2>
			</div>
			<div class="content" id="profile_content">
				<div id="star_information">
					<div>
						<h1>스타정보</h1>
						<div class="inf_div">
                            <textarea rows="8" cols="65" id="input_box2" name="detail_intro"
									  placeholder="상세설명">${detail_intro }</textarea>
							<span style="color:#aaa;" id="counter2">(${detail_intro.length()} / 최대 500자)</span>
						</div>
					</div>
					<div>
						<h1>경력</h1>
						<div class="inf_div">
                            <textarea rows="5" cols="65" id="input_box3" name="career"
									  placeholder="상세히 입력해주세요.">${career }</textarea>
							<span style="color:#aaa;" id="counter3">(${career.length()} / 최대 1000자)</span>
						</div>
					</div>
				</div>
				<div id="star_picture">
					<c:set var="img_index"/>
					<c:choose>
						<c:when test="${not empty imageFileList && imageFileList != null }">
							<c:forEach var="careerImgVO" items="${imageFileList }" varStatus="status">
								<h1>기존 사진</h1>
								<div id="modify_img">
									<div id="div_${status.index }" style="margin-bottom: 10px">
										[사진 ${status.index }]
									</div>
									<div id="div_exist_career_${status.index}">
										<!-- 이미지 수정시 미리 원래 이미지 파일이름을 저장함 -->
										<input type="hidden" name="career_img_cd" value="${careerImgVO.career_img_cd }">
										<input type="hidden" name="oldFileName" value="${careerImgVO.imageFileName }">
										<img alt="사진"
											 src="${contextPath }/starField/download.do?imageFileName=${careerImgVO.imageFileName}&star_field_cd=${careerImgVO.star_field_cd}"
											 id="preview${status.index }" width="200" height="200">
									</div>
									<br>
									<div class="div_modEnable" id="div_sub${status.index }">
										<label class="label_btn" for="imageFileName${status.index }">첨부파일</label>
										<!-- 수정된 이미지 파일이름을 전송함 -->
										<input type="file" id="imageFileName${status.index }"
											   name="imageFileName${status.index }"
											   onchange="readURL2(this, ${status.index })"
											   style="display: none;">
										<button class="btn-pill text-white" id="img_delete_btn" type="button"
												style="margin-bottom: 10px"
												onclick="fn_removeModImage(${careerImgVO.career_img_cd}, ${careerImgVO.star_field_cd }, '${careerImgVO.imageFileName }', ${status.index })">
											이미지 삭제하기
										</button>
									</div>
									<c:if test="${status.last eq true }">
										<c:set var="img_index" value="${status.count }"/> <!-- 기존 이미지 수 -->
										<input type="hidden" name="pre_img_num" value="${status.count }">
										<input type="hidden" id="added_img_num" name="added_img_num"
											   value="${status.count }"> <!-- 수정시 새로 추가된 이미지 수 -->
									</c:if>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:set var="img_index" value="${0 }"/>
							<!-- 기존 이미지수 -->
							<input type="hidden" name="pre_img_num" value="${0 }">
							<!-- 수정시 이미지 수 -->
							<input type="hidden" id="added_img_num" name="added_img_num" value="${0 }">
						</c:otherwise>
					</c:choose>

					<div class="tr_modEnable">
						<h1>추가 사진</h1>
						<button onclick="fn_addModeImage(${img_index})" style="background: none; border: 0;"
								type="button"><i class="fa fa-plus" aria-hidden="true" style="cursor: pointer"></i>
						</button>
					</div>

					<div id="tb_addImage">
						<!-- 자격증 이미지 추가 공간 -->
					</div>

					<div>
						<h1>사업자등록증</h1>
						<div id="exist_business">
							<input type="hidden" name="old_business_img" value="${business_img }">
							<c:choose>
								<c:when test="${not empty business_img && business_img != null }">
									<img id="business_img" width="200px" height="200px"
										 src="${contextPath }/starField/download.do?imageFileName=${business_img}&star_field_cd=${star_field_cd}">
								</c:when>
								<c:otherwise>
									<img id="business_img" width="200px" height="200px"
										 src="${contextPath}/resources/image/common/develocket_spaceman.png">
								</c:otherwise>
							</c:choose>
						</div>
						<div id="div_business">
							<input type="file" id="business_file" name="business_img" style="display: none"
								   onchange="readURL(this, 'business_img')">
						</div>
						<div id="div_business_mod">
							<c:if test="${not empty business_img && business_img != null }">
								<button class="btn-pill text-white" type="button" id="business_btn"
										onclick="fn_removeExistImage(${star_field_cd}, '${business_img}', 'business')">
									기존 이미지 삭제하기
								</button>
							</c:if>
						</div>
					</div>
				</div>
				<div id="star_question">
					<div>
						<h1>질문답변</h1>
						<div class="question_div">
							<h2>💬제공하는 서비스를 어떠한 절차로 전문적으로 진행하나요?</h2>
							<div class="response_div">
								<c:choose>
									<c:when test="${not empty qna1 and qna1 != 'null' }">
                                        <textarea rows="3" cols="65" id="input_box4" name="qna1"
												  placeholder="한줄소개">${qna1 }</textarea>
									</c:when>
									<c:otherwise>
                                        <textarea rows="3" cols="65" id="input_box4" name="qna1"
												  placeholder="한줄소개"></textarea>
									</c:otherwise>
								</c:choose>
								<span style="color:#aaa;" id="counter4">(${qna1.length()} / 최대 150자)</span>
							</div>
						</div>
						<div class="question_div">
							<h2>💬서비스의 견적은 어떤 방식으로 산정 되나요?</h2>
							<div class="response_div">
								<c:choose>
									<c:when test="${not empty qna2 and qna2 != 'null' }">
                                        <textarea rows="3" cols="65" id="input_box4" name="qna2"
												  placeholder="한줄소개">${qna2 }</textarea>
									</c:when>
									<c:otherwise>
                                        <textarea rows="3" cols="65" id="input_box4" name="qna2"
												  placeholder="한줄소개"></textarea>
									</c:otherwise>
								</c:choose>
								<span style="color:#aaa;" id="counter5">(${qna2.length()} / 최대 150자)</span>
							</div>
						</div>
						<div class="question_div">
							<h2>💬완료한 서비스 중 대표적인 서비스는 무엇인가요? 소요 시간은 얼마나 소요 되었나요?</h2>
							<div class="response_div">
								<c:choose>
									<c:when test="${not empty qna3 and qna3 != 'null' }">
                                        <textarea rows="3" cols="65" id="input_box4" name="qna3"
												  placeholder="한줄소개">${qna3 }</textarea>
									</c:when>
									<c:otherwise>
                                        <textarea rows="3" cols="65" id="input_box4" name="qna3"
												  placeholder="한줄소개"></textarea>
									</c:otherwise>
								</c:choose>
								<span style="color:#aaa;" id="counter6">(${qna3.length()} / 최대 150자)</span>
							</div>
						</div>
						<div class="question_div">
							<h2>💬A/S 또는 환불 규정은 어떻게 되나요?</h2>
							<div class="response_div">
								<c:choose>
									<c:when test="${not empty qna4 and qna4 != 'null' }">
                                        <textarea rows="3" cols="65" id="input_box4" name="qna4"
												  placeholder="한줄소개">${qna4 }</textarea>
									</c:when>
									<c:otherwise>
                                        <textarea rows="3" cols="65" id="input_box4" name="qna4"
												  placeholder="한줄소개"></textarea>
									</c:otherwise>
								</c:choose>
								<span style="color:#aaa;" id="counter7">(${qna4.length()} / 최대 150자)</span>
							</div>
						</div>
					</div>
				</div>
				<hr>
				<label class="label_btn" for="register_btn">수정등록</label>
				<input type="submit" id="register_btn" style="margin-left: 10px; display: none">
				<label class="label_btn" for="reset_btn">리셋하기</label>
				<input type="reset" id="reset_btn" style="display: none">
				<label class="label_btn" for="remove_btn">프로필 삭제</label>
				<input type="button" id="remove_btn" style="display: none" onclick="fn_deleteProfile(${star_field_cd })">
			</div>
		</section>
	</form>
</div>

<script>
	$('#input_box1').keyup(function (e) {
		var content = $(this).val();
		$('#counter1').html("(" + content.length + " / 최대 500자)");    //글자수 실시간 카운팅

		if (content.length > 500) {
			alert("최대 500자까지 입력 가능합니다.");
			$(this).val(content.substring(0, 500));
			$('#counter1').html("(500 / 최대 500자)");
		}
	});

	$('#input_box2').keyup(function (e) {
		var content = $(this).val();
		$('#counter2').html("(" + content.length + " / 최대 500자)");    //글자수 실시간 카운팅

		if (content.length > 500) {
			alert("최대 500자까지 입력 가능합니다.");
			$(this).val(content.substring(0, 500));
			$('#counter2').html("(500 / 최대 500자)");
		}
	});

	$('#input_box3').keyup(function (e) {
		var content = $(this).val();
		$('#counter3').html("(" + content.length + " / 최대 1000자)");    //글자수 실시간 카운팅

		if (content.length > 1000) {
			alert("최대 1000자까지 입력 가능합니다.");
			$(this).val(content.substring(0, 1000));
			$('#counter3').html("(1000 / 최대 1000자)");
		}
	});

	$('#input_box4').keyup(function (e) {
		var content = $(this).val();
		$('#counter4').html("(" + content.length + " / 최대 150자)");    //글자수 실시간 카운팅

		if (content.length > 150) {
			alert("최대 150자까지 입력 가능합니다.");
			$(this).val(content.substring(0, 150));
			$('#counter4').html("(150 / 최대 150자)");
		}
	});

	$('#input_box5').keyup(function (e) {
		var content = $(this).val();
		$('#counter5').html("(" + content.length + " / 최대 150자)");    //글자수 실시간 카운팅

		if (content.length > 150) {
			alert("최대 150자까지 입력 가능합니다.");
			$(this).val(content.substring(0, 150));
			$('#counter5').html("(150 / 최대 150자)");
		}
	});

	$('#input_box6').keyup(function (e) {
		var content = $(this).val();
		$('#counter6').html("(" + content.length + " / 최대 150자)");    //글자수 실시간 카운팅

		if (content.length > 150) {
			alert("최대 150자까지 입력 가능합니다.");
			$(this).val(content.substring(0, 150));
			$('#counter6').html("(150 / 최대 150자)");
		}
	});

	$('#input_box7').keyup(function (e) {
		var content = $(this).val();
		$('#counter7').html("(" + content.length + " / 최대 150자)");    //글자수 실시간 카운팅

		if (content.length > 150) {
			alert("최대 150자까지 입력 가능합니다.");
			$(this).val(content.substring(0, 150));
			$('#counter7').html("(150 / 최대 150자)");
		}
	});

</script>

</body>
</html>