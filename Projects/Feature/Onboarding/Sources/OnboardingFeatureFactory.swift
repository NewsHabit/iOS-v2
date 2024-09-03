//
//  OnboardingFeatureFactory.swift
//  FeatureOnboarding
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Core
import FeatureOnboardingInterface

public class OnboardingFeatureFactory {
    private let localStorage: LocalStorageProtocol
    private let navigationController: UINavigationController
    
    public init(
        navigationController: UINavigationController,
        localStorage: LocalStorageProtocol
    ) {
        self.navigationController = navigationController
        self.localStorage = localStorage
    }
    
    public func start() {
        showProfileViewController()
    }
    
    private func showProfileViewController() {
        let profileViewController = ProfileViewController()
        profileViewController.delegate = self
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    private func showCategoryViewController() {
        let categoryViewController = CategoryViewController()
        categoryViewController.delegate = self
        navigationController.pushViewController(categoryViewController, animated: true)
    }
    
    private func showDailyNewsCountViewController() {
        let dailyNewsCountViewController = DailyNewsCountViewController()
        dailyNewsCountViewController.delegate = self
        navigationController.pushViewController(dailyNewsCountViewController, animated: true)
    }
}

extension OnboardingFeatureFactory: ProfileViewControllerDelegate {
    public func profileViewControllerDidFinish() {
        showCategoryViewController()
    }
}

extension OnboardingFeatureFactory: CategoryViewControllerDelegate {
    public func categoryViewControllerDidFinish() {
        showDailyNewsCountViewController()
    }
}
                                    
extension OnboardingFeatureFactory: DailyNewsCountViewControllerDelegate {
    public func dailyNewsCountViewControllerDidFinish() {
        // Onboarding 완료 처리
        // 예: AppDelegate나 SceneDelegate에서 메인 화면으로 전환
        print("Onboarding 완료")
    }
}
