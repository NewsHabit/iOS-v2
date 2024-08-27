import ProjectDescription

public extension Project {
    enum Environment {
        public static let appName = "NewsHabit"
        public static let deploymentTargets = DeploymentTargets.iOS("15.0")
        public static let bundleId = "com.goojiong.newshabit"
        public static let defaultSettings: Settings = .settings(
            base: [
                "ENABLE_USER_SCRIPT_SANDBOXING": "YES"
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
