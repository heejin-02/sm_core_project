<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
                      "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta charset="UTF-8" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded" />
<link rel="stylesheet" href="resources/assets/css/share.css" />
<link rel="stylesheet" href="resources/assets/css/similar_search.css" />
<title>정책 제안 목록</title>
</head>
<body>
	<div id="wrapper">
		<%@ include file="header.jsp"%>

		<!-- 배너 -->
		<div class="sub_banner">
			<p class="sub_banner_title">정책 제안 목록</p>
		</div>

		<!-- 카테고리 탭 -->
		<div class="tabs">
			<c:forEach var="cat" items="${categories}">
				<a
					href="${pageContext.request.contextPath}/proposal_list?category=${cat}"
					class="tab ${cat == selectedCategory ? 'active' : ''}"> ${cat}
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
										${p.CATEGORY} </span>
									<div class="stats">
										<span class="material-symbols-rounded">person</span> <span
											class="stat">${p.ID}</span> <span
											class="material-symbols-rounded">thumb_up</span> <span
											class="stat">${p.AGREE_CNT}</span> <span
											class="material-symbols-rounded">thumb_down</span> <span
											class="stat">${p.DISAG_CNT}</span>
									</div>
								</div>

								<%-- 제목 + 내용 요약 --%>
								<div class="search_box_content">
									<a
										href="${pageContext.request.contextPath}/proposal_detail?id=${p.PRPSL_NO}"
										class="search_box_content_title"> ${p.TITLE} </a>
									<p class="search_box_content_body">${fn:length(p.CONTENT) > 100 
                       ? fn:substring(p.CONTENT,0,100) + '...' 
                       : p.CONTENT}
									</p>
								</div>

								<%-- 등록일 --%>
								<div class="search_box_footer">
									<small> <fmt:formatDate value="${p.PRPSL_DT}"
											pattern="yyyy.MM.dd" /> 제안
									</small>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:otherwise>
			</c:choose>

			<!-- 새 제안 작성 버튼 -->
			<a href="<c:url value='/proposal_post'/>" class="basic_btn"> 새 제안
				작성 </a>
		</div>

		<%@ include file="footer.jsp"%>
	</div>

</body>
</html>
