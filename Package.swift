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
            targets: ["TossPayments"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "TossPayments",
            path: "TossPayments/Sources"
        )
    ],
    swiftLanguageVersions: [.v5],
    version: .exact(try? String(contentsOf: URL(fileURLWithPath: "version")) ?? "0.0.1")
)
