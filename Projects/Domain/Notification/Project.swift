import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .domain(
        interface: .Notification,
        factory: .init(
            dependencies: [
                .core
            ]
        )
    ),
    .domain(
        implements: .Notification,
        factory: .init(
            dependencies: [
                .domain(interface: .Notification)
            ]
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Domain.Notification.rawValue,
    targets: targets
)
