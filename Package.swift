// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "UMengSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "UMCommon",
            targets: ["UMCommon"]
        ),
        .library(
            name: "UMPush",
            targets: ["UMPush"]
        ),
    ],
    targets: [
        .binaryTarget(name: "UMCommonBinary",path: "Frameworks/UMCommon.xcframework"),
        .binaryTarget(name: "UMDeviceBinary",path: "Frameworks/UMDevice.xcframework"),
        .binaryTarget(name: "UYumaoBinary",path: "Frameworks/UYumao.xcframework"),
        .binaryTarget(name: "UMPushBinary",path: "Frameworks/UMPush.xcframework"),
        
        // MARK: UMCommon
        .target(
            name: "UMCommon",
            dependencies: [
                "UMCommonBinary",
                "UMDeviceBinary",
                "UYumaoBinary"
            ],
            resources: [
                .copy("Resources/UMCommonLog.bundle")
            ],
            linkerSettings: [
                .linkedFramework("SystemConfiguration"),
                .linkedFramework("CoreTelephony"),
                .linkedFramework("Security"),
                .linkedFramework("CoreGraphics"),
                .linkedLibrary("z"),
                .linkedLibrary("c++")
            ]
        ),

        // MARK: UMPush

        .target(
            name: "UMPush",
            dependencies: [
                "UMCommon",
                "UMPushBinary"
            ],
            resources: [
                .copy("Resources/UMPushResource.bundle")
            ],
            linkerSettings: [
                .linkedFramework("UserNotifications")
            ]
        ),

        .testTarget(
            name: "UMengSDKTests",
            dependencies: [
                "UMPush"
            ]
        )
    ]
)
