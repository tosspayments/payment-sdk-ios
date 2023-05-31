import ProjectDescription
import ProjectDescriptionHelpers

let swiftlint = TargetScript.pre(script: """
    ROOT_PATH=${PROJECT_DIR}/../../..
    source ${ROOT_PATH}/.env.brew 
    bundle exec swiftlint lint ${TARGET_NAME} --config ${ROOT_PATH}/.swiftlint.yml
    """, 
    name: "Run Swiftlint",
    basedOnDependencyAnalysis: false
)

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
            productName: "UIKitExample",
            bundleId: BundleIdentifier.uiKitExample,
            deploymentTarget: .iOS(targetVersion: "11.0", devices: [.ipad, .iphone]),
            infoPlist: .extendingDefault(with: [
                "UIMainStoryboardFile": "",
                "UILaunchStoryboardName": "LaunchScreen",
                "LSSupportsOpeningDocumentsInPlace": true,
                "UIFileSharingEnabled": true,
                "CFBundleShortVersionString": "$(MARKETING_VERSION)",
                "Appearance": "Light",
                "CFBundleURLTypes": .array([
                    .dictionary([
                        "CFBundleTypeRole": "Editor",
                        "CFBundleURLSchemes": .array([
                            "tosspaymentExample"
                        ])
                    ])
                ])
            ]),
            sources: ["UIKitExample/Sources/**"],
            resources: ["UIKitExample/Resources/**"],
            scripts: [
                swiftlint
            ],
            dependencies: [
                .package(product: "TossPayments")
            ],
            settings: .settings(base: [
                "MARKETING_VERSION": Version.current
            ])
        )
    ],
    schemes: [
        Scheme(
            name: "UIKitExample",
            buildAction: .buildAction(targets: ["UIKitExample"]),
            testAction: nil,
            runAction: .runAction(),
            archiveAction: .archiveAction(configuration: .release),
            profileAction: nil,
            analyzeAction: nil
        )
    ],
    additionalFiles: ["Project.swift"]
)
