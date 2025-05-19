<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 회원가입 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="resources/assets/css/share.css" />
</head>
<body>
	<div id="wrapper">
		
		<!-- 헤더(네비게이션) -->
		<%@ include file="header.jsp" %>
		
		<!-- 배너 -->
		<div class="sub_banner">
			<p class="sub_banner_title">회원가입</p>
		</div>
		
		<!-- 정보입력 -->
		<div id="join">
		<form action="join" method="post" enctype="multipart/form-data">
			    <span class="input_title">아이디</span>
			    <input type="text" name="ID" placeholder="아이디를 입력해주세요." required>
			    <br>
			
			    <span class="input_title">비밀번호</span>
			    <input type="password" name="PW" placeholder="비밀번호를 입력해주세요." required>
			    <br>
			
			    <span class="input_title">비밀번호 확인</span>
			    <input type="password" name="PW_confirm" placeholder="비밀번호 확인을 입력해주세요." required>
			    <br>
			
			    <span class="input_title">닉네임</span>
			    <input type="text" name="NICK" placeholder="닉네임을 입력해주세요." required>
			    <br>
			
			    <span class="input_title">지역</span>
			    <input type="text" name="REGION" placeholder="지역을 입력해주세요.">
			    <br>
			
			    <span class="input_title">재학증명자료</span>
			    <input type="file" name="ID_CARD" id="file_input">
			    <br>
			
			    <input class="basic_btn" type="submit" value="회원가입">
			</form>
		</div>
	</div>
</body>
</html>
