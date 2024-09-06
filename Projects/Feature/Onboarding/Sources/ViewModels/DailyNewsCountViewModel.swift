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
        var cellViewModels: CurrentValueSubject<[DailyNewsCountCellViewModel], Never>
    }
    
    // MARK: - Property
    
    private let actionSubject = PassthroughSubject<Action, Never>()
    public var cancellables = Set<AnyCancellable>()
    private(set) var state: State
    private var localStorageService: LocalStorageProtocol
    
    // MARK: - Init
    
    public init(localStorageService: LocalStorageProtocol) {
        self.localStorageService = localStorageService
        let initialCellViewModels = DailyNewsCountType.allCases.map { count in
            DailyNewsCountCellViewModel(
                count: count,
                isSelected: localStorageService.userSettings.dailyNewsCount == count
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
        case let .dailyNewsCountDidSelect(count: count):
            updateCategoryCellViewModel(for: count)
        case .doneButtonDidTap:
            saveDailyNewsCount()
        }
    }
    
    private func updateCategoryCellViewModel(for count: DailyNewsCountType) {
        let updatedCellViewModels = state.cellViewModels.value.map { cellViewModel in
            var updatedViewModel = cellViewModel
            updatedViewModel.isSelected = (cellViewModel.count == count)
            return updatedViewModel
        }
        state.cellViewModels.send(updatedCellViewModels)
    }
    
    private func saveDailyNewsCount() {
        let dailyNewsCount = state.cellViewModels.value
            .filter { $0.isSelected }
            .map { $0.count }[0]
        localStorageService.userSettings.dailyNewsCount = dailyNewsCount
    }
    
    public func send(_ action: Action) {
        actionSubject.send(action)
    }
}
