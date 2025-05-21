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
  <%@ include file="header.jsp"%>

  <div class="detail_wrapper">
    <h1>${proposal.TITLE}</h1>
    <p class="meta">
      Category: ${proposal.CATEGORY} |
      작성자: ${proposal.ID} |
      <fmt:formatDate value="${proposal.prpslDtAsDate}" pattern="yyyy.MM.dd"/>
    </p>
    <hr/>

    <h3>제안 배경 및 현황</h3>
    <p>${proposal.CONTENT}</p>

    <h3>기대 효과</h3>
    <p>${proposal.EXPECTATION_EFFECT}</p>

    <h3>처리 현황</h3>
    <p>${proposal.PRCS_NM} (${proposal.ST_CD})</p>

    <!-- 👍👎 버튼 항상 보이게 -->
    <div style="margin-top: 20px;">
      <button onclick="vote('${proposal.PRPSL_NO}', 'LIKE')">👍 ${proposal.AGREE_CNT}</button>
      <button onclick="vote('${proposal.PRPSL_NO}', 'DISLIKE')">👎 ${proposal.DISAG_CNT}</button>
    </div>
  </div>

  <script>
  function vote(proposalId, voteType) {
    fetch('${pageContext.request.contextPath}/proposal/vote?id=' + proposalId + '&voteType=' + voteType, {
      method: 'POST'
    })
    .then(response => {
      if (!response.ok) throw new Error("이미 투표했거나 오류 발생");
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

  <%@ include file="footer.jsp"%>
</body>
</html>
