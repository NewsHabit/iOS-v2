import DependencyPlugin
import ProjectDescriptionHelpers
import ProjectDescription

let targets: [Target] = [
    .shared(
        implements: .DesignSystem,
        factory: .init(
            dependencies: [
                .shared(implements: .ThirdPartyLib),
                .shared(implements: .Util)
            ]
        )
    )
]

let project: Project = .makeModule(
    name: ModulePath.Shared.DesignSystem.rawValue,
    targets: targets,
    resourceSynthesizers: [
        .assets(),
        .fonts()
    ]
)
