<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<c:set var="previewVOList" value="${previewVOList }"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Develocket</title>
    
    <style type="text/css">
    .slides-li{ list-style-type: none; } /* 보여줄 구간의 높이와 넓이 설정 */ 
    #slideShow{ width: 1080px; height: 680px; position: relative; margin: 50px auto; overflow: hidden; /*리스트 형식으로 이미지를 일렬로 정렬할 것이기 때문에, 500px 밖으로 튀어 나간 이미지들은 hidden으로 숨겨줘야됨*/ } 
    .slides{ position: absolute; left: 0; top: 0; width: 2500px; /* 슬라이드할 사진과 마진 총 넓이 */ transition: left 0.5s ease-out; /*ease-out: 처음에는 느렸다가 점점 빨라짐*/ } 
    /* 첫 번째 슬라이드 가운데에 정렬하기위해 첫번째 슬라이드만 margin-left조정 */ 
    .slides li:first-child{ margin-left: 100px; } /* 슬라이드들 옆으로 정렬 */ 
    .slides li:not(:last-child){ float: left; margin-right: 100px; } 
    .slides li{ float: left; } 
    .controller span{ position:absolute; background-color: transparent; color: black; text-align: center; border-radius: 50%; padding: 10px 20px; top: 50%; font-size: 1.3em; cursor: pointer; } /* 이전, 다음 화살표에 마우스 커서가 올라가 있을때 */ 
    .controller span:hover{ background-color: rgba(128, 128, 128, 0.11); } 
    .prevs{ left: 10px; } /* 이전 화살표에 마우스 커서가 올라가 있을때 이전 화살표가 살짝 왼쪽으로 이동하는 효과*/ 
    .prevs:hover{ transform: translateX(-10px); } 
    .nexts{ right: 10px; } /* 다음 화살표에 마우스 커서가 올라가 있을때 이전 화살표가 살짝 오른쪽으로 이동하는 효과*/ 
    .nexts:hover{ transform: translateX(10px); }

    
    </style>
    
    <script type="text/javascript">
    var index = 0;   //이미지에 접근하는 인덱스
    window.onload = function(){
        slideShow();
    }
    
    function slideShow() {
    var i;
    var x = document.getElementsByClassName("slide1");  //slide1에 대한 dom 참조
    for (i = 0; i < x.length; i++) {
       x[i].style.display = "none";   //처음에 전부 display를 none으로 한다.
    }
    index++;
    if (index > x.length) {
        index = 1;  //인덱스가 초과되면 1로 변경
    }   
    x[index-1].style.display = "block";  //해당 인덱스는 block으로
    setTimeout(slideShow, 2500);   //함수를 4초마다 호출
 
	}
    </script>
</head>
<body>
<!-- Begin Site Title ================================================== -->
<div class="container">
    <div class="mainheading">
    
    	<div>
		  <img class="slide1" src="${contextPath}/resources/image/common/banner.png" >
		  <img class="slide1" src="${contextPath}/resources/image/common/banner2.png">
		  <img class="slide1" src="${contextPath}/resources/image/common/banner3.png">
		 </div>
    
    	<%-- <div id="slideShow"> 
    		<ul class="slides"> 
    			<li class="slides-li"><img src="${contextPath}/resources/image/common/banner.png" alt=""></li> 
    			<li class="slides-li"><img src="${contextPath}/resources/image/common/kangstar.jpg" alt=""></li> 
    			<li class="slides-li"><img src="${contextPath}/resources/image/common/banner.png" alt=""></li> 
    			<li class="slides-li"><img src="${contextPath}/resources/image/common/kangstar.jpg" alt=""></li> 
    			<li class="slides-li"><img src="${contextPath}/resources/image/common/banner.png" alt=""></li> 
    			<li class="slides-li"><img src="${contextPath}/resources/image/common/kangstar.jpg" alt=""></li> 
    		</ul> 
    		<p class="controller"> <!-- &lang: 왼쪽 방향 화살표 &rang: 오른쪽 방향 화살표 --> 
    			<span class="prevs">&lang;</span> 
    			<span class="nexts">&rang;</span> 
    		</p> 
    	</div> 
    	<script type="text/javascript">
    	const slides = document.querySelector(".slides"); 
    	//전체 슬라이드 컨테이너 
    	const slideImg = document.querySelectorAll('.slides li'); 
    	//모든 슬라이드들 
    	let currentIdx = 0; //현재 슬라이드 index 
    	const slideCount = slideImg.length; // 슬라이드 개수 
    	const prevs = document.querySelector('.prevs'); //이전 버튼 
    	const nexts = document.querySelector('.nexts'); //다음 버튼 
    	const slideWidth = 300; //한개의 슬라이드 넓이 
    	const slideMargin = 100; //슬라이드간의 margin 값 //전체 슬라이드 컨테이너 넓이 설정 
    	slides.style.width = (slideWidth + slideMargin) * slideCount + 'px'; function moveSlide(num) { slides.style.left = -num * 400 + 'px'; currentIdx = num; } prevs.addEventListener('click', function () { 
    	    /*첫 번째 슬라이드로 표시 됐을때는 이전 버튼 눌러도 아무런 반응 없게 하기 위해 currentIdx !==0일때만 moveSlide 함수 불러옴 */ 
    	    if (currentIdx !== 0) moveSlide(currentIdx - 1); }); nexts.addEventListener('click', function () { 
    	        /* 마지막 슬라이드로 표시 됐을때는 다음 버튼 눌러도 아무런 반응 없게 하기 위해 currentIdx !==slideCount - 1 일때만 moveSlide 함수 불러옴 */ 
    	        if (currentIdx !== slideCount - 1) { moveSlide(currentIdx + 1); } });
    	    
    	    
    	</script> --%>
    	


        <%-- <img src="${contextPath}/resources/image/common/banner.png" alt="banner" style="width: 100%;"> --%>
        <!-- <h1 class="sitetitle">Develocket</h1>
        <p class="lead">
            당신의 재능! 로켓에게 판매하세요!!
        </p> -->
    </div>
    <!-- End Site Title ================================================== -->

    <!-- Begin Featured ================================================== -->
    <section class="featured-posts">
        <div class="section-title">
            <h2>
                <span>CATEGORY</span></h2>
        </div>
        <div class="category_card">
            <ul class="category_list">
                <li class="category_item">
                    <a class="category_link" href="${contextPath}/starcategory/starcategory_IT.do">
                        <img src="${contextPath}/resources/image/category/1/develocket-spaceman-it.png">
                        <!-- <span class="category_text">IT</span> -->
                    </a>
                </li>
                <li class="category_item">
                    <a class="category_link" href="${contextPath}/starcategory/starcategory_Health.do">
                        <img src="${contextPath }/resources/image/category/1/develocket-spaceman-category.png">
                        <!-- <span class="category_text">건강</span> --></a>
                </li>
                <li class="category_item">
                    <a class="category_link" href="${contextPath}/starcategory/starcategory_Study.do">
                        <img src="${contextPath }/resources/image/category/1/develocket-spaceman-study.png">
                        <!-- <span class="category_text">학업</span> --></a>
                </li>
                <li class="category_item">
                    <a class="category_link" href="${contextPath}/starcategory/starcategory_Lesson.do">
                        <img src="${contextPath }/resources/image/category/1/develocket-spaceman-lesson.png">
                        <!-- <span class="category_text">레슨</span> --></a>
                </li>
                <li class="category_item">
                    <a class="category_link" href="${contextPath}/starcategory/starcategory_ETC.do">
                        <img src="${contextPath }/resources/image/category/1/develocket-spaceman-etc.png">
                        <!-- <span class="category_text">기타</span> --></a>
                </li>
            </ul>
        </div>

    </section>
    <!-- End Featured ================================================== -->

    <!-- Begin List Posts ================================================== -->
    <section class="recent-posts">
        <div class="section-title">
            <h2>
                <span>POPULAR STAR</span></h2>
        </div>
        <div class="card-columns listrecent">
            <c:choose>
                <c:when test="${not empty previewVOList && previewVOList != 'null' }">
                    <c:forEach var="previewVO" items="${previewVOList }">
                        <div class="card">
                            <c:choose>
                                <c:when test="${not empty previewVO.profile_img }">
                                    <a href="${contextPath }/starField/starFieldView.do?star_field_cd=${previewVO.star_field_cd}">
                                        <img class="img-fluid"
                                             src="${contextPath }/starField/download.do?imageFileName=${previewVO.profile_img}&star_field_cd=${previewVO.star_field_cd}"
                                             alt="">
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${contextPath }/starField/starFieldView.do?star_field_cd=${previewVO.star_field_cd}">
                                        <img class="img-fluid" src="${contextPath }/resources/image/common/develocket_spaceman.png"
                                             alt="">
                                    </a>
                                </c:otherwise>
                            </c:choose>
                            <div class="card-block">
                                <h2 class="card-title">
                                    <a href="${contextPath }/starField/starFieldView.do?star_field_cd=${previewVO.star_field_cd}">
                                            ${previewVO.star_nickname }
                                    </a>
                                </h2>
                                <c:choose>
                                    <c:when test="${not empty previewVO.short_intro }">
                                        <h4 class="card-text">${previewVO.short_intro }</h4>
                                    </c:when>
                                    <c:otherwise>
                                        <h4 class="card-text">기본 짧은소개글</h4>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!-- begin post -->
                    <div class="card">
                        <a href="view/starprofile/starprofile.html">
                            <img class="img-fluid" src="${contextPath}/resources/image/common/kangstar.jpg" alt="">
                        </a>
                        <div class="card-block">
                            <h2 class="card-title">
                                <a>강스타</a>
                            </h2>
                            <h4 class="card-text">한줄 소개</h4>
                        </div>
                    </div>
                    <!-- end post -->
                </c:otherwise>
            </c:choose>
        </div>
    </section>
</div>
</body>
</html>