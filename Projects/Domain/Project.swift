import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let domainTargets: [Target] = [
    .domain(
        factory: .init(
            dependencies: [
                .core,
                .domain(implements: .News)
            ]
        )
    )
]

let project: Project = .makeModule(
    name: ModulePath.Domain.name,
    targets: domainTargets
)
