<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"      prefix="c"   %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"       prefix="fmt" %>

<!-- 정책제안소 (정책 목록) -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=person" />
	<link rel="stylesheet" href="resources/assets/css/share.css" />
	<link rel="stylesheet" href="resources/assets/css/proposal_list.css" />
	<title>정책 제안</title>
</head>
<body>
	<div class="wrapper">

		<!-- 헤더(네비게이션) -->
		<%@ include file="header.jsp" %>

		<!-- 배너 -->
		<div class="main_banner">
			<div class="title">
	 			<p class="banner_title">좋은 아이디어가 있다면 제안해보세요!</p>
	 			<p class="banner_body">다양한 정책에 대해 좋은 생각이 있다면 공유해주세요.</p>
	 		</div>

			<a href="${pageContext.request.contextPath}/proposal_post" class="basic_btn">
        정책 제안하기
      </a>
		</div>
		
		<!-- 카테고리 탭 -->
		<div class="tabs">
		  <c:forEach var="cat" items="${categories}">
		    <a href="${pageContext.request.contextPath}/proposal_list?category=${cat}"
		       class="tab ${cat == selectedCategory ? 'active' : ''}">
		      <span>${cat}</span>
		    </a>
		  </c:forEach>
		</div>
		
		<!-- 제안 리스트 -->
		<div id="proposal_list">
		
		  <c:choose>
		    <%-- 1) 등록된 제안이 하나도 없을 때 --%>
		    <c:when test="${empty proposals}">
		      <div class="no-results">
		        <p>아직 등록된 제안이 없습니다.</p>
		      </div>
		    </c:when>
		
		    <%-- 2) 제안이 있을 때, 카드로 반복 --%>
		    <c:otherwise>
		      <div class="search_box_container">
		        <c:forEach var="p" items="${proposals}">
		          <div class="search_box">
		            <%-- 카테고리 + 통계 --%>
		            <div class="search_box_header">
		              <span class="category ${fn:toLowerCase(p.CATEGORY)}">
		                ${p.CATEGORY}
		              </span>
		              <div class="stats">
		                <span class="material-symbols-rounded">person</span>
		                <span class="stat">${p.ID}</span>
		                <span class="material-symbols-rounded">thumb_up</span>
		                <span class="stat">${p.AGREE_CNT}</span>
		                <span class="material-symbols-rounded">thumb_down</span>
		                <span class="stat">${p.DISAG_CNT}</span>
		              </div>
		            </div>
		
		            <%-- 제목 + 내용 요약 --%>
		            <div class="search_box_content">
		              <a href="${pageContext.request.contextPath}/proposal_detail?id=${p.PRPSL_NO}"
		                 class="search_box_content_title">
		                ${p.TITLE}
		              </a>
		              <p class="search_box_content_body">
		                ${fn:length(p.CONTENT) > 100 
		                   ? fn:substring(p.CONTENT,0,100) + '...' 
		                   : p.CONTENT}
		              </p>
		            </div>
		
		            <%-- 등록일 --%>
					<div class="search_box_footer">
					  <small>
					    <fmt:formatDate value="${p.prpslDtAsDate}" pattern="yyyy.MM.dd"/>
					      제안
					    </small>
					  </div>
					</div>
		        </c:forEach>
		      </div>
		    </c:otherwise>
		  </c:choose>
		
		</div>
		<!-- 새 제안 작성 버튼 -->
		<button class="basic_btn">제안 더보기</button>
		
		<!-- footer -->
		<%@ include file="footer.jsp" %>

	</div>
</body>
</html>
