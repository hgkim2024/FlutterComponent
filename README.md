# Flutter Project 기반 구축
> UB Plus 에서 근무할 때 D-STOP 앱을 SwiftUI 로 앱을 개발했었습니다. 이때 AOS 와 iOS 에 Native 기능이 거의 사용되지 않았고,백여 개의 UI 화면을 개발해야 했습니다. 주 개발 요구사항은 UI 화면 개발이며 나머지 부가적인 Native 기능이 있어도 향후 개발 방향성은 크로스 플랫폼인 Flutter 로 개발하는 것이 개발 및 테스트, 유지보수, 개발 속도 등 여러 방면에서 좋다고 생각되어 Flutter 로 개발할 수 있는 환경을 구축했습니다.

<br>
<br>

![샘플 GIF](gif/ub_flutter.gif)

<br>

## UI 컴포넌트화
- Text, Font, Button, Dialog 컴포넌트화

<br>

## Log 공통화 (Log.dart)
- Log 출력 시 파일명, 라인 표기
- Log 출력 시 Tag 를 추가하여 Tag 별로 Filter 하여 로그 볼 수 있도록 개발
- Tag 는 2개 이상도 가능하다.
- Log Level 설정으로 출력할 로그 Level 지정 가능

<br>

## REST API 공통처리 (dioProvider.dart)
- REST API 요청할 때 Access Token 만료 시 Refresh Token 으로 갱신하여 다시 요청하는 처리 공통화
- REST API 호출 시 데이터 정보, 성공 실패 여부 등이 가독성 있게 보이도록 공통화
- REST API Error Handle 공통화

<br>

## Router (router.dart)
- Go Router 를 사용하여 화면이동 구조를 한 파일에서 확인 할 수 있게 개발

<br>

## 사용된 라이브러리
- retrofit
- flutter_riverpod
- go_router
- permission_handler
