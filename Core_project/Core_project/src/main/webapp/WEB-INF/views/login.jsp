<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 로그인 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/assets/css/share.css" />
<link rel="stylesheet" href="resources/assets/css/joinAndLogin.css" />
<title>로그인</title>
</head>
<body>
	<div class="wrapper">

		<!-- 헤더(네비게이션) -->
		<%@ include file="header.jsp"%>
	
		<!-- 배너 -->
		<div class="sub_banner">
			<p class="sub_banner_title">로그인</p>
		</div>
	
		<!-- 정보입력 -->
		<div class="join_login">
			<form action="login" method="post" enctype="multipart/form-data">
				<table>
					<!-- 아이디 -->
					<tr>
						<td class="join_login_title">
							<span class="input_title">아이디</span>
						</td>
						<td class="join_login_input">
							<input type="text" name="id" placeholder="아이디를 입력해주세요.">
						</td>
					</tr>
	
					<!-- 비밀번호 -->
					<tr>
						<td class="join_login_title">
							<span class="input_title">비밀번호</span>
						</td>
						<td class="join_login_input">
							<input type="password" name="pw" placeholder="비밀번호를 입력해주세요.">
						</td>
					</tr>
				</table>
				
				<input class="basic_btn" type="submit" value="로그인">
			</form>
		</div>
		
		<!-- footer -->
		<%@ include file="footer.jsp" %>
	</div>
</body>
</html>
