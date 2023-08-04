# 토스페이먼츠 iOS SDK

<img src="https://img.shields.io/badge/Swift-F05138?style=flat-square&logo=Swift&logoColor=white"/>

토스페이먼츠 iOS SDK를 위한 모노레포입니다. 토스페이먼츠 [결제창](https://docs.tosspayments.com/guides/payment/integration), [결제위젯](https://docs.tosspayments.com/guides/payment-widget/overview)을 iOS 앱에 연동하세요.

## 설치하기

### 요구 사항

토스페이먼츠 iOS SDK를 설치하기 전에 최소 요구 사항을 확인하세요.

- iOS 11.0 이상
- Swift 5.0 이상
- Xcode 12.5.1 이상

### CocoaPods로 설치하기

프로젝트 폴더에 있는 Podfile에 아래와 같이 토스페이먼츠 iOS SDK를 추가하세요. Podfile을 저장하고 `pod install` 커맨드를 실행하세요.

```
pod 'TossPayments'
```

### Swift Package Manager(SPM)로 설치하기
[토스페이먼츠 개발자 센터](https://docs.tosspayments.com/reference/widget-ios#swift-package-managerspm로-설치하기)

## 시작하기

### 연동 가이드

* [결제창 연동하기](https://docs.tosspayments.com/guides/payment/integration): 결제창에서 고객이 결제수단을 선택하고, 결제 정보를 입력해서 결제를 완료합니다. 
* [결제위젯 연동하기](https://docs.tosspayments.com/guides/payment-widget/integration): 토스페이먼츠에서 수많은 상점을 분석하여 만든 최적의 주문서 UI입니다.

### 샘플 프로젝트

1. `payment-sdk-ios` 리포지토리를 클론하세요.
```
git clone https://github.com/tosspayments/payment-sdk-ios
```

2. `TossPayments.xcworkspace` 파일을 XCode로 실행하세요.

```
xed TossPayments.xcworkspace
```

3. `UIKit-Example`을 빌드하고 단말 또는 시뮬레이터에 설치하세요. 앱이 실행되면 Client Key, Customer Key 등 필요한 정보를 모두 수정하고 Stage 필드를 `v1`으로 설정하세요.

![토스페이먼츠 iOS SDK 예시](https://static.tosspayments.com/docs/github/ios-sample.png)
