import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let sharedTargets: [Target] = [
    .shared(
        factory: .init(
            dependencies: [
                .shared(implements: .DesignSystem),
                .shared(implements: .ThirdPartyLib),
                .shared(implements: .Util)
            ]
        )
    )
]

let project: Project = .makeModule(
    name: ModulePath.Shared.name,
    targets: sharedTargets
)
