<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" />
<c:set var="inquiryVO" value="${inquiryMap.inquiryVO }" />
<c:set var="imageFileList" value="${inquiryMap.imageFileList }" />
<c:set var="removeCompleted" value="${inquiryMap.removeCompleted }" />
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>글상세보기</title>

	<style>
		.fa-circle-xmark:hover{
			cursor: pointer;
			color: darkgray;
		}
	</style>

	<link href='${contextPath}/resources/inquiry/inquiryForm/inquiry_tailwind.min.css' rel='stylesheet'>
	<script type='text/javascript' src='https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js'></script>
	<link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css' rel='stylesheet'>
	<script src="https://kit.fontawesome.com/d3a24d5be2.js" ></script>

	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

	<script type="text/javascript">

		function backToInquiryList(obj) {
			obj.action = "${contextPath}/inquiry/inquiryList.do";
			obj.submit();
		}
	
		function backToList(obj, inquiry_cd) {
			obj.action = "${contextPath}/inquiry/inquiryVeiw.do?removeCompleted=false&inquiry_cd=" + inquiry_cd;
			obj.submit();
		}


		function fn_modify(image_count) {

			$('#span_btn_basic').css("display", "none");
			$('#span_btn_modify').css("display", "block");
			$('#i_title').attr("disabled", false);
			$('#i_content').attr("disabled", false);
			$('.fa-circle-xmark').css("visibility", "visible");

			let innerHtml = "";
			innerHtml += '<div class="mb-1" id="input_image' + image_count + '">';
				innerHtml += '<div class="relative border-dotted h-32 rounded-lg border-dashed border-2 border-blue-700s bg-gray-100 flex justify-center items-center borders">';
					innerHtml += '<div class="absolute">';
						innerHtml += '<div class="flex flex-col items-center"> <i class="fa fa-folder-open fa-3x text-blue-700" style="color: #F34F30;"></i> <span class="block text-gray-400 font-normal">이곳을 클릭하여 파일을 추가해주세요</span> </div>';
					innerHtml += '</div>';
					innerHtml += '<input type="file" name="imageFileName' + image_count + '" onchange="readURL(this,' + image_count + ')" class="h-full w-full opacity-0">';
				innerHtml += '</div>';
			innerHtml += '</div>';
			innerHtml += '<div class="mb-1" style="display: none;" id="div_preview' + image_count + '">';
				innerHtml += '<div style="padding: 20px;" align="center" class="relative border-dotteds h-32s rounded-lg border-dasheds border-2 border-blue-700s bg-gray-100 flexs justify-center items-center borderss">';
					innerHtml += '<i style="float: right; font-size: 22px;" onclick="fn_remove_image(' + image_count + ')" class="fa-solid fa-circle-xmark"></i>';
					innerHtml += '<img style="height: 480px" id="preview' + image_count +'" src="" alt="이미지 미리보기">';
				innerHtml += '</div>';
			innerHtml += '</div>';

			$("#allImageSection").append(innerHtml);
		}

		
		function fn_modify_inquiry(obj) {	/* 수정등록 클릭 시 컨트롤러에게 수정된 데이터를 전송함 */
			obj.action = "${contextPath}/inquiry/modifyInquiry.do";
			obj.submit();
		}


		// 기존 이미지 개수(수정 이전의 이미지 갯수)
		var pre_img_num = 0;
		// 새로 추가된 이미지 갯수(수정 후 이미지 갯수)
		/*var img_index = 0;*/

		var isFirstAddImage = true;

		function readURL(input, index) {

			if (isFirstAddImage == true) {
				pre_img_num = index;
				/*img_index = ++index;*/
				isFirstAddImage = false;
			}
			/*else {
				/!* TODO 추가!! *!/
				++img_index;
			}*/

			// 선택된 이미지 파일이 있다면
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#preview' + index).attr('src', e.target.result);
				};
				reader.readAsDataURL(input.files[0]);
			}

			$('#input_image' + index).css("display", "none");
			$('#div_preview' + index).css("display", "block");

			let image_count = index + 1;

			let innerHtml = "";
			innerHtml += '<div class="mb-1" id="input_image' + image_count + '">';
			innerHtml += '<div class="relative border-dotted h-32 rounded-lg border-dashed border-2 border-blue-700s bg-gray-100 flex justify-center items-center borders">';
			innerHtml += '<div class="absolute">';
			innerHtml += '<div class="flex flex-col items-center"> <i class="fa fa-folder-open fa-3x text-blue-700" style="color: #F34F30;"></i> <span class="block text-gray-400 font-normal">이곳을 클릭하여 파일을 추가해주세요</span> </div>';
			innerHtml += '</div>';
			innerHtml += '<input type="file" name="imageFileName' + image_count + '" onchange="readURL(this,' + image_count + ')" class="h-full w-full opacity-0">';
			innerHtml += '</div>';
			innerHtml += '</div>';
			innerHtml += '<div class="mb-1" style="display: none;" id="div_preview' + image_count + '">';
			innerHtml += '<div style="padding: 20px;" align="center" class="relative border-dotteds h-32s rounded-lg border-dasheds border-2 border-blue-700s bg-gray-100 flexs justify-center items-center borderss">';
			innerHtml += '<i style="float: right; font-size: 22px;" onclick="fn_remove_image(' + image_count + ')" class="fa-solid fa-circle-xmark"></i>';
			innerHtml += '<img style="height: 480px" id="preview' + image_count +'" src="" alt="이미지 미리보기">';
			innerHtml += '</div>';
			innerHtml += '</div>';

			$('#allImageSection').append(innerHtml);
		}
		
		function fn_remove_inquiry(url, inquiry_cd) {
			var form = document.createElement("form");	
			form.setAttribute("method", "post");
			form.setAttribute("action", url);
			
			var inquiryCDInput = document.createElement("input");		
			inquiryCDInput.setAttribute("type", "hidden")				
			inquiryCDInput.setAttribute("name", "inquiry_cd");
			inquiryCDInput.setAttribute("value", inquiry_cd);
			
			form.appendChild(inquiryCDInput);	
			document.body.appendChild(form);	
			form.submit();
		}
		
		function fn_reply_form(isLogOn, url, parent_cd, group_cd) {
			
			if (isLogOn != '' && isLogOn != 'false') {
				var form = document.createElement("form");
				form.setAttribute("method", "post");
				form.setAttribute("action", url);
				
				var parentCDInput = document.createElement("input");
				parentCDInput.setAttribute("type", "hidden");
				parentCDInput.setAttribute("name", "parent_cd");
				parentCDInput.setAttribute("value", parent_cd);
				
				var groupCDInput = document.createElement("input");
				groupCDInput.setAttribute("type", "hidden");
				groupCDInput.setAttribute("name", "group_cd");
				groupCDInput.setAttribute("value", group_cd);
				
				form.appendChild(parentCDInput);
				form.appendChild(groupCDInput);
				document.body.appendChild(form);	
				form.submit();	
			}
			else {
				alert('로그인 후 글쓰기가 가능합니다.');
				location.href = "${contextPath}/rocketInfo/loginForm.do?action=/inquiry/inquiryReplyForm.do&parent_cd=" + parent_cd + "&=group_cd" + group_cd;
			}
			
		}

		function fn_remove_image(index) {

			$('#input_image' + index).empty();
			let empty_input = '<input type="file" name="imageFileName" style="display: none">';
			$('#input_image' + index).append(empty_input);

			$('#div_preview' + index).remove();
		}

		
		function fn_removeExistImage(_inquiry_img_cd, _inquiry_cd, _imageFileName, index) {

			$.ajax({
				type: "post",
				async: false,
				url: "http://localhost:8080/develocket/inquiry/removeExistImage.do",
				dataType: "text",
				data: {inquiry_img_cd: _inquiry_img_cd, inquiry_cd: _inquiry_cd, imageFileName: _imageFileName},
				success: function(result, textStatus) {
					if (result == 'success') {
						alert("이미지를 삭제했습니다.");

						$('#div_exist_image_' + index).remove();
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
	</script>
</head>
<body>
	<form action="#" name="frmInquiry" method="post" enctype="multipart/form-data">
		<input type="hidden" name="inquiry_cd" value="${inquiryVO.inquiry_cd }">
		<div class="py-20 h-screen bg-gray-300s px-2 inquiry inquiryView">
			<div class="mx-auto bg-whites rounded-lg overflow-hidden">
				<div class="md:flex">
					<div class="w-full px-4 py-6 ">
						<b><h1 style="font-size: 30px; margin-bottom: 5px;">1:1 문의</h1></b><br>
						<div class="mb-1">
							<span class="text-lg">
								작성자
							</span>
							<input type="text" name="id" value="${inquiryVO.id }" disabled class="h-12 px-3 w-full border-blue-400 border-2 rounded focus:outline-none focus:border-blue-600 borders">
						</div>
						<div class="mb-1">
							<span class="text-lg">
								작성일시
							</span>
							<input type="text" value="${inquiryVO.write_date}" disabled class="h-12 px-3 w-full border-blue-400 border-2 rounded focus:outline-none focus:border-blue-600 borders">
						</div>
						<div class="mb-1">
							<span class="text-lg">
								제목
							</span>
							<input id="i_title" name="inquiry_title" type="text" value="${inquiryVO.inquiry_title}" disabled class="h-12 px-3 w-full border-blue-400s border-2 rounded focus:outline-none focus:border-blue-600s borders" >
						</div>
						<div class="mb-1">
							<span class="text-lg">
								내용
							</span>
							<textarea id="i_content" name="inquiry_content" type="text" disabled class="h-24 py-1 px-3 w-full border-2 border-blue-400s rounded focus:outline-none focus:border-blue-600s resize-none borders">${inquiryVO.inquiry_content}</textarea>
						</div>
						<div class="mb-1">
							<span>첨부파일</span>
						</div>


						<c:choose>
							<c:when test="${not empty imageFileList && imageFileList != 'null' }">
								<c:forEach var="inquiryImgVO" items="${imageFileList }" varStatus="status" >
									<div class="mb-1" id="div_exist_image_${status.index}">
										<div style="padding: 20px;" align="center" class="relative border-dotteds h-32s rounded-lg border-dasheds border-2 border-blue-700s bg-gray-100 flexs justify-center items-center borderss">
											<i style="float: right; font-size: 22px; visibility: hidden" onclick="fn_removeExistImage('${inquiryImgVO.inquiry_img_cd}', '${inquiryImgVO.inquiry_cd}', '${inquiryImgVO.imageFileName}', '${status.index}')" class="fa-solid fa-circle-xmark"></i>
											<img style="height: 480px;" id="preview${status.index }" src="${contextPath }/download.do?imageFileName=${inquiryImgVO.imageFileName}&inquiry_cd=${inquiryImgVO.inquiry_cd}" alt="이미지">
										</div>
									</div>
									<c:set var="img_index" />
									<c:if test="${status.last eq true }">
										<c:set var="img_index" value="${status.count }" />	<!-- 기존 이미지 수 -->
									</c:if>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<c:set var="img_index" value="${0 }" />
								<!-- 기존 이미지수 -->
								<input type="hidden" name="pre_img_num" value="${0 }" >
								<!-- 수정시 이미지 수 -->
								<input type="hidden" id="added_img_num" name="added_img_num" value="${0 }" >
							</c:otherwise>
						</c:choose>
						<div class="mb-1" id="allImageSection"></div>
						<div class="mt-3 text-right" id="span_btn_basic">
							<c:if test="${rocketInfoVO.rocket_cd == inquiryVO.rocket_cd}">
								<button class="btns btn-out" type="button" onclick="fn_modify(${img_index})" >수정하기</button>
								<button class="btns btn-out" type="button" onclick="fn_remove_inquiry('${contextPath}/inquiry/removeInquiry.do', ${inquiryVO.inquiry_cd })">삭제하기</button>
							</c:if>
							<button class="btns btn-primarys" type="button" onclick="backToInquiryList(frmInquiry)" >목록보기</button>
							<c:if test="${rocketInfoVO.rocket_cd == '31'}">
								<button class="btns btn-out" type="button" onclick="fn_reply_form('${isLogOn}', '${contextPath}/inquiry/inquiryReplyForm.do', '${inquiryVO.inquiry_cd }', '${inquiryVO.group_cd }')" >답글쓰기</button>
							</c:if>
						</div>
						<div class="mt-3 text-right" id="span_btn_modify" style="display: none">
							<button class="btns btn-primarys" type="button" onclick="fn_modify_inquiry(frmInquiry)" >수정등록</button>
							<button class="btns btn-out" type="button" onclick="backToList(frmInquiry, '${inquiryVO.inquiry_cd}')">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>









