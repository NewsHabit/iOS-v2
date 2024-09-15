[기존 NewsHabit 프로젝트](https://github.com/NewsHabit/iOS)를 **Micro-Feature Architecture** + **MVVM-C** 구조로 리팩토링한 레포지토리입니다.

<br>

## ⚒️ 기술 스택
|용도|의존성|버전|
|-|-|-|
|아키텍처|[Tuist](https://tuist.io/)|4.7.0|
|네트워크|[Alamofire](https://github.com/Alamofire/Alamofire)|5.8.1|
|네트워크|[Kingfisher](https://github.com/onevcat/Kingfisher)|7.0.0|
|UI|[FlexLayout](https://github.com/layoutBox/FlexLayout)|2.0.7|
|UI|[PinLayout](https://github.com/layoutBox/PinLayout)|1.10.5|

<br>

## 🗂️ 프로젝트 구조

<img width=250 src="https://github.com/user-attachments/assets/97d57ff2-f27a-417f-bc57-45e2254246a5" align="left" hspace="10" vspace="10">

``` swift
Projects
├── App
│   ├── Resources
│   └── Sources (메인 앱 타겟)
├── Feature
│   ├── ...
│   │   ├── Examples (데모 앱을 위한 앱 타겟)
|   │   ├── Interface (공개 API를 정의하는 프레임워크 타겟)
│   │   └── Sources (실제 구현을 포함하는 프레임워크 타겟)
├── Domain
│   ├── ...
│   │   ├── Interface (도메인 로직의 공개 API를 정의하는 프레임워크 타겟)
│   │   └── Sources (도메인 로직 구현을 포함하는 프레임워크 타겟)
├── Core
│   ├── ...
│   │   ├── Interface (코어 기능의 공개 API를 정의하는 프레임워크 타겟)
│   │   └── Sources (코어 기능 구현을 포함하는 프레임워크 타겟)
└── Shared
    ├── DesignSystem
    │   ├── Resources
    │   └── Sources (디자인 시스템 구현을 포함하는 프레임워크 타겟)
    ├── Util
    │   └── Sources (유틸리티 구현을 포함하는 프레임워크 타겟)
    └── ThirdPartyLib
```

<br>

## ✨ 주요 기능
### 온보딩

|![image](https://github.com/user-attachments/assets/2ffe71d2-4632-4ce4-853d-b7312fb54779)|![image](https://github.com/user-attachments/assets/100a60d6-81f8-4479-8d5b-69724856bea4)|![image](https://github.com/user-attachments/assets/28b763e8-ef3d-4969-8f4d-7ea1d79d918c)|
|-|-|-|

- 사용자는 자신의 닉네임을 설정할 수 있다.
- 사용자는 추천받고 싶은 기사의 카테고리를 설정할 수 있다.
- 사용자는 추천받고 싶은 기사의 개수를 설정할 수 있다.

### 오늘의 뉴스

|![image](https://github.com/user-attachments/assets/efde0fa5-4f72-46cd-a56a-6580c656cfc4)|![image](https://github.com/user-attachments/assets/63da4598-812a-40f6-836f-52594182d9f4)|![image](https://github.com/user-attachments/assets/08250790-a10f-4d5c-9afe-bd174e5d5bc3)|
|-|-|-|

- 사용자는 자신의 닉네임을 네비게이션 바 라지 타이틀에서 확인할 수 있다.
- 사용자는 자신이 오늘의 뉴스를 모두 읽은 누적 일수를 네비게이션 바 서브 타이틀에서 확인할 수 있다.
- 사용자는 자신이 설정한 데이터(카테고리, 개수)를 바탕으로 오늘의 뉴스 목록을 볼 수 있다.
- 오늘의 뉴스를 모두 읽으면 알림 메시지가 표시되고, 오늘의 뉴스를 모두 읽은 날짜를 이달의 기록 뷰에서 확인할 수 있다.

### 지금 뜨는 뉴스

|![image](https://github.com/user-attachments/assets/96da5b82-1ea3-463c-8b70-3ed177ba5d30)|![image](https://github.com/user-attachments/assets/b2156fdb-4b0a-4edf-99bc-f85b452234bf)|
|-|-|

- 사용자는 실시간 인기 있는 뉴스 목록을 확인할 수 있다.
- 사용자는 뉴스 목록을 새로고침할 수 있다.

### 설정

|![image](https://github.com/user-attachments/assets/4e5203d6-28be-4478-b242-d2d2656972a5)|![image](https://github.com/user-attachments/assets/18aeb52c-8c66-4217-b265-77095985faaa)|![image](https://github.com/user-attachments/assets/58313855-91c2-4b7a-8184-56747a38f393)|![image](https://github.com/user-attachments/assets/389c575a-65f7-4773-af80-aba6dc2d0e5c)|
|-|-|-|-|

- 사용자는 자신의 닉네임을 수정할 수 있다.
- 사용자는 추천받고 싶은 기사의 카테고리와 개수를 수정할 수 있다.
- 사용자는 시간을 지정하여 알림을 허용할 수 있다.

