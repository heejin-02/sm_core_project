<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 토론목록 페이지 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="resources/assets/css/discuss_list.css" />
	<link rel="stylesheet" href="resources/assets/css/share.css" />
	<title>토론장</title>
</head>
<body>
	<div class="wrapper">

		<!-- 헤더(네비게이션) -->
      	<%@ include file="header.jsp" %>
		
		<!-- 배너 -->
		<div class="main_banner">
			<div class="title">
	 			<p class="banner_title">다른 사람들과 의견을 나눠봐요!</p>
	 			<p class="banner_body">토론을 통해 다른 사람과 의견을 나누고 더 좋은 아이디어를 찾아보세요.</p>
	 		</div>

			<button class="basic_btn" onclick="location.href='discuss_post'">토론방 생성하기</button>
		</div>

		<!-- 검색 결과 목록 -->
       	<div class="content_list_container">
          	<div class="list_title_div">
				<p class="list_title">토론 목록</p>
				<p class="list_body">관심있는 토론에 참여해 다른 사람들의 의견을 살펴보세요!</p>
			</div>

			<!-- 토론 검색 -->
			<div class="discuss_search">
				<form action="#">
					<select name="search_range" class="search_range">
						<option value="all">전체 범위</option>
						<option value="ttile">제목</option>
						<option value="body">내용</option>
					</select>
					<select name="search_category" class="search_category">
						<option value="all">전체 카테고리</option>
						<option value="shcool">학교생활</option>
						<option value="local">지역사회</option>
						<option value="culture">문화생활</option>
						<option value="society">사회문제</option>
					</select>
					<input class="search_bar" type="text" name="search_keyword" placeholder="관심 주제를 입력해주세요.">
					<input class="submit_btn" type="submit" value="검색">
				</form>
			</div>
	
			<!-- 토론 리스트 -->
			<div class="discuss_content_list">
				<!-- todo: 반복문으로 내용 불러오기 -->
				<div class="discuss_box">
					<!-- 카테고리 -->
					<div class="discuss_box_header">
						<p>사회문제</p>
					</div>
					
					<div class="discuss_box_content">
						<!-- 토론 시작 시간(개설일) -->
						<p class="discuss_box_content_date">2025.05.19 토론 </p>
						<!-- 토론 주제 -->
						<p class="discuss_box_content_title">
							집에 가고 싶은 건에 대하여
						</p>
						<!-- AI 토론 요약 -->
						<p class="discuss_box_content_AItitle">AI 토론 요약</p>
						<p class="discuss_box_content_AI">
							집에 가고 싶은 건에 대하여 집에 가고 싶은 건에 대하여 집에 가고 싶은 건에 대하여 집에 가고 싶은 건에 대하여 집에 가고 싶은 건에 대하여 집에 가고 싶은 건에 대하여 집에 가고 싶은 건에 대하여
						</p>
					</div>

					<div class="discuss_box_footer">
						<!-- 제안자 -->
						<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#444444"><path d="M480-480q-66 0-113-47t-47-113q0-66 47-113t113-47q66 0 113 47t47 113q0 66-47 113t-113 47ZM160-240v-32q0-34 17.5-62.5T224-378q62-31 126-46.5T480-440q66 0 130 15.5T736-378q29 15 46.5 43.5T800-272v32q0 33-23.5 56.5T720-160H240q-33 0-56.5-23.5T160-240Zm80 0h480v-32q0-11-5.5-20T700-306q-54-27-109-40.5T480-360q-56 0-111 13.5T260-306q-9 5-14.5 14t-5.5 20v32Zm240-320q33 0 56.5-23.5T560-640q0-33-23.5-56.5T480-720q-33 0-56.5 23.5T400-640q0 33 23.5 56.5T480-560Zm0-80Zm0 400Z"/></svg>
                  		<span class="discuss_box_footer_name">청정기</span>

						<!-- 총 참여 인원 -->
						<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#444444"><path d="M840-136q-8 0-15-3t-13-9l-92-92H320q-33 0-56.5-23.5T240-320v-40h440q33 0 56.5-23.5T760-440v-280h40q33 0 56.5 23.5T880-640v463q0 18-12 29.5T840-136ZM160-473l47-47h393v-280H160v327Zm-40 137q-16 0-28-11.5T80-377v-423q0-33 23.5-56.5T160-880h440q33 0 56.5 23.5T680-800v280q0 33-23.5 56.5T600-440H240l-92 92q-6 6-13 9t-15 3Zm40-184v-280 280Z"/></svg>
                  		<span class="discuss_box_footer_name">10명</span>
					</div>
				</div>
			</div>
			<!-- todoo: 페이지 넘기기 추가 -->
		</div>


		<!-- 푸터 -->
      	<%@ include file="footer.jsp" %>

	</div>
</body>
</html>
