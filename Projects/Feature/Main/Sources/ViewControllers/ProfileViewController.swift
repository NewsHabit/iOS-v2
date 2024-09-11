//
//  ProfileViewController.swift
//  FeatureMain
//
//  Created by 지연 on 9/2/24.
//

import Combine
import UIKit

import Shared

public final class ProfileViewController: BaseViewController<ProfileView> {
    private let viewModel: ProfileViewModel
    private var cancellables = Set<AnyCancellable>()
    private let animationDuration = 0.35
    
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
        
        setupNavigationBar()
        setupAction()
        setupBinding()
        nicknameInputField.textField.becomeFirstResponder()
    }
    
    private func setupNavigationBar() {
        setBackButton()
        setTitle("프로필")
    }
    
    // MARK: - Setup Methods
    
    private func setupAction() {
        doneButton.addTarget(self, action: #selector(handleNextButtonTap), for: .touchUpInside)
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
                self?.viewModel.send(.nicknameDidChange(nickname: text))
            }.store(in: &cancellables)
        
        viewModel.state.nickname
            .sink { [weak self] nickname in
                guard let self = self else { return }
                nicknameInputField.textField.text = nickname
                doneButton.isEnabled = nicknameInputField.isValid
            }.store(in: &cancellables)
    }
    
    private func adjustNextButtonPosition(keyboardHeight: CGFloat) {
        UIView.animate(withDuration: animationDuration) {
            self.doneButton.transform = CGAffineTransform(
                translationX: 0,
                y: self.tabBarHeight - keyboardHeight
            )
        }
    }
    
    private func resetNextButtonPosition() {
        UIView.animate(withDuration: animationDuration) {
            self.doneButton.transform = .identity
        }
    }
    
    // MARK: - Action Methods
    
    @objc private func handleNextButtonTap() {
        viewModel.send(.saveButtonDidTap)
        nicknameInputField.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nicknameInputField.endEditing(true)
    }
}

private extension ProfileViewController {
    var nicknameInputField: NewsHabitInputField {
        contentView.nicknameInputField
    }
    
    var doneButton: NewsHabitConfirmButton {
        contentView.saveButton
    }
}
