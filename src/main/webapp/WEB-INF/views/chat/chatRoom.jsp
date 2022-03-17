<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="chatContentVOList" value="${chatContentVOList }" />
<c:set var="chatRoomVO" value="${chatRoomVO }" />
<c:set var="hide_check" value="${chatRoomVO.hide_check }" />
<c:set var="contract_cd" value="${contract_cd }" />
<c:set var="user_cd" value="${user_cd }" />
<c:set var="rocket_cd" value="${chatRoomVO.rocket_cd }r" />
<c:set var="star_cd" value="${chatRoomVO.star_cd }s" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>채팅창</title>

	<link href="${contextPath}/resources/chat/chatRoom/chatRoom_bootstrap.min.css" rel="stylesheet" />
	<link href='https://use.fontawesome.com/releases/v5.7.2/css/all.css' rel='stylesheet'>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<link href="${contextPath}/resources/chat/chatRoom/chatRoom_style.css" rel="stylesheet" />

	<style type="text/css">
	
		#closeBtn {
			margin-bottom: 3px;
			position: relative;
			
		}
	
		.myMsg {
			text-align: right;
		}
	</style>
	
	<script type="text/javascript">
		let webSocket = new WebSocket("<%=application.getInitParameter("CHATSERVER_ADDR") %>/chatingServer");
		
		let chat_content, chatMessage;
		let _contract_cd = '${contract_cd}';
		let _user_cd = '${user_cd}';
		let _star_field_cd = '${chatRoomVO.star_field_cd}';
		let _rocket_cd = '${rocket_cd}';
		let _name = '${chatRoomVO.name}';
		let _star_nickname = '${chatRoomVO.star_nickname}';
		let _profile_img = '${chatRoomVO.profile_img}';
		let _profile_img_r = '${chatRoomVO.profile_img_r}';
		
		// 채팅창이 열리면 대화창, 메시지 입력창, 대화명 표시란으로 사용할 DOM 객체 지정
		window.onload = function() {
			chat_content = document.getElementById("chat-content");
			chatMessage = document.getElementById("chatMessage");
		
		}
		
		// 클라이언트의 메시지 전송하는 메서드임
		function sendMessage() {
			// 대화창에 표시
			var innerHTML = '<div class="media media-chat media-chat-reverse"><div class="media-body"><p>' + chatMessage.value + '</p></div></div>';
			$('#chat-content').append(innerHTML);
			
			webSocket.send(_user_cd + '|' + chatMessage.value);
			chat_content.scrollTop = chat_content.scrollHeight;
			
			insertDB();
			
			document.getElementById("chatMessage").value = null;
		}
		
		// DB에 채팅메세지 저장
		function insertDB() {
			$.ajax({
				type: "post",
				async: false,
				url: "http://221.148.239.155:8080/develocket/chat/saveChattingMessage.do",
				dataType: "text",
				data: {contract_cd: _contract_cd, user_cd: _user_cd, message: chatMessage.value},
				success: function(result, textStatus) {
					
				},
				error: function(data, textStatus) {
					alert("에러가 발생했습니다.")
				},
				complete: function(data, textStatus) {
					//
				}
			});
		}
		
		// 서버 연결 종료
		function disconnect() {
			webSocket.close();
		}
		
		function fn_requestReview() {

			var innerHTML = "<div class='media media-meta-day'>" + _name + "님께 리뷰를 요청하였습니다.</div>";

			if (!confirm("리뷰를 요청하시겠습니까?(한번만 가능합니다.)")) {

			}
			else {
				$('#chat-content').append(innerHTML);

				requestReviewDB();
				$('#reviewBtn').remove();

				sendMessageReview();
			}
		}

		function sendMessageReview() {
			// 대화창에 표시
			let messageReview = _star_nickname + "님이 리뷰 작성을 요청하였습니다."
			let reviewMessage = '<a href="${contextPath }/review/reviewForm.do?rocket_cd=${chatRoomVO.rocket_cd }&star_field_cd=${chatRoomVO.star_field_cd}&contract_cd=${contract_cd}">리뷰를 남겨주세요</a>';

			var innerHTML1 = '<div class="media media-chat media-chat-reverse"><div class="media-body"><p>' + '리뷰를 요청하였습니다' + '</p></div></div>';
			$('#chat-content').append(innerHTML1);


			webSocket.send(_user_cd + '|' + messageReview);
			webSocket.send(_user_cd + '|' + reviewMessage);
			chat_content.scrollTop = chat_content.scrollHeight;

			document.getElementById("chatMessage").value = null;
		}

		function fn_endContract() {

			var _contract_cd = '${contract_cd}';

			if (!confirm("거래를 종료하시겠습니까?(확인 시 버튼이 사라집니다.)")) {

			}
			else {
				$('#endBtn').remove();
				location.href = "${contextPath}/chat/endContract.do?contract_cd=" + _contract_cd;
			}
		}
		
		function requestReviewDB() {
			let _message = _star_nickname + "님이 리뷰 작성을 요청하였습니다.";
			
			$.ajax({
				type: "post",
				async: false,
				url: "http://221.148.239.155:8080/develocket/chat/requestReview.do",
				dataType: "text",
				data: {contract_cd: _contract_cd, message: _message},
				success: function(result, textStatus) {
					
				},
				error: function(data, textStatus) {
					alert("에러가 발생했습니다.")
				},
				complete: function(data, textStatus) {
					//
				}
			});
		}
		
		function enterKey() {
			if (window.event.keyCode == 13) {
				sendMessage();
			}
		}
		
		
		/*
			웹소켓과 관련한 이벤트가 발생시 호출되는 함수들 정의
			각 상황은 이벤트로 전달됨 => 리스너가 감지하여 이 메서드들을 호출해줄것임
			호출 시 
		*/
		
		// 웹소켓 서버에 연결됐을 때 실행
		webSocket.onopen = function(event) {
			
			var innerHTML = "";
				
			if (_rocket_cd == _user_cd) {
				innerHTML += '<div class="media media-meta-day">'+_name+'님이 입장하셨습니다.</div>';

			}
			else {
				innerHTML += '<div class="media media-meta-day">'+_star_nickname+'님이 입장하셨습니다.</div>';
			}
			
			$('#chat-content').append(innerHTML);
		}
		
		// 웹소켓이 닫혔을때 실행
		webSocket.onclose = function(event) {
			chat_content.innerHTML += "웹소켓 서버가 종료되었습니다. <br>"
		}
		
		// 에러 발생시 실행
		webSocket.onerror = function(event) {
			alert(event);
			chat_content.innerHTML += "채팅 중 에러가 발생했습니다. <br>"
		}
		
		// 메시지를 받았을 때 실행
		webSocket.onmessage = function(event) {
			let message = event.data.split("|"); 	// 프로필명과 메시지 분리
			let sender = message[0];				// 보낸사람의 프로필명
			let content = message[1];				// 메시지 내용
			
			if (content != "") {
				// 일반대화
				if (_user_cd == _rocket_cd) {
					if (_profile_img != null && _profile_img != "") {
						chat_content.innerHTML += '<div class="media media-chat"><img class="avatar" src="${contextPath }/starField/download.do?imageFileName=${chatRoomVO.profile_img}&star_field_cd=${chatRoomVO.star_field_cd}" alt="상대방 사진"/><div class="media-body"><p>' + content + '</p></div></div>';
					}
					else {
						chat_content.innerHTML += '<div class="media media-chat"><img class="avatar" src="${contextPath}/resources/image/common/develocket_spaceman.png" alt="상대방 사진"/><div class="media-body"><p>' + content + '</p></div></div>';
					}
				}
				else {
					if (_profile_img_r != null && _profile_img_r != "") {
						chat_content.innerHTML += '<div class="media media-chat"><img class="avatar" src="${contextPath }/rocketInfo/download.do?imageFileName=${chatRoomVO.profile_img_r}&rocket_cd=${chatRoomVO.rocket_cd}" alt="상대방 사진"/><div class="media-body"><p>' + content + '</p></div></div>';
					}
					else {
						chat_content.innerHTML += '<div class="media media-chat"><img class="avatar" src="${contextPath}/resources/image/common/develocket_spaceman.png" alt="상대방 사진"/><div class="media-body"><p>' + content + '</p></div></div>';
					}
				}
			}
			chat_content.scrollTop = chat_content.scrollHeight;
		}
	</script>
</head>
<body oncontextmenu="return false" class="snippet-body">
<div class="page-content page-container" id="page-content">
	<div class="padding">
		<div class="row container d-flex justify-content-center">
			<div class="col-md-6">
				<div class="card card-bordered">
					<div class="card-header">
						<h4 class="card-title">
							<strong>
								${chatRoomVO.star_nickname} <${chatRoomVO.cate_l }-${chatRoomVO.cate_m }-${chatRoomVO.cate_s }>
							</strong>
						</h4>
						<div>
							<c:if test="${user_cd == star_cd}">
								<c:if test="${chatRoomVO.status_info == '3'  }">
									<button class="btn btn-xs btn-secondary" id="reviewBtn" onclick="fn_requestReview();" data-abc="true">
										리뷰요청
									</button>
								</c:if>
								<c:if test="${chatRoomVO.status_info >= '3' and chatRoomVO.status_info < '6'  }">
									<button class="btn btn-xs btn-secondary" id="endBtn" onclick="fn_endContract();" data-abc="true">
										거래종료
									</button>
								</c:if>
							</c:if>
						</div>
					</div>
					<div class="ps-container ps-theme-default ps-active-y" id="chat-content" style="overflow-y: scroll !important; height: 400px !important">
						<c:forEach var="chatContentVO" items="${chatContentVOList }">
							<c:choose>
								<c:when test="${chatContentVO.sender_id == 'admin' }">
									<div class="media media-meta-day">${chatContentVO.message }</div>
								</c:when>
								<c:when test="${chatContentVO.sender_id == 'review' }">
									<c:choose>
										<c:when test="${rocket_cd == user_cd }">
											<div class="media media-meta-day">${chatContentVO.message } </div>
											<c:choose>
												<c:when test="${chatRoomVO.status_info == '4' }">
													<div class="media media-meta-day">
														<a href="${contextPath }/review/reviewForm.do?rocket_cd=${chatRoomVO.rocket_cd }&star_field_cd=${chatRoomVO.star_field_cd}&contract_cd=${contract_cd}">
															리뷰를 남겨주세요
														</a>
													</div>
												</c:when>
												<c:otherwise>
													<div class="media media-meta-day">리뷰작성을 완료하였습니다</div>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${chatRoomVO.status_info == '4' }">
													<div class="media media-meta-day">${chatRoomVO.name }님께 리뷰를 요청하였습니다</div>
												</c:when>
												<c:otherwise>
													<div class="media media-meta-day">리뷰작성을 완료하였습니다</div>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:when test="${chatContentVO.sender_id == user_cd }">
									<div class="media media-chat media-chat-reverse">
										<div class="media-body">
											<p>${chatContentVO.message }</p>
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${star_cd == user_cd }">
											<div class="media media-chat">
												<c:choose>
													<c:when test="${not empty chatRoomVO.profile_img_r and chatRoomVO.profile_img_r != null}">
														<img class="avatar" src="${contextPath }/rocketInfo/download.do?imageFileName=${chatRoomVO.profile_img_r}&rocket_cd=${chatRoomVO.rocket_cd}" alt="상대방 사진"/>
													</c:when>
													<c:otherwise>
														<img class="avatar" src="${contextPath}/resources/image/common/develocket_spaceman.png" alt="상대방 사진"/>
													</c:otherwise>
												</c:choose>
												<div class="media-body">
													<p>${chatContentVO.message }</p>
													<p class="meta"><time datetime="2018">23:58</time></p>
												</div>
											</div>
										</c:when>
										<c:when test="${rocket_cd == user_cd }">
											<div class="media media-chat">
												<c:choose>
													<c:when test="${not empty chatRoomVO.profile_img and chatRoomVO.profile_img != null}">
														<img class="avatar" src="${contextPath }/starField/download.do?imageFileName=${chatRoomVO.profile_img}&star_field_cd=${chatRoomVO.star_field_cd}" alt="상대방 사진"/>
													</c:when>
													<c:otherwise>
														<img class="avatar" src="${contextPath}/resources/image/common/develocket_spaceman.png" alt="상대방 사진"/>
													</c:otherwise>
												</c:choose>
												<div class="media-body">
													<p>${chatContentVO.message }</p>
													<p class="meta"><time datetime="2018">23:58</time></p>
												</div>
											</div>
										</c:when>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${fn:contains(hide_check, 'c')}">
							<div class="media media-meta-day">
									${chatRoomVO.name }님이 채팅방을 나가셨습니다.
							</div>
						</c:if>
						<c:if test="${fn:contains(hide_check, 'd')}">
							<div class="media media-meta-day">
									${chatRoomVO.star_nickname }님이 채팅방을 나가셨습니다.
							</div>
						</c:if>
						<div class="ps-scrollbar-x-rail" style="left: 0px; bottom: 0px">
							<div class="ps-scrollbar-x" tabindex="0" style="left: 0px; width: 0px">
							</div>
						</div>
						<div class="ps-scrollbar-y-rail" style="top: 0px; height: 0px; right: 2px">
							<div class="ps-scrollbar-y" tabindex="0" style="top: 0px; height: 2px">
							</div>
						</div>

					</div>

					<div class="publisher bt-1 border-light">
						<input class="publisher-input" id="chatMessage" type="text" onkeyup="enterKey();" placeholder="내용을 작성해주세요"/>
						<button class="publisher-btn text-info" id="sendBtn" onclick="sendMessage();" data-abc="true"><i class="fa fa-paper-plane"></i></button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src=""></script>
<script type="text/javascript" src=""></script>
<script type="text/Javascript"></script>
</body>
</html>