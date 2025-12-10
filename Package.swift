// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "BstageBridgeKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "BstageBridgeKit",
            targets: ["BstageBridgeKit"]
        ),
    ],
    dependencies: [
        // MLKit 의존성들은 binaryTarget으로 포함
    ],
    targets: [
        // MLKit xcframework들을 binaryTarget으로 포함
        .binaryTarget(
            name: "MLKitCommon",
            url: "https://github.com/apps-bmf/google-mlkit-spm/releases/download/v0.0.1/MLKitCommon.xcframework.zip",
            checksum: "b0d97e824bc2694f20ace756ebf76aab60c03d382ba73769baded24a566d95ec"
        ),
        .binaryTarget(
            name: "MLKitTranslate",
            url: "https://github.com/apps-bmf/google-mlkit-spm/releases/download/v0.0.1/MLKitTranslate.xcframework.zip",
            checksum: "17b4de3f2b28b41da30c71dcc9b2e1460174df8c21b13afd6287b096b6486994"
        ),
        .binaryTarget(
            name: "MLKitLanguageID",
            url: "https://github.com/apps-bmf/google-mlkit-spm/releases/download/v0.0.1/MLKitLanguageID.xcframework.zip",
            checksum: "8d5dc20e1a3f26b1181d912b7c80d746ed015eeddfd8aaa66dff13d85fc9f1c4"
        ),
        .binaryTarget(
            name: "MLKitNaturalLanguage",
            url: "https://github.com/apps-bmf/google-mlkit-spm/releases/download/v0.0.1/MLKitNaturalLanguage.xcframework.zip",
            checksum: "46273e5dfadea9fef9370ec385d2b90e96ffd68a277fc72bd9a70497c8d1de94"
        ),
        .binaryTarget(
            name: "GoogleToolboxForMac",
            url: "https://github.com/apps-bmf/google-mlkit-spm/releases/download/v0.0.1/GoogleToolboxForMac.xcframework.zip",
            checksum: "fceff1a3b2843b98fd9f5543eefb0357dc2e04f3b4988e667cd3961773697b14"
        ),
        .binaryTarget(
            name: "GoogleUtilitiesComponents",
            url: "https://github.com/apps-bmf/google-mlkit-spm/releases/download/v0.0.1/GoogleUtilitiesComponents.xcframework.zip",
            checksum: "aa9158109eaf66a104e9307b4edb9896f12559640b7426e119481e369d2c6f04"
        ),
        
        // Wrapper 타겟 - 리소스 번들을 포함
        .target(
            name: "BstageBridgeKit",
            dependencies: [
                "MLKitCommon",
                "MLKitTranslate",
                "MLKitLanguageID",
                "MLKitNaturalLanguage",
                "GoogleToolboxForMac",
                "GoogleUtilitiesComponents",
            ],
            resources: [
                // 리소스 번들을 여기에 포함
                .copy("Resources/MLKitTranslate_resource.bundle"),
            ],
            linkerSettings: [
                .linkedFramework("CoreFoundation"),
                .linkedFramework("CoreTelephony"),
                .linkedFramework("Foundation"),
                .linkedFramework("QuartzCore"),
                .linkedFramework("Security"),
                .linkedFramework("SystemConfiguration"),
                .linkedFramework("UIKit"),
            ]
        ),
    ]
)

