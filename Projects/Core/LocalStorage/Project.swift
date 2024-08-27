import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .core(
        interface: .LocalStorage,
        factory: .init(
            dependencies: [
                .shared
            ]
        )
    ),
    .core(
        implements: .LocalStorage,
        factory: .init(
            dependencies: [
                .core(interface: .LocalStorage)
            ]
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Core.LocalStorage.rawValue,
    targets: targets
)
