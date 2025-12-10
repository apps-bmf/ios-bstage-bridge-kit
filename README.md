# BstageBridgeKit

MLKit Translate와 필요한 리소스 번들을 포함하는 Swift Package Manager 패키지입니다.

## 설치

### Swift Package Manager

Xcode에서:
1. File → Add Packages...
2. Git URL에 이 저장소 URL 입력
3. 버전 선택 후 Add Package

또는 `Package.swift`에 추가:

```swift
dependencies: [
    .package(url: "https://github.com/your-org/mlkit-translate-wrapper.git", from: "1.0.0")
]
```

## 사용법

```swift
import BstageBridgeKit
import MLKitTranslate

// 리소스 번들 확인 (선택사항)
if BstageBridgeKit.verifyResourceBundle() {
    print("✅ 리소스 번들 로드 성공")
}

// MLKit Translate 사용
let options = TranslatorOptions(sourceLanguage: .english, targetLanguage: .korean)
let translator = Translator.translator(options: options)
```

## 특징

- ✅ MLKit Translate xcframework 포함
- ✅ 필요한 리소스 번들 자동 포함
- ✅ 빌드 스크립트 불필요
- ✅ 다른 프로젝트에서 쉽게 재사용 가능

## 포함된 프레임워크

- MLKitCommon
- MLKitTranslate
- MLKitLanguageID
- MLKitNaturalLanguage
- GoogleToolboxForMac
- GoogleUtilitiesComponents

