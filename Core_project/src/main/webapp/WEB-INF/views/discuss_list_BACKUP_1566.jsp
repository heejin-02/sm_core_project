<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>토론장</title>
<link rel="stylesheet" href="resources/assets/css/share.css" />
<link rel="stylesheet" href="resources/assets/css/discuss_list.css" />
</head>
<body>
	<div class="wrapper">
		<%@ include file="header.jsp"%>

		<!-- 배너: 토론방 생성 -->
		<div class="main_banner">
			<div class="title">
				<p class="banner_title">다른 사람들과 의견을 나눠봐요</p>
				<p class="banner_body">토론을 통해 다른 사람과 의견을 나누고 더 좋은 아이디어를 찾아보세요.</p>
			</div>
			<button class="basic_btn" onclick="location.href='${pageContext.request.contextPath}/discuss/post'">토론방 생성하기</button>
		</div>

		<div class="content_list_container">
			<div class="list_title_div">
				<p class="list_title">토론 목록</p>
				<p class="list_body">진행 중인 토론에 참여하거나 종료된 토론을 둘러보세요!</p>
			</div>

			<!-- 검색 폼 (제목으로만 검색) -->
			<div class="discuss_search">
				<form action="${pageContext.request.contextPath}/discuss/list" method="get">
					<input type="text" name="keyword" placeholder="제목으로 검색" value="${keyword}" />
					<input class="submit_btn" type="submit" value="검색" />
				</form>
			</div>

			<!-- 토론방 리스트 -->
			<div class="discuss_content_list">
				<c:if test="${empty rooms}">
					<p style="margin: 30px auto; font-size: 18px; color: #666;">등록된 토론방이 없습니다.</p>
				</c:if>
				<c:forEach var="room" items="${rooms}">
					<div class="discuss_box">
						<!-- 카테고리 -->
						<div class="discuss_box_header">
							<p class="discuss_box_header_category">${room.droom_category}</p>
							<span class="discuss_box_status">
								<c:choose>
									<c:when test="${room.droom_st eq '진행중'}">토론 진행 중</c:when>
									<c:otherwise>종료된 토론</c:otherwise>
								</c:choose>
							</span>
						</div>

						<!-- 내용 -->
						<div class="discuss_box_content">
							<p class="discuss_box_content_title">${room.droom_title}</p>
							<p class="discuss_box_content_intro">${room.droom_info}</p>

							<p class="discuss_box_detail">
								토론 일자 | <fmt:formatDate value="${room.create_at}" pattern="yyyy.MM.dd" />
							</p>
							<p class="discuss_box_detail">토론 인원 | ${room.droom_limit}명</p>
						</div>

						<!-- 버튼 -->
						<div class="discuss_box_footer">
							<form action="discuss_room" method="get">
								<input type="hidden" name="id" value="${room.droom_no}" />
								<c:choose>
									<c:when test="${room.droom_st eq '진행중'}">
										<input type="submit" class="btn_enter" value="토론 참여하기" />
									</c:when>
									<c:otherwise>
										<input type="submit" class="btn_review" value="토론 다시보기" />
									</c:otherwise>
								</c:choose>
							</form>
						</div>
					</div>
				</c:forEach>
			</div>
			<!-- todoo: 페이지 넘기기 추가 -->
		</div>

		<%@ include file="footer.jsp"%>
	</div>
</body>
</html>
