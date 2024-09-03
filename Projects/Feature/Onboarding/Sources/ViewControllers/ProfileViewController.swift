//
//  ProfileViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 8/28/24.
//

import UIKit

import FeatureOnboardingInterface
import Shared

public final class ProfileViewController: BaseViewController<ProfileView> {
    public weak var delegate: ProfileViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAction()
    }
    
    private func setupAction() {
        nextButton.addTarget(self, action: #selector(handleNextButtonTap), for: .touchUpInside)
    }
    
    @objc private func handleNextButtonTap() {
        delegate?.profileViewControllerDidFinish()
    }
}

private extension ProfileViewController {
    var nextButton: NewsHabitConfirmButton {
        contentView.nextButton
    }
}
