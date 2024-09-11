//
//  NotificationTimeViewController.swift
//  FeatureMain
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Shared

public final class NotificationTimeViewController: BottomSheetViewController<NotificationTimeView> {
    weak var delegate: NotificationDelegate?
    
    // MARK: - Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAction()
    }
    
    // MARK: - Setup Methods
    
    private func setupAction() {
        saveButton.addTarget(self, action: #selector(handleSaveButtonTap), for: .touchUpInside)
    }
    
    // MARK: - Action Methods
    
    @objc private func handleSaveButtonTap() {
        dismiss(animated: false) { [weak self] in
            guard let self = self else { return }
            delegate?.notificationTimeDidUpdate(datePicker.date)
        }
    }
}

private extension NotificationTimeViewController {
    var datePicker: UIDatePicker {
        bottomSheetView.datePicker
    }
    
    var saveButton: NewsHabitConfirmButton {
        bottomSheetView.saveButton
    }
}
