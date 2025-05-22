<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>토론 목록</title>
  <link rel="stylesheet" href="resources/assets/css/share.css" />
  <link rel="stylesheet" href="resources/assets/css/discuss_list.css" />
</head>
<body>
  <div class="wrapper">
    <%@ include file="header.jsp" %>

    <div class="main_banner">
      <div class="title">
        <p class="banner_title">다른 사람들과 의견을 나눠봐요</p>
        <p class="banner_body">토론을 통해 다른 사람과 의견을 나누고 더 좋은 아이디어를 찾아보세요.</p>
      </div>
      <button class="basic_btn"
              onclick="location.href='${pageContext.request.contextPath}/discuss_post'">
        토론 생성하기
      </button>
    </div>

    <div class="content_list_container">
      <div class="list_title_div">
        <p class="list_title">토론 목록</p>
        <p class="list_body">관심있는 토론에 참여해 다른 사람들의 의견을 살펴보세요!</p>
      </div>

      <div class="discuss_search">
        <form action="${pageContext.request.contextPath}/discuss_list" method="get" style="display:flex; gap:10px; align-items:center;">
          <!-- 1) 전체 범위 셀렉트 -->
          <select name="range" class="search_range">
            <option value="">전체 범위</option>
            <option value="진행중" ${
                param.range=='진행중' ? 'selected':'' }>진행 중</option>
            <option value="종료됨" ${
                param.range=='종료됨' ? 'selected':'' }>종료된 토론</option>
          </select>

          <!-- 2) 전체 카테고리 셀렉트 -->
          <select name="category" class="search_category">
            <option value="">전체 카테고리</option>
            <option value="학교생활" ${
                param.category=='학교생활' ? 'selected':'' }>학교생활</option>
            <option value="지역사회" ${
                param.category=='지역사회' ? 'selected':'' }>지역사회</option>
            <option value="문화생활" ${
                param.category=='문화생활' ? 'selected':'' }>문화생활</option>
            <option value="사회문제" ${
                param.category=='사회문제' ? 'selected':'' }>사회문제</option>
            <!-- 필요하면 더 늘리세요 -->
          </select>

          <!-- 3) 키워드 입력창 -->
          <input
            type="text"
            name="keyword"
            class="search_bar"
            placeholder="관심 주제를 입력해주세요."
            value="${param.keyword}"
          />

          <!-- 4) 검색 버튼 -->
          <input type="submit" class="submit_btn" value="검색" />
        </form>
      </div>

      <div class="discuss_content_list">
        <c:if test="${empty posts}">
          <p style="margin:30px auto;font-size:18px;color:#666;">
            등록된 토론이 없습니다.
          </p>
        </c:if>

        <c:forEach var="post" items="${posts}">
          <a href="${pageContext.request.contextPath}/discuss_room?id=${post.discussionId}"
             class="discuss_box_link">
            <div class="discuss_box">
              <div class="discuss_box_content">
                <p class="discuss_box_content_date">
                  <fmt:formatDate value="${post.createdAt}" pattern="yyyy.MM.dd"/> 작성
                </p>
                <p class="discuss_box_content_title">${post.title}</p>
                <p class="discuss_box_content_AI">
                  ${post.content}
                </p>
              </div>
              <div class="discuss_box_footer">
                <span class="discuss_box_footer_name">${post.authorId}</span>
              </div>
            </div>
          </a>
        </c:forEach>
      </div>
    </div>

    <%@ include file="footer.jsp" %>
  </div>
</body>
</html>