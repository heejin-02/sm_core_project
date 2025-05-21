<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=person" />
	<link rel="stylesheet" href="resources/assets/css/share.css" />
	<link rel="stylesheet" href="resources/assets/css/proposal_post.css" />
</head>
<body>
	<div class="wrapper">

		<%@ include file="header.jsp" %>

		<div class="sub_banner">
			<p class="sub_banner_title">정책 아이디어 제안</p>
		</div>
		
		<div class="pro_post">
			<form action="proposal_post" method="post" enctype="multipart/form-data">
				<table>
					<!-- 카테고리 -->
					<tr>
						<td class="post_title">
							<span class="input_title">카테고리</span>
						</td>
						<td class="post_input">
							<div class="category">
								<input type="radio" name="CATEGORY" value="학교생활">
								<span class="category_title">학교생활</span>
							</div>
							<div class="category">
								<input type="radio" name="CATEGORY" value="지역사회">
								<span class="category_title">지역사회</span>
							</div>
							<div class="category">
								<input type="radio" name="CATEGORY" value="문화생활">
								<span class="category_title">문화생활</span>
							</div>
							<div class="category">
								<input type="radio" name="CATEGORY" value="사회문제">
								<span class="category_title">사회문제</span>
							</div>
						</td>
					</tr>

					<!-- 제안명 -->
					<tr>
						<td class="post_title">
							<span class="input_title">제안명</span>
						</td>
						<td class="post_input">
							<input type="text" name="TITLE" placeholder="제안명을 입력해주세요.">
						</td>
					</tr>
					
					<!-- 제안 배경 및 현황 -> RESULT_CONTENT에 매핑됨 -->
					<tr>
						<td class="post_title">
							<span class="input_title">제안 배경 및 현황</span>
						</td>
						<td class="post_input">
							<textarea name="RESULT_CONTENT" placeholder="제안 배경 및 현황을 입력해주세요."></textarea>
						</td>
					</tr>
					
					<!-- 제안 내용 -->
					<tr>
						<td class="post_title">
							<span class="input_title">제안 내용</span>
						</td>
						<td class="post_input">
							<textarea name="CONTENT" placeholder="제안 내용을 입력해주세요."></textarea>
						</td>
					</tr>
					
					<!-- 기대 효과 -->
					<tr>
						<td class="post_title">
							<span class="input_title">기대 효과</span>
						</td>
						<td class="post_input">
							<textarea name="EXPECTATION_EFFECT" placeholder="기대효과를 입력해주세요."></textarea>
						</td>
					</tr>
				</table>
			
			    <input class="basic_btn" type="submit" value="제출하기">
			</form>
		</div>

		<%@ include file="footer.jsp" %>

	</div>
</body>
</html>
