import ProjectDescription

let project = Project(
    name: "UIKitExample",
    organizationName: "TossPayments, Inc",
    options: .options(automaticSchemesOptions: .disabled),
    packages: [
        .local(path: Path.relativeToRoot("./"))
    ],
    targets: [
        Target(
            name: "UIKitExample",
            platform: .iOS,
            product: .app,
            productName: "TossPayments UIKitExample",
            bundleId: "com.tosspayments.paymentsdk.examples.uikit",
            deploymentTarget: .iOS(targetVersion: "11.0", devices: [.ipad, .iphone]),
            sources: ["UIKitExample/Sources/**"],
            resources: ["UIKitExample/Resources/**"],
            dependencies: [
                .package(product: "TossPayments")
            ]
        )
    ],
    schemes: [
        Scheme(
            name: "UIKitExample",
            buildAction: .buildAction(targets: ["UIKitExample"]),
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
