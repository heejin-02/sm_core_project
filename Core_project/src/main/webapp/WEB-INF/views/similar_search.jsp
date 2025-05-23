<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 유사도 검색 페이지(메인) -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
   <meta charset="UTF-8" />
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=person" />
   <link rel="stylesheet" href="resources/assets/css/share.css" />
   <link rel="stylesheet" href="resources/assets/css/similar_search.css" />
</head>
<body>
   <div class="wrapper">
   
      <!-- 헤더(네비게이션) -->
      <%@ include file="header.jsp" %>
       
       <!-- 검색 배너 -->
       <div class="main_banner">
          <div class="title">
             <p class="banner_title">좋은 아이디어 있으신가요?</p>
             <p class="banner_body">내 아이디어를 검색해 실제 시행중인 정책의 유사도를 확인해보세요!</p>
          </div>
          <div id="search">
			  <form action="search" method="post" onsubmit="return validateSearch()">
			    <input class="search_bar" type="text" id="searchInput" name="input" placeholder="아이디어를 입력해주세요.">
			    <input class="submit_btn" type="submit" value="검색">
			  </form>
			</div>
       </div>
       
       <!-- 검색 결과 목록 -->
       <div class="content_list_container">
          <div class="list_title_div">
             <p class="list_title">검색 결과</p>
             <p class="list_body">검색하신 아이디어와 유사한 정책 목록입니다.</p>
          </div>
          
          <c:choose>
	        <c:when test="${empty list}">
	          <div class="no-results">
	            <p>아직 등록된 제안이 없습니다.</p>
	          </div>
	        </c:when>
	
	        <c:otherwise>	
	         <div class="search_box_container">
	           <c:forEach var="p" items="${list}">
				<a class="search_box_link" href="${pageContext.request.contextPath}/similar_search_detail?category=${p.category}&similar=${p.similarity}&date=${p.date}&title=${p.title}&summary=${p.summary}&name=${p.proposer}">
					<div class="search_box">
					<!-- 카테고리, 유사도 -->
					<div class="search_box_header">
						<span class="category">${p.category}</span>
						<span class="similarity">유사도 ${p.similarity}%</span>
					</div>
					
					<!-- 제안날짜, 제안제목, 제안내용 -->
					<div class="search_box_content">
						<p class="search_box_content_date">${p.date} 제안</p>
						<p class="search_box_content_title">${p.title}</p>
						<p class="search_box_content_body">${p.summary}</p>
					</div>
					
					<!-- 제안자 -->
					<div class="search_box_proponent">
						<span class="material-symbols-rounded">person</span>
						<span class="search_box_proponent_name">${p.proposer}</span>
					</div>
					</div>
				</a>
	            </c:forEach>
	         </div>
	         </c:otherwise>
  			</c:choose>
       </div>

      <!-- 더보기 버튼 -->
      <!-- todo: 버튼 넘겨서 쭉 리스트 볼 수 있게 하기 -->
      <button class="basic_btn">유사도 분석 결과 더보기</button>
       <script>
		  function validateSearch() {
		    const input = document.getElementById("searchInput").value.trim();
		    if (input === "") {
		      alert("검색어를 입력해 주세요");
		      return false;
		    }
		    return true;
		  }
		</script>
       
       <!-- 푸터 -->
      <%@ include file="footer.jsp" %>
   
   </div>
</body>
</html>
