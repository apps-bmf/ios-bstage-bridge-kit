# 사용 예시

## 다른 프로젝트에서 사용하기

### 1. Tuist 프로젝트에서 사용

`Tuist/Package.swift`에 추가:

```swift
dependencies: [
    .package(path: "../BstageBridgeKit"), // 로컬 경로
    // 또는
    .package(url: "https://github.com/your-org/BstageBridgeKit.git", from: "1.0.0"), // Git 저장소
]
```

`Project.swift`에서:

```swift
dependencies: [
    .external(name: "BstageBridgeKit"), // 이것만 추가하면 됨!
]
```

### 2. 일반 Xcode 프로젝트에서 사용

1. File → Add Packages...
2. Git URL 또는 로컬 경로 입력
3. `MLKitTranslateWrapper` 타겟 추가

### 3. 코드에서 사용

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

// 번역 실행
let translatedText = try await translator.translate("Hello, World!")
print(translatedText)
```

## 장점

✅ **빌드 스크립트 불필요** - SPM이 자동으로 리소스 번들을 처리  
✅ **재사용 가능** - 다른 프로젝트에서 쉽게 사용  
✅ **유지보수 용이** - 한 곳에서만 관리  
✅ **자동화** - xcframework 업데이트 시 리소스 번들도 자동 업데이트

