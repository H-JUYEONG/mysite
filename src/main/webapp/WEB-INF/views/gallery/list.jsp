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
								<li id="i-${GalleryVo.no}">
									<div class="view" >
										<img class="imgItem" data-no="${GalleryVo.no}" data-userno="${GalleryVo.userNo}" src="${pageContext.request.contextPath}/upload/${GalleryVo.saveName}">
										<div class="imgWriter">작성자: <strong>${GalleryVo.name}</strong></div>
									</div>
								</li>
							<!-- 이미지반복영역 -->
							</c:forEach>
						</ul>
					</div>
					<!-- //list -->
					
				<!-- 이미지 올리기 모달창 -->
				<div id="uploadImg" class="modal">
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
					
				<!-- 이미지보기 및 삭제 모달창 -->
				<div id="showImg" class="modal">
					<div id="img-form" class="modal-content">
						<p>이미지보기</p>
						<button class="closeBtn" id="closeBtn2" type="button">×</button>
                   		<div class="m-body">
                   			<img class="imgItem" id="show" src="">
                   		</div>
                   			<div>
                   				<button id="btnDelete" class="btnDelete" type="button">삭제</button>
                   			</div>
                   		<div>
                   			<input id="modalNo" class="m-no" type="text" name="no" value="">
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
		
		// 이미지 업로드 모달창 띄우기 버튼 클릭이벤트 등록
		let uploadBtn = document.querySelector('#btnImgUpload');
		uploadBtn.addEventListener('click', callModal);
		
		// 이미지 업로드 모달창 닫기 버튼 클릭이벤트 등록
		let closeBtn = document.querySelector('#closeBtn');
		closeBtn.addEventListener('click', closeModal);
		
		// 이미지보기 모달창 띄우기 버튼 클릭이벤트 등록
		let showImg = document.querySelector('#viewArea');
		showImg.addEventListener('click', showImgModal);
		
		// 이미지보기 모달창 닫기 버튼 클릭이벤트 등록
		let closeBtn2 = document.querySelector('#closeBtn2');
		closeBtn2.addEventListener('click', closeImgModal);
		
		// 이미지보기 모달창 삭제 버튼 클릭이벤트 등록
		let btnDelete = document.querySelector('#btnDelete');
		btnDelete.addEventListener('click', deleteRemove);

	});
	
	// 이미지 업로드 모달창 보이기
	function callModal() {
		let modalTag = document.querySelector('#uploadImg');
		modalTag.style.display = 'block';
	}
	
	// 이미지 업로드 모달창 닫기
	function closeModal() {
		let modalTag = document.querySelector('#uploadImg');
		modalTag.style.display = 'none';
	}
	
	// 이미지보기 모달창 보이기
	function showImgModal(event) {
		
		if(event.target.tagName == 'IMG') {
			console.log('클릭');
			
			// 갤러리 리스트의 이미지 값 가져오기
			let src = event.target.src;  // 주소
			let no = event.target.dataset.no; // 이미지 번호
			let userNo = event.target.dataset.userno; // 글 작성자의 번호
			let userSession = ${sessionScope.authUser.no}; // 로그인한 회원번호 
			
			// 이미지보기 모달창에 가져온 이미지 주소 값 넣기
			let imgTag = document.querySelector('#show');
			imgTag.src = src;
			
			// 이미지보기 모달창 input에 가져온 no 값 넣기
			let txtNoTag = document.querySelector('#modalNo');
			txtNoTag.value = no;
			
			// 삭제 버튼 id 가져오기
			let btnDelete = document.querySelector('#btnDelete');
			
			if (userSession == userNo) {
				btnDelete.style.display = 'block'; // 삭제 버튼 보이기
	        } else {
	            btnDelete.style.display = 'none'; // 삭제 버튼 숨기기
	        }
			
			// 모달창 보이게 처리
			let modalTag = document.querySelector('#showImg');
			modalTag.style.display = 'block';
		}
	}
	
	// 이미지보기 모달창 닫기
	function closeImgModal() {
		
		let modalTag = document.querySelector('#showImg');
		modalTag.style.display = 'none';
	}
	
	// 이미지 삭제
	function deleteRemove() {
		
		// input에 넣어둔 no의 value를 가져온다.
		let txtNoTag = document.querySelector('#modalNo');
		let no = txtNoTag.value;
		
		// DB에서 데이터 삭제(서버에 전송해서 삭제)
		axios({
			method: 'get', // put, post, delete
			url: '${pageContext.request.contextPath}/api/gallery/remove',
			headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
			params: { no: no }, //get방식 파라미터로 값이 전달
			//data: guestbookVo, //put, post, delete 방식 자동으로 JSON으로 변환 전달
			
			responseType: 'json' //수신타입
		}).then(function (response) {
				console.log(response); //수신데이터
				console.log(response.data);
				
				// 화면에서 지우기
				let delId = '#i-' + no;
				let removeList = document.querySelector(delId);
				removeList.remove();
					
				// 모달창 닫기
				closeImgModal();
				
				
		}).catch(function (error) {
				console.log(error);
		});
		
	}

	</script>
</body>
</html>

