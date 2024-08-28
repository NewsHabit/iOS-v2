import ProjectDescription

public extension Project {
    enum Environment {
        public static let appName = "NewsHabit"
        public static let deploymentTargets = DeploymentTargets.iOS("15.0")
        public static let bundleId = "com.goojiong.newshabit"
        public static let defaultSettings: Settings = .settings(
            configurations: [
                .debug(name: "Debug", settings: [
                    "ENABLE_USER_SCRIPT_SANDBOXING": "YES",
                    "GCC_PREPROCESSOR_DEFINITIONS": ["DEBUG=1", "FLEXLAYOUT_SWIFT_PACKAGE=1"]
                ])
            ]
        )
        public static func appInfoPlist() -> InfoPlist {
            return .extendingDefault(with: [
                "ITSAppUsesNonExemptEncryption": false,
                "CFBundleDisplayName": "뉴빗",
                "CFBundleName": "NewsHabit",
                "CFBundleShortVersionString": "1.0.0",
                "CFBundleVersion": "1",
                "UILaunchStoryboardName": "LaunchScreen",
                "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
                "UIApplicationSceneManifest": [
                    "UIApplicationSupportsMultipleScenes": false,
                    "UISceneConfigurations": [
                        "UIWindowSceneSessionRoleApplication": [[
                            "UISceneConfigurationName": "Default Configuration",
                            "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                        ]]
                    ]
                ]
            ])
        }
    }
}
