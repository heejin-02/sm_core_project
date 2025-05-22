<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
   <meta charset="UTF-8" />
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <link rel="stylesheet" href="resources/assets/css/share.css" />
   <link rel="stylesheet" href="resources/assets/css/joinAndLogin.css" />
    <title>회원가입</title>
</head>

<body>
   <div class="wrapper">
      <%@ include file="header.jsp" %>

      <div class="sub_banner">
         <p class="sub_banner_title">회원가입</p>
      </div>

      <div class="join_login">
         <form id="joinForm" action="join" method="post" enctype="multipart/form-data">
            <table>
               <tr>
                  <td class="join_login_title"><span class="input_title">아이디</span></td>
                  <td class="join_login_input">
                     <input type="text" name="id" id="id" placeholder="아이디를 입력해주세요.">
                     <p id="id_check"></p>
                  </td>
               </tr>
               <tr>
                   <td class="join_login_title"><span class="input_title">비밀번호</span></td>
                   <td class="join_login_input">
                       <input type="password" name="pw" id="pw" placeholder="비밀번호를 입력해주세요.">
                   </td>
               </tr>
               <tr>
                   <td class="join_login_title"><span class="input_title">비밀번호 확인</span></td>
                   <td class="join_login_input">
                       <input type="password" id="pw_check" placeholder="비밀번호를 다시 입력해주세요.">
                       <p id="pw_check_msg"></p>
                   </td>
               </tr>
               <tr>
                  <td class="join_login_title"><span class="input_title">이름</span></td>
                  <td class="join_login_input">
                     <input type="text" name="nick" id="nick" placeholder="이름을 입력해주세요.">
                  </td>
               </tr>
               <tr>
                  <td class="join_login_title"><span class="input_title">재학 중인 학교</span></td>
                  <td class="join_login_input">
                     <input type="text" name="region" id="region" placeholder="재학 중인 학교 이름을 입력해주세요.">
                  </td>
               </tr>
               <tr>
                  <td class="join_login_title"><span class="input_title">재학증명자료</span></td>
                  <td class="join_login_input">
                     <input type="file" name="file" id="file_input">
                  </td>
               </tr>
            </table>

             <input class="basic_btn" type="submit" value="회원가입">
         </form>
      </div>

      <%@ include file="footer.jsp" %>
   </div>

   <script>
   document.addEventListener("DOMContentLoaded", function () {
       let isIdAvailable = false;

       const idInput = document.getElementById("id");
       const pwInput = document.getElementById("pw");
       const pwCheckInput = document.getElementById("pw_check");
       const nickInput = document.getElementById("nick");
       const regionInput = document.getElementById("region");
       const fileInput = document.getElementById("file_input");
       const pwCheckMsg = document.getElementById("pw_check_msg");
       const joinForm = document.getElementById("joinForm");
       const idCheckMessage = document.getElementById("id_check");

       // 아이디 중복 검사
       idInput.addEventListener("blur", function () {
           const id = idInput.value.trim();
           if (id === "") {
               idCheckMessage.textContent = "아이디를 입력해주세요.";
               idCheckMessage.style.color = "red";
               isIdAvailable = false;
               return;
           }

           fetch("checkId?id=" + encodeURIComponent(id))
               .then(response => response.text())
               .then(data => {
                   if (data === "OK") {
                       idCheckMessage.textContent = "사용 가능한 아이디입니다.";
                       idCheckMessage.style.color = "green";
                       isIdAvailable = true;
                   } else {
                       idCheckMessage.textContent = "이미 사용 중인 아이디입니다.";
                       idCheckMessage.style.color = "red";
                       isIdAvailable = false;
                   }
               })
               .catch(error => {
                   idCheckMessage.textContent = "서버 오류가 발생했습니다.";
                   idCheckMessage.style.color = "red";
                   isIdAvailable = false;
               });
       });

       // 비밀번호 확인
       pwCheckInput.addEventListener("input", function() {
           if (pwInput.value === pwCheckInput.value) {
               pwCheckMsg.textContent = "비밀번호가 일치합니다.";
               pwCheckMsg.style.color = "green";
           } else {
               pwCheckMsg.textContent = "비밀번호가 일치하지 않습니다.";
               pwCheckMsg.style.color = "red";
           }
       });

       // 제출 전 검사
       joinForm.addEventListener("submit", function (e) {
           const id = idInput.value.trim();
           const pw = pwInput.value.trim();
           const pwCheck = pwCheckInput.value.trim();
           const nick = nickInput.value.trim();
           const region = regionInput.value.trim();
           const file = fileInput.files.length;

           if (!id || !pw || !pwCheck || !nick || !region || file === 0) {
               alert("모든 항목을 입력해주세요.");
               e.preventDefault();
               return;
           }

           if (pw !== pwCheck) {
               alert("비밀번호가 일치하지 않습니다.");
               e.preventDefault();
               return;
           }

           if (!isIdAvailable) {
               alert("이미 사용 중인 아이디입니다. 변경해주세요.");
               e.preventDefault();
               return;
           }
       });
   });
   </script>
   
	   <!-- FlashAttributes 처리 -->
	<c:if test="${not empty joinSuccess}">
	<script>
	    alert("회원가입 완료!");
	</script>
	</c:if>
</body>
</html>
