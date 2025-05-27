<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String uri = (String) request.getAttribute("javax.servlet.forward.request_uri");
if (uri == null) {
	uri = request.getRequestURI();
}
String ctx = request.getContextPath(); // ex: /Core_project
boolean isActive = uri.equals(ctx + "/") || uri.equals(ctx + "/search");
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>청정기, 청소년정책제안소</title>
<link rel="stylesheet" href="resources/assets/css/share.css" />
<link rel="stylesheet" href="resources/assets/css/headerAndFooter.css" />
<link rel="stylesheet" href="resources/assets/css/fontFace.css" />
</head>
<body>
	<header >
		<div id="header">
			<a href="/Core_project" id="logo"> <img
				src="resources/images/logo.png">
			</a>

			<nav id="nav">
				<a href="<%= ctx %>/" class="<%= isActive ? "active" : "" %>">정책 기획소</a>
				<a href="/Core_project/proposal_list"
					class="<%=uri.contains("/Core_project/proposal_list") ? "active" : ""%>">정책
					제안소</a> <a href="/Core_project/discuss_list"
					class="<%=uri.contains("/Core_project/discuss_list") ? "active" : ""%>">토론장</a>
				<span>|</span>
				
				<c:if test="${empty sessionScope.midx}">
					<a href="/Core_project/join"
						class="<%=uri.contains("/Core_project/join") ? "active" : ""%>">
						회원가입</a>
					<a href="/Core_project/login"
						class="<%=uri.contains("/Core_project/login") ? "active" : ""%>">로그인</a>
				</c:if>

				<c:if test="${not empty sessionScope.midx}">
					<a href="#">${sessionScope.nickname}님</a>
					<a href="logout">로그아웃</a>

					<form action="delete" method="post"
						onsubmit="return confirm('정말 탈퇴하시겠습니까?');">
						<button type="submit">회원탈퇴</button>
					</form>
				</c:if>
			</nav>
		</div>
	</header>
</body>
</html>
