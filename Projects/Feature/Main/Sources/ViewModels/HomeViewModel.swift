//
//  HomeViewModel.swift
//  FeatureMain
//
//  Created by 지연 on 9/12/24.
//

import Combine
import Foundation

import Core
import Domain
import Shared

public final class HomeViewModel: ViewModel {
    // MARK: - Action
    
    public enum Action {
        case newsCellDidTap(index: Int)
    }
    
    // MARK: - State
    
    public struct State {
        var totalDaysAllNewsRead: CurrentValueSubject<Int, Never>
        var cellViewModels: CurrentValueSubject<[DailyNewsCellViewModel], Never>
        var selectedNewsURL: CurrentValueSubject<URL?, Never>
        var isTodayAllRead: CurrentValueSubject<Bool, Never>
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
        self.state = State(
            totalDaysAllNewsRead: .init(localStorageService.newsData.totalDaysAllNewsRead),
            cellViewModels: .init([]),
            selectedNewsURL: .init(nil),
            isTodayAllRead: .init(false)
        )
        
        fetchDailyNews()
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
        case let .newsCellDidTap(index):
            markNewsAsRead(at: index)
            updateSelectedNewsURL(at: index)
        }
    }
    
    private func fetchDailyNews() {
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
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                let cellViewModels = response.recommendedNewsResponseDtoList.map {
                    DailyNewsCellViewModel(dailyNews: $0, isRead: false)
                }
                state.cellViewModels.send(cellViewModels)
            }).store(in: &cancellables)
    }
    
    private func markNewsAsRead(at index: Int) {
        var cellViewModels = state.cellViewModels.value
        
        guard !cellViewModels[index].isRead else { return }
        
        cellViewModels[index].isRead = true
        state.cellViewModels.send(cellViewModels)
        updateTodayAllReadStatus()
    }
    
    private func updateTodayAllReadStatus() {
        let allItemsRead = state.cellViewModels.value.allSatisfy { $0.isRead }
        state.isTodayAllRead.send(allItemsRead)
    }
    
    private func updateSelectedNewsURL(at index: Int) {
        let urlString = state.cellViewModels.value[index].dailyNews.naverUrl
        state.selectedNewsURL.send(URL(string: urlString))
    }
    
    public func send(_ action: Action) {
        actionSubject.send(action)
    }
}