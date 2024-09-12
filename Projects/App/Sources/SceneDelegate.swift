//
//  SceneDelegate.swift
//  NewsHabit
//
//  Created by 지연 on 8/25/24.
//

import UIKit

import Core
import Domain
import Feature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let localStorageService = LocalStorageService()
    var onboardingViewControllerFactory: OnboardingViewControllerFactoryProtocol?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if localStorageService.appState.isOnboardingCompleted {
            launchMainView()
        } else {
            launchOnboardingProcess()
        }
        window?.makeKeyAndVisible()
        
        setupOnboardingCompletionObserver()
    }
    
    private func launchMainView() {
        let baseURL = "https://newshabit.org"
        let newsService = NewsService(networkService: NetworkService(baseURL: baseURL))
        let notificationService = NotificationService(localStorageService: localStorageService)
        let mainViewControllerFactory = MainViewControllerFactory(
            localStorageService: localStorageService,
            newsService: newsService,
            notificationService: notificationService
        )
        window?.rootViewController = MainTabBarController(factory: mainViewControllerFactory)
    }
    
    private func launchOnboardingProcess() {
        onboardingViewControllerFactory = OnboardingViewControllerFactory(
            localStorageService: localStorageService
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
        localStorageService.appState.isOnboardingCompleted = true
        launchMainView()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
