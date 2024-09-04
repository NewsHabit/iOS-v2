//
//  CategoryViewModel.swift
//  FeatureOnboarding
//
//  Created by 지연 on 9/5/24.
//

import Combine
import Foundation

import Core
import Shared

public final class CategoryViewModel: ViewModel {
    // MARK: - Action
    
    public enum Action {
        case categoryDidSelect(category: CategoryType)
        case nextButtonDidTap
    }
    
    // MARK: - State
    
    public struct State {
        var categories: Set<CategoryType>
    }
    
    // MARK: - Property
    
    @Published private(set) var state: State
    
    private let actionSubject = PassthroughSubject<Action, Never>()
    public var cancellables = Set<AnyCancellable>()
    private var localStorage: LocalStorageProtocol
    
    // MARK: - Init
    
    public init(localStorage: LocalStorageProtocol) {
        self.localStorage = localStorage
        self.state = State(categories: Set(localStorage.userSettings.selectedCategories))
        
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
        case let .categoryDidSelect(category: category):
            if state.categories.contains(category) {
                state.categories.remove(category)
            } else {
                state.categories.insert(category)
            }
        case .nextButtonDidTap:
            localStorage.userSettings.selectedCategories = Array(state.categories)
        }
    }
    
    public func send(_ action: Action) {
        actionSubject.send(action)
    }
}
