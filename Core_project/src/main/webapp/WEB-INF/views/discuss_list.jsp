<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>토론장</title>
  <link rel="stylesheet" href="resources/assets/css/share.css" />
  <link rel="stylesheet" href="resources/assets/css/discuss_list.css" />
  <style>
    a.discuss_box_link {
      text-decoration: none;
      color: inherit;
    }
  </style>
</head>
<body>
  <div class="wrapper">
    <%@ include file="header.jsp" %>

    <!-- 배너 -->
    <div class="main_banner">
      <div class="title">
        <p class="banner_title">다른 사람들과 의견을 나눠봐요</p>
        <p class="banner_body">토론을 통해 다른 사람과 의견을 나누고 더 좋은 아이디어를 찾아보세요.</p>
      </div>
      <button class="basic_btn" onclick="location.href='${pageContext.request.contextPath}/discuss/post'">토론방 생성하기</button>
    </div>

    <!-- 토론 목록 -->
    <div class="content_list_container">
      <div class="list_title_div">
        <p class="list_title">토론 목록</p>
        <p class="list_body">관심있는 토론에 참여해 다른 사람들의 의견을 살펴보세요!</p>
      </div>

      <!-- 검색창 -->
      <div class="discuss_search">
        <form action="${pageContext.request.contextPath}/discuss/list" method="get">
          <select class="search_range">
            <option>전체 범위</option>
          </select>
          <select class="search_category">
            <option>전체 카테고리</option>
          </select>
          <input class="search_range search_bar" type="text" name="keyword" placeholder="관심 주제를 입력해주세요." value="${keyword}" />
          <input class="submit_btn" type="submit" value="검색" />
        </form>
      </div>

      <!-- 카드 리스트 -->
      <div class="discuss_content_list">
        <c:if test="${empty rooms}">
          <p style="margin: 30px auto; font-size: 18px; color: #666;">등록된 토론방이 없습니다.</p>
        </c:if>

        <c:forEach var="room" items="${rooms}">
          <a href="${pageContext.request.contextPath}/discuss_room?id=${room.droom_no}" class="discuss_box_link">
            <div class="discuss_box">
              <!-- 카테고리, 상태 -->
              <div class="discuss_box_header">
                <p class="discuss_box_header_category">${room.droom_category}</p>
              </div>

              <!-- 제목, 내용 -->
              <div class="discuss_box_content">
                <p class="discuss_box_content_date">
                  <fmt:formatDate value="${room.create_at}" pattern="yyyy.MM.dd"/> 토론
                </p>
                <p class="discuss_box_content_title">${room.droom_title}</p>
                <p class="discuss_box_content_AItitle">AI 토론 요약</p>
                <p class="discuss_box_content_AI">${room.droom_info}</p>
              </div>
              <div class="discuss_box_footer">
           		<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#444444"><path d="M480-480q-66 0-113-47t-47-113q0-66 47-113t113-47q66 0 113 47t47 113q0 66-47 113t-113 47ZM160-240v-32q0-34 17.5-62.5T224-378q62-31 126-46.5T480-440q66 0 130 15.5T736-378q29 15 46.5 43.5T800-272v32q0 33-23.5 56.5T720-160H240q-33 0-56.5-23.5T160-240Zm80 0h480v-32q0-11-5.5-20T700-306q-54-27-109-40.5T480-360q-56 0-111 13.5T260-306q-9 5-14.5 14t-5.5 20v32Zm240-320q33 0 56.5-23.5T560-640q0-33-23.5-56.5T480-720q-33 0-56.5 23.5T400-640q0 33 23.5 56.5T480-560Zm0-80Zm0 400Z"/></svg>
               	<span class="discuss_box_footer_name">${room.id}</span>

               	<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#444444"><path d="M840-136q-8 0-15-3t-13-9l-92-92H320q-33 0-56.5-23.5T240-320v-40h440q33 0 56.5-23.5T760-440v-280h40q33 0 56.5 23.5T880-640v463q0 18-12 29.5T840-136ZM160-473l47-47h393v-280H160v327Zm-40 137q-16 0-28-11.5T80-377v-423q0-33 23.5-56.5T160-880h440q33 0 56.5 23.5T680-800v280q0 33-23.5 56.5T600-440H240l-92 92q-6 6-13 9t-15 3Zm40-184v-280 280Z"/></svg>
               	<span class="discuss_box_footer_name">${room.droom_limit}명</span>
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
