//
//  HotViewModel.swift
//  FeatureMain
//
//  Created by 지연 on 9/12/24.
//

import Combine
import Foundation

import Core
import Domain
import Shared

public final class HotViewModel: ViewModel {
    // MARK: - Action
    
    public enum Action {
        case viewDidLoad
        case viewWillAppear
        case refreshControlDidTrigger
        case cellDidTap(index: Int)
    }
    
    // MARK: - State
    
    public struct State {
        var fullDateTime: CurrentValueSubject<String, Never>
        var cellViewModels: CurrentValueSubject<[HotNews], Never>
        var isRefreshing: CurrentValueSubject<Bool, Never>
        var selectedNewsURL: CurrentValueSubject<URL?, Never>
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
            fullDateTime: .init(Date().formatAsFullDateTime()),
            cellViewModels: .init([]),
            isRefreshing: .init(false),
            selectedNewsURL: .init(nil)
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
            fetchHotNews()
        case .viewWillAppear:
            updateState()
        case .refreshControlDidTrigger:
            refresh()
        case let .cellDidTap(index):
            updateSelectedNewsURL(at: index)
        }
    }
    
    private func refresh() {
        state.isRefreshing.send(true)
        updateState()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.state.isRefreshing.send(false)
        }
    }
    
    private func updateState() {
        let currentFullDateTime = Date().formatAsFullDateTime()
        
        if currentFullDateTime == state.fullDateTime.value { return }
        
        state.fullDateTime.send(currentFullDateTime)
        fetchHotNews()
    }
    
    private func fetchHotNews() {
        newsService.getHotNews()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("✅ Fetch hot news completed !")
                case .failure(let error):
                    print("Error fetching hot news: \(error)")
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                let cellViewModels = response.hotNewsResponseDtoList
                state.cellViewModels.send(cellViewModels)
            }).store(in: &cancellables)
    }
    
    private func updateSelectedNewsURL(at index: Int) {
        let urlString = state.cellViewModels.value[index].naverUrl
        state.selectedNewsURL.send(URL(string: urlString))
    }
    
    public func send(_ action: Action) {
        actionSubject.send(action)
    }
}
