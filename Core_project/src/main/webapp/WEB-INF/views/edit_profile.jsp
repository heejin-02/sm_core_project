<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>회원정보 수정</title>
</head>
<body>
    <h2>회원정보 수정</h2>
    
    <c:if test="${not empty msg}">
        <p style="color:green">${msg}</p>
    </c:if>

    <form action="edit_profile" method="post">
		    <label>아이디: </label>
		    <input type="text" name="id" value="${user.id}" readonly /><br/>
		
		    <label>비밀번호: </label>
		    <input type="password" name="pw" placeholder="변경할 비밀번호 입력" /><br/>
		
		    <label>닉네임: </label>
		    <input type="text" name="nick" value="${user.nick}" required /><br/>
		
		    <label>지역: </label>
		    <input type="text" name="region" value="${user.region}" required /><br/>
		
		    <button type="submit">수정 완료</button>
		</form>
    <a href="/">홈으로</a>
</body>
</html>
