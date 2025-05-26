<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>정책 제안</title>
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
        <%-- 1) 결과 없을 때 --%>
        <c:when test="${empty proposals}">
          <div class="no_results">
            <!-- SVG 생략 -->
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
                      <span class="search_box_proponent_name">${p.ID}</span>
                    </div>
                    <hr/>
                    <div class="search_box_comment">
                      <div class="search_box_comment_goodbad">
                        <div><span>${p.AGREE_CNT}</span></div>
                        <div><span>${p.DISAG_CNT}</span></div>
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
                +         '<span class="search_box_proponent_name">' + author + '</span>'
                +       '</div>'
                +       '<hr/>'
                +       '<div class="search_box_comment">'
                +         '<div class="search_box_comment_goodbad">'
                +           '<div><span>' + agreeCnt + '</span></div>'
                +           '<div><span>' + disagCnt + '</span></div>'
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
