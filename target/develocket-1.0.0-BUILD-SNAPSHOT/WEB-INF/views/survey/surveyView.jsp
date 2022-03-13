<%@page import="org.json.JSONArray"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.Reader"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	JSONParser parser = new JSONParser();
	Reader reader = null;
	try {
		reader = new FileReader("C:\\develocket\\Develocket_T\\src\\main\\webapp\\resources\\json\\survey.json");
	} catch (FileNotFoundException e) {
		e.printStackTrace();
	}

	org.json.simple.JSONObject jsonSimpleObject = null;
	try {
		jsonSimpleObject = (org.json.simple.JSONObject) parser.parse(reader);
	} catch (Exception e) {
		e.printStackTrace();
	}

	// json파일을 String 형식으로 변환함
	JSONObject jsonObject = new JSONObject(jsonSimpleObject.toJSONString());

	Map<String, String> surveyMap = new HashMap<>();

	Iterator<String> iterator = jsonObject.keys();
	while (iterator.hasNext()) {
		String key = iterator.next().toString();
		JSONArray jsonArray = jsonObject.getJSONArray(key);
		String value = jsonArray.get(0).toString();

		surveyMap.put(key, value);
	}
%>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" />
<c:set var="surveyMap" value="<%=surveyMap %>"/>
<c:set var="categoryVO" value="${categoryVO }"/>
<c:set var="cate_m" value="${categoryVO.cate_m }"/>
<c:set var="example" value="${surveyMap[cate_m] }"/>
<c:set var="star_field_cd" value="${star_field_cd }" />
<c:set var="active_star_num" value="${active_star_num }" />
<c:set var="total_survey" value="${total_survey }" />
<!DOCTYPE html>
<html class="survey">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,700,900&display=swap" rel="stylesheet">

	<link rel="stylesheet" href="${contextPath }/resources/survey/fonts/icomoon/style.css">

	<link rel="stylesheet" href="${contextPath }/resources/survey/css/owl.carousel.min.css">

	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="${contextPath }/resources/survey/css/bootstrap.min.css">

	<!-- Style -->
	<link rel="stylesheet" href="${contextPath }/resources/survey/css/style.css">


	<title>설문지 작성</title>

	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		var cnt = 1;

		function fn_next() {
			cnt++;

			if (cnt > 4) {
				cnt = 4;

				$('#contactForm').submit();
				return;
			}

			if (cnt == 2) {
				if (!checkLevelA(form.level_a.value)) {
					cnt--;
					return;
				}

				var innerHtml = "원하시는 기간을 입력해주세요.";

				$("#question").empty();
				$("#question").append(innerHtml);

				$('#answer1').css("display", "none");
				$('#answer2').css("display", "block");
				$('#answer3').css("display", "none");
				$('#answer4').css("display", "none");

				var content = $('#answer2').val();
				fn_checkLength(content);
			}
			else if (cnt == 3) {
				if (!checkPeriodA(form.period_a.value)) {
					cnt--;
					return;
				}

				var innerHtml = "원하는 횟수를 입력해주세요.";

				$("#question").empty();
				$("#question").append(innerHtml);

				$('#answer1').css("display", "none");
				$('#answer2').css("display", "none");
				$('#answer3').css("display", "block");
				$('#answer4').css("display", "none");

				var content = $('#answer3').val();
				fn_checkLength(content);
			}
			else if (cnt == 4) {
				if (!checkTimesA(form.times_a.value)) {
					cnt--;
					return;
				}

				var innerHtml = "추가로 입력하고 싶은 내용 적어주세요.";

				$("#question").empty();
				$("#question").append(innerHtml);

				$('#answer1').css("display", "none");
				$('#answer2').css("display", "none");
				$('#answer3').css("display", "none");
				$('#answer4').css("display", "block");

				var content = $('#answer4').val();
				fn_checkLength(content);

				$('#next').attr("value", "견적 보내기");
			}
		}

		function fn_back() {
			cnt--;

			if (cnt < 1) {
				cnt = 1;
				return;
			}

			$("#question").empty();

			if (cnt == 1) {
				var innerHtml = "원하는 목표가 무엇인가요?<br>(최대한 자세히 작성해주세요.)";

				$("#question").empty();
				$("#question").append(innerHtml);

				$('#answer1').css("display", "block");
				$('#answer2').css("display", "none");
				$('#answer3').css("display", "none");
				$('#answer4').css("display", "none");

				var content = $('#answer1').val();
				fn_checkLength(content);

			}
			else if (cnt == 2) {
				var innerHtml = '원하시는 기간을 입력해주세요.';

				$("#question").empty();
				$("#question").append(innerHtml);

				$('#answer1').css("display", "none");
				$('#answer2').css("display", "block");
				$('#answer3').css("display", "none");
				$('#answer4').css("display", "none");

				var content = $('#answer2').val();
				fn_checkLength(content);

			}
			else if (cnt == 3) {
				var innerHtml = '원하는 횟수를 입력해주세요.';

				$("#question").empty();
				$("#question").append(innerHtml);

				$('#answer1').css("display", "none");
				$('#answer2').css("display", "none");
				$('#answer3').css("display", "block");
				$('#answer4').css("display", "none");

				var content = $('#answer3').val();
				fn_checkLength(content);

				$('#next').attr("type", "button");
				$('#next').attr("value", "다음");
			}

		}

		// 글자수 체크
		function fn_checkLength(content) {
			$('#counter').html("("+content.length+" / 최대 500자)");
		}

		function checkExistData(value, dataName) {
			if (value == "") {
				alert(dataName + " 입력해주세요!");
				return false;
			}
			return true;
		}

		function checkLevelA(level_a) {
			if (!checkExistData(level_a, "원하는 목표에 대한 답변을"))
				return false;

			return true;
		}

		function checkPeriodA(period_a) {
			if (!checkExistData(period_a, "원하는 기간에 대한 답변을"))
				return false;

			return true;
		}

		function checkTimesA(times_a) {
			if (!checkExistData(times_a, "원하는 횟수에 대한 답변을"))
				return false;

			return true;
		}

	</script>

</head>
<body>
<div class="content">

	<div class="container">
		<div class="row">
			<div class="col-md-5 mr-auto">
				<h2 class="cateHead"><input type="text" value="${categoryVO.cate_l}" name="cateHead1" id="cateHead1" class="h2" style="font-weight: bold; border: none; background-color: white;" disabled></h2>
				<h3><input type="text" value="${categoryVO.cate_m} - ${categoryVO.cate_s}" name="cateHead2" id="cateHead2" class="h3" style="font-weight: bold; border: none; background-color: white; width: auto;" disabled></h3>

				<br>

				<ul class="list-unstyled pl-md-5 mb-5">
					<li class="d-flex text-black mb-2">
						<span class="mr-3"><span class="icon-star"></span></span>활동스타 : &nbsp;<input type="text" name="starNum" id="starNum" value="${active_star_num}" style="text-align: start; height: 31px; border: none;">
					</li>
					<li class="d-flex text-black mb-2"><span class="mr-3"><span class="icon-file-text-o"></span></span> 누적요청서 : &nbsp;<input type="text" name="surveyNum" id="surveyNum" value="${total_survey}" style="text-align: start; height: 31px; border: none;"></li>
				</ul>

				<p class="mb-5 info">디벨로켓은 어떤 곳인가요? <br>
					서비스가 필요한 로켓과 서비스를 제공하는 스타를 쉽고 빠르게
					연결해드리는 전문가 매칭 서비스입니다.
					<br>설문지를 작성하면, 설문지에 맞는 맞춤형 스타를 매칭해드려요.
					맘에 쏙 드는 스타의 맞춤형 서비스를 받아보세요.</p>

			</div>

			<div class="col-md-6">
				<form action="${contextPath }/survey/joinSurvey.do" class="mb-5" method="post" id="contactForm" name="form" >
					<input type="hidden" name="star_field_cd" value="${star_field_cd }">

					<div class="row">
						<div class="col-md-12 form-group">
							<div>
								<label id="question" class="col-form-label" style="font-weight: bold;">
									원하는 목표가 무엇인가요?<br>
									(최대한 자세히 작성해주세요.)
								</label>
							</div>

							<textarea class="form-control" name="level_a" id="answer1" cols="30" rows="7" placeholder="${example}" style="display: block;"></textarea>
							<textarea class="form-control" name="period_a" id="answer2" cols="30" rows="7" placeholder="3개월 / 6개월" style="display: none;"></textarea>
							<textarea class="form-control" name="times_a" id="answer3" cols="30" rows="7" placeholder="주 3회" style="display: none;"></textarea>
							<textarea class="form-control" name="add_comments_a" id="answer4" cols="30" placeholder="입력해주세요." rows="7" style="display: none;"></textarea>
							<span style="color:#aaa;" id="counter">(0 / 최대 500자)</span>
						</div>
					</div>

					<div class="row">
						<div class="col-md-12">
							<input type="button" value="이전" id="back" onclick="fn_back()" class="btn btn-primary rounded-0 py-2 px-4 beforeBtn">
							<input type="button" value="다음" id="next" onclick="fn_next()" class="btn btn-primary rounded-0 py-2 px-4 nextBtn">
							<span class="submitting"></span>
						</div>
					</div>
				</form>
				<div id="form-message-warning mt-4"></div>
			</div>
		</div>
	</div>
</div>


<script>
	$('#answer1').keyup(function (e){
		var content = $(this).val();
		$('#counter').html("("+content.length+" / 최대 500자)");    //글자수 실시간 카운팅

		if (content.length > 500){
			alert("최대 500자까지 입력 가능합니다.");
			$(this).val(content.substring(0, 500));
			$('#counter').html("(500 / 최대 500자)");
		}
	});

	$('#answer2').keyup(function (e){
		var content = $(this).val();
		$('#counter').html("("+content.length+" / 최대 500자)");    //글자수 실시간 카운팅

		if (content.length > 500){
			alert("최대 500자까지 입력 가능합니다.");
			$(this).val(content.substring(0, 500));
			$('#counter').html("(500 / 최대 500자)");
		}
	});

	$('#answer3').keyup(function (e){
		var content = $(this).val();
		$('#counter').html("("+content.length+" / 최대 500자)");    //글자수 실시간 카운팅

		if (content.length > 500){
			alert("최대 500자까지 입력 가능합니다.");
			$(this).val(content.substring(0, 500));
			$('#counter').html("(500 / 최대 500자)");
		}
	});

	$('#answer4').keyup(function (e){
		var content = $(this).val();
		$('#counter').html("("+content.length+" / 최대 500자)");    //글자수 실시간 카운팅

		if (content.length > 500){
			alert("최대 500자까지 입력 가능합니다.");
			$(this).val(content.substring(0, 500));
			$('#counter').html("(500 / 최대 500자)");
		}
	});
</script>

<script src="${contextPath }/resources/survey/js/jquery-3.3.1.min.js"></script>
<script src="${contextPath }/resources/survey/js/popper.min.js"></script>
<script src="${contextPath }/resources/survey/js/bootstrap.min.js"></script>
<script src="${contextPath }/resources/survey/js/jquery.validate.min.js"></script>
<script src="${contextPath }/resources/survey/js/main.js"></script>

</body>
</html>