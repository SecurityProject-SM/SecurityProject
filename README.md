# 건어물 🏢
#### SmartBuilding Management System

##### 팀원 : 박찬희, 김호식, 이창민
기간 : 24.11.01 ~ 24.12.23

[웹 시연영상](유튜브 링크 넣기)   
([노션 링크 넣기](https://scratch-helium-985.notion.site/131282d9286180f2b89ac82111e2d57d?pvs=4))

~~대표 이미지~~

# 1. 프로젝트 주제 및 기획의도

#### 주제 ❗️
<code> 프로젝트 주제 뭐였더라 </code>

#### 기획의도❗️
1. 머시기 머시기
2. ㅁㄴㅇㄹ
---
# 2. 프로젝트 개요
📌 프로젝트 계획도   
<img src="/path/to/img.jpg" width="200px" height="150px" title="px(픽셀) 크기 설정" ></img><br/>

📌 플로우차트   

📌 시스템 아이텍처   

📌 소프트웨어 아키텍처(개발환경 및 수행도구)   

📌 DB설계(ERD)   

📌 WBS  

📌 역할분담   


---

# 사용자 페이지
## 핵심 기능
### 1) 챗봇 및 웹소켓 📫
<img src="/path/to/img.jpg" width="200px" height="150px" title="px(픽셀) 크기 설정" ></img><br/>

- Naver Clova ChatBot API를 활용하여 사용자와 1:1 대화를 할 수 있는 챗봇 시스템 구현   


- 웹소켓(WebSocket) 기반의 양방향 실시간 통신을 통해 빠르고 안정적인 메시지 전송 환경을 제공 


- 사용자가 보낸 메시지는 웹소켓을 통해 서버로 전송되며, 서버는 NCP CLOVA ChatBot과 통신하여 적절한 응답을 리턴받음

### 2) 소셜 로그인 (카카오) 👀
<img src="/path/to/img.jpg" width="200px" height="150px" title="px(픽셀) 크기 설정" ></img><br/>

- Kakao Rest API를 활용하여 소셜 로그인 구현
  - 기존 사용자와 신규 사용자를 구분하여 처리

> 로그인 플로우
> 1. Authorization Code를 기반으로 Access Token 요청
> 2. Access Token으로 사용자 고유 ID와 이름, 이메일 등을 수신
> 3. 사용자가 소셜로그인을 처음 시도한 경우 추가정보를 입력받고 db에 추가


### 3) 결제?

### 4) 에너지 관리

### 5) 주차 관리

## 기본 기능 ⚡

### 메인 페이지

~~이미지~~

> - 지도
>   - 카카오맵 api를 사용하여 지도를 페이지에 통합 및 표시
> - Ajax
>   - 전력 사용량을 실시간 비동기통신으로 가져와 업데이트
>   - 주차 데이터를 실시간으로 가져와 업데이트
> - highcharts
>   - 전력 사용량을 highcharts 라이브러를 사용하여 시각화
>   - AJAX 요청을 통해 데이터를 주기적으로 가져와 차트에 실시간 추가
> - 웹캠
>   - WebRTC 기술을 사용하여 로컬 장치의 웹캠에 접근
>   - HTML5 <vidio> 태그를 활용해 실시간 스트림 출력
> - 날씨
>   - OpenWeather api를 사용하여 날씨 데이터를 비동기적으로 가져와 UI에 업데이트
> - Mybatis 
>   - SQL과 Java Dto 객체를 매핑해 데이터베이스 연동
>   - Mapper XML에서 작성된 SQL을 Repository 인터페이스 메서드에 매핑.
>   - Mapper 파일을 통해 CRUD 및 동적 쿼리 실행

### 분석, 공지사항 페이지
~~이미지~~

> - Mybatis
>   - SQL과 Java Dto 객체를 매핑해 데이터베이스 연동
>   - Mapper XML에서 작성된 SQL을 Repository 인터페이스 메서드에 매핑.
>   - Mapper 파일을 통해 CRUD 및 동적 쿼리 실행

---

# 관리자 페이지
## 핵심 기능
### 1) 웹소켓 통신 💬
<img src="/path/to/img.jpg" width="200px" height="150px" title="px(픽셀) 크기 설정" ></img><br/>

- STOMP를 활용하여 메시지 브로커 방식으로 데이터 전송
- SockJS 및 STOMP 클라이언트를 사용해 서버에 연결

>**메시지 플로우**
> 1. 클라이언트 연결
>    1. 페이지 로드시 SockJS 연결 자동 생성
 >    2. STOMP 경로 /send/user 및 /send/admin 구독
> 2. 메시지 송신
>   1. 발신자가 메시지 입력 후 Enter 또는 send 버튼 클릭 → JSON 형식으로 메시지를 STOMP 경로로 전송
>3. 메시지 수신
>   1. 서버는 구독된 경로로 메시지를 수신
>   2. 수신된 메시지는 HTML DOM에 추가되어 채팅 UI에 표시.


### 2) 에너지 관리

### 3) 차량감지 시스템

### 4) 관리자 일정 통합 관리 시스템

## 기본 기능
### 기본 페이지
~~이미지~~

> - Mybatis
>   - SQL과 Java Dto 객체를 매핑해 데이터베이스 연동
>   - Mapper XML에서 작성된 SQL을 Repository 인터페이스 메서드에 매핑.
>   - Mapper 파일을 통해 CRUD 및 동적 쿼리 실행

---






# 5. Troubleshooting



# 6. 에필로그

