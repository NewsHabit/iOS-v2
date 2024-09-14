//
//  ProfileViewModel.swift
//  FeatureMain
//
//  Created by 지연 on 9/6/24.
//

import Combine
import Foundation

import Core
import Domain
import Shared

public final class ProfileViewModel: ViewModel {
    // MARK: - Action
    
    public enum Action {
        case nicknameDidChange(nickname: String)
        case saveButtonDidTap
    }
    
    // MARK: - State
    
    public struct State {
        var nickname: CurrentValueSubject<String, Never>
    }
    
    // MARK: - Property
    
    private let actionSubject = PassthroughSubject<Action, Never>()
    public var cancellables = Set<AnyCancellable>()
    private(set) var state: State
    private var localStorageService: LocalStorageProtocol
    private var notificationService: NotificationProtocol
    
    // MARK: - Init
    
    public init(
        localStorageService: LocalStorageProtocol,
        notificationService: NotificationProtocol
    ) {
        self.localStorageService = localStorageService
        self.notificationService = notificationService
        self.state = State(
            nickname: .init(localStorageService.userSettings.nickname)
        )
        
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
            state.nickname.send(nickname)
        case .saveButtonDidTap:
            localStorageService.userSettings.nickname = state.nickname.value
            NotificationCenter.default.post(name: .NicknameDidChangeNotification, object: nil)
            if localStorageService.userSettings.isNotificationEnabled {
                notificationService.updateNotificationSettings(isEnabled: true, time: nil)
            }
        }
    }
    
    public func send(_ action: Action) {
        actionSubject.send(action)
    }
}
