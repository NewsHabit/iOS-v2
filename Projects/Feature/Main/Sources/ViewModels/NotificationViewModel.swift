//
//  NotificationViewModel.swift
//  FeatureMain
//
//  Created by 지연 on 9/6/24.
//

import Combine
import Foundation

import Domain
import Shared

public final class NotificationViewModel: ViewModel {
    // MARK: - Action
    
    public enum Action {
        case switchControlDidTap
    }
    
    // MARK: - Struct
    
    public struct State {
        var isNotificationEnabled: CurrentValueSubject<Bool, Never>
        var notificationTime: CurrentValueSubject<String, Never>
    }
    
    // MARK: - Property
    
    private let actionSubject = PassthroughSubject<Action, Never>()
    public var cancellables = Set<AnyCancellable>()
    private(set) var state: State
    private var notificationService: NotificationProtocol
    
    // MARK: - Init
    
    public init(
        notificationService: NotificationProtocol,
        isNotificationEnabled: Bool,
        notificationTime: String
    ) {
        self.notificationService = notificationService
        self.state = State(
            isNotificationEnabled: .init(isNotificationEnabled),
            notificationTime: .init(notificationTime)
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
        case .switchControlDidTap:
            var isNotificationEnabled = state.isNotificationEnabled.value
            isNotificationEnabled.toggle()
            notificationService.updateNotificationSettings(
                isEnabled: isNotificationEnabled,
                time: state.notificationTime.value
            )
            state.isNotificationEnabled.send(isNotificationEnabled)
        }
    }
    
    public func send(_ action: Action) {
        actionSubject.send(action)
    }
}
