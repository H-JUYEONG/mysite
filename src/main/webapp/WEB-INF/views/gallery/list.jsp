<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>갤러리</title>

<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/gallery.css" rel="stylesheet" type="text/css">

<!-- Axios 라이브러리 포함 -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<style>
/* 모달창 배경 회색부분 */
.modal {
   width: 100%; /* 가로전체 */
   height: 100%; /* 세로전체 */
   display: none; /* 시작할때 숨김처리 */
   position: fixed; /* 화면에 고정 */
   left: 0; /* 왼쪽에서 0에서 시작 */
   top: 0; /* 위쪽에서 0에서 시작 */
   z-index: 999; /* 제일위에 */
   overflow: auto; /* 내용이 많으면 스크롤 생김 */
   background-color: rgba(0, 0, 0, 0.4); /* 배경이 검정색에 반투명 */
}

/* 모달창 내용 흰색부분 */
.modal .modal-content {
   width: 400px;
   margin: 100px auto; /* 상하 100px, 좌우 가운데 */
   padding: 0px 20px 20px 20px; /* 안쪽여백 */
   background-color: #ffffff; /* 배경색 흰색 */
   border: 1px solid #888888; /* 테두리 모양 색 */
}

/* 닫기버튼 */
.modal .modal-content .closeBtn {
   text-align: right;
   color: #aaaaaa;
   font-size: 28px;
   font-weight: bold;
   cursor: pointer;
   border: none;
   background-color: #ffffff;
}
</style>





</head>


<body>
	<div id="wrap">

		<!-- header + nav -->
		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>


		<div id="container" class="clearfix">
			<div id="aside">
				<h2>갤러리</h2>
				<ul>
					<li><a href="${pageContext.request.contextPath}/gallery/list">일반갤러리</a></li>
					<li><a href="${pageContext.request.contextPath}/attach/form">파일첨부연습</a></li>
				</ul>
			</div>
			<!-- //aside -->
			
			<div id="content">
				<div id="content-head">
					<h3>일반갤러리</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>갤러리</li>
							<li class="last">일반갤러리</li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<!-- //content-head -->

				
				<div id="gallery">
					<div id="list">
				
						<!-- 로그인에 성공한 유저만 버튼이 보임  -->
						<c:if test="${not empty sessionScope.authUser}">
							<button id="btnImgUpload">이미지올리기</button>
							<div class="clear"></div>
						</c:if>
					
						<ul id="viewArea">
							
							<c:forEach items="${requestScope.galleryList}" var="GalleryVo">
							<!-- 이미지반복영역 -->
								<li>
									<div class="view" >
										<img class="imgItem" src="${pageContext.request.contextPath}/upload/${GalleryVo.saveName}">
										<div class="imgWriter">작성자: <strong>${GalleryVo.name}</strong></div>
									</div>
								</li>
							<!-- 이미지반복영역 -->
							</c:forEach>
						</ul>
					</div>
					<!-- //list -->
					
				<!-- 모달 창 컨텐츠 -->
				<div id="myModal" class="modal">
					<div id="img-form" class="modal-content">
						<p>이미지등록</p>
						<button class="closeBtn" id="closeBtn" type="button">×</button>
                   		<div class="m-body">
                     	<form action="${pageContext.request.contextPath}/gallery/upload" method="post" enctype="multipart/form-data">
						<div class="m-body">
                        	<label for="input-content">글작성</label>
                     		<input id="input-content" type="text" name="content" value="">
                   		</div>
						<table>
							<colgroup>
								<col style="width: 600px;">
								<col style="width: 220px;">
							</colgroup>
							<tr>
								<td class="text-left">
								<label class="form-text">이미지선택</label>
									<input type="file" name="file">
								</td>
								<td class="text-right">
									<button type="submit">등록</button>
								</td>
							</tr>
						</table>
						</form>
                   		</div>
                  	</div>
               	</div>
					
				</div>
				<!-- //	gallery -->

			</div>
			<!-- //content  -->

		</div>
		<!-- //container  -->
	

		<!-- footer -->
		<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
	</div>
	<!-- //wrap -->

	<script>
	document.addEventListener("DOMContentLoaded", function() {
		
		let uploadBtn = document.querySelector('#btnImgUpload');
		uploadBtn.addEventListener('click', callModal);
		
		let closeBtn = document.querySelector('#closeBtn');
		closeBtn.addEventListener('click', closeModal);
		
	});
	
	// 모달창 보이기
	function callModal() {
		let modalTag = document.querySelector('#myModal');
		modalTag.style.display = 'block';
	}
	
	// 모달창 닫기
	function closeModal() {
		let modalTag = document.querySelector('#myModal');
		modalTag.style.display = 'none';
	}
	
	
	
	
	
	
	
	</script>





</body>





</html>

