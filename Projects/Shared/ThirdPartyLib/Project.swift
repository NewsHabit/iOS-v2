import DependencyPlugin
import ProjectDescriptionHelpers
import ProjectDescription

let targets: [Target] = [
    .shared(
        implements: .ThirdPartyLib,
        factory: .init(
            infoPlist: .extendingDefault(
                with: [
                    "UIMainStoryboardFile": "",
                    "UILaunchStoryboardName": "",
                    "LSSupportsOpeningDocumentsInPlace": true
                ]
            ),
            dependencies: [
                .SPM.Alamofire,
                .SPM.FlexLayout,
                .SPM.Kingfisher,
                .SPM.PinLayout
            ]
        )
    )
]

let project: Project = .makeModule(
    name: ModulePath.Shared.ThirdPartyLib.rawValue,
    packages: [
        .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .upToNextMajor(from: "5.8.1")),
        .remote(url: "https://github.com/layoutBox/FlexLayout", requirement: .upToNextMajor(from: "2.0.7")),
        .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.0.0")),
        .remote(url: "https://github.com/layoutBox/PinLayout", requirement: .upToNextMajor(from: "1.10.5")),
    ],
    targets: targets
)
