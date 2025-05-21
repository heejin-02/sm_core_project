<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>토론장</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/share.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/discuss_list.css" />
</head>
<body>
	<div class="wrapper">
		<%@ include file="header.jsp"%>

		<!-- 배너 -->
		<div class="main_banner">
			<div class="title">
				<p class="banner_title">다른 사람들과 의견을 나눠봐요</p>
				<p class="banner_body">토론을 통해 다른 사람과 의견을 나누고 더 좋은 아이디어를 찾아보세요.</p>
			</div>
			<button class="basic_btn"
				onclick="location.href='${pageContext.request.contextPath}/discuss_post'">토론방
				생성하기</button>
		</div>

		<!-- 제목 -->
		<div class="list_title_div">
			<p class="list_title">토론 목록</p>
			<p class="list_body">관심있는 토론에 참여해 다른 사람들의 의견을 살펴보세요!</p>
		</div>

		<!-- 검색창 -->
		<div class="discuss_search">
  <form action="${pageContext.request.contextPath}/discuss_list" method="get" class="search_form_flex">
    <select name="search_range">
      <option value="all">전체 범위</option>
      <option value="title">제목</option>
      <option value="content">내용</option>
    </select>

    <select name="search_category">
      <option value="all">전체 카테고리</option>
      <option value="학교생활">학교생활</option>
      <option value="지역사회">지역사회</option>
      <option value="문화생활">문화생활</option>
      <option value="사회문제">사회문제</option>
    </select>

    <input type="text" name="keyword" placeholder="관심 주제를 입력해주세요." value="${param.keyword}" />
    <input class="submit_btn" type="submit" value="검색" />
  </form>
</div>

		<!-- 토론방 리스트 -->
		<div class="discuss_content_list">
			<c:if test="${empty rooms}">
				<p class="no_results">등록된 토론방이 없습니다.</p>
			</c:if>

			<c:forEach var="room" items="${rooms}">
				<div class="discuss_box">
					<!-- 헤더 -->
					<div class="discuss_box_header">
						<p class="discuss_box_header_category">${room.droom_category}</p>
						<span class="discuss_box_status"> <c:choose>
								<c:when test="${room.droom_st eq '진행중'}">토론 진행 중</c:when>
								<c:otherwise>종료된 토론</c:otherwise>
							</c:choose>
						</span>
					</div>

					<!-- 본문 -->
					<div class="discuss_box_content">
						<p class="discuss_box_date">
							<fmt:formatDate value="${room.create_at}" pattern="yyyy.MM.dd" />
							토론
						</p>
						<p class="discuss_box_content_title">${room.droom_title}</p>

						<!-- AI 요약 -->
						<p class="discuss_box_ai_summary_title">AI 토론 요약</p>
						<p class="discuss_box_ai_summary_body">${room.droom_info}</p>

						<hr />
						<div class="discuss_box_footer_row">
							<div class="discuss_box_user">
								<span>👤 ${room.id}</span>
							</div>
							<div class="discuss_box_count">
								<span>💬 ${room.droom_limit}명</span>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>

		<%@ include file="footer.jsp"%>
	</div>
</body>
</html>
