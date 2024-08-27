import DependencyPlugin
import ProjectDescription

let workspace = Workspace(
    name: Project.Environment.appName,
    projects: ["Projects/*"]
)
