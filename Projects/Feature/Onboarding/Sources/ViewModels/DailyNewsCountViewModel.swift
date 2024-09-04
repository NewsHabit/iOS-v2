//
//  DailyNewsCountViewModel.swift
//  FeatureOnboarding
//
//  Created by 지연 on 9/5/24.
//

import Combine
import Foundation

import Core
import Shared

public final class DailyNewsCountViewModel: ViewModel {
    // MARK: - Action
    
    public enum Action {
        case dailyNewsCountDidSelect(count: DailyNewsCountType)
        case doneButtonDidTap
    }
    
    // MARK: - State
    
    public struct State {
        var count: DailyNewsCountType
    }
    
    // MARK: - Property
    
    @Published private(set) var state: State
    
    private let actionSubject = PassthroughSubject<Action, Never>()
    public var cancellables = Set<AnyCancellable>()
    private var localStorage: LocalStorageProtocol
    
    // MARK: - Init
    
    public init(localStorage: LocalStorageProtocol) {
        self.localStorage = localStorage
        self.state = State(count: localStorage.userSettings.dailyNewsCount)
        
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
        case let .dailyNewsCountDidSelect(count: count):
            state.count = count
        case .doneButtonDidTap:
            localStorage.userSettings.dailyNewsCount = state.count
        }
    }
    
    public func send(_ action: Action) {
        actionSubject.send(action)
    }
}
