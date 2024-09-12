//
//  DailyNewsViewModel.swift
//  FeatureMain
//
//  Created by 지연 on 9/12/24.
//

import Combine
import Foundation

import Core
import Domain
import Shared

public final class DailyNewsViewModel: ViewModel {
    // MARK: - Action
    
    public enum Action {
        
    }
    
    // MARK: - State
    
    public struct State {
        var cellViewModels: CurrentValueSubject<[DailyNewsCellViewModel], Never>
    }
    
    // MARK: - Property
    
    private let actionSubject = PassthroughSubject<Action, Never>()
    public var cancellables = Set<AnyCancellable>()
    private(set) var state: State
    private var localStorageService: LocalStorageProtocol
    private var newsService: NewsProtocol
    
    // MARK: - Init
    
    public init(localStorageService: LocalStorageProtocol, newsService: NewsProtocol) {
        self.localStorageService = localStorageService
        self.newsService = newsService
        self.state = State(cellViewModels: .init([]))
        updateCellViewModels()
        
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
    
    private func updateCellViewModels() {
        let categories = localStorageService.userSettings.selectedCategories
            .map { $0.apiIdentifier }
        let count = localStorageService.userSettings.dailyNewsCount.rawValue
        
        newsService.getDailyNews(categories: categories, count: count)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("✅ Fetch daily news completed !")
                case .failure(let error):
                    print("Error fetching daily news: \(error)")
                }
            }, receiveValue: { [weak self] dailyNewsList in
                guard let self else { return }
                let cellViewModels = dailyNewsList.recommendedNewsResponseDtoList.map {
                    DailyNewsCellViewModel(dailyNews: $0, isRead: false)
                }
                state.cellViewModels.send(cellViewModels)
            }).store(in: &cancellables)
    }
    
    public func send(_ action: Action) {
        actionSubject.send(action)
    }
}
