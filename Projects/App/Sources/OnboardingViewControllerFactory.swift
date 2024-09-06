//
//  OnboardingViewControllerFactory.swift
//  NewsHabit
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Core
import Feature

class OnboardingViewControllerFactory: OnboardingViewControllerFactoryProtocol {
    private let onboardingFeatureFactory: OnboardingFeatureFactory
    private var coordinator: OnboardingCoordinator?
    
    init(localStorageService: LocalStorageProtocol) {
        self.onboardingFeatureFactory = OnboardingFeatureFactory(
            localStorageService: localStorageService
        )
    }
    
    func makeOnboardingViewController() -> UIViewController {
        let navigationController = UINavigationController()
        coordinator = onboardingFeatureFactory.makeOnboardingCoordinator(
            navigationController: navigationController
        )
        coordinator?.start()
        return navigationController
    }
}
