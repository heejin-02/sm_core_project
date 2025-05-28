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
	<title>청정기 | 정책 제안하기</title>
</head>
<body>
	<div class="wrapper">

		<!--헤더 -->
		<%@ include file="header.jsp" %>

		<div class="sub_banner">
			<p class="sub_banner_title">정책 아이디어 제안</p>
		</div>
		
		<div class="pro_post">
			<form action="proposal_post" method="post" onsubmit="return validateProposalForm()">
				<table>
					<!-- 카테고리 -->
					<tr>
						<td class="post_title">
							<span>카테고리</span>
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
							<span>제안명</span>
						</td>
						<td class="post_input">
							<input type="text" name="TITLE" id="title" placeholder="제안명을 입력해주세요.">
						</td>
					</tr>
					
					<!-- 제안 배경 및 현황 -->
					<tr>
						<td class="post_title title_top">
							<span>제안 배경 및 현황</span>
						</td>
						<td class="post_input limint_input">
							<textarea maxlength="1000" name="RESULT_CONTENT" placeholder="제안 배경 및 현황을 입력해주세요." id="background_content"></textarea>
							<p class="text_limit_st" id="background_limit">0 / 1000 자</p>
						</td>
					</tr>
					
					<!-- 제안 내용 -->
					<tr>
						<td class="post_title title_top">
							<span>제안 내용</span>
						</td>
						<td class="post_input limint_input">
							<textarea maxlength="1000" name="CONTENT" placeholder="제안 내용을 입력해주세요." id="main_content"></textarea>
							<p class="text_limit_st" id="main_limit">0 / 1000 자</p>
						</td>
					</tr>
					
					<!-- 기대 효과 -->
					<tr>
						<td class="post_title title_top">
							<span>기대 효과</span>
						</td>
						<td class="post_input limint_input">
							<textarea maxlength="1000" name="EXPECTATION_EFFECT" placeholder="기대효과를 입력해주세요." id="effect_content"></textarea>
							<p class="text_limit_st" id="effect_limit">0 / 1000 자</p>
						</td>
					</tr>
				</table>
			
			    <input class="basic_btn" type="submit" value="제출하기">
			</form>
		</div>

		<%@ include file="footer.jsp" %>

	</div>
	
	<script>
		const background_limit = document.getElementById('background_limit');
		const main_limit = document.getElementById('main_limit');
		const effect_limit = document.getElementById('effect_limit');

		const background_content = document.getElementById('background_content');
		const main_content = document.getElementById('main_content');
		const effect_content = document.getElementById('effect_content');

		background_content.addEventListener('input', () => {
			const currentLength = background_content.value.length;
			background_limit.textContent = currentLength + ` / 1000 자`;
			background_limit.style.color = currentLength >= 1000 ? 'red' : '#3E3E3E';
		})

		main_content.addEventListener('input', () => {
			const currentLength = main_content.value.length;
			main_limit.textContent = currentLength + ` / 1000 자`;
			main_limit.style.color = currentLength >= 1000 ? 'red' : '#3E3E3E';
		})

		effect_content.addEventListener('input', () => {
			const currentLength = effect_content.value.length;
			effect_limit.textContent = currentLength + ` / 1000 자`;
			effect_limit.style.color = currentLength >= 1000 ? 'red' : '#3E3E3E';
		})

		function validateProposalForm() {
			const title = document.getElementById("title").value.trim();
			const background = background_content.value.trim();
			const content = main_content.value.trim();
			const effect = effect_content.value.trim();
			const categoryChecked = document.querySelector('input[name="CATEGORY"]:checked');

			if (!categoryChecked) {
				alert("카테고리를 선택해주세요.");
				return false;
			}

			if (title === "") {
				alert("제안명을 입력해주세요.");
				return false;
			}

			if (background === "") {
				alert("제안 배경 및 현황을 입력해주세요.");
				return false;
			}

			if (content === "") {
				alert("제안 내용을 입력해주세요.");
				return false;
			}

			if (effect === "") {
				alert("기대 효과를 입력해주세요.");
				return false;
			}

			return true; // 유효성 통과 시 제출
		}
	</script>
</body>
</html>
