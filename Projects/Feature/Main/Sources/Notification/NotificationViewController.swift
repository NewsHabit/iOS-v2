//
//  NotificationViewController.swift
//  FeatureMain
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Shared

public final class NotificationViewController: BaseViewController<NotificationView> {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupGesture()
    }
    
    private func setupNavigationBar() {
        setBackButton()
        setTitle("알림")
    }
    
    private func setupGesture() {
        timeLabel.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(handleTimeLabelTap)
        ))
    }
    
    @objc private func handleTimeLabelTap() {
        present(NotificationTimeViewController(), animated: false)
    }
}

private extension NotificationViewController {
    var timeLabel: UILabel {
        contentView.timeLabel
    }
}
