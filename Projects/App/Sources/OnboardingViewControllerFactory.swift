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
    private let localStorage: LocalStorageProtocol
    private var onboardingFeatureFactory: OnboardingFeatureFactory?
    
    init(localStorage: LocalStorageProtocol) {
        self.localStorage = localStorage
    }
    
    func makeOnboardingViewController() -> UIViewController {
        let navigationController = UINavigationController()
        onboardingFeatureFactory = OnboardingFeatureFactory(
            navigationController: navigationController,
            localStorage: localStorage
        )
        onboardingFeatureFactory?.start()
        return navigationController
    }
}
