<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"   prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

    <div class="sub_banner">
		<p class="sub_banner_title">찬반 토론</p>
	</div>
    
    <!-- 타이틀 배너 -->
    <div class="title_banner">
      <p class="title_banner_category">${post.category}</p>
      <p class="title_banner_title">${post.title}</p>
      <div class="title_banner_info">
        <span><span class="title_banner_info_title">게시일  </span><fmt:formatDate value="${post.createdAt}" pattern="yyyy.MM.dd"/></span>
        <span>|</span>
        <span><span class="title_banner_info_title">작성자  </span>${post.authorId}</span>
        <span>|</span>
        <span><span class="title_banner_info_title">의견수  </span>${fn:length(comments)}</span>
      </div>
    </div>
    
     <!-- 여기에 삭제 버튼 추가 -->
	  <c:if test="${not empty sessionScope.mvo && post.authorId == sessionScope.mvo.id}">
	    <form action="${pageContext.request.contextPath}/discuss_delete" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');" style="margin-top: 10px;">
	      <input type="hidden" name="id" value="${post.discussionId}" />
	      <button type="submit" class="btn-delete">게시글 삭제</button>
	    </form>
	  </c:if>

    <div class="content_container">
      <div class="content_container_content">
        <span>토론 내용</span>
        <span>${post.content}</span>
      </div>

      <div class="content_container_content">
        <span>AI 토론 요약</span>
        <span>${aiSummary}</span>
      </div>
    </div>

    <div class="comment_write_container">
      <c:choose>
        <%-- 로그인 했으면 댓글 폼 --%>
        <c:when test="${not empty sessionScope.mvo}">
          <form action="${pageContext.request.contextPath}/discuss_room/comment"
                method="post">
            <input type="hidden" name="discussionId" value="${post.discussionId}" />

            <select name="opinionType" class="select_tf">
              <option name="opinionType" value="T">찬성</option>
              <option name="opinionType" value="F">반대</option>
            </select>

            <input class="search_bar" type="text" name="content" class="comment-text" placeholder="의견을 입력해주세요." required>
  
            <!-- <div>
              <label><input type="radio" name="opinionType" value="T" checked/> 찬성</label>
              <label><input type="radio" name="opinionType" value="F" /> 반대</label>
            </div> -->
  
            <!-- <textarea name="content" class="comment-text"
                      placeholder="의견을 입력하세요…" required></textarea> -->
            <button class="submit_btn">댓글 작성</button>
          </form>
        </c:when>
  
        <%-- 로그인 안 했으면 안내문 --%>
        <c:otherwise>
          <span class="comment_none">댓글을 작성하려면&nbsp;<a href="${pageContext.request.contextPath}/login">로그인</a>&nbsp;해주세요.</span>
        </c:otherwise>
      </c:choose>
    </div>

    <!-- 댓글 목록 -->
    <div class="comment_container">
      <c:if test="${empty comments}">
        <div class="no_results">
            <svg xmlns="http://www.w3.org/2000/svg" height="100px" viewBox="0 -960 960 960" width="100px" fill="#e5e5e5"><path d="M280-400q-17 0-28.5-11.5T240-440q0-17 11.5-28.5T280-480q17 0 28.5 11.5T320-440q0 17-11.5 28.5T280-400Zm600-400v498q0 17-11.5 28.5T840-262q-15 0-27.5-10T800-302v-498H291q-20 0-30-12.5T251-840q0-15 10-27.5t30-12.5h509q33 0 56.5 23.5T880-800ZM680-520H571q-20 0-30-12.5T531-560q0-15 10-27.5t30-12.5h109q17 0 28.5 11.5T720-560q0 17-11.5 28.5T680-520ZM240-240l-92 92q-19 19-43.5 8.5T80-177v-591l-24-24q-11-11-11-28t11-28q11-11 28-11t28 11l736 736q11 11 11.5 27.5T848-56q-11 11-28 11t-28-11L606-240H240Zm297-297Zm-257 17q-17 0-28.5-11.5T240-560q0-17 11.5-28.5T280-600q17 0 28.5 11.5T320-560q0 17-11.5 28.5T280-520Zm400-120H440q-17 0-28.5-11.5T400-680q0-17 11.5-28.5T440-720h240q17 0 28.5 11.5T720-680q0 17-11.5 28.5T680-640ZM344-504ZM160-688v413l46-45h322L160-688Z"/></svg>
            <p>등록된 의견이 없습니다.</p>
          </div>
      </c:if>
      <c:if test="${not empty comments}">
        <div class="comment_box_container">
          <div class="comment_title">
            <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#4C9DF8"><path d="M840-640q32 0 56 24t24 56v80q0 7-2 15t-4 15L794-168q-9 20-30 34t-44 14H280v-520l240-238q15-15 35.5-17.5T595-888q19 10 28 28t4 37l-45 183h258Zm-480 34v406h360l120-280v-80H480l54-220-174 174ZM160-120q-33 0-56.5-23.5T80-200v-360q0-33 23.5-56.5T160-640h120v80H160v360h120v80H160Zm200-80v-406 406Z"/></svg>
            <span>찬성</span>
          </div>
          <div class="comment_agreement scroll_container">
           <c:forEach var="cmt" items="${comments}">
			  <c:if test="${cmt.opinionType=='T'}">
			    <div class="comment_box">
			      <div class="comment_box_metadata">
			        <span class="comment_box_writer">${cmt.userId}</span>
			        <span>|</span>
			        <span class="comment_box_date">
			          <fmt:formatDate value="${cmt.createdAt}" pattern="yyyy.MM.dd HH:mm"/>
			        </span>
			
			        <c:if test="${not empty sessionScope.mvo && cmt.userId == sessionScope.mvo.id}">
			          <span>|</span>
			          <a class="comment_delete" href="${pageContext.request.contextPath}/discuss_room/delete_comment?id=${cmt.commentId}&discussionId=${post.discussionId}"
			             onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
			        </c:if>
			      </div>

			      <p class="comment_box_body">${cmt.content}</p>
			    </div>
			  </c:if>
			</c:forEach>
          </div>

        </div>

        <div class="comment_box_container">
          <div class="comment_title">
            <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#f84c4c"><path d="M120-320q-32 0-56-24t-24-56v-80q0-7 2-15t4-15l120-282q9-20 30-34t44-14h440v520L440-82q-15 15-35.5 17.5T365-72q-19-10-28-28t-4-37l45-183H120Zm480-34v-406H240L120-480v80h360l-54 220 174-174Zm200-486q33 0 56.5 23.5T880-760v360q0 33-23.5 56.5T800-320H680v-80h120v-360H680v-80h120Zm-200 80v406-406Z"/></svg>
            <span>반대</span>
          </div>
          <div class="comment_opposition scroll_container">
           <c:forEach var="cmt" items="${comments}">
			  <c:if test="${cmt.opinionType=='F'}">
			    <div class="comment_box">
			      <div class="comment_box_metadata">
			        <span class="comment_box_writer">${cmt.userId}</span>
			        <span>|</span>
			        <span class="comment_box_date">
			          <fmt:formatDate value="${cmt.createdAt}" pattern="yyyy.MM.dd HH:mm"/>
			        </span>
              <c:if test="${not empty sessionScope.mvo && cmt.userId == sessionScope.mvo.id}">
              		<span>|</span>
                  <a class="comment_delete" href="${pageContext.request.contextPath}/discuss_room/delete_comment?id=${cmt.commentId}&discussionId=${post.discussionId}"
                      onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
	            </c:if>
			      </div>
			
			      <p class="comment_box_body">${cmt.content}</p>

			    </div>
			  </c:if>
			</c:forEach>

          </div>
        </div>
      </c:if>
    </div>

    <%@ include file="footer.jsp" %>
  </div>
</body>
</html>