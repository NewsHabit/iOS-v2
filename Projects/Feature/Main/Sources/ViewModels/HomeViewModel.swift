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
        case viewDidLoad
        case newsCellDidTap(index: Int)
    }
    
    // MARK: - State
    
    public struct State {
        var totalDaysAllNewsRead: CurrentValueSubject<Int, Never>
        var dailyNewsCellViewModels: CurrentValueSubject<[DailyNewsCellViewModel], Never>
        var monthlyRecordCellViewModels: CurrentValueSubject<[MonthlyRecordCellViewModel], Never>
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
            dailyNewsCellViewModels: .init([]),
            monthlyRecordCellViewModels: .init([]),
            selectedNewsURL: .init(nil),
            isTodayAllRead: .init(false)
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
        case .viewDidLoad:
            fetchDailyNews()
            updateMonthlyRecordCellViewModels()
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
                state.dailyNewsCellViewModels.send(cellViewModels)
            }).store(in: &cancellables)
    }
    
    private func updateMonthlyRecordCellViewModels() {
        let calendar = Calendar.current
        let date = Date()
        let components = calendar.dateComponents([.year, .month], from: date)
        guard let startOfMonth = calendar.date(from: components),
              let daysInMonth = calendar.range(of: .day, in: .month, for: date)?.count 
        else { return }
        
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        let year = components.year!
        let month = components.month!
        let today = calendar.dateComponents([.year, .month, .day], from: date)
        
        let cellViewModels = (1..<firstWeekday).map { _ in
            MonthlyRecordCellViewModel(day: nil, isRead: false, isToday: false)
        } + (1...daysInMonth).map { day in
            let dayString = String(format: "%02d", day)
            let isRead = localStorageService.newsData.monthlyCompletionDates.contains(dayString)
            let isToday = today.year == year && today.month == month && today.day == day
            return MonthlyRecordCellViewModel(day: dayString, isRead: isRead, isToday: isToday)
        }
        
        state.monthlyRecordCellViewModels.send(cellViewModels)
    }
    
    private func markNewsAsRead(at index: Int) {
        var cellViewModels = state.dailyNewsCellViewModels.value
        
        guard !cellViewModels[index].isRead else { return }
        
        cellViewModels[index].isRead = true
        state.dailyNewsCellViewModels.send(cellViewModels)
        updateTodayAllReadStatus()
    }
    
    private func updateTodayAllReadStatus() {
        let allItemsRead = state.dailyNewsCellViewModels.value.allSatisfy { $0.isRead }
        guard allItemsRead else { return }
        
        localStorageService.newsData.totalDaysAllNewsRead += 1
        localStorageService.newsData.monthlyCompletionDates.append(Date().formatAsDayOnly())
        state.totalDaysAllNewsRead.send(localStorageService.newsData.totalDaysAllNewsRead)
        state.isTodayAllRead.send(true)
        updateMonthlyRecordCellViewModels()
    }
    
    private func updateSelectedNewsURL(at index: Int) {
        let urlString = state.dailyNewsCellViewModels.value[index].dailyNews.naverUrl
        state.selectedNewsURL.send(URL(string: urlString))
    }
    
    public func send(_ action: Action) {
        actionSubject.send(action)
    }
}
