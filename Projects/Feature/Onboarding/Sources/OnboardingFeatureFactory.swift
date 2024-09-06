//
//  OnboardingFeatureFactory.swift
//  FeatureOnboarding
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Core

public class OnboardingFeatureFactory {
    private let localStorageService: LocalStorageProtocol
    
    public init(localStorageService: LocalStorageProtocol) {
        self.localStorageService = localStorageService
    }
    
    public func makeProfileViewController() -> ProfileViewController {
        let profileViewModel = ProfileViewModel(localStorageService: localStorageService)
        return ProfileViewController(viewModel: profileViewModel)
    }
    
    public func makeCategoryViewController() -> CategoryViewController {
        let categoryViewModel = CategoryViewModel(localStorageService: localStorageService)
        return CategoryViewController(viewModel: categoryViewModel)
    }
    
    public func makeDailyNewsCountViewController() -> DailyNewsCountViewController {
        let dailyNewsCountViewModel = DailyNewsCountViewModel(localStorageService: localStorageService)
        return DailyNewsCountViewController(viewModel: dailyNewsCountViewModel)
    }
    
    public func makeOnboardingCoordinator(navigationController: UINavigationController) -> OnboardingCoordinator {
        return OnboardingCoordinator(navigationController: navigationController, factory: self)
    }
}
