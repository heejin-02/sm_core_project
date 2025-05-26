<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 토론 게시 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
   <meta charset="UTF-8" />
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=person" />
   <link rel="stylesheet" href="resources/assets/css/share.css" />
   <link rel="stylesheet" href="resources/assets/css/discuss_post.css" />
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
         <form action="discuss_post" method="post">
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
						<div class="category">
							<input type="radio" name="category" value="기타">
							<span class="category_title">기타</span>
						</div>
					</td>
				</tr>
				
               <!-- 토론주제 -->
               <tr>
                  <td class="post_title">
                     <span class="input_title">토론 주제</span>
                  </td>
                  <td class="post_input">
                     <input type="text" name="title" placeholder="토론 주제를 적어주세요.">
                  </td>
               </tr>
               
               <!-- 토론 내용 -->
               <tr>
                  <td class="post_title title_top">
                     <span class="input_title">토론 내용</span>
                  </td>
                  <td class="post_input">
                     <textarea name="content" placeholder="토론 내용을 입력해주세요."></textarea>
                  </td>
               </tr>
               
            </table>
         
             <input class="basic_btn" type="submit" value="제출하기">
         </form>
      </div>

      <!-- 푸터 -->
         <%@ include file="footer.jsp" %>

   </div>
</body>
</html>
