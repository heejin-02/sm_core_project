<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 정책 제안 목록 -->
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
            <p class="sub_banner_title">정책 제안 목록</p>
        </div>

        <!-- 카테고리 탭 -->
        <div class="tabs">
            <c:forEach var="cat" items="${categories}">
                <a href="${pageContext.request.contextPath}/proposal_list?category=${cat}"
                   class="tab ${cat == selectedCategory ? 'active' : ''}">
                   ${cat}
                </a>
            </c:forEach>
        </div>

        <!-- 제안 리스트 -->
        <div id="proposal_list">
            <table class="list_table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>등록일</th>
                        <th>상태</th>
                        <th>처리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${proposals}">
                        <tr>
                            <td>${p.PRPSL_NO}</td>
                            <td>
                              <a href="${pageContext.request.contextPath}/proposal_detail?id=${p.PRPSL_NO}">
                                ${p.TITLE}
                              </a>
                            </td>
                            <td>${p.ID}</td>
                            <td><fmt:formatDate value="${p.PRPSL_DT}" pattern="yyyy-MM-dd"/></td>
                            <td>${p.ST_CD}</td>
                            <td>${p.PRCS_NM}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <a href="<c:url value='/proposal_post'/>" class="basic_btn">새 제안 작성</a>
        </div>
    </div>
</body>
</html>
