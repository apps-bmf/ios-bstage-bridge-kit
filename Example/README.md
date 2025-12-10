# Example App

이 폴더에는 `BstageBridgeKit` 패키지를 사용하는 예제 앱이 포함되어 있습니다.

## 구조

```
Example/
└── ios-bstage-bridge-kit/     # Tuist로 생성된 예제 앱
    ├── Project.swift          # BstageBridgeKit 패키지 사용
    ├── Tuist/
    │   └── Package.swift      # BstageBridgeKit 의존성 포함
    └── ios-bstage-bridge-kit/ # 앱 소스 코드
```

## 사용 방법

1. `BstageBridgeKit` 패키지가 루트에 있는지 확인
2. Example 앱에서 `tuist generate` 실행
3. Xcode에서 워크스페이스 열기
4. 앱 실행

## 특징

- ✅ `BstageBridgeKit` 패키지만 추가하면 MLKit Translate 사용 가능
- ✅ 빌드 스크립트 불필요 (리소스 번들 자동 처리)
- ✅ 간단한 의존성 관리

