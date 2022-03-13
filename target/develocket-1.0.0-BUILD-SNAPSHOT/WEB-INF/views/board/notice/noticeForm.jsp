<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>공지사항 작성</title>
	<script type="text/javascript">
	
	</script>
	
</head>
<body>
	<h1>공지사항 작성</h1>
	<form action="${contextPath}/board/addNotice.do" method="post">
		<table>
			<tr>
				<td>글 제목</td>
				<td><input type="text" placeholder="여기에 제목을 쓰세요"></td>
			</tr>
			<tr>
				<td>글 내용</td>
				<td>
					<textarea rows="10" cols="50" placeholder="여기에 내용을 쓰세요"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					파일 첨부
				</td>
				<td>
					<input type="file">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="등록하기">
					<input type="button" value="취소" onclick="backToList()">
				</td>
			</tr>
		</table>
	</form>
	
</body>
</html>