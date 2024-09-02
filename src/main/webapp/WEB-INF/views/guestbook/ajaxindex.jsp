<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax</title>

<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/guestbook.css" rel="stylesheet" type="text/css">

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
				<h2>방명록</h2>
				<ul>
					<li><a href="${pageContext.request.contextPath}/guestbook/listform">일반방명록</a></li>
					<li><a href="${pageContext.request.contextPath}/guestbook/ajaxindex">ajax방명록</a></li>
				</ul>
			</div>
			<!-- //aside -->

			<div id="content">

				<div id="content-head" class="clearfix">
					<h3>일반방명록</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>방명록</li>
							<li class="last">일반방명록</li>
						</ul>
					</div>
				</div>
				<!-- //content-head -->

				<div id="guestbook">
					<form id="guestbookForm" action="${pageContext.request.contextPath}/api/guestbook/write" method="get">
						<table id="guestAdd">
							<colgroup>
								<col style="width: 70px;">
								<col>
								<col style="width: 70px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th>
										<label class="form-text" for="input-uname">이름</label>
									</th>
									<td>
										<input id="input-uname" type="text" name="name" value=""></td>
									<th>
										<label class="form-text" for="input-pass">패스워드</label>
									</th>
									<td><input id="input-pass" type="password" name="pass" value=""></td>
								</tr>
								<tr>
									<td colspan="4"><textarea name="content" cols="72" rows="5"></textarea></td>
								</tr>
								<tr class="button-area">
									<td colspan="4" class="text-center"><button type="submit">등록</button></td>
								</tr>
							</tbody>

						</table>
						<!-- //guestWrite -->
						<input type="hidden" name="action" value="add">
					</form>
					
					
					<!-- 모달 창 컨텐츠 -->
					<div id="myModal" class="modal">
						<div id="guestbook" class="modal-content">
                     	<button class="closeBtn" type="button">×</button>
                     	<div class="m-header">패스워드를 입력하세요</div>
                     	<div class="m-body">
                        <input id="modalPw" class="m-password" type="password" name="password" value=""><br> 
                        <input id="modalNo" class="m-no" type="text" name="no" value="">
                   		</div>
                     <div class="m-footer">
                        <button id="btnDelete" class="btnDelete" type="button">삭제</button>
                     </div>
                  		</div>
               		</div>
					
					<!-- 리스트 자리 -->
					<div id="guestbookListArea">
					<!-- afterbegin(시작후) -->
					</div>
					

				</div>
				<!-- //guestbook -->

			</div>
			<!-- //content  -->
		</div>
		<!-- //container  -->

		<!-- footer -->
		<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
	</div>
	<!-- //wrap -->

	<script>
	document.addEventListener("DOMContentLoaded", function () {
        console.log("DOM tree완료");
        
        // 리스트 가져와서 그리기****************************************************
        getListRender();

        // 방명록 등록하고 그리기 이벤트 등록*************************************************************
    	/* 전송버튼(form, submit) 클릭했을때 */
    	let guestbookForm = document.querySelector('#guestbookForm');
    	guestbookForm.addEventListener('submit', addRender);
    	
    	// 모달창 띄우기 버튼 클릭이벤트 등록
    	let listArea = document.querySelector("#guestbookListArea");
    	listArea.addEventListener('click', callModal);
    	
    	// 모달창 닫기 버튼 클릭이벤트 등록
    	let closeBtn = document.querySelector('.closeBtn');
    	closeBtn.addEventListener('click', closeModal);
    	
    	// 모달창의 삭제버튼 클릭할때 이벤트 등록
    	let btnDelete = document.querySelector('#btnDelete');
    	btnDelete.addEventListener('click', deleteRemove);
    	
	}); // DOMContentLoaded
	
	
// 메소드 정의***************************************************************
	
	// 삭제(삭제폼 아님)
	function deleteRemove() {
		console.log('삭제');
		
		// 데이터 수집
		let modalPwTag = document.querySelector('#modalPw');
		let modalNoTag = document.querySelector('#modalNo');
		
		let password = modalPwTag.value;
		let no = modalNoTag.value;
		
		let guestbookVo = {
			no: no,
			password: password
		};
		
		console.log(guestbookVo);
		
		// DB에서 데이터 삭제(서버에 전송해서 삭제)
		axios({
			method: 'get', // put, post, delete
			url: '${pageContext.request.contextPath}/api/guestbook/remove',
			headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
			params: guestbookVo, //get방식 파라미터로 값이 전달
			//data: guestbookVo, //put, post, delete 방식 자동으로 JSON으로 변환 전달
			
			responseType: 'json' //수신타입
		}).then(function (response) {
				console.log(response); //수신데이터
				console.log(response.data);
				
				if(response.data == true) {
					// 화면에서 지우기
					let delId = '#t-' + no;
					let removeTable = document.querySelector(delId);
					removeTable.remove();
					
					// 모달창 닫기
					closeModal();
					
				} else {
					alert('비밀번호를 확인하세요');
				}
				
		}).catch(function (error) {
				console.log(error);
		});
	}
	
	// 모달창 닫기
	function closeModal(event) {
		console.log('모달창 닫기');
		let modalTag = document.querySelector('#myModal');
		modalTag.style.display = 'none';
	}
	
	// 모달창 보이기
	function callModal(event) {
		
		// console.log(this);
		// console.log(event.target.tagName);
		if(event.target.tagName == 'BUTTON') { // tagName은 무조건 대문자로 비교해야함
			console.log('클릭');
		
			// 버튼안에 태그에서 data-no값 가져오기
			let no = event.target.dataset.no;
			console.log(no);
			
			// 모달창의 input의 value = no
			let txtNoTag = document.querySelector('#modalNo');
			txtNoTag.value = no;
		
			// 모달창 보이게 처리 (display: block 추가)
			let modalTag = document.querySelector('#myModal');
			modalTag.style.display = 'block';
			
			// 이전에 입력한 비밀번호 안보이게 하기
			let txtPwTag = document.querySelector('#modalPw');
			txtPwTag.value = '';
		}
		
	}
	
	// 방명록 등록하고 그리기
	function addRender(event) {
		
		event.preventDefault();
		console.log('전송');
		
		// 폼의 데이터 수집(이름, 패스워드, 본문)
		let nameTag = document.querySelector('#input-uname'); // 공부차원에서 id로 가져옴
		let passwordTag = document.querySelector('[name="pass"]'); // 일관성있게 속성값으로 찾기
		let contentTag = document.querySelector('[name="content"]');
		
		let name = nameTag.value;
		let password = passwordTag.value;
		let content = contentTag.value;

		// 아래 params에 값 전달 (한줄로 써서 직접 넣어도 됨)
		let guestbookVo = { 
			name: name,
			password: password,
			content: content
		};
		console.log(guestbookVo);
		
		// 전송
        axios({
        	method: 'get', // put, post, delete
        	url: '${pageContext.request.contextPath}/api/guestbook/write',
        	headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
        	params: guestbookVo, // get방식 파라미터로 값이 전달 
        	// data: guestbookVo, // put, post, delete 방식 자동으로 JSON으로 변환 전달
        	
        	responseType: 'json' //수신타입
        }).then(function (response) {
        	console.log(response.data); //수신데이터
        
        	// 리스트에 추가(그리기)
        	render(response.data, 'up');
        	
        	// 폼 비우기
        	//guestbookForm.reset(); 한줄로도 가능
        	nameTag.value = ''; 
        	passwordTag.value = ''; 
        	contentTag.value = ''; 
        	
        }).catch(function (error) {
        	console.log(error);
        });
		
	}

	
	// 리스트 가져와서 그리기
	function getListRender() {
		
		// 서버로 데이터 요청
		axios({
        	method: 'get', // put, post, delete
        	url: '${pageContext.request.contextPath}/api/guestbook/list',
        	headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
        	// params: guestbookVo, //get방식 파라미터로 값이 전달
        	// data: guestbookVo, //put, post, delete 방식 자동으로 JSON으로 변환 전달
        	
        	responseType: 'json' //수신타입
        }).then(function (response) {
        	console.log(response.data); //수신데이터
        	
        	for(let i = 0; i < response.data.length; i++) {
               // console.log(response.data[i].name);
               let guestbookVo = response.data[i]
        		render(guestbookVo, 'down');
              }
        	
        }).catch(function (error) {
        	console.log(error);
        });
		
	}
	
	
	/* 그리기 */
	function render(guestbookVo, dir) { // 매개변수 이름은 아무렇게나 가능
		
		// 태그 가져오기
		let listArea = document.querySelector('#guestbookListArea');
		
		let str = '';
		str += '<table id="t-'+ guestbookVo.no +'" class="guestRead">';
		str += '	<colgroup>';
		str += '		<col style="width: 10%;">';
		str += '		<col style="width: 40%;">';
		str += '		<col style="width: 40%;">';
		str += '		<col style="width: 10%;">';
		str += '	</colgroup>';
		str += '	<tr>';
		str += '		<td>' + guestbookVo.no + '</td>';
		str += '		<td>' + guestbookVo.name + '</td>';
		str += '		<td>' + guestbookVo.regDate + '</td>';
		str += '		<td><button class="callModal" type="button" data-no="' + guestbookVo.no + '">삭제(모달창보이기)</button></td>';
		str += '	</tr>';
		str += '	<tr>';
		str += '		<td colspan=4 class="text-left">' + guestbookVo.content + '</td>';
		str += '	</tr>';
		str += '</table>';
		
		if(dir == 'down') {
			listArea.insertAdjacentHTML('beforeend', str);
		} else if (dir == 'up') {
			listArea.insertAdjacentHTML('afterbegin', str);
		} else {
			console.log('방향체크');
		}
	}
	
	</script>

</body>

</html>