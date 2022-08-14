// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "bksdkcore",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "bksdkcore",
            targets: [
                "bksdkcore"
            ]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/XbikeJavierBC/ghmjolnircore.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/XbikeJavierBC/ghgungnircore.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/roberthein/TinyConstraints.git",
            branch: "master"
        )
    ],
    targets: [
        .target(
            name: "bksdkcore",
            dependencies: [
                "ghmjolnircore",
                "ghgungnircore",
                "TinyConstraints"
            ],
            resources: [
                .process("resources/localizable"),
                .process("resources/font/abel"),
            ]
        ),
        .testTarget(
            name: "bksdkcoreTests",
            dependencies: [
                "bksdkcore"
            ]
        ),
    ]
)
