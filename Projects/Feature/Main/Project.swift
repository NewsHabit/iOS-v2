import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .feature(
        interface: .Main,
        factory: .init(
            dependencies: [
                .domain
            ]
        )
    ),
    .feature(
        implements: .Main,
        factory: .init(
            dependencies: [
                .feature(interface: .Main)
            ]
        )
    ),
    .feature(
        example: .Main,
        factory: .init(
            infoPlist: Project.Environment.appInfoPlist(),
            dependencies: [
                .feature(implements: .Main),
                .feature(interface: .Main)
            ],
            settings: Project.Environment.defaultSettings
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Feature.Main.rawValue,
    targets: targets
)
