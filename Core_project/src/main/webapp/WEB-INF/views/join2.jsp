<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="resources/assets/css/share.css">
</head>

<body>
	<div id="wrapper">

		<!-- 헤더(네비게이션) -->
		<%@ include file="header.jsp"%>

		<!-- 배너 -->
		<div class="sub_banner">
			<p class="sub_banner_title">회원가입</p>
		</div>

		<!-- 정보입력 -->
		<div id="join">
			<li><h1>환영합니다!</h1></li>
			<li>회원가입을 축하합니다.</li>
			<!-- request영역에 저장된 회원정보 중 이메일을 출력하시오. -->
			<li>id <%=request.getParameter("id")%>입니다.
			</li>
			</form>
		</div>
	</div>
</body>
</html>
