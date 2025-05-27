<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"      prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"       prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>청정기 | 토론장 </title>
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
            <svg xmlns="http://www.w3.org/2000/svg" height="100px" viewBox="0 -960 960 960" width="100px" fill="#e5e5e5"><path d="M280-400q-17 0-28.5-11.5T240-440q0-17 11.5-28.5T280-480q17 0 28.5 11.5T320-440q0 17-11.5 28.5T280-400Zm600-400v498q0 17-11.5 28.5T840-262q-15 0-27.5-10T800-302v-498H291q-20 0-30-12.5T251-840q0-15 10-27.5t30-12.5h509q33 0 56.5 23.5T880-800ZM680-520H571q-20 0-30-12.5T531-560q0-15 10-27.5t30-12.5h109q17 0 28.5 11.5T720-560q0 17-11.5 28.5T680-520ZM240-240l-92 92q-19 19-43.5 8.5T80-177v-591l-24-24q-11-11-11-28t11-28q11-11 28-11t28 11l736 736q11 11 11.5 27.5T848-56q-11 11-28 11t-28-11L606-240H240Zm297-297Zm-257 17q-17 0-28.5-11.5T240-560q0-17 11.5-28.5T280-600q17 0 28.5 11.5T320-560q0 17-11.5 28.5T280-520Zm400-120H440q-17 0-28.5-11.5T400-680q0-17 11.5-28.5T440-720h240q17 0 28.5 11.5T720-680q0 17-11.5 28.5T680-640ZM344-504ZM160-688v413l46-45h322L160-688Z"/></svg>
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
                <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#444444"><path d="M480-480q-66 0-113-47t-47-113q0-66 47-113t113-47q66 0 113 47t47 113q0 66-47 113t-113 47ZM160-240v-32q0-34 17.5-62.5T224-378q62-31 126-46.5T480-440q66 0 130 15.5T736-378q29 15 46.5 43.5T800-272v32q0 33-23.5 56.5T720-160H240q-33 0-56.5-23.5T160-240Zm80 0h480v-32q0-11-5.5-20T700-306q-54-27-109-40.5T480-360q-56 0-111 13.5T260-306q-9 5-14.5 14t-5.5 20v32Zm240-320q33 0 56.5-23.5T560-640q0-33-23.5-56.5T480-720q-33 0-56.5 23.5T400-640q0 33 23.5 56.5T480-560Zm0-80Zm0 400Z"/></svg>
                <span class="discuss_box_footer_name">${post.nick}</span>

                <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#444444"><path d="M840-136q-8 0-15-3t-13-9l-92-92H320q-33 0-56.5-23.5T240-320v-40h440q33 0 56.5-23.5T760-440v-280h40q33 0 56.5 23.5T880-640v463q0 18-12 29.5T840-136ZM160-473l47-47h393v-280H160v327Zm-40 137q-16 0-28-11.5T80-377v-423q0-33 23.5-56.5T160-880h440q33 0 56.5 23.5T680-800v280q0 33-23.5 56.5T600-440H240l-92 92q-6 6-13 9t-15 3Zm40-184v-280 280Z"/></svg>
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
          var raw = p.createdAt;
          var dateText = '';

          if (typeof raw === 'number') {
            var d = new Date(raw);
            dateText = d.getFullYear() + '.' + String(d.getMonth()+1).padStart(2, '0') + '.' + String(d.getDate()).padStart(2, '0');
          } else if (typeof raw === 'string' && raw.length >= 10) {
            dateText = raw.substr(0,10).replace(/-/g, '.');
          }

          // 3) 카드 HTML 문자열 생성
          var card =
            '<a href="' + detailUrl + '" class="discuss_box_link">' +
              '<div class="discuss_box">' +
                '<div class="discuss_box_header">' +
                  '<p class="discuss_box_header_category">' + (p.category||'') + '</p>' +
                '</div>' +
                '<div class="discuss_box_content">' +
                  '<p class="discuss_box_content_date">' + dateText+ ' 작성</p>' +
                  '<p class="discuss_box_content_title">' + (p.title||'') + '</p>' +
                  '<p class="discuss_box_content_AItitle">AI 토론 요약</p>' +
                  '<p class="discuss_box_content_AI">' + (p.summary||'') + '</p>' +
                '</div>' +
                '<div class="discuss_box_footer">' +
                  '<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#444444"><path d="M480-480q-66 0-113-47t-47-113q0-66 47-113t113-47q66 0 113 47t47 113q0 66-47 113t-113 47ZM160-240v-32q0-34 17.5-62.5T224-378q62-31 126-46.5T480-440q66 0 130 15.5T736-378q29 15 46.5 43.5T800-272v32q0 33-23.5 56.5T720-160H240q-33 0-56.5-23.5T160-240Zm80 0h480v-32q0-11-5.5-20T700-306q-54-27-109-40.5T480-360q-56 0-111 13.5T260-306q-9 5-14.5 14t-5.5 20v32Zm240-320q33 0 56.5-23.5T560-640q0-33-23.5-56.5T480-720q-33 0-56.5 23.5T400-640q0 33 23.5 56.5T480-560Zm0-80Zm0 400Z"/></svg>' +
                  '<span class="discuss_box_footer_name">' + (p.nick ||'') + '</span>' +
                  '<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#444444"><path d="M840-136q-8 0-15-3t-13-9l-92-92H320q-33 0-56.5-23.5T240-320v-40h440q33 0 56.5-23.5T760-440v-280h40q33 0 56.5 23.5T880-640v463q0 18-12 29.5T840-136ZM160-473l47-47h393v-280H160v327Zm-40 137q-16 0-28-11.5T80-377v-423q0-33 23.5-56.5T160-880h440q33 0 56.5 23.5T680-800v280q0 33-23.5 56.5T600-440H240l-92 92q-6 6-13 9t-15 3Zm40-184v-280 280Z"/></svg>' +
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
