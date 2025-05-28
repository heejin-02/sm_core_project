<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>청정기 | 유사도 분석 결과</title>
<link rel="icon" type="image/x-icon" href="<c:url value='/resources/images/favicon.ico' />">
<link rel="stylesheet" href="resources/assets/css/share.css"/>
<link rel="stylesheet" href="resources/assets/css/similar_search_detail.css"/>
</head>
<body>
	<div class="wrapper">
		
		<!-- 헤더 -->
	    <%@ include file="header.jsp"%>
	    
		<!-- 서브배너 -->
	    <div class="sub_banner">
			<p class="sub_banner_title">유사한 정책 열람</p>
		</div>

		<!-- 타이틀 배너 -->
		<div class="title_banner">
			<div class="banner_header">
				<span class="title_banner_similar">유사도 ${similar} %</span>
			</div>
			<p class="title_banner_title">${title}</p>
			<div class="title_banner_info">
			<span><span class="title_banner_info_title">게시일  </span>${date}</span>
			<span>|</span>
			<span><span class="title_banner_info_title">기관명  </span>${name}</span>
			<span>|</span>
			<span><span class="title_banner_info_title">카테고리  </span>${category}</span>
			</div>
		</div>

		<!-- 정책 설명 -->
		<div class="content_container">
			<div class="content_container_content">
				<span>정책 상세</span>
				<span>${summary}</span>
			</div>
		</div>
	    
	    <!-- 푸터 -->
		<%@ include file="footer.jsp" %>
   
   </div>
</body>
</html>