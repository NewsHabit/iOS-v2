//
//  MyNewsHabitViewModel.swift
//  FeatureMain
//
//  Created by 지연 on 9/6/24.
//

import Combine
import Foundation

import Core
import Shared

public final class MyNewsHabitViewModel: ViewModel {
    // MARK: - Action
    
    public enum Action {
        
    }
    
    // MARK: - State
    
    public struct State {
        
    }
    
    // MARK: - Property
    
    private let actionSubject = PassthroughSubject<Action, Never>()
    public var cancellables = Set<AnyCancellable>()
    private(set) var state: State
    private var localStorageService: LocalStorageProtocol
    
    // MARK: - Init
    
    public init(localStorageService: LocalStorageProtocol) {
        self.localStorageService = localStorageService
        self.state = State()
        
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
        }
    }
    
    public func send(_ action: Action) {
        actionSubject.send(action)
    }
}
