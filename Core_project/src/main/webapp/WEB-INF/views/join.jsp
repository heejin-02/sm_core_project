<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 회원가입 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	 <c:if test="${not empty msg}">
        <p style="color:red;">${msg}</p>
    </c:if>
    
    <!-- 회원가입 폼 예시 -->
    <form action="join" method="post">
        이메일: <input type="email" name="user_email" required><br>
        이름: <input type="text" name="user_name" required><br>
        비밀번호: <input type="password" name="user_pw" required><br>
        비밀번호 확인: <input type="password" name="user_pw_confirm" required><br>
        <button type="submit">회원가입</button>
    </form>
</body>
</html>
