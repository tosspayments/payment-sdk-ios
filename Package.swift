// swift-tools-version:5.3
import PackageDescription

let setting = ProductSetting.bundleVersion("0.1.24")
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
            resources: [.copy("../version")]
        )
    ],
    swiftLanguageVersions: [.v5]
)
