//
//  ProfileViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 8/28/24.
//

import Combine
import UIKit

import FeatureOnboardingInterface
import Shared

public final class ProfileViewController: BaseViewController<ProfileView> {
    private let viewModel: ProfileViewModel
    private var cancellables = Set<AnyCancellable>()
    private let animationDuration = 0.35
    
    public weak var delegate: ProfileViewControllerDelegate?
    
    // MARK: - Init
    
    public init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAction()
        setupBinding()
        nicknameInputField.textField.becomeFirstResponder()
    }
    
    // MARK: - Setup Methods
    
    private func setupAction() {
        nextButton.addTarget(self, action: #selector(handleNextButtonTap), for: .touchUpInside)
    }
    
    private func setupBinding() {
        keyboardWillShowPublisher
            .sink { [weak self] keyboardHeight in
                self?.adjustNextButtonPosition(keyboardHeight: keyboardHeight)
            }.store(in: &cancellables)
        
        keyboardWillHidePublisher
            .sink { [weak self] _ in
                self?.resetNextButtonPosition()
            }.store(in: &cancellables)
        
        nicknameInputField.textField.textDidChangePublisher
            .dropFirst() // 초기값 세팅을 위해 무시
            .sink { [weak self] text in
                guard let self else { return }
                viewModel.send(.nicknameDidChange(nickname: text))
            }.store(in: &cancellables)
        
        viewModel.$state
            .sink { [weak self] state in
                guard let self else { return }
                nicknameInputField.textField.text = state.nickname
                nextButton.isEnabled = nicknameInputField.isValid
            }
            .store(in: &cancellables)
    }
    
    private func adjustNextButtonPosition(keyboardHeight: CGFloat) {
        UIView.animate(withDuration: animationDuration) {
            self.nextButton.transform = CGAffineTransform(translationX: 0, y: 30 - keyboardHeight)
        }
    }
    
    private func resetNextButtonPosition() {
        UIView.animate(withDuration: animationDuration) {
            self.nextButton.transform = .identity
        }
    }
    
    // MARK: - Action Methods
    
    @objc private func handleNextButtonTap() {
        viewModel.send(.nextButtonDidTap)
        nicknameInputField.endEditing(true)
        delegate?.profileViewControllerDidFinish()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nicknameInputField.endEditing(true)
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
