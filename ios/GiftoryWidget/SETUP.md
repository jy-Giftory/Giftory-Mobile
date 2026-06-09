# iOS 홈 위젯 설정 가이드

Android 위젯은 코드만으로 완성되지만, iOS WidgetKit은 Xcode에서 타겟을 추가해야 동작합니다.

## 1. Widget Extension 타겟 추가
1. Xcode에서 `ios/Runner.xcworkspace` 열기
2. File → New → Target → **Widget Extension** 선택
3. Product Name: `GiftoryWidget`
4. **Include Configuration Intent 체크 해제**
5. Finish → "Activate" 클릭

## 2. 생성된 파일을 이 폴더의 파일로 교체
Xcode가 자동 생성한 `GiftoryWidget.swift`, `GiftoryWidgetBundle.swift`를
이 폴더(`ios/GiftoryWidget/`)에 있는 동명의 파일 내용으로 덮어쓰기.

## 3. App Group 설정 (앱 ↔ 위젯 데이터 공유)
두 타겟 모두에 동일한 App Group을 추가:
- **Runner** 타겟 → Signing & Capabilities → `+ Capability` → **App Groups** → `group.com.example.giftory.widget` 추가
- **GiftoryWidgetExtension** 타겟 → 동일하게 App Group 추가

> App Group ID는 `lib/core/services/widget_service.dart`의 `_appGroupId`,
> `GiftoryWidget.swift`의 `appGroupId`와 반드시 일치해야 합니다.

## 4. 빌드
`flutter run` 후 홈 화면에서 위젯 추가 → Giftory 선택

---

## 참고
- Android는 별도 설정 없이 `flutter build`만으로 위젯이 포함됩니다.
- 위젯 데이터는 앱이 기념일을 불러올 때마다 `WidgetService.updateUpcoming()`을 통해 자동 갱신됩니다.
