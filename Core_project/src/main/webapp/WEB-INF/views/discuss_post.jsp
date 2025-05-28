<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 토론 게시 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
   <meta charset="UTF-8" />
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <link rel="icon" type="image/x-icon" href="<c:url value='/resources/images/favicon.ico' />">
   <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=person" />
   <link rel="stylesheet" href="resources/assets/css/share.css" />
   <link rel="stylesheet" href="resources/assets/css/discuss_post.css" />
   <title>청정기 | 찬반 토론 제안</title>
</head>
<body>
   <div class="wrapper">

      <!-- 헤더(네비게이션) -->
      <%@ include file="header.jsp" %>
      
      <!-- 배너 -->
      <div class="sub_banner">
         <p class="sub_banner_title">찬반 토론 제안</p>
      </div>
      
      <!-- 내용 입력 -->
      <div class="pro_post">
         <form action="discuss_post" method="post" onsubmit="return validateForm()">
            <table>
               <!-- 카테고리 -->
               <tr>
                  <td class="post_title">
                     <span>카테고리</span>
                  </td>
                  <td class="post_input">
                     <div class="category">
                        <input type="radio" name="category" value="학교생활">
                        <span class="category_title">학교생활</span>
                     </div>
                     <div class="category">
                        <input type="radio" name="category" value="지역사회">
                        <span class="category_title">지역사회</span>
                     </div>
                     <div class="category">
                        <input type="radio" name="category" value="문화생활">
                        <span class="category_title">문화생활</span>
                     </div>
                     <div class="category">
                        <input type="radio" name="category" value="사회문제">
                        <span class="category_title">사회문제</span>
                     </div>
                  </td>
               </tr>
               
               <!-- 토론주제 -->
               <tr>
                  <td class="post_title">
                     <span class="input_title">토론 주제</span>
                  </td>
                  <td class="post_input">
                     <input type="text" name="title" id="title" placeholder="토론 주제를 적어주세요.">
                  </td>
               </tr>
               
               <!-- 토론 내용 -->
               <tr>
                  <td class="post_title title_top">
                     <span class="input_title">토론 내용</span>
                  </td>
                  <td class="post_input limint_input">
                     <textarea maxlength="1000" name="content" placeholder="토론 내용을 입력해주세요." id="discuss_content"></textarea>
                     <p class="text_limit_st" id="discuss_limit">0 / 1000 자</p>
                  </td>
               </tr>
            </table>
            <input class="basic_btn" type="submit" value="제출하기">
         </form>
      </div>

      <!-- 푸터 -->
      <%@ include file="footer.jsp" %>

   </div>

   <script>
      // 글자 수 카운트
      const discuss_limit = document.getElementById('discuss_limit');
      const discuss_content = document.getElementById('discuss_content');

      discuss_content.addEventListener('input', () => {
         const currentLength = discuss_content.value.length;
         discuss_limit.textContent = currentLength + " / 1000 자";
         discuss_limit.style.color = currentLength >= 1000 ? 'red' : '#3E3E3E';
      });

      // 제출 전 유효성 검사
      function validateForm() {
         const title = document.getElementById("title").value.trim();
         const content = document.getElementById("discuss_content").value.trim();

         if (title === "") {
            alert("토론 주제를 입력해주세요.");
            return false;
         }

         if (content === "") {
            alert("토론 내용을 입력해주세요.");
            return false;
         }

         return true; // 유효성 통과 시 제출
      }
   </script>
</body>
</html>
