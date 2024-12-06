<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스마트 빌딩 - 마이페이지</title>
    <link href="styles.css" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>

    @media (min-width: 1200px) {
        .main-content {
             margin-left: 0rem;
        }
    }

    /* Base styles */
    body {
        min-height: 100vh;
        background: linear-gradient(to bottom, #EBF5FF, #FFFFFF);
    }

    .container {
        max-width: 1200px; /* 전체 컨테이너 최대 너비 설정 */
        padding: 1rem;
        background: linear-gradient(145deg, #eef2f7 0%, #dde4ec 100%);
        border-radius: 20px;
    }

    /* 반응형 처리 */
    @media (max-width: 1024px) {
        .main-grid {
            grid-template-columns: 1fr;
            gap: 1.5rem;
        }
    }

    .profile-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .camera-button {
        position: absolute;
        bottom: 0;
        right: 0;
        background: #3B82F6;
        color: white;
        padding: 0.5rem;
        border-radius: 9999px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    }

    .camera-button i {
        height: 1rem;
        width: 1rem;
    }

    .profile-details {
        flex: 1;
    }


    /* 프로필 섹션 스타일 수정 */
    .profile-section {
        background: white;
        border-radius: 0.75rem;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        margin-bottom: 1.5rem;
    }

    .profile-content {
        padding: 1.5rem 2rem;
        background-color: #FCFBFF;
        color: #090909;
    }

    .profile-info {
        display: flex;
        align-items: center;
        gap: 1.5rem;
    }

    .profile-image-container {
        position: relative;
    }

    .profile-image {
        height: 8rem;
        width: 8rem;
        border-radius: 9999px;
        border: 4px solid white;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        background: white;
    }

    .profile-details h1 {
        color: #090909;
        margin-bottom: 0.5rem;
    }

    .user-type {
        color: rgb(9, 9, 9);
    }

    .user-info {
        display: flex;
        gap: 1rem;
        margin-top: 0.5rem;
    }

    .info-item {
        display: flex;
        align-items: center;
        gap: 0.25rem;
        color: #090909;
    }

    .info-item i {
        color: #090909;
    }

    .profile-actions {
        display: flex;
        gap: 0.75rem;
        margin-top: 1rem;
    }

    @media (max-width: 768px) {
        .profile-info {
            flex-direction: column;
            align-items: flex-start;
        }

        .profile-actions {
            width: 100%;
            justify-content: flex-start;
        }
    }



    .inquiry-button {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        background: white;
        border: 1px solid #E5E7EB;
        padding: 0.5rem 1rem;
        border-radius: 0.5rem;
        transition: background-color 0.2s;
    }


    .contract-button {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        background: white;
        border: 1px solid #E5E7EB;
        padding: 0.5rem 1rem;
        border-radius: 0.5rem;
        transition: background-color 0.2s;
    }

    .contract-button:hover {
        background: #F9FAFB;
    }

    /* Main Grid Layout */
    .main-grid {
        display: grid;
        grid-template-columns: 1fr;
        gap: 1.5rem;
    }

    @media (min-width: 1024px) {
        .main-grid {
            grid-template-columns: 4fr 8fr;
        }
    }

    /* Sidebar */
    .sidebar {
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
    }

    /* Info Cards */
    .info-card {
        background: white;
        border-radius: 0.75rem;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        padding: 1.5rem;
    }

    .info-card h2 {
        font-size: 1.125rem;
        font-weight: 600;
        margin-bottom: 1rem;
    }

    /* Environment Grid */
    .environment-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 1rem;
    }

    .environment-item {
        padding: 1rem;
        border-radius: 0.5rem;
        text-align: center;
    }

    .environment-item i {
        height: 1.5rem;
        width: 1.5rem;
        margin: 0 auto 0.5rem;
    }

    .environment-item .value {
        font-size: 1.5rem;
        font-weight: 700;
    }

    .environment-item .label {
        font-size: 0.875rem;
        color: #6B7280;
    }

    .temperature {
        background: #EBF5FF;
    }

    .temperature i {
        color: #3B82F6;
    }

    .humidity {
        background: #ECFDF5;
    }

    .humidity i {
        color: #10B981;
    }

    .air-quality {
        background: #F5F3FF;
    }

    .air-quality i {
        color: #8B5CF6;
    }

    .power {
        background: #FEF3C7;
    }

    .power i {
        color: #F59E0B;
    }

    /* Notifications */
    .notifications {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }

    .notification-item {
        display: flex;
        align-items: center;
        gap: 1rem;
        padding: 0.75rem;
        border-radius: 0.5rem;
    }

    .notification-icon {
        padding: 0.5rem;
        border-radius: 9999px;
    }

    .notification-icon i {
        height: 1.25rem;
        width: 1.25rem;
    }

    .notification-title {
        font-size: 0.875rem;
        font-weight: 500;
    }

    .notification-desc {
        font-size: 0.75rem;
        color: #6B7280;
    }

    .delivery {
        background: #EBF5FF;
    }

    .delivery .notification-icon {
        background: #DBEAFE;
        color: #3B82F6;
    }

    .parking {
        background: #FEF3C7;
    }

    .parking .notification-icon {
        background: #FDE68A;
        color: #F59E0B;
    }

    .payment {
        background: #ECFDF5;
    }

    .payment .notification-icon {
        background: #D1FAE5;
        color: #10B981;
    }

    /* Quick Menu */
    .quick-menu-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 1rem;
    }

    .quick-menu-item {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.75rem;
        background: #F9FAFB;
        border-radius: 0.5rem;
        transition: background-color 0.2s;
    }

    .quick-menu-item:hover {
        background: #F3F4F6;
    }

    .quick-menu-item i {
        height: 1.25rem;
        width: 1.25rem;
        color: #4B5563;
    }

    .quick-menu-item span {
        font-size: 0.875rem;
        font-weight: 500;
    }

    /* Form Card */
    .form-card {
        background: white;
        border-radius: 0.75rem;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    }

    .form-header {
        padding: 1.5rem;
        border-bottom: 1px solid #E5E7EB;
    }

    .form-title h2 {
        font-size: 1.25rem;
        font-weight: 600;
    }

    .form-title p {
        font-size: 0.875rem;
        color: #6B7280;
    }

    .user-form {
        padding: 1.5rem;
    }

    .form-grid {
        display: grid;
        gap: 1.5rem;
    }

    @media (min-width: 768px) {
        .form-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .form-group label {
        font-size: 0.875rem;
        font-weight: 500;
        color: #374151;
    }

    .input-container {
        position: relative;
    }

    .input-icon {
        position: absolute;
        left: 0.75rem;
        top: 50%;
        transform: translateY(-50%);
        color: #6B7280;
    }

    .input-icon i {
        height: 1.25rem;
        width: 1.25rem;
    }

    .input-container input {
        width: 100%;
        padding: 0.5rem 0.75rem 0.5rem 2.5rem;
        border: 1px solid #E5E7EB;
        border-radius: 0.5rem;
    }

    .input-container input:read-only {
        background: #F9FAFB;
    }

    /* Settings Section */
    .settings-section {
        margin-top: 1.5rem;
        padding-top: 1.5rem;
        border-top: 1px solid #E5E7EB;
    }

    .settings-section h3 {
        font-size: 1.125rem;
        font-weight: 500;
        margin-bottom: 1rem;
    }

    .settings-grid {
        display: grid;
        gap: 1.5rem;
    }

    @media (min-width: 768px) {
        .settings-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    .settings-group {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .settings-group label {
        font-size: 0.875rem;
        font-weight: 500;
        color: #374151;
    }

    .checkbox-group {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .checkbox-label {
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .checkbox-label input[type="checkbox"] {
        border-radius: 0.25rem;
        color: #3B82F6;
    }

    .checkbox-label span {
        font-size: 0.875rem;
    }

    /* Form Actions */
    .form-actions {
        display: flex;
        justify-content: flex-end;
        gap: 0.75rem;
        margin-top: 1.5rem;
        padding-top: 1.5rem;
        border-top: 1px solid #E5E7EB;
    }

    .save-button {
        background: #3B82F6;
        color: white;
        padding: 0.5rem 1.5rem;
        border-radius: 0.5rem;
        transition: background-color 0.2s;
    }

    .save-button:hover {
        background: #2563EB;
    }

    .delete-button {
        background: #EF4444;
        color: white;
        padding: 0.5rem 1.5rem;
        border-radius: 0.5rem;
        transition: background-color 0.2s;
    }

    .delete-button:hover {
        background: #DC2626;
    }

    /* Usage History */
    .usage-history {
        background: white;
        border-radius: 0.75rem;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        padding: 1.5rem;
        margin-top: 1.5rem;
    }

    .usage-history h2 {
        font-size: 1.125rem;
        font-weight: 600;
        margin-bottom: 1rem;
    }

    .history-list {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }

    .history-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 1rem;
        background: #F9FAFB;
        border-radius: 0.5rem;
    }

    .history-content {
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .history-content i {
        height: 1.5rem;
        width: 1.5rem;
    }

    .history-content i[data-lucide="zap"] {
        color: #F59E0B;
    }

    .history-content i[data-lucide="car"] {
        color: #3B82F6;
    }

    .history-content i[data-lucide="calendar"] {
        color: #10B981;
    }

    .history-details {
        display: flex;
        flex-direction: column;
    }

    .history-title {
        font-weight: 500;
    }

    .history-desc {
        font-size: 0.875rem;
        color: #6B7280;
    }

    .history-date {
        font-size: 0.875rem;
        color: #6B7280;
    }

    .main-grid {
        display: grid;
        grid-template-columns: minmax(300px, 400px) minmax(500px, 800px); /* 왼쪽과 오른쪽 컬럼의 최소/최대 너비 지정 */
        gap: 2rem; /* 간격을 1.5rem에서 2rem으로 수정 */
        max-width: 1200px; /* 전체 최대 너비 설정 */
        margin: 0 auto; /* 중앙 정렬 */
        padding: 0 1rem; /* 좌우 여백 추가 */
    }

</style>


</head>

<body>
<div class="container">
    <!-- 상단 프로필 섹션 -->
    <div class="profile-section">
        <div class="profile-content">
            <div class="profile-info">
                <div class="profile-image-container">
                    <div class="profile-image">
                        <img src="<c:url value='/img/gunamul2.jpeg'/>" alt="프로필 이미지">
                    </div>
                    <button class="camera-button">
                        <i data-lucide="camera"></i>
                    </button>
                </div>
                <div class="profile-details">
                    <h1>${user.userName}</h1>
                    <p class="user-type">입주자</p>
                    <div class="user-info">
                        <div class="info-item">
                            <i data-lucide="home"></i>
                            A동 701호
                        </div>
                        <div class="info-item">
                            <i data-lucide="calendar"></i>
                            입주일: 2023.01.15
                        </div>
                    </div>
                </div>
                <div class="profile-actions">
                    <button class="inquiry-button">
                        <i data-lucide="message-circle"></i>
                        문의하기
                    </button>
                    <a href="<c:url value='/contract'/>" class="contract-button">
                        <i data-lucide="file-text"></i>
                        계약서
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="main-grid">
        <!-- 왼쪽 사이드바 - 주거 정보 -->
        <div class="sidebar">
            <!-- 실시간 환경 정보 -->
            <div class="info-card">
                <h2>우리 집 환경</h2>
                <div class="environment-grid">
                    <div class="environment-item temperature">
                        <i data-lucide="thermometer"></i>
                        <div class="value">23°C</div>
                        <div class="label">실내 온도</div>
                    </div>
                    <div class="environment-item humidity">
                        <i data-lucide="droplets"></i>
                        <div class="value">45%</div>
                        <div class="label">습도</div>
                    </div>
                    <div class="environment-item air-quality">
                        <i data-lucide="wind"></i>
                        <div class="value">좋음</div>
                        <div class="label">공기질</div>
                    </div>
                    <div class="environment-item power">
                        <i data-lucide="zap"></i>
                        <div class="value">3.2</div>
                        <div class="label">전력(kW)</div>
                    </div>
                </div>
            </div>

            <!-- 최근 알림 -->
            <div class="info-card">
                <h2>알림</h2>
                <div class="notifications">
                    <div class="notification-item delivery">
                        <div class="notification-icon">
                            <i data-lucide="package"></i>
                        </div>
                        <div class="notification-content">
                            <div class="notification-title">택배 도착</div>
                            <div class="notification-desc">1층 택배함 A-123 • 10분 전</div>
                        </div>
                    </div>
                    <div class="notification-item parking">
                        <div class="notification-icon">
                            <i data-lucide="hard-drive"></i>
                        </div>
                        <div class="notification-content">
                            <div class="notification-title">주차 위치 기록</div>
                            <div class="notification-desc">B1층 A-15 • 2시간 전</div>
                        </div>
                    </div>
                    <div class="notification-item payment">
                        <div class="notification-icon">
                            <i data-lucide="check-circle"></i>
                        </div>
                        <div class="notification-content">
                            <div class="notification-title">관리비 납부 완료</div>
                            <div class="notification-desc">3월 관리비 • 1일 전</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 빠른 메뉴 -->
            <div class="info-card">
                <h2>빠른 메뉴</h2>
                <div class="quick-menu-grid">
                    <a href="#" class="quick-menu-item">
                        <i data-lucide="calculator"></i>
                        <span>관리비 조회</span>
                    </a>
                    <a href="#" class="quick-menu-item">
                        <i data-lucide="car"></i>
                        <span>주차 관리</span>
                    </a>
                    <a href="#" class="quick-menu-item">
                        <i data-lucide="package"></i>
                        <span>택배 조회</span>
                    </a>
                    <a href="#" class="quick-menu-item">
                        <i data-lucide="calendar"></i>
                        <span>시설 예약</span>
                    </a>
                </div>
            </div>
        </div>

        <!-- 메인 컨텐츠 -->
        <div class="main-content">
            <!-- 개인정보 수정 폼 -->
            <div class="form-card">
                <div class="form-header">
                    <div class="form-title">
                        <h2>개인정보</h2>
                        <p>회원님의 기본 정보를 수정할 수 있습니다</p>
                    </div>
                </div>
                <form id="update_form" class="user-form">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="id">아이디</label>
                            <div class="input-container">
                                <span class="input-icon">
                                    <i data-lucide="user"></i>
                                </span>
                                <input id="id" name="userId" type="text" value="${user.userId}" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="pwd">비밀번호</label>
                            <div class="input-container">
                                <span class="input-icon">
                                    <i data-lucide="lock"></i>
                                </span>
                                <input id="pwd" name="userPwd" type="password" value="${user.userPwd}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="mail">이메일</label>
                            <div class="input-container">
                                <span class="input-icon">
                                    <i data-lucide="mail"></i>
                                </span>
                                <input id="mail" name="userMail" type="email" value="${user.userMail}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="tel">전화번호</label>
                            <div class="input-container">
                                <span class="input-icon">
                                    <i data-lucide="phone"></i>
                                </span>
                                <input id="tel" name="userTel" type="tel" value="${user.userTel}">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="name">이름</label>
                        <div class="input-container">
                            <span class="input-icon">
                                <i data-lucide="user"></i>
                            </span>
                            <input id="name" name="userName" type="text" value="${user.userName}">
                        </div>
                    </div>

                    <%--<!-- 입주자 설정 -->
                    <div class="settings-section">
                        <h3>스마트홈 설정</h3>
                        <div class="settings-grid">
                            <div class="settings-group">
                                <label>알림 설정</label>
                                <div class="checkbox-group">
                                    <label class="checkbox-label">
                                        <input type="checkbox" checked>
                                        <span>택배 알림</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" checked>
                                        <span>주차 알림</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" checked>
                                        <span>에너지 사용량 알림</span>
                                    </label>
                                </div>
                            </div>
                            <div class="settings-group">
                                <label>자동화 설정</label>
                                <div class="checkbox-group">
                                    <label class="checkbox-label">
                                        <input type="checkbox" checked>
                                        <span>실내온도 자동조절</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox">
                                        <span>조명 자동제어</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox">
                                        <span>환기 자동제어</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>--%>

                    <div class="form-actions">
                        <button type="button" id="update_btn" class="save-button">
                            저장하기
                        </button>
                        <button type="button" id="delete_btn" class="delete-button">
                            회원 탈퇴
                        </button>
                    </div>
                </form>
            </div>

            <!-- 최근 이용 내역 -->
            <div class="usage-history">
                <h2>최근 이용 내역</h2>
                <div class="history-list">
                    <div class="history-item">
                        <div class="history-content">
                            <i data-lucide="zap"></i>
                            <div class="history-details">
                                <div class="history-title">전기 사용량</div>
                                <div class="history-desc">89 kWh 사용</div>
                            </div>
                        </div>
                        <span class="history-date">2024-03-15</span>
                    </div>
                    <div class="history-item">
                        <div class="history-content">
                            <i data-lucide="car"></i>
                            <div class="history-details">
                                <div class="history-title">주차장 이용</div>
                                <div class="history-desc">B1층 A-15</div>
                            </div>
                        </div>
                        <span class="history-date">2024-03-14</span>
                    </div>
                    <div class="history-item">
                        <div class="history-content">
                            <i data-lucide="calendar"></i>
                            <div class="history-details">
                                <div class="history-title">커뮤니티 시설 예약</div>
                                <div class="history-desc">피트니스 센터</div>
                            </div>
                        </div>
                        <span class="history-date">2024-03-13</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    lucide.createIcons();

    let mypage = {
        init: function () {
            $('#update_btn').click(() => {
                this.check();
            });
            $('#delete_btn').click(() => {
                let id = $('#id').val();
                let c = confirm("정말 회원 탈퇴하시겠습니까?");
                if(c == true){
                    location.href='<c:url value="/deleteimpl"/>'+'?id='+id;
                }
            });
        },
        check:function(){
            let id = $('#id').val();
            let pwd = $('#pwd').val();
            let tel = $('#tel').val();
            let mail = $('#mail').val();
            let name = $('#name').val();

            if(id == '' || id == null){
                alert('아이디를 입력해주세요');
                $('#id').focus();
                return;
            }
            if(pwd == '' || pwd == null){
                alert('비밀번호를 입력해주세요');
                $('#pwd').focus();
                return;
            }
            if(name == '' || name == null){
                alert('이름을 입력해주세요');
                $('#name').focus();
                return;
            }
            if(tel == '' || tel == null){
                alert('전화번호를 입력해주세요');
                $('#tel').focus();
                return;
            }
            if(mail == '' || mail == null){
                alert('이메일을 입력해주세요');
                $('#mail').focus();
                return;
            }
            this.send();
        },
        send:function(){
            $('#update_form').attr('method','post');
            $('#update_form').attr('action','/updateimpl');
            $('#update_form').submit();
        }
    }

    $(function () {
        mypage.init();
    })
</script>
</body>
</html>