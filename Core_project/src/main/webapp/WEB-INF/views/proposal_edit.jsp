<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>제안 수정</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/share.css"/>
</head>
<body>
  <h2>제안 수정</h2>

  <!-- proposal 객체가 없을 때 안내 -->
  <c:if test="${empty proposal}">
    <p style="color:red;">제안 정보를 불러올 수 없습니다.</p>
  </c:if>

  <!-- proposal 객체가 있을 때만 폼 렌더링 -->
  <c:if test="${not empty sessionScope.mvo and not empty proposal and proposal.ID == sessionScope.mvo.id}">
    <form action="${pageContext.request.contextPath}/proposal/edit" method="post">
    
    <!-- 수정 권한이 있는 경우에만 수정 폼 보이기 -->
    <c:if test="${proposal.ID == sessionScope.mvo.id}">
      <form action="${pageContext.request.contextPath}/proposal/edit" method="post">
        <input type="hidden" name="PRPSL_NO" value="${proposal.PRPSL_NO}" />
        <input type="hidden" name="CATEGORY" value="${proposal.CATEGORY}" />

        <div>
          <label>제목</label><br/>
          <input type="text" name="TITLE" value="${proposal.TITLE}" required />
        </div>
        <div>
          <label>제안 배경 및 현황</label><br/>
          <textarea name="RESULT_CONTENT" rows="5" required>${proposal.RESULT_CONTENT}</textarea>
        </div>
        <div>
          <label>제안 내용</label><br/>
          <textarea name="CONTENT" rows="5" required>${proposal.CONTENT}</textarea>
        </div>
        <div>
          <label>기대 효과</label><br/>
          <textarea name="EXPECTATION_EFFECT" rows="5" required>${proposal.EXPECTATION_EFFECT}</textarea>
        </div>
        <div>
          <button type="submit">수정 완료</button>
          <a href="${pageContext.request.contextPath}/proposal_detail?id=${proposal.PRPSL_NO}">취소</a>
        </div>
      </form>
    </c:if>

	<!-- 수정 완료 버튼 -->
	<button type="submit" class="basic_btn">수정하기</button>
	
    <!-- 수정 권한이 없을 때 안내 -->
    <c:if test="${proposal.ID != sessionScope.mvo.id}">
      <p>수정 권한이 없습니다.</p>
    </c:if>

  </c:if>

</body>
</html>
