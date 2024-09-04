//
//  ProfileViewModel.swift
//  FeatureOnboardingInterface
//
//  Created by 지연 on 9/4/24.
//

import Combine
import Foundation

import Core
import Shared

public final class ProfileViewModel: ViewModel {
    // MARK: - Action
    
    public enum Action {
        case nicknameDidChange(nickname: String)
        case nextButtonDidTap
    }
    
    // MARK: - State
    
    public struct State {
        var nickname: String
    }
    
    // MARK: - Property
    
    @Published private(set) var state: State
    
    private let actionSubject = PassthroughSubject<Action, Never>()
    public var cancellables = Set<AnyCancellable>()
    private var localStorage: LocalStorageProtocol
    
    public init(localStorage: LocalStorageProtocol) {
        self.localStorage = localStorage
        self.state = State(nickname: localStorage.userSettings.nickname)
        
        bindAction()
    }
    
    private func bindAction() {
        actionSubject
            .sink { [weak self] action in
                self?.handleAction(action)
            }.store(in: &cancellables)
    }
    
    private func handleAction(_ action: Action) {
        switch action {
        case let .nicknameDidChange(nickname):
            state.nickname = nickname
        case .nextButtonDidTap:
            localStorage.userSettings.nickname = state.nickname
        }
    }
    
    public func send(_ action: Action) {
        actionSubject.send(action)
    }
}
