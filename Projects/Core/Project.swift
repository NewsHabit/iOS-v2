import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let coreTargets: [Target] = [
    .core(
        factory: .init(
            dependencies: [
                .shared,
                .core(implements: .Network),
                .core(implements: .LocalStorage)
            ]
        )
    )
]

let project: Project = .makeModule(
    name: ModulePath.Core.name,
    targets: coreTargets
)
