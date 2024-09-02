//
//  ProfileViewController.swift
//  FeatureMain
//
//  Created by 지연 on 9/2/24.
//

import UIKit

import Shared

public final class ProfileViewController: BaseViewController<ProfileView> {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        setBackButton()
        setTitle("프로필")
    }
}
