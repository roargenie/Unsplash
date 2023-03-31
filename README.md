# Unsplash
<img src="https://user-images.githubusercontent.com/105975078/229026090-652d133d-d1bc-48e5-acbe-4127f9a8dde2.jpeg" width=20%><img src="https://user-images.githubusercontent.com/105975078/229026096-59f24aa5-792f-4c06-96e8-2561c6cde37c.jpeg" width=20%><img src="https://user-images.githubusercontent.com/105975078/229026098-982da8a1-580f-42df-bcd6-944fa9f0249e.jpeg" width=20%><img src="https://user-images.githubusercontent.com/105975078/229026100-ed5bfaeb-3798-4438-ae04-900a58eef987.jpeg" width=20%><img src="https://user-images.githubusercontent.com/105975078/229026103-49bc9029-993a-43dd-9103-c49c95e89b58.jpeg" width=20%>

### 앱 소개
- 개발기간 : 2023.02.12 ~ ing
- 1인 개발
- 사진 추천 / 검색 서비스

### 주요 기능
- 사진 랜덤 추천
- 오늘의 사진추천
- 사진 검색

### 기술 스택
- `MVVM` `RxSwift` `Coordinator` `Singleton` `Repository` `Input/Output` `Compositional Layout`
`Diffable DataSource` `SnapKit` `Then` `Alamofire`

### 기술 설명
- ViewController의 독립성을 위한 `Coordinator` 패턴 적용.
- 비즈니스 로직 구분과 코드 가독성을 위한 `Input/Output` 패턴 적용.
- `CombineLatest`, `WithLatestFrom` Operator를 활용하여 로그인, 회원가입 로직 구현.
- `throttle`, `debounce` Operator를 활용하여 중복터치 및 중복값 네트워크 호출 방지.
- ButtonStatus, LabelStatus 등을 `Enum` 으로 관리하여 상태 변경에 따른 효율적인 UI변경.
- `Protocol` 및 `Initializer` 를 활용하여 의존성 주입.
- Custom Layout으로 Pinterest UI 구현.

### 트러블 슈팅
[개발일지 보러가기](https://military-dugout-02f.notion.site/Unsplash-Side-Project-993e8ee8ac254ce79cf168acc9ba980b)
- 
