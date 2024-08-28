//
//  ProfileViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 8/28/24.
//

import UIKit

import Shared

public final class ProfileViewController: BaseViewController<ProfileView> {
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension ProfileViewController {
    var nicknameTextField: NewsHabitInputField {
        contentView.nicknameTextField
    }
}
