<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("utf-8"); %>
<c:set var="pageContext" value="${pageContext.servletContext.contextPath }"/>

    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		function fn_enable(obj) {			
			/* 수정하기 클릭시 수정등록, 취소 버튼을 활성화 시킴 */
		}
		
		function fn_backToList() {
			//메뉴로 돌아가는 버튼
		}
		function fn_modFaq() {
			//수정 후 반영하는 버튼
		}
	</script>
	<title>자주묻는질문 상세보기</title>
</head>
<body>
	<div>
		<h1>질문 제목</h1>
		
	</div>
	<div>
		<form action="#" enctype="multipart/form-data">
			<table >
				<tr align="center" width="450px">
					<td style="border: 1px solid black;" >
						<input type="file" name="" id="" onchange="readURL()">
						<img alt="자주묻는질문 이미지" src="#"		
							id="faqImage" style=" border: 1px solid red;" >		<!-- download.do로 이미지 다운로드 --> 
					</td>
				</tr>
				<tr>
					<td>
						<input type="button" value="목록보기" onclick="fn_backToList()">
					</td>
				</tr>
				
					<%-- <c:if test="만약에 로그인되어있고, 계정이 admin이라면"> --%>
				<tr>
					<td id="">
						<input type="button" value="수정하기" onclick="fn_enable()">
						<input type="button" value="등록하기" onclick="fn_addFaq()">
						<input type="button" value="취소" onclick="fn_backToList()">
					</td>
					<td id="">
						
					</td>									
				</tr>
				<%-- </c:if> --%>
				
				
			</table>
		
		</form>
	</div>
</body>
</html>