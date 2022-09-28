import ProjectDescription

let project = Project(
    name: "SwiftUIExample",
    organizationName: "TossPayments, Inc",
    options: .options(automaticSchemesOptions: .disabled),
    packages: [
        .local(path: Path.relativeToRoot("./"))
    ],
    targets: [
        Target(
            name: "SwiftUIExample",
            platform: .iOS,
            product: .app,
            productName: "TossPayments SwiftUIExample",
            bundleId: "com.tosspayments.paymentsdk.examples.swiftui",
            deploymentTarget: .iOS(targetVersion: "14.0", devices: [.ipad, .iphone]),
            sources: ["SwiftUIExample/Sources/**"],
            resources: ["SwiftUIExample/Resources/**"],
            dependencies: [
                .package(product: "TossPayments")
            ]
        )
    ],
    schemes: [
        Scheme(
            name: "SwiftUIExample",
            buildAction: .buildAction(targets: ["SwiftUIExample"]),
            testAction: nil,
            runAction: .runAction(),
            archiveAction: nil,
            profileAction: nil,
            analyzeAction: nil
        )
    ],
    additionalFiles: [
        "Project.swift"
    ])
