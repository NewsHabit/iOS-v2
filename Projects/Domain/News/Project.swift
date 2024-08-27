import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .domain(
        interface: .News,
        factory: .init(
            dependencies: [
                .core
            ]
        )
    ),
    .domain(
        implements: .News,
        factory: .init(
            dependencies: [
                .domain(interface: .News)
            ]
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Domain.News.rawValue,
    targets: targets
)
