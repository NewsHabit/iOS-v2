import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .shared(
        implements: .Util,
        factory: .init(
            dependencies: [
                .shared(implements: .DesignSystem),
                .shared(implements: .ThirdPartyLib)
            ]
        )
    )
]

let project: Project = .makeModule(
    name: ModulePath.Shared.Util.rawValue,
    targets: targets
)
