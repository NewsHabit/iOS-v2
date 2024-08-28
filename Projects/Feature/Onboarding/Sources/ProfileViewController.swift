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
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        setLargeTitle("👋🏻 환영합니다!\n뉴빗과 함께 습관을 만들어보아요")
        setRightButton(title: "다음", action: #selector(handleNextButtonTap))
    }
    
    @objc private func handleNextButtonTap() {
        print("다음 버튼 탭")
    }
}
