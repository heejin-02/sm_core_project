<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

			<button class="basic_btn">정책 제안하기</button>
		</div>
		
		<!-- footer -->
		<%@ include file="footer.jsp" %>

	</div>
</body>
</html>
