<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/guestbook.css" rel="stylesheet" type="text/css">

<!-- Axios 라이브러리 포함 -->

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

</head>

<body>
	<div id="wrap">

		<!-- header + nav -->
		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>

		<div id="container" class="clearfix">
			<div id="aside">
				<h2>방명록</h2>
				<ul>
					<li>일반방명록</li>
					<li>ajax방명록</li>
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
        
        //서버로 데이터 요청
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
        		render(guestbookVo);
              }
        	
        }).catch(function (error) {
        	console.log(error);
        });
        
    	/* 전송버튼(form, submit) 클릭했을때 */
    	let guestbookForm = document.querySelector('#guestbookForm');
    	guestbookForm.addEventListener('submit', function(event) {
    		event.preventDefault();
    		console.log('전송');
    		
    		// 폼의 데이터 수집(이름, 패스워드, 본문)
    		let name = document.querySelector('#input-uname').value; // 공부차원에서 id로 가져옴
    		let password = document.querySelector('[name="pass"]').value; // 일관성있게 속성값으로 찾기
    		let content = document.querySelector('[name="content"]').value;
    
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
            	
            	for(let i = 0; i < response.data.length; i++) {
                   // console.log(response.data[i].name);
                   let guestbookVo = response.data[i]
            		render(guestbookVo);
                  }
            	
            }).catch(function (error) {
            	console.log(error);
            });
    		
    	});
	});
	

	
	/* 그리기 */
	function render(guestbookVo) { // 매개변수 이름은 아무렇게나 가능
		
		// 태그 가져오기
		let listArea = document.querySelector('#guestbookListArea');
		
		let str = '';
		str += '<table class="guestRead">';
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
		str += '		<td><a href="">[삭제]</a></td>';
		str += '	</tr>';
		str += '	<tr>';
		str += '		<td colspan=4 class="text-left">' + guestbookVo.content + '</td>';
		str += '	</tr>';
		str += '</table>';
		
		listArea.insertAdjacentHTML('afterbegin', str); // 쿼리문 order by가 asc일 경우에는 beforeend 사용
	}
	

	</script>

</body>

</html>