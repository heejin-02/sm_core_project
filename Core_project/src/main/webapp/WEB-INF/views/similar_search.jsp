<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 유사도 검색 페이지(메인) -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="resources/assets/css/similar_search.css" />
	<link rel="stylesheet" href="resources/assets/css/share.css" />
</head>
<body>
	<div id="wrapper">
	
		<!-- 헤더(네비게이션) -->
		<%@ include file="header.jsp" %>
	 	
	 	<!-- 검색 배너 -->
	 	<div id="search_banner">
	 		<div id="title">
	 			<p class="banner_title">좋은 아이디어 있으신가요?</p>
	 			<p class="banner_body">내 아이디어를 검색해 실제 정책 / 제안된 정책과의 유사도를 확인해보세요!</p>
	 		</div>
	 		<div id="search">
	 			<form action="#" method="post">
	 				<input class="search_bar" type="text" placeholder="아이디어를 입력해주세요.">
	 				<input class="submit_btn" type="submit" value="검색">
	 			</form>
	 		</div>
	 	</div>
	 	
	 	<!-- 검색 결과 목록 -->
	 	<div id="search_list">
	 		<div class="list_title_div">
	 			<p class="list_title">검색 결과</p>
	 			<p class="list_body">유사한 정책 목록입니다.</p>
	 		</div>
	 		
	 		<!-- 검색 전에는 결과 없음 페이지 띄우기 -->
	 		<!-- todo: 정책 데이터 받아와서 for each 돌리기 -->
	 		<div class="search_box">
	 			<!-- 카테고리, 유사도 -->
	 			<div class="search_box_header">
	 				<span class="category">학교생활</span>
	 				<span class="similarity">유사도 47%</span>
	 			</div>
	 			
	 			<!-- 제안날짜, 제안제목, 제안내용 -->
				<div class="search_box_content">
					<p class="search_box_content_date">2025.05.12 제안</p>
					<p class="search_box_content_title">청소년들의 사회 참여 활동</p>
					<p class="search_box_content_body">내용 어쩌구 저쩌구</p>
				</div>
				
				<!-- 게시자 -->
				<div class="search_box_proponent">
					<span class="search_box_proponent_icon">􀉩</span>
					<span class="search_box_proponent_name">청정기</span>
				</div>
				
				<!-- 더보기 버튼 -->
				<button clss="basic_btn">유사도 분석 결과 더보기</button>
	 		</div>
	 	</div>
	
	</div>
</body>
</html>
