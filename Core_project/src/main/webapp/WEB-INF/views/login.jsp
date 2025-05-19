<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 로그인 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="resources/assets/css/share.css" />
	<link rel="stylesheet" href="resources/assets/css/joinAndLogin.css" />
</head>
<body>
	
		<!-- 헤더(네비게이션) -->
		<%@ include file="header.jsp" %>
		
		<!-- 배너 -->
		<div class="sub_banner">
			<p class="sub_banner_title">로그인</p>
		</div>
		
		<!-- 정보입력 -->
		<div id="login">
			<form action="login" method="post">
			    <span class="input_title">아이디</span>
			    <input type="text" name="id" placeholder="아이디를 입력해주세요." required>
			    <br>
			    <span class="input_title">비밀번호</span>
			    <input type="password" name="pw" placeholder="비밀번호를 입력해주세요." required>
			    <br>
			    <input class="basic_btn" type="submit" value="로그인">
			</form>
		</div>
	</div>
</body>
</html>
