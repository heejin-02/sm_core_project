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

      <div class="content_container_content">
        <span>제안 내용</span>
        <span>${proposal.CONTENT}</span>
      </div>

      <div class="content_container_content">
        <span>기대 효과</span>
        <span>${proposal.EXPECTATION_EFFECT}</span>
      </div>
    </div>

    <!-- 👍👎 버튼 항상 보이게 -->
    <div class="updown_btn">
      <button class="up_btn" onclick="vote('${proposal.PRPSL_NO}', 'LIKE')">
        <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#4C9DF8"><path d="M840-640q32 0 56 24t24 56v80q0 7-2 15t-4 15L794-168q-9 20-30 34t-44 14H280v-520l240-238q15-15 35.5-17.5T595-888q19 10 28 28t4 37l-45 183h258Zm-480 34v406h360l120-280v-80H480l54-220-174 174ZM160-120q-33 0-56.5-23.5T80-200v-360q0-33 23.5-56.5T160-640h120v80H160v360h120v80H160Zm200-80v-406 406Z"/></svg>
        <span>${proposal.AGREE_CNT}</span>
      </button>
      <button class="down_btn" onclick="vote('${proposal.PRPSL_NO}', 'DISLIKE')">
        <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#f84c4c"><path d="M120-320q-32 0-56-24t-24-56v-80q0-7 2-15t4-15l120-282q9-20 30-34t44-14h440v520L440-82q-15 15-35.5 17.5T365-72q-19-10-28-28t-4-37l45-183H120Zm480-34v-406H240L120-480v80h360l-54 220 174-174Zm200-486q33 0 56.5 23.5T880-760v360q0 33-23.5 56.5T800-320H680v-80h120v-360H680v-80h120Zm-200 80v406-406Z"/></svg>
        <span>${proposal.DISAG_CNT}</span>
      </button>
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
