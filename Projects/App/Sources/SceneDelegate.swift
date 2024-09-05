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
    let localStorage = LocalStorageService()
    var onboardingViewControllerFactory: OnboardingViewControllerFactoryProtocol?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if localStorage.appState.isOnboardingCompleted {
            launchMainView()
        } else {
            launchOnboardingProcess()
        }
        window?.makeKeyAndVisible()
        
        setupOnboardingCompletionObserver()
    }
    
    private func launchMainView() {
        let mainViewControllerFactory = MainViewControllerFactory(
            localStorage: localStorage
        )
        window?.rootViewController = MainTabBarController(factory: mainViewControllerFactory)
    }
    
    private func launchOnboardingProcess() {
        onboardingViewControllerFactory = OnboardingViewControllerFactory(
            localStorage: localStorage
        )
        window?.rootViewController = onboardingViewControllerFactory?.makeOnboardingViewController()
    }
    
    private func setupOnboardingCompletionObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleOnboardingDidFinish),
            name: .OnboardingDidFinishNotification,
            object: nil
        )
    }

    @objc private func handleOnboardingDidFinish() {
        localStorage.appState.isOnboardingCompleted = true
        launchMainView()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
