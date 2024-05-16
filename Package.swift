// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "TossPayments",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "TossPayments",
            targets: ["TossPayments"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "TossPayments",
            dependencies: ["WidgetLogger"],
            path: "TossPayments/Sources"
        ),
        .binaryTarget(name: "WidgetLogger", path: "Tosspayments/BinaryFramework/WidgetLogger.xcframework")
    ],
    swiftLanguageVersions: [.v5]
)
