//
//  OnboardingCoordinator.swift
//  FeatureOnboarding
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Core
import FeatureOnboardingInterface
import Shared

public class OnboardingCoordinator {
    private let navigationController: UINavigationController
    private let factory: OnboardingFeatureFactory
    
    public init(
        navigationController: UINavigationController,
        factory: OnboardingFeatureFactory
    ) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    public func start() {
        showProfileViewController()
    }
    
    private func showProfileViewController() {
        let profileViewController = factory.makeProfileViewController()
        profileViewController.delegate = self
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    private func showCategoryViewController() {
        let categoryViewController = factory.makeCategoryViewController()
        categoryViewController.delegate = self
        navigationController.pushViewController(categoryViewController, animated: true)
    }
    
    private func showDailyNewsCountViewController() {
        let dailyNewsCountViewController = factory.makeDailyNewsCountViewController()
        dailyNewsCountViewController.delegate = self
        navigationController.pushViewController(dailyNewsCountViewController, animated: true)
    }
}

extension OnboardingCoordinator: ProfileViewControllerDelegate {
    public func profileViewControllerDidFinish() {
        showCategoryViewController()
    }
}

extension OnboardingCoordinator: CategoryViewControllerDelegate {
    public func categoryViewControllerDidFinish() {
        showDailyNewsCountViewController()
    }
}
                                    
extension OnboardingCoordinator: DailyNewsCountViewControllerDelegate {
    public func dailyNewsCountViewControllerDidFinish() {
        NotificationCenter.default.post(name: .OnboardingDidFinishNotification, object: nil)
    }
}
