// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "mail-kit",
    platforms: [
       .macOS(.v10_15)
    ],
    products: [
        .library(name: "MailKit", targets: ["MailKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.36.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.4.0"),
    ],
    targets: [
        .target(name: "MailKit", dependencies: [
            .product(name: "NIO", package: "swift-nio"),
            .product(name: "Logging", package: "swift-log"),
        ]),
        .testTarget(name: "MailKitTests", dependencies: ["MailKit"]),
    ]
)
