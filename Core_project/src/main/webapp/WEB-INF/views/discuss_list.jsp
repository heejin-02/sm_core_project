<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"      prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"       prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>토론 목록</title>
  <link rel="stylesheet" href="resources/assets/css/share.css" />
  <link rel="stylesheet" href="resources/assets/css/discuss_list.css" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
  <div class="wrapper">
    <%@ include file="header.jsp" %>

    <div class="main_banner">
      <div class="title">
        <p class="banner_title">다른 사람들과 의견을 나눠봐요</p>
        <p class="banner_body">토론을 통해 다른 사람과 의견을 나누고 더 좋은 아이디어를 찾아보세요.</p>
      </div>
      <button class="basic_btn"
              onclick="location.href='${pageContext.request.contextPath}/discuss_post'">
        토론 생성하기
      </button>
    </div>

    <div class="content_list_container">
      <div class="list_title_div">
        <p class="list_title">토론 목록</p>
        <p class="list_body">관심있는 토론에 참여해 다른 사람들의 의견을 살펴보세요!</p>
      </div>

      <div class="discuss_search">
        <form action="${pageContext.request.contextPath}/discuss_list"
              method="get" style="display:flex; gap:10px; align-items:center;">
          <select name="category" class="search_category">
            <option value="">전체 카테고리</option>
            <option value="학교생활" ${currentCategory=='학교생활' ? 'selected':''}>학교생활</option>
            <option value="지역사회" ${currentCategory=='지역사회' ? 'selected':''}>지역사회</option>
            <option value="문화생활" ${currentCategory=='문화생활' ? 'selected':''}>문화생활</option>
            <option value="사회문제" ${currentCategory=='사회문제' ? 'selected':''}>사회문제</option>
            <option value="기타"     ${currentCategory=='기타'     ? 'selected':''}>기타</option>
          </select>
          <input type="text"
                 name="keyword"
                 class="search_bar"
                 placeholder="관심 주제를 입력해주세요."
                 value="${fn:escapeXml(keyword)}" />
          <input type="submit" class="submit_btn" value="검색" />
        </form>
      </div>

      <div class="discuss_content_list">
        <c:if test="${empty posts}">
          <div class="no_results">
            <!-- SVG 생략 -->
            <p>진행 중인 토론이 없습니다.</p>
          </div>
        </c:if>

        <c:forEach var="post" items="${posts}">
          <a href="${pageContext.request.contextPath}/discuss_room?id=${post.discussionId}"
             class="discuss_box_link">
            <div class="discuss_box">
              <div class="discuss_box_header">
                <p class="discuss_box_header_category">${post.category}</p>
              </div>
              <div class="discuss_box_content">
                <p class="discuss_box_content_date">
                  <fmt:formatDate value="${post.createdAt}" pattern="yyyy.MM.dd"/> 작성
                </p>
                <p class="discuss_box_content_title">${post.title}</p>
                <p class="discuss_box_content_AItitle">AI 토론 요약</p>
                <p class="discuss_box_content_AI">${post.summary}</p>
              </div>
              <div class="discuss_box_footer">
                <span class="discuss_box_footer_name">${post.authorId}</span>
                <span class="discuss_box_footer_name">${post.commentCount}</span>
              </div>
            </div>
          </a>
        </c:forEach>
      </div>

      <c:if test="${totalCount > pageSize}">
        <button id="load-more-btn" type="button" class="basic_btn">토론 더보기</button>
      </c:if>
    </div>

    <%@ include file="footer.jsp" %>
  </div>

  <script>
$(function(){
  var offset    = ${pageSize};                       // 이미 렌더링된 개수
  var total     = ${totalCount};                     // 전체 개수
  var ctx       = '${pageContext.request.contextPath}';
  var category  = '${fn:escapeXml(currentCategory)}';
  var keyword   = '${fn:escapeXml(keyword)}';

  $('#load-more-btn').on('click', function(){
    $.ajax({
      url:      ctx + '/discuss_list/loadMore',
      method:   'GET',
      data:     { offset: offset, category: category, keyword: keyword },
      dataType: 'json',
      success: function(data){
        if (!data || !data.length) {
          $('#load-more-btn').remove();
          return;
        }

        $.each(data, function(i, p){
          // 1) 상세 URL
          var detailUrl = ctx + '/discuss_room?id=' + p.discussionId;
          // 2) 날짜 포맷 (YYYY-MM-DD → YYYY.MM.DD)
          var raw = p.createdAt || '';
          var dateText = raw.length >= 10
            ? raw.substr(0,10).replace(/-/g, '.')
            : raw;

          // 3) 카드 HTML 문자열 생성
          var card =
            '<a href="' + detailUrl + '" class="discuss_box_link">' +
              '<div class="discuss_box">' +
                '<div class="discuss_box_header">' +
                  '<p class="discuss_box_header_category">' + (p.category||'') + '</p>' +
                '</div>' +
                '<div class="discuss_box_content">' +
                  '<p class="discuss_box_content_date">' + dateText + ' 작성</p>' +
                  '<p class="discuss_box_content_title">' + (p.title||'') + '</p>' +
                  '<p class="discuss_box_content_AItitle">AI 토론 요약</p>' +
                  '<p class="discuss_box_content_AI">' + (p.summary||'') + '</p>' +
                '</div>' +
                '<div class="discuss_box_footer">' +
                  '<span class="discuss_box_footer_name">' + (p.authorId||'') + '</span>' +
                  '<span class="discuss_box_footer_name">' + (p.commentCount||0) + '</span>' +
                '</div>' +
              '</div>' +
            '</a>';

          // 4) 화면에 추가
          $('.discuss_content_list').append(card);
        });

        // 5) offset 업데이트 & 더보기 버튼 제거 조건
        offset += data.length;
        if (offset >= total) {
          $('#load-more-btn').remove();
        }
      },
      error: function(xhr, status, err){
        console.error('loadMore 에러:', status, err);
      }
    });
  });
});
</script>
  
  
</body>
</html>
