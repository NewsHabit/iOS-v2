//
//  SceneDelegate.swift
//  NewsHabit
//
//  Created by 지연 on 8/25/24.
//

import UIKit

import Core
import Feature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var onboardingViewControllerFactory: OnboardingViewControllerFactoryProtocol?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let localStorage = LocalStorageService()
        let rootViewController: UIViewController?
        
        if localStorage.appState.isOnboardingCompleted {
            let mainViewControllerFactory = MainViewControllerFactory(
                localStorage: localStorage
            )
            rootViewController = MainTabBarController(factory: mainViewControllerFactory)
        } else {
            onboardingViewControllerFactory = OnboardingViewControllerFactory(
                localStorage: localStorage
            )
            rootViewController = onboardingViewControllerFactory?.makeOnboardingViewController()
        }
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
