// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        productTypes: [
          // BstageBridgeKit은 기본 설정 사용
      ]
    )
#endif

let package = Package(
  name: "ios-bstage-bridge-kit",
  platforms: [.iOS(.v15)],
  products: [
  ],
  dependencies: [
    .package(url: "https://github.com/google/promises.git", exact: "2.4.0"),
    .package(url: "https://github.com/google/GoogleDataTransport.git", revision: "CocoaPods-9.4.1"),
    .package(url: "https://github.com/google/GoogleUtilities.git", exact: "7.13.3"),
    .package(url: "https://github.com/google/gtm-session-fetcher.git", exact: "3.5.0"),
    .package(url: "https://github.com/firebase/nanopb.git", exact: "2.30910.0"),
    .package(url: "https://github.com/ZipArchive/ZipArchive", exact: "2.4.3"),
    // BstageBridgeKit 패키지 추가 (로컬 경로)
    .package(path: "../../"),
  ],
  targets: []
)
