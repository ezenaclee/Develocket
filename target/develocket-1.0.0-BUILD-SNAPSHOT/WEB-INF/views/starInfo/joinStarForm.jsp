<%@page import="org.json.JSONArray"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.Reader"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	JSONParser parser = new JSONParser();

	Reader reader = null;
	try {
		reader = new FileReader("C:\\develocket\\Develocket_T\\src\\main\\webapp\\resources\\json\\field.json");

	} catch (FileNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	org.json.simple.JSONObject jsonSimpleObject = null;
	try {
		jsonSimpleObject = (org.json.simple.JSONObject) parser.parse(reader);
	} catch (Exception e) {
		e.printStackTrace();
	}

	JSONObject jsonObject = new JSONObject(jsonSimpleObject.toJSONString());

	List<String> largeFieldList = new ArrayList<String>();
	Map<String, List<String>> middleMap = new HashMap<String, List<String>>();
	List<String> middleKeyList = new ArrayList<>();
	Map<String, List<String>> smallMap = new HashMap<String, List<String>>();

	Iterator<String> iterator = jsonObject.keys();
	while (iterator.hasNext()) {
		String field = iterator.next().toString();
		largeFieldList.add(field);
	}


	for (String large : largeFieldList) {
		List<String> tempList = new ArrayList<String>();

		JSONObject jsonObject2 = (JSONObject) jsonObject.get(large);
		Iterator<String> iteratorM = jsonObject2.keys();
		while (iteratorM.hasNext()) {
			String field = iteratorM.next().toString();
			tempList.add(field);
		}
		middleMap.put(large, tempList);

		for (String middleKey : tempList) {
			middleKeyList.add(middleKey);
		}

	}

	for (String large : largeFieldList) {
		List<String> middleList = middleMap.get(large);
		JSONObject jsonObject2 = jsonObject.getJSONObject(large);

		for (String middle : middleList) {
			List<String> tempList = new ArrayList<String>();
			JSONArray jsonArray = jsonObject2.getJSONArray(middle);

			if (jsonArray != null) {
				for (int i = 0; i < jsonArray.length(); i++) {
					tempList.add(jsonArray.get(i).toString());
				}
			}
			smallMap.put(middle, tempList);
		}

	}

	String[] field_L = {"IT", "건강/미용", "학업", "레슨"};


%>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" />
<c:set var="field_L" value="<%= field_L %>" />
<c:set var="field_M" value="<%= middleMap %>" />
<c:set var="field_S" value="<%= smallMap %>" />
<c:set var="star_cd" value="${star_cd }" />
<html>
<head>
	<title>스타등록창</title>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

	<script type="text/javascript">
		function fn_addButton(field) {

			$("#second_button").empty();
			$("#third_button").empty();
			$("#four").empty();

			var innerHtml = '';
			<%
				for (String key : field_L) {
			%>
			var key_s = '<%=key %>';
			if (key_s == field) {
				<%
                    for (String value : middleMap.get(key)) {
                    %>
				var value_s = '<%=value %>';
				<c:set var="value_s" value="<%=value %>" />
				innerHtml += '<button class="btn btn-pill text-white" onclick="fn_addButton2(' + '\'${value_s}\'' + ')" id="' + value_s + '">' + value_s + '</button>';
				<%}%>
			}
			<%}%>
			$("#second_button").append(innerHtml);
		}

		function fn_addButton2(field) {

			$("#third_button").empty();
			$("#four").empty();

			var innerHtml = '';
			<%for (String key : middleKeyList) {%>
			var key_s = '<%=key%>';
			if (key_s == field) {
				<%for (String value : smallMap.get(key)) {%>
				var value_s = '<%=value%>';
				<c:set var="value_s" value="<%=value %>" />
				innerHtml += '<button class="btn btn-pill text-white" onclick="fn_addButton3(' + '\'${value_s}\'' + ')" id="' + value_s + '">' + value_s + '</button>';
				<%}%>
			}
			<%}%>

			$("#third_button").append(innerHtml);
		}

		function fn_addButton3(field) {

			var star_cd = ${star_cd};

			if (star_cd == '0') {
				$("#four").empty();

				var smallCategory = document.createElement('input');
				smallCategory.setAttribute("type","text");
				smallCategory.setAttribute("name","small_category");
				smallCategory.setAttribute("value", field);
				smallCategory.setAttribute("readOnly", true);

				$("#four").append(smallCategory);
				$("#submit_btn").css("visibility", "visible");

			}
			else {
				$("#four").empty();

				var category = document.createElement('input');
				category.setAttribute("type", "text");
				category.setAttribute("name", "cate_s")
				category.setAttribute("value", field);
				category.setAttribute("readOnly", true);

				var inputStarCD = document.createElement('input');
				inputStarCD.setAttribute("type", "hidden");
				inputStarCD.setAttribute("name", "star_cd")
				inputStarCD.setAttribute("value", star_cd);
				inputStarCD.setAttribute("readOnly", true);

				$("#four").append(category);
				$("#four").append(inputStarCD);

				var regBtn = document.createElement('input');
				regBtn.setAttribute("type","button");
				regBtn.setAttribute("value", "스타등록하기");
				regBtn.setAttribute("onclick", "fn_submit()");

				$("#four").append(regBtn);


			}


		}

		function fn_submit() {
			$('#form').attr("action", "${contextPath}/starInfo/joinExtra.do");
			$('#form').submit();
		}


		// 빈값 체크
		function fn_checkAll() {
			var star_cd = ${star_cd};

			if (star_cd == '0') {
				if (!checkNickName(form.star_nickname.value)) {
					return false;
				}
				else if (!checkArea(form.area.value)) {
					return false;
				}
				else {
					return true;
				}
			}
			else {
				return true;
			}

		}


		function checkExistData(value, dataName) {
			if (value == "") {
				alert(dataName);
				return false;
			}
			return true;
		}

		function checkNickName(nickName) {

			if (!checkExistData(nickName, "닉네임을 입력해주세요.")) {
				form.star_nickname.focus();
				return false;
			}
			else if (nickName.search(/\s/) != -1){
				alert("닉네임은 공백 없이 입력해주세요.");
				form.star_nickname.value = null;
				form.star_nickname.focus();
				return false;
			}
			else if (nicknameCheckCount == 0) {
				alert("닉네임 중복체크를 진행해주세요.")
				return false;
			}
			else {
				return true;
			}
		}

		function checkArea(area) {
			if (!checkExistData(area, "활동 지역을 설정해주세요."))
				return false;

			return true;
		}

		var nicknameCheckCount = 0;
		function fn_duplicateNickName() {

			let _star_nickname = $('#nickname').val();

			if (_star_nickname.length < 3) {
				alert("3글자 이상 입력해주세요.");
				$('#nickname').focus();
				return;
			}

			$.ajax({
				url:"http://localhost:8080/develocket/starInfo/duplicateCheck.do",
				type:'post',
				dataType: "text",
				data:{star_nickname: _star_nickname},
				success:function(count){
					if(count != 1) {
						alert("사용할 수 있는 닉네임입니다.");
						$('#nickname_check').prop("disabled", true);
						$('#nickname').prop("readonly", true);
						nicknameCheckCount = 1;

					} else {
						alert("사용할 수 없는 닉네임입니다.");
						$('#nickname').focus();
					}
				},
				error:function(){
					alert("에러입니다.");
				}
			});
		}

		function fn_cancel() {
			$('#nickname_check').prop("disabled", false);
			$('#nickname').prop("readonly", false);
			nicknameCheckCount = 0;
		}
	</script>

	<!-- Style -->
	<link rel="stylesheet" href="${contextPath}/resources/css/starInfo/joinstarform.css">

</head>
<body>
<div class="container">
	<div class="mainheading">
		<%--<img src="${contextPath}/resources/image/common/banner.png" alt="banner" style="width: 100%;">--%>
		<h1 class="sitetitle">STAR REGISTER</h1>
		<p class="lead">
			스타등록후 로켓에게 당신의 재능을 판매해보세요!
		</p>
	</div>

	<section class="featured-posts">
		<div class="section-title">
			<h2>
				<span>INFORMATION</span>
			</h2>
		</div>
		<div id="Large_Field">
			<c:forEach var="large" items="${field_L }">
				<button onclick="fn_addButton('${large}');" id="${large}" class="btn btn-pill text-white">${large}</button>
			</c:forEach>
		</div>

		<div width="100%" border="0" id="second_button"></div>
		<div width="100%" border="0" id="third_button"></div>

		<div id="star_div">
			<form action="${contextPath}/starInfo/join.do}" method="post"
				  id="form" name="form"	onsubmit="return fn_checkAll();">
				<div id="four"></div>
				<c:if test="${star_cd == '0' }">
					<div class="section-title">
						<h2>
							<span>NICKNAME</span>
						</h2>
					</div>
					<div id="star_nickname">
						닉네임: <input type="text" style="width: 250px" id="nickname" name="star_nickname" minlength="3"  maxlength="9" placeholder="3~9자리로 입력해주세요.">
						<button type="button" class="btn btn-pill text-white" id="nickname_check" onclick="fn_duplicateNickName()">중복체크</button>
						<button type="button" class="btn btn-pill text-white" id="cancel_btn" onclick="fn_cancel()">취소</button>
					</div>
					<div class="section-title">
						<h2>
							<span>HOME</span>
						</h2>
					</div>
					<div id="star_home">
						<input type="text" id="sample5_address" name="area" placeholder="주소" style="width:350px;" readonly>
						<input type="button" class="btn btn-pill text-white" id="star_address_btn" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
						<div id="map" style="width:500px; height:500px; margin-top:30px; display:none"></div>
					</div>
					<input id="submit_btn" class="btn btn-pill text-white" type="submit" value="스타등록하기" style="visibility: hidden;">
				</c:if>
			</form>

			<c:if test="${star_cd == '0' }">
				<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=93e0c8ed2e4ac36fabb65e15da2bc39c&libraries=services"></script>
				<script>
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div
							mapOption = {
								center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
								level: 5 // 지도의 확대 레벨
							};

					//지도를 미리 생성
					var map = new daum.maps.Map(mapContainer, mapOption);
					//주소-좌표 변환 객체를 생성
					var geocoder = new daum.maps.services.Geocoder();
					//마커를 미리 생성
					var marker = new daum.maps.Marker({
						position: new daum.maps.LatLng(37.537187, 127.005476),
						map: map
					});


					function sample5_execDaumPostcode() {
						new daum.Postcode({
							oncomplete: function(data) {
								var addr = data.address; // 최종 주소 변수

								// 주소 정보를 해당 필드에 넣는다.
								document.getElementById("sample5_address").value = addr;
								// 주소로 상세 정보를 검색
								geocoder.addressSearch(data.address, function(results, status) {
									// 정상적으로 검색이 완료됐으면
									if (status === daum.maps.services.Status.OK) {

										var result = results[0]; //첫번째 결과의 값을 활용

										// 해당 주소에 대한 좌표를 받아서
										var coords = new daum.maps.LatLng(result.y, result.x);
										// 지도를 보여준다.
										mapContainer.style.display = "block";
										map.relayout();
										// 지도 중심을 변경한다.
										map.setCenter(coords);
										// 마커를 결과값으로 받은 위치로 옮긴다.
										marker.setPosition(coords)
									}
								});
							}
						}).open();
					}
				</script>
			</c:if>
		</div>
	</section>
</div>
</body>
</html>