<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>청정기, 청소년정책제안소</title>
  <link rel="stylesheet" href="resources/assets/css/share.css" />
  <link rel="stylesheet" href="resources/assets/css/proposal_list.css" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
  <div class="wrapper">
    <%@ include file="header.jsp"%>

    <div class="main_banner">
      <div class="title">
        <p class="banner_title">좋은 아이디어가 있다면 제안해보세요!</p>
        <p class="banner_body">다양한 정책에 대해 좋은 생각이 있다면 공유해주세요.</p>
      </div>
      <button class="basic_btn" onclick="location.href='proposal_post'">정책 제안하기</button>
    </div>

    <!-- 카테고리 탭 -->
    <div class="tabs">
      <c:forEach var="cat" items="${categories}">
        <a href="${pageContext.request.contextPath}/proposal_list?category=${cat}"
           class="tab ${cat eq selectedCategory ? 'active' : ''}">${cat}</a>
      </c:forEach>
    </div>

    <!-- 제안 리스트 -->
    <div id="proposal_list">
      <c:choose>
        <c:when test="${empty proposals}">
          <div class="no_results">
            <svg xmlns="http://www.w3.org/2000/svg" height="100px" viewBox="0 -960 960 960" width="100px" fill="#e5e5e5"><path d="M800-280q-15 0-27.5-10.5T760-321v-439h-80v80q0 17-11.5 28.5T640-640H467q-16 0-30.5-6T411-663L302-772q-6-6-9-13t-3-15q0-16 11.5-28t29.5-12h36q11-35 43-57.5t70-22.5q40 0 71.5 22.5T594-840h166q33 0 56.5 23.5T840-760v440q0 20-12.5 30T800-280ZM480-760q17 0 28.5-11.5T520-800q0-17-11.5-28.5T480-840q-17 0-28.5 11.5T440-800q0 17 11.5 28.5T480-760Zm166 560L200-646v446h446Zm-446 80q-33 0-56.5-23.5T120-200v-526l-37-37q-12-12-12-28.5T83-820q12-12 28.5-12t28.5 12l680 680q12 12 12 28t-12 28q-12 12-28.5 12T763-84l-37-36H200Z"/></svg>
            <p>제안된 정책이 없습니다.</p>
          </div>
        </c:when>

        <%-- 2) 결과 있을 때: 초기 6개 렌더링 + AJAX로 추가될 컨테이너 --%>
        <c:otherwise>
          <div id="proposal-container" class="search_box_container">
            <c:forEach var="p" items="${proposals}">
              <div class="search_box">
                <a class="search_box_inner_link"
                   href="${pageContext.request.contextPath}/proposal_detail?id=${p.PRPSL_NO}">
                  <div class="search_box_header">
                    <span class="category ${fn:toLowerCase(p.CATEGORY)}">${p.CATEGORY}</span>
                  </div>
                  <div class="search_box_content">
                    <span class="search_box_content_date">
          ${p.prpslDtAsDate} 제안
        </span>
                    <div class="search_box_content_title">${p.TITLE}</div>
                    <p class="search_box_content_body">${p.CONTENT}</p>
                  </div>
                  <div class="stats">
                    <div class="search_box_proponent">
                      <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#444444"><path d="M480-480q-66 0-113-47t-47-113q0-66 47-113t113-47q66 0 113 47t47 113q0 66-47 113t-113 47ZM160-240v-32q0-34 17.5-62.5T224-378q62-31 126-46.5T480-440q66 0 130 15.5T736-378q29 15 46.5 43.5T800-272v32q0 33-23.5 56.5T720-160H240q-33 0-56.5-23.5T160-240Zm80 0h480v-32q0-11-5.5-20T700-306q-54-27-109-40.5T480-360q-56 0-111 13.5T260-306q-9 5-14.5 14t-5.5 20v32Zm240-320q33 0 56.5-23.5T560-640q0-33-23.5-56.5T480-720q-33 0-56.5 23.5T400-640q0 33 23.5 56.5T480-560Zm0-80Zm0 400Z"/></svg>
                      <span class="search_box_proponent_name">${p.NICK}</span>
                    </div>
                    <hr/>
                    <div class="search_box_comment">
                      <div class="search_box_comment_goodbad">
                        <div>
                          <svg xmlns="http://www.w3.org/2000/svg" height="20px" viewBox="0 -960 960 960" width="20px" fill="#444444"><path d="M840-640q32 0 56 24t24 56v80q0 7-2 15t-4 15L794-168q-9 20-30 34t-44 14H280v-520l240-238q15-15 35.5-17.5T595-888q19 10 28 28t4 37l-45 183h258Zm-480 34v406h360l120-280v-80H480l54-220-174 174ZM160-120q-33 0-56.5-23.5T80-200v-360q0-33 23.5-56.5T160-640h120v80H160v360h120v80H160Zm200-80v-406 406Z"/></svg>
                          <span>${p.AGREE_CNT}</span>
                        </div>
                        <div>
                          <svg xmlns="http://www.w3.org/2000/svg" height="20px" viewBox="0 -960 960 960" width="20px" fill="#444444"><path d="M120-320q-32 0-56-24t-24-56v-80q0-7 2-15t4-15l120-282q9-20 30-34t44-14h440v520L440-82q-15 15-35.5 17.5T365-72q-19-10-28-28t-4-37l45-183H120Zm480-34v-406H240L120-480v80h360l-54 220 174-174Zm200-486q33 0 56.5 23.5T880-760v360q0 33-23.5 56.5T800-320H680v-80h120v-360H680v-80h120Zm-200 80v406-406Z"/></svg>
                          <span>${p.DISAG_CNT}</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </a>
              </div>
            </c:forEach>
          </div>

          <%-- 전체 개수 > 페이지 사이즈일 때만 더보기 버튼 노출 --%>
          <c:if test="${totalCount > pageSize}">
            <button id="load-more-btn" class="basic_btn">제안 더보기</button>
          </c:if>
        </c:otherwise>
      </c:choose>
    </div>

    <%@ include file="footer.jsp"%>

    <script>
    $(function(){
      var offset      = ${pageSize};               // 한 페이지 당 보여줄 개수
      var totalCount  = ${totalCount};             // 전체 제안 개수
      var selectedCat = '${selectedCategory}';     // 현재 카테고리
      var ctx         = '${pageContext.request.contextPath}';
      

      $('#load-more-btn').on('click', function(){
        $.ajax({
          url: ctx + '/proposal_list/loadMore',
          method: 'GET',
          data: { offset: offset, category: selectedCat },
          dataType: 'json',
          success: function(data){
            if (!data || !data.length) {
              $('#load-more-btn').remove();
              return;
            }
            data.forEach(function(p){
              if (!p.prpsl_NO) return;
              var detailUrl  = ctx + '/proposal_detail?id=' + p.prpsl_NO;
              var catText    = p.category       || '';
              var catClass   = catText.toLowerCase();
              var dateText   = p.prpslDtAsDate  || '';
              var title      = p.title          || '';
              var content    = p.content        || '';
              var agreeCnt   = p.agree_CNT      || 0;
              var disagCnt   = p.disag_CNT      || 0;
              var author     = p.id             || '';
              var nick			= p.nick           || '';

              var card = ''
                + '<div class="search_box">'
                +   '<a class="search_box_inner_link" href="' + detailUrl + '">'
                +     '<div class="search_box_header">'
                +       '<span class="category ' + catClass + '">' + catText + '</span>'
                +     '</div>'
                +     '<div class="search_box_content">'
                +       '<span class="search_box_content_date">' + dateText + ' 제안</span>'
                +       '<div class="search_box_content_title">' + title + '</div>'
                +       '<p class="search_box_content_body">' + content + '</p>'
                +     '</div>'
                +     '<div class="stats">'
                +       '<div class="search_box_proponent">'
                +         '<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#444444"><path d="M480-480q-66 0-113-47t-47-113q0-66 47-113t113-47q66 0 113 47t47 113q0 66-47 113t-113 47ZM160-240v-32q0-34 17.5-62.5T224-378q62-31 126-46.5T480-440q66 0 130 15.5T736-378q29 15 46.5 43.5T800-272v32q0 33-23.5 56.5T720-160H240q-33 0-56.5-23.5T160-240Zm80 0h480v-32q0-11-5.5-20T700-306q-54-27-109-40.5T480-360q-56 0-111 13.5T260-306q-9 5-14.5 14t-5.5 20v32Zm240-320q33 0 56.5-23.5T560-640q0-33-23.5-56.5T480-720q-33 0-56.5 23.5T400-640q0 33 23.5 56.5T480-560Zm0-80Zm0 400Z"/></svg>'
                +         '<span class="search_box_proponent_name">' + nick + '</span>'
                +       '</div>'
                +       '<hr/>'
                +       '<div class="search_box_comment">'
                +         '<div class="search_box_comment_goodbad">'
                +           '<div>'
                +             '<svg xmlns="http://www.w3.org/2000/svg" height="20px" viewBox="0 -960 960 960" width="20px" fill="#444444"><path d="M840-640q32 0 56 24t24 56v80q0 7-2 15t-4 15L794-168q-9 20-30 34t-44 14H280v-520l240-238q15-15 35.5-17.5T595-888q19 10 28 28t4 37l-45 183h258Zm-480 34v406h360l120-280v-80H480l54-220-174 174ZM160-120q-33 0-56.5-23.5T80-200v-360q0-33 23.5-56.5T160-640h120v80H160v360h120v80H160Zm200-80v-406 406Z"/></svg>'
                +             '<span>' + agreeCnt + '</span></div>'
                +           '<div>'
                +             '<svg xmlns="http://www.w3.org/2000/svg" height="20px" viewBox="0 -960 960 960" width="20px" fill="#444444"><path d="M120-320q-32 0-56-24t-24-56v-80q0-7 2-15t4-15l120-282q9-20 30-34t44-14h440v520L440-82q-15 15-35.5 17.5T365-72q-19-10-28-28t-4-37l45-183H120Zm480-34v-406H240L120-480v80h360l-54 220 174-174Zm200-486q33 0 56.5 23.5T880-760v360q0 33-23.5 56.5T800-320H680v-80h120v-360H680v-80h120Zm-200 80v406-406Z"/></svg>'
                +             '<span>' + disagCnt + '</span></div>'
                +         '</div>'
                +       '</div>'
                +     '</div>'
                +   '</a>'
                + '</div>';
              $('#proposal-container').append(card);
            });
            offset += data.length;
            if (offset >= totalCount) {
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

  </div>
</body>
</html>
