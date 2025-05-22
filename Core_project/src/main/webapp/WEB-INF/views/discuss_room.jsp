<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"   prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>${post.title}</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/share.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/discuss_room.css">
</head>
<body>
  <div class="wrapper">
    <%@ include file="header.jsp" %>

    <div class="detail_wrapper">

      <%-- 제목 --%>
      <h1 class="detail_title">${post.title}</h1>

      <%-- 메타 정보 --%>
      <p class="detail_meta">
        작성자: <span class="author">${post.authorId}</span>
        <span class="sep">|</span>
        작성일: <fmt:formatDate value="${post.createdAt}" pattern="yyyy.MM.dd HH:mm"/>
      </p>
      <hr>

      <%-- 본문 --%>
      <div class="detail_content">
        <p>${post.content}</p>
      </div>

      <c:choose>
        <%-- 로그인 했으면 댓글 폼 --%>
        <c:when test="${not empty sessionScope.mvo}">
          <form action="${pageContext.request.contextPath}/discuss_room/comment"
                method="post">
            <input type="hidden" name="discussionId" value="${post.discussionId}" />

            <div class="comment-form">
              <label><input type="radio" name="opinionType" value="T" checked/> 찬성</label>
              <label><input type="radio" name="opinionType" value="F" /> 반대</label>
            </div>

            <textarea name="content" class="comment-text"
                      placeholder="의견을 입력하세요…" required></textarea>
            <button class="basic_btn">댓글 작성</button>
          </form>
        </c:when>

        <%-- 로그인 안 했으면 안내문 --%>
        <c:otherwise>
          <p>댓글을 작성하려면
            <a href="${pageContext.request.contextPath}/login">로그인</a> 해주세요.
          </p>
        </c:otherwise>
      </c:choose>

      <%-- 댓글 목록 --%>
      <div class="comment-list">
        <c:if test="${empty comments}">
          <p>등록된 댓글이 없습니다.</p>
        </c:if>
        <c:forEach var="cmt" items="${comments}">
          <div class="comment-item ${cmt.opinionType=='T' ? 'for' : 'against'}">
            <div class="meta">
              ${cmt.userId} |
              <fmt:formatDate value="${cmt.createdAt}" pattern="yyyy.MM.dd HH:mm" />
            </div>
            <div class="body">${cmt.content}</div>
          </div>
        </c:forEach>
      </div>

    </div>
    <%@ include file="footer.jsp" %>
  </div>
</body>
</html>
