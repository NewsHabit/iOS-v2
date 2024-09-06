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
        var cellViewModels: CurrentValueSubject<[CategoryCellViewModel], Never>
    }
    
    // MARK: - Property
    
    private let actionSubject = PassthroughSubject<Action, Never>()
    public var cancellables = Set<AnyCancellable>()
    private(set) var state: State
    private var localStorageService: LocalStorageProtocol
    
    // MARK: - Init
    
    public init(localStorageService: LocalStorageProtocol) {
        self.localStorageService = localStorageService
        let initialCellViewModels = CategoryType.allCases.map { category in
            CategoryCellViewModel(
                category: category,
                isSelected: localStorageService.userSettings.selectedCategories.contains(category)
            )
        }
        self.state = State(cellViewModels: .init(initialCellViewModels))
        
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
            updateCategoryCellViewModel(for: category)
        case .nextButtonDidTap:
            saveSelectedCategories()
        }
    }
    
    private func updateCategoryCellViewModel(for category: CategoryType) {
        let updatedCellViewModels = state.cellViewModels.value.map { cellViewModel in
            if cellViewModel.category == category {
                var updatedViewModel = cellViewModel
                updatedViewModel.isSelected.toggle()
                return updatedViewModel
            }
            return cellViewModel
        }
        state.cellViewModels.send(updatedCellViewModels)
    }
    
    private func saveSelectedCategories() {
        let selectedCategories = state.cellViewModels.value
            .filter { $0.isSelected }
            .map { $0.category }
        localStorageService.userSettings.selectedCategories = selectedCategories
    }
    
    public func send(_ action: Action) {
        actionSubject.send(action)
    }
}
