<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="resources/assets/css/share.css" />
	<link rel="stylesheet" href="resources/assets/css/joinAndLogin.css" />
    <title>회원가입</title>
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
            <form action="join"
                  method="post">
                
                <span class="input_title">아이디</span>
                <input type="text" name="id" placeholder="아이디를 입력해주세요." required>
                <br>

                <span class="input_title">비밀번호</span>
                <input type="password" name="pw" id="pw" placeholder="비밀번호를 입력해주세요." required>
                <br>

                <span class="input_title">닉네임</span>
                <input type="text" name="nick" placeholder="닉네임을 입력해주세요." required>
                <br>

                <span class="input_title">지역</span>
                <input type="text" name="region" placeholder="지역을 입력해주세요.">
                <br>

				<!--
                <span class="input_title">재학증명자료</span>
                <input type="file" name="file" id="file">
                <br>
                -->

                <input class="basic_btn" type="submit" value="회원가입">
            </form>
        </div>
    </div>
</body>
</html>
