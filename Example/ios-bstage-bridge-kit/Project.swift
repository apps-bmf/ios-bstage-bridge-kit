import ProjectDescription

let project = Project(
    name: "ios-bstage-bridge-kit",
    targets: [
        .target(
            name: "ios-bstage-bridge-kit",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.ios-bstage-bridge-kit",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            buildableFolders: [
                "ios-bstage-bridge-kit/Sources",
                "ios-bstage-bridge-kit/Resources",
            ],
            dependencies: [
                // promises
                .external(name: "FBLPromises"),
                .external(name: "Promises"),

                // GoogleDataTransport
                .external(name: "GoogleDataTransport"),

                // GoogleUtilities
                .external(name: "GULAppDelegateSwizzler"),
                .external(name: "GULEnvironment"),
                .external(name: "GULISASwizzler"),
                .external(name: "GULLogger"),
                .external(name: "GULMethodSwizzler"),
                .external(name: "GULNSData"),
                .external(name: "GULNetwork"),
                .external(name: "GULReachability"),
                .external(name: "GULUserDefaults"),

                // gtm-session-fetcher
                .external(name: "GTMSessionFetcher"),
                // .external(name: "GTMSessionFetcherCore"),
                // .external(name: "GTMSessionFetcherFull"),
                .external(name: "GTMSessionFetcherLogView"),
                
                // nanopb
                .external(name: "nanopb"),
                
                // ZipArchive
                .external(name: "ZipArchive"),
                
                // BstageBridgeKit - MLKit과 리소스 번들을 모두 포함
                .external(name: "BstageBridgeKit"),
            ],
            settings: .settings(
                base: [
                    "OTHER_LDFLAGS": ["$(inherited)", "-ObjC", "-all_load"],
                ]
            )
        )
    ]
)
