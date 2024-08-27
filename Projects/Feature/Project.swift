import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let featureTargets: [Target] = [
    .feature(
        factory: .init(
            dependencies: [
                .domain,
                .feature(implements: .Main),
                .feature(implements: .Onboarding)
            ]
        )
    )
]

let project: Project = .makeModule(
    name: ModulePath.Feature.name,
    targets: featureTargets
)
