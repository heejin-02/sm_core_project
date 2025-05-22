<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
 			<!-- 로그인 안 된 상태 -->
			<c:if test="${empty sessionScope.midx}">
			   <a href="join">회원가입</a>
			   <a href="login">로그인</a>
			</c:if>
			
			<!-- 로그인 된 상태 -->
			<c:if test="${not empty sessionScope.midx}">
			   <a href="mypage">${sessionScope.nickname}님</a>
			   <a href="edit_profile">회원정보 수정</a>  <!-- 여기 추가 -->
			   <a href="logout">로그아웃</a>
			</c:if>
						   
			   <!-- 회원탈퇴 폼 추가 -->
			   <form action="delete" method="post" onsubmit="return confirm('정말 탈퇴하시겠습니까?');" style="display:inline;">
			     <button type="submit">회원탈퇴</button>
			   </form>
			</c:if>
 		</nav>
 	</header>
</body>
</html>