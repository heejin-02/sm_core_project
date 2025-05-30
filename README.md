# 스마트인재개발원 핵심 프로젝트
# ✏️ 청소년 정책 제안 토론 플랫폼 청소년 정책 기획소 (팀 공기청정기 )
<img width="400" src="https://github.com/user-attachments/assets/c73fcde8-a34d-4cad-b4a6-94d3b37c3f43"><br>

## 👀 서비스 소개
청정기는 ‘청소년 정책 기획소’의 줄임말이자 탁한 공기를 맑게해주는 공기청정기처럼,
청소년의 목소리로 맑고 건강한 정책으로 정화하고자 하는 플랫폼입니다!

## 📅 프로젝트 기간
2025/05/15 ~ 2025/05/29

## 🌟 주요 기능

---

### 🧑‍💻 회원가입  
청소년 인증을 통해 누구나 쉽게 가입하고, 자유롭게 의견을 나눌 수 있습니다.

---

### 🔍 유사도 검색  
<img src="https://github.com/user-attachments/assets/273f200f-b41a-4af9-abcc-b40b7d575c73" width="400"/>
<img src="https://github.com/user-attachments/assets/b7c5e4da-d371-4364-a2ac-d1100037db8f" width="400"/>

자신이 생각했던 아이디어가 이미 존재하는 정책인지 확인할 수 있습니다.  
입력한 키워드를 바탕으로 **의미 기반 유사도 분석**을 통해 관련 정책을 찾아줍니다.

---

### 📝 정책 제안  
<img src="https://github.com/user-attachments/assets/87037a44-56be-40d0-9a91-f6867ac25ad8" width="400"/>
<img src="https://github.com/user-attachments/assets/b1f2d1ea-dc9d-4aac-9503-ead00e09ff45" width="400"/>

청소년이 **직접 정책을 제안**하고, 다른 사용자와 함께 고민을 나눌 수 있는 공간을 제공합니다.

---

### 💬 찬반 토론  
<img src="https://github.com/user-attachments/assets/95036ee5-4fac-4a18-8807-f1056762f444" width="400"/>

정책 제안에 대해 다양한 시각에서 **찬성과 반대 의견을 자유롭게 토론**할 수 있습니다.

---

### 🧠 AI 댓글 요약  
<img src="https://github.com/user-attachments/assets/d33972a9-00dc-4fe3-bcb8-bf2f19595b97" width="400"/>

많은 댓글 속에서 흐름을 파악하기 어렵다면?  
**AI가 찬반 의견을 요약**해 핵심 내용을 한눈에 보여줍니다.

---

> 함께 만드는 청소년 정책, **청!정!기!**에서 시작해보세요 🎉


## ⛏ 기술스택
![image](https://github.com/user-attachments/assets/4a492235-620b-457b-989d-d60a07bbd463)
<br>

## ⚙ 시스템 아키텍처
![image](https://github.com/user-attachments/assets/4c58c051-73f1-4260-b4cb-47be9059f073)
<br>

## ⚙ AI 서비스 시스템 아키텍처
### 유사도 분석
![image](https://github.com/user-attachments/assets/d3ace899-691a-4d42-804e-986a928ac7d6)
<br>
### AI 댓글요약
![image](https://github.com/user-attachments/assets/2bf04ac6-8423-4da8-810c-aa4903b5650c)
<br>

## 📌 ER-다이어그램
![image](https://github.com/user-attachments/assets/8f6dceb6-2628-4492-b468-a05839e1d185)
<br>

## 📌 서비스 흐름도
![image](https://github.com/user-attachments/assets/e0df909a-a820-436f-8da2-c0bcab032d5a)

<br>

## 📌 DB 설계도
![image](https://github.com/user-attachments/assets/ce4e3f7b-b728-4071-9698-eafebaf91a63)
<br>

## 👨‍👩‍👦‍👦 팀원 역할
|역할|이름|GitHub|
|------|---|---|
|팀장/AI 설계/데이터분석|오희진| [GitHub](https://github.com/heejin-02)|
|프론트엔드/디자인|김혜림| [GitHub](https://github.com/hyerimmmmm)|
|백엔드|박지은| [GitHub](https://github.com/jieunpark0428)|
|백엔드/DB설계|이동한| [GitHub](https://github.com/donghan-lee)|
|백엔드/DB설계|차명훈| [GitHub](https://github.com/ckaudgns89)|

## 🤾‍♂️ 트러블슈팅

* 특정 데이터 조회 시, 쿼리문이 정상적으로 실행되지 않아 데이터가 반환되지 않거나 Null이 반환됨<br>
MyBatis를 사용하는 과정에서 ResultMap이 정의되지 않아, 쿼리 결과가 DTO로 매핑되지 않는 문제가 발생함
-> Mapper.xml에 ResultMap을 명시적으로 추가하고, 쿼리문과 DTO 필드 간의 매핑을 정확히 지정하여 데이터를 정상적으로 연결함
 
* AI 댓글 요약을 불러올 때, 글자수가 초과되면 요약이 안되고 빈 칸으로 응답이 나오는 문제<br>
 tokens 수를 제한하여 응답이가 생성되었을 때 제한한 토큰 수보다 응답이 더 길면 gpt 응답이 사라지는 현상이 발생함
-> 모델을 변경하고, 프롬프트 엔지니어링을 통해 글자수에 최대한 제약을 두어 응답을 조절함
