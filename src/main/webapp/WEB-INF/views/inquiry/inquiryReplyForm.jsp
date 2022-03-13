<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" />
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>답변쓰기</title>

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

		let image_count = 0;

		function readURL(input, index) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				// onload로 파일을 모두 읽어들이면 바로 function이 실행됨
				reader.onload = function(e) {
					// 첨부파일이 img에서 보일 수 있도록 설정
					$('#preview' + index).attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}

			$('#input_image' + image_count).css("display", "none");
			$('#div_preview' + image_count).css("display", "block");

			image_count++;

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

		function backToList(obj) {
			obj.action = "${contextPath}/inquiry/inquiryList.do";
			obj.submit();
		}

		function fn_remove_image(index) {

			$('#input_image' + index).empty();
			let empty_input = '<input type="file" name="imageFileName" style="display: none">';
			$('#input_image' + index).append(empty_input);

			$('#div_preview' + index).remove();
		}

	</script>
</head>
<body>
	<form action="${contextPath }/inquiry/addNewInquiry.do" name="inquiryForm" method="post"
		  enctype="multipart/form-data">
		<div class="py-20 h-screen bg-gray-300s px-2 inquiry">
			<div class="mx-auto bg-whites rounded-lg overflow-hidden">
				<div class="md:flex">
					<div class="w-full px-4 py-6">
						<b><h1 style="font-size: 30px; margin-bottom: 5px;">1:1 문의 작성</h1></b><br>
						<div class="mb-1"> <span class="text-lg">작성자</span> <input type="text" name="inquiry_title" value="${rocketInfoVO.name }" disabled class="h-12 px-3 w-full border-blue-400 border-2 rounded focus:outline-none focus:border-blue-600 borders"> </div>
						<div class="mb-1"> <span class="text-lg">제목</span> <input type="text" name="inquiry_title" placeholder="제목을 작성해주세요" class="h-12 px-3 w-full border-blue-400s border-2 rounded focus:outline-none focus:border-blue-600s borders" > </div>
						<div class="mb-1"> <span class="text-lg">내용</span> <textarea type="text" name="inquiry_content" placeholder="내용을 작성해주세요" class="h-24 py-1 px-3 w-full border-2 border-blue-400s rounded focus:outline-none focus:border-blue-600s resize-none borders"></textarea> </div>
						<div class="mb-1"> <span class="text-sm text-gray-400">첨부파일은 아래에 추가해주세요</span> </div>
						<br>
						<span>첨부파일</span>
						<div class="mb-1" id="input_image0">
							<div class="relative border-dotted h-32 rounded-lg border-dashed border-2 border-blue-700s bg-gray-100 flex justify-center items-center borders">
								<div class="absolute">
									<div class="flex flex-col items-center"> <i class="fa fa-folder-open fa-3x text-blue-700" style="color: #F34F30;"></i> <span class="block text-gray-400 font-normal">이곳을 클릭하여 파일을 추가해주세요</span> </div>
								</div>
								<input type="file" name="imageFileName0" onchange="readURL(this, 0)" class="h-full w-full opacity-0">
							</div>
						</div>
						<div class="mb-1" style="display: none;" id="div_preview0">
							<div style="padding: 20px;" align="center" class="relative border-dotteds h-32s rounded-lg border-dasheds border-2 border-blue-700s bg-gray-100 flexs justify-center items-center borderss">
								<i style="float: right; font-size: 22px;" onclick="fn_remove_image(0)" class="fa-solid fa-circle-xmark"></i>
								<img style="height: 480px" id="preview0" src="" alt="이미지 미리보기">
							</div>
						</div>
						<div class="mb-1" id="allImageSection"></div>
						<div class="mt-3 text-right">
							<button type="submit" class="btns btn-primarys">답글 쓰기
							</button>
							<button onclick="backToList(this.form)" class="btns btn-out">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>