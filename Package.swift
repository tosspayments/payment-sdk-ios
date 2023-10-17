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
            targets: ["TossPayments"]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "TossPayments",
            path: "TossPayments/Sources",
            resources: [.process("../version")]
        )
    ],
    swiftLanguageVersions: [.v5]
)
