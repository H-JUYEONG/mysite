<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페이징</title>
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/board.css" rel="stylesheet" type="text/css">

<!-- Axios 라이브러리 포함 -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

</head>


<body>
	<div id="wrap">

		<!-- header + nav -->
		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>

		<div id="container" class="clearfix">
			<div id="aside">
				<h2>게시판</h2>
				<ul>
					<li><a href="">일반게시판</a></li>
					<li><a href="">댓글게시판</a></li>
				</ul>
			</div>
			<!-- //aside -->

			<div id="content">

				<div id="content-head">
					<h3>일반게시판</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>게시판</li>
							<li class="last">일반게시판</li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<!-- //content-head -->
	
				<div id="board">
					<div id="list">
						<form action="" method="">
							<div class="form-group text-right">
								<input type="text" name="keyword" value="">
								<button type="submit" id=btn_search>검색</button>
							</div>
						</form>
						<table >
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>글쓴이</th>
									<th>조회수</th>
									<th>작성일</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${requestScope.pMap.tboardList}" var="tboardVo">
								<tr>
									<td>${tboardVo.no}</td>
									<td class="text-left"><a href="#">${tboardVo.title}</a></td>
									<td>${tboardVo.name}</td>
									<td>${tboardVo.hit}</td>
									<td>${tboardVo.regDate}</td>
									<td><a href="">[삭제]</a></td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
			
					<div id="paging">
						<ul>
							<c:if test="${requestScope.pMap.prev}">
								<li><a href="${pageContext.request.contextPath}/tboard/list3?crtpage=${requestScope.pMap.startPageBtnNo-1}&keyword=${param.keyword}">◀</a></li>
							</c:if>
								
							<c:forEach begin="${requestScope.pMap.startPageBtnNo}" end="${requestScope.pMap.endPageBtnNo}" step="1" var="page">
								<c:choose>
									<c:when test="${param.crtpage == page}">
										<li class="active"><a href="${pageContext.request.contextPath}/tboard/list3?crtpage=${page}&keyword=${param.keyword}">${page}</a></li>
									</c:when>
									<c:otherwise>
										<li class=""><a href="${pageContext.request.contextPath}/tboard/list3?crtpage=${page}&keyword=${param.keyword}">${page}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
									
							<c:if test="${requestScope.pMap.next}">
								<li><a href="${pageContext.request.contextPath}/tboard/list3?crtpage=${requestScope.pMap.endPageBtnNo+1}&keyword=${param.keyword}">▶</a></li>
							</c:if>
						</ul>
						<div class="clear"></div>
					</div>
						<a id="btn_write" href="">글쓰기</a>
					
					</div>
					<!-- //list -->
				</div>
				<!-- //board -->
			</div>
			<!-- //content  -->

		</div>
		<!-- //container  -->
		

		<!-- footer -->
		<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
	</div>
	<!-- //wrap -->

</body>

</html>
