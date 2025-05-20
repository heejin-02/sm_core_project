<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/assets/css/share.css" />
<link rel="stylesheet" href="resources/assets/css/headerAndFooter.css" />
<link rel="stylesheet" href="resources/assets/css/fontFace.css" />
</head>
<body>
	<header id="header">
 		<a href="/Core_project" id="logo">
 			<img src="resources/images/logo.png"></image>
 		</a>
 		
 		<nav id="nav">
 			<!-- todo: 로그인하면 로그아웃 보이게 -->
 			<a href="/Core_project">정책 기획소</a>
 			<a href="proposal_list">정책 제안소</a>
 			<a href="discuss_list">토론장</a>
 			<span>|</span>
 			<a href="join">회원가입</a>
 			<a href="<c:url value='/login' />">로그인</a>
 		</nav>
 	</header>
</body>
</html>