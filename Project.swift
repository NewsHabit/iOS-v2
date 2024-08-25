import ProjectDescription

let project = Project(
    name: "NewsHabit",
    targets: [
        .target(
            name: "NewsHabit",
            destinations: .iOS,
            product: .app,
            bundleId: "goojiong.NewsHabit",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                    "UIApplicationSceneManifest": [
                        "UIApplicationSupportsMultipleScenes": false,
                        "UISceneConfigurations": [
                            "UIWindowSceneSessionRoleApplication": [
                                [
                                    "UISceneConfigurationName": "Default Configuration",
                                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                                ],
                            ]
                        ]
                    ],
                ]
            ),
            sources: ["NewsHabit/Sources/**"],
            resources: ["NewsHabit/Resources/**"],
            dependencies: []
        )
    ]
)
