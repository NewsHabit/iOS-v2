//
//  OnboardingFeatureFactory.swift
//  FeatureOnboarding
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Core

public class OnboardingFeatureFactory {
    private let localStorage: LocalStorageProtocol
    
    public init(localStorage: LocalStorageProtocol) {
        self.localStorage = localStorage
    }
    
    public func makeProfileViewController() -> ProfileViewController {
        let profileViewModel = ProfileViewModel(localStorage: localStorage)
        return ProfileViewController(viewModel: profileViewModel)
    }
    
    public func makeCategoryViewController() -> CategoryViewController {
        let categoryViewModel = CategoryViewModel(localStorage: localStorage)
        return CategoryViewController(viewModel: categoryViewModel)
    }
    
    public func makeDailyNewsCountViewController() -> DailyNewsCountViewController {
        return DailyNewsCountViewController()
    }
    
    public func makeOnboardingCoordinator(navigationController: UINavigationController) -> OnboardingCoordinator {
        return OnboardingCoordinator(navigationController: navigationController, factory: self)
    }
}
