import ProjectDescription
import ProjectDescriptionHelpers

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
            bundleId: BundleIdentifier.swiftUIExample,
            deploymentTarget: .iOS(targetVersion: "14.0", devices: [.ipad, .iphone]),
            infoPlist: .extendingDefault(with: [
                "UIMainStoryboardFile": "",
                "UILaunchStoryboardName": "LaunchScreen",
                "LSSupportsOpeningDocumentsInPlace": true,
                "UIFileSharingEnabled": true,
                "CFBundleShortVersionString": "$(MARKETING_VERSION)"
            ]),
            sources: ["SwiftUIExample/Sources/**"],
            resources: ["SwiftUIExample/Resources/**"],
            dependencies: [
                .package(product: "TossPayments")
            ],
            settings: .settings(base: [
                "MARKETING_VERSION": Version.current,
                "DEVELOPMENT_TEAM": TeamIdentifier.tossPayments
            ])
        )
    ],
    schemes: [
        Scheme(
            name: "SwiftUIExample",
             buildAction: .buildAction(targets: ["SwiftUIExample"]),
            testAction: nil,
            runAction: .runAction(),
            archiveAction: .archiveAction(configuration: .release),
            profileAction: nil,
            analyzeAction: nil
        )
    ],
    additionalFiles: [
        "Project.swift"
    ])
