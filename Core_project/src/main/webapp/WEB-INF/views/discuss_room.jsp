<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>${room.droom_title}</title>
  <link rel="stylesheet" href="resources/assets/css/share.css">
  <link rel="stylesheet" href="resources/assets/css/discuss_room.css">
</head>
<body>
  <div class="wrapper">
    <%@ include file="header.jsp" %>

    <div class="detail_wrapper">
      <h1>${room.droom_title}</h1>
      <p class="meta">
        카테고리: ${room.droom_category} |
        개설자: ${room.id} |
        <fmt:formatDate value="${room.create_at}" pattern="yyyy.MM.dd" />
      </p>
      <hr>

      <h3>토론 소개</h3>
      <p>${room.droom_info}</p>

      <h3>토론 인원</h3>
      <p>${room.droom_limit}명</p>

      <h3>상태</h3>
      <p>${room.droom_st}</p>

      <!-- 토론 참가/종료 표시 -->
      <c:choose>
        <c:when test="${room.droom_st eq '진행중'}">
          <form action="${pageContext.request.contextPath}/discuss/enter" method="post">
            <input type="hidden" name="id" value="${room.droom_no}" />
            <button class="basic_btn">토론 참여하기</button>
          </form>
        </c:when>
        <c:otherwise>
          <p class="end_msg">이 토론은 종료되었습니다.</p>
        </c:otherwise>
      </c:choose>
    </div>

    <%@ include file="footer.jsp" %>
  </div>
</body>
</html>
