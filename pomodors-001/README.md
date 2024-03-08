# Flutter timer Project

- `pageView` 컴포넌트를 사용하여 `Multi View Page App` 을 구현
- `BottomNavigator`를 이용하여 화면을 전환하면서 보여주기

## Setting 화면 구현하기

- setting ui 도구 dependency 추가하기 : `flutter pub add settings_ui` 설치하기
- 날짜 설정 도구 dependency 추가하기 : `flutter pub add datetime_setting`

## Setting 에서 `일할시간`을 설정하면 Home 의 타이머에 반영하기

- `setting_page.dart` 에게 `onChange` 함수를 props 로 전달하여 `workTimer`state 를 변경하도록 코딩하기
- `workTimer` state 를 `home_page.dart` 에 전달하여 `_count` 변수에 할당하여 화면에 반영하기

- `setting` 에서 설정한 값이 `home` 에 반영되도록 하였지만, 어플을 종료한 후 다시 시작하면 값이 초기화가 되어 버린다

## Device 의 `localStorage` 에 setting 값 저장하기
