<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 정책 제안 작성 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
                      "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=person" />
	<link rel="stylesheet" href="resources/assets/css/share.css" />
	<link rel="stylesheet" href="resources/assets/css/similar_search.css" />
</head>
<body>
    <div id="wrapper">
        <%@ include file="header.jsp" %>

        <!-- 배너 -->
        <div class="sub_banner">
            <p class="sub_banner_title">정책 제안하기</p>
        </div>

        <!-- 제안 작성 폼 -->
        <div id="proposal_post">
            <form action="${pageContext.request.contextPath}/proposal_post"
                  method="post">
                
                <!-- 카테고리 -->
                <span class="input_title">카테고리</span>
                <select name="CATEGORY" required>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat}"
                          ${cat == proposal.CATEGORY ? "selected" : ""}>
                          ${cat}
                        </option>
                    </c:forEach>
                </select>
                <br/>

                <!-- 제목 -->
                <span class="input_title">제목</span>
                <input type="text"
                       name="TITLE"
                       placeholder="제목을 입력하세요."
                       value="${proposal.TITLE}"
                       required />
                <br/>

                <!-- 내용 -->
                <span class="input_title">내용</span>
                <textarea name="CONTENT"
                          rows="6"
                          placeholder="내용을 입력하세요."
                          required>${proposal.CONTENT}</textarea>
                <br/>

                <!-- 기대효과 -->
                <span class="input_title">기대효과</span>
                <textarea name="EXPECTATION_EFFECT"
                          rows="4"
                          placeholder="기대효과를 입력하세요.">${proposal.EXPECTATION_EFFECT}</textarea>
                <br/>

                <!-- 제출 버튼 -->
                <input class="basic_btn"
                       type="submit"
                       value="등록하기" />
                <a href="<c:url value='/proposal_list'/>" class="basic_btn">목록으로</a>
            </form>
        </div>
    </div>
</body>
</html>
