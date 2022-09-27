// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "TossPayments",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "TossPayments",
            targets: ["TossPayments"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "TossPayments",
            dependencies: []),
        .target(
            name: "TossPayments-Examples",
            dependencies: ["TossPayments"],
            path: "Examples")
    ]
)
