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
    private let animationDuration = 0.35
    
    // MARK: - Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAction()
        setupDelegate()
        setupNotificationObserver()
        nicknameInputField.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup Methods
    
    private func setupAction() {
        nextButton.addTarget(self, action: #selector(handleNextButtonTap), for: .touchUpInside)
    }
    
    private func setupDelegate() {
        nicknameInputField.delegate = self
    }
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func handleNextButtonTap() {
        nicknameInputField.endEditing(true)
        delegate?.profileViewControllerDidFinish()
    }
    
    @objc private func handleKeyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        
        UIView.animate(withDuration: animationDuration) {
            self.nextButton.transform = CGAffineTransform(
                translationX: 0,
                y: 30 - keyboardFrame.cgRectValue.height
            )
        }
    }
    
    @objc private func handleKeyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: animationDuration) {
            self.nextButton.transform = .identity
        }
    }
}

extension ProfileViewController: NewsHabitInputFieldDelegate {
    public func inputFieldDidChange(_ inputField: NewsHabitInputField, isValid: Bool) {
        nextButton.isEnabled = nicknameInputField.isValid
    }
}

private extension ProfileViewController {
    var nicknameInputField: NewsHabitInputField {
        contentView.nicknameInputField
    }
    
    var nextButton: NewsHabitConfirmButton {
        contentView.nextButton
    }
}
