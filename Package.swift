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
        // Amazon IVS products를 외부에서 직접 사용할 수 있도록 노출
        .library(
            name: "AmazonIVSBroadcast",
            targets: ["AmazonIVSBroadcast"]
        ),
        .library(
            name: "AmazonIVSBroadcastStages",
            targets: ["AmazonIVSBroadcastStages"]
        ),
        .library(
            name: "AmazonIVSPlayer",
            targets: ["AmazonIVSPlayer"]
        ),
    ],
    dependencies: [],
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
        
        // Amazon IVS xcframework들을 binaryTarget으로 포함
        .binaryTarget(
            name: "AmazonIVSBroadcast",
            url: "https://broadcast.live-video.net/1.27.0/AmazonIVSBroadcast.xcframework.zip",
            checksum: "46f5ae81871437f4853ae664b5a5ce4eef59a60315e291cbc93a79d785049a59"
        ),
        .binaryTarget(
            name: "AmazonIVSBroadcastStages",
            url: "https://broadcast.live-video.net/1.27.0/AmazonIVSBroadcast-Stages.xcframework.zip",
            checksum: "9b39a0fbe378ba1565f149829244a27d0efa4841444c58112b75f1a45d2df8ab"
        ),
        .binaryTarget(
            name: "AmazonIVSPlayer",
            url: "https://player.live-video.net/1.43.0/AmazonIVSPlayer.xcframework.zip",
            checksum: "24cf5d8c7f74e036f1310bed94ca640222f1d7d39d852c40dd05b14606465862"
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
                "AmazonIVSBroadcast",
                "AmazonIVSBroadcastStages",
                "AmazonIVSPlayer",
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
