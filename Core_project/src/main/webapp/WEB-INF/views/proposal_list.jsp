<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"      prefix="c"   %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"       prefix="fmt" %>

<!-- 정책제안소 (정책 목록) -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

			<button class="basic_btn" onclick="location.href='proposal_post'">정책 제안하기</button>
		</div>
		
		<!-- 카테고리 탭 -->
     	<div class="tabs">
			<c:forEach var="cat" items="${categories}">
			  <a href="${pageContext.request.contextPath}/proposal_list?category=${cat}"
			     class="tab ${cat eq selectedCategory ? 'active' : ''}">
			    ${cat}
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
						<%-- 카테고리--%>
						<div class="search_box_header">
							<span class="category ${fn:toLowerCase(p.CATEGORY)}">
							${p.CATEGORY}
							</span>
						
						</div>

						<%-- 등록일 --%>
						<div class="search_box_content">
							<span class="search_box_content_date">
								<fmt:formatDate value="${p.prpslDtAsDate}" pattern="yyyy.MM.dd"/>제안
							</span>
							<!-- js에서 클릭 이벤트로 처리하기 -->
							<!-- <a href="${pageContext.request.contextPath}/proposal_detail?id=${p.PRPSL_NO}"
							class="search_box_content_title">
							${p.TITLE}
							</a> -->
							<p class="search_box_content_title">
								${p.TITLE}
							</p>
							<p class="search_box_content_body">
								${p.CONTENT}
							</p>
						</div>

						<!-- 좋아요 싫어요 -->
						<div class="stats">
							<div class="search_box_proponent">
								<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#444444"><path d="M480-480q-66 0-113-47t-47-113q0-66 47-113t113-47q66 0 113 47t47 113q0 66-47 113t-113 47ZM160-240v-32q0-34 17.5-62.5T224-378q62-31 126-46.5T480-440q66 0 130 15.5T736-378q29 15 46.5 43.5T800-272v32q0 33-23.5 56.5T720-160H240q-33 0-56.5-23.5T160-240Zm80 0h480v-32q0-11-5.5-20T700-306q-54-27-109-40.5T480-360q-56 0-111 13.5T260-306q-9 5-14.5 14t-5.5 20v32Zm240-320q33 0 56.5-23.5T560-640q0-33-23.5-56.5T480-720q-33 0-56.5 23.5T400-640q0 33 23.5 56.5T480-560Zm0-80Zm0 400Z"/></svg>
								<span class="search_box_proponent_name">${p.ID}</span>
							</div>

							<hr>

							<div class="search_box_comment">
								<div class="search_box_comment_goodbad">
									<div>
										<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#444444"><path d="M840-640q32 0 56 24t24 56v80q0 7-2 15t-4 15L794-168q-9 20-30 34t-44 14H280v-520l240-238q15-15 35.5-17.5T595-888q19 10 28 28t4 37l-45 183h258Zm-480 34v406h360l120-280v-80H480l54-220-174 174ZM160-120q-33 0-56.5-23.5T80-200v-360q0-33 23.5-56.5T160-640h120v80H160v360h120v80H160Zm200-80v-406 406Z"/></svg>
										<span class="search_box_proponent_name">${p.AGREE_CNT}</span>
									</div>
									<div>
										<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#444444"><path d="M120-320q-32 0-56-24t-24-56v-80q0-7 2-15t4-15l120-282q9-20 30-34t44-14h440v520L440-82q-15 15-35.5 17.5T365-72q-19-10-28-28t-4-37l45-183H120Zm480-34v-406H240L120-480v80h360l-54 220 174-174Zm200-486q33 0 56.5 23.5T880-760v360q0 33-23.5 56.5T800-320H680v-80h120v-360H680v-80h120Zm-200 80v406-406Z"/></svg>
										<span class="search_box_proponent_name">${p.DISAG_CNT}</span>
									</div>
								</div>
								<div class="search_box_comment_comment">
									
								</div>
							</div>
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
