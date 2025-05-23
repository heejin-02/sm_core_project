<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>제안 상세</title>
  <link rel="stylesheet" href="resources/assets/css/share.css"/>
  <link rel="stylesheet" href="resources/assets/css/proposal_detail.css"/>
</head>
<body>
  
  <div class="wrapper">
    <%@ include file="header.jsp"%>

    <div class="sub_banner">
			<p class="sub_banner_title">정책 아이디어 열람</p>
		</div>

    <!-- 타이틀 배너 -->
    <div class="title_banner">
      <p class="title_banner_category">${proposal.CATEGORY}</p>
      <p class="title_banner_title">${proposal.TITLE}</p>
      <div class="title_banner_info">
        <span><span class="title_banner_info_title">제안일  </span><fmt:formatDate value="${proposal.prpslDtAsDate}" pattern="yyyy.MM.dd"/></span>
        <span>|</span>
        <span><span class="title_banner_info_title">제안자  </span>${proposal.ID}</span>
        <span>|</span>
        <span><span class="title_banner_info_title">추천  </span>${proposal.AGREE_CNT}</span>
        <span>|</span>
        <span><span class="title_banner_info_title">비추천  </span>${proposal.DISAG_CNT}</span>
      </div>
    </div>

    <div class="content_container">
      <div class="content_container_content">
        <span>제안 배경 및 현황</span>
        <span>${proposal.RESULT_CONTENT}</span>
      </div>

      <hr>

      <div class="content_container_content">
        <span>제안 내용</span>
        <span>${proposal.CONTENT}</span>
      </div>

      <hr>

      <div class="content_container_content">
        <span>기대 효과</span>
        <span>${proposal.EXPECTATION_EFFECT}</span>
      </div>
    </div>

	<!-- 게시글 삭제 -->
	<c:if test="${sessionScope.midx == proposal.ID}">
	    <form action="proposal_delete" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
	        <input type="hidden" name="id" value="${proposal.PRPSL_NO}">
	        <button type="submit" class="basic_btn">삭제하기</button>
	    </form>
	</c:if>
	
    <!-- 👍👎 버튼 항상 보이게 -->
    <div style="margin-top: 20px;">
      <button onclick="vote('${proposal.PRPSL_NO}', 'LIKE')">👍 ${proposal.AGREE_CNT}</button>
      <button onclick="vote('${proposal.PRPSL_NO}', 'DISLIKE')">👎 ${proposal.DISAG_CNT}</button>
    </div>

    <%@ include file="footer.jsp"%>
  </div>

  <script>
  function vote(proposalId, voteType) {
    fetch('${pageContext.request.contextPath}/proposal/vote?id=' + proposalId + '&voteType=' + voteType, {
      method: 'POST'
    })
    .then(response => {
      if (!response.ok) throw new Error("이미 투표했거나 비로그인 상태이거나 오류 발생");
      return response.text();
    })
    .then(msg => {
      if (voteType === 'LIKE') {
        alert('좋아요를 눌렀습니다');
      } else if (voteType === 'DISLIKE') {
        alert('싫어요를 눌렀습니다');
      } else {
        alert(msg); // 예외 처리
      }
      location.reload();
    })
    .catch(err => {
      alert(err.message);
    });
  }
</script>

</body>
</html>
