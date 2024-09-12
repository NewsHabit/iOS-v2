//
//  MainFeatureFactory.swift
//  FeatureMainInterface
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Core
import Domain

public final class MainFeatureFactory {
    private let localStorageService: LocalStorageProtocol
    private let newsService: NewsProtocol
    private let notificationService: NotificationProtocol
    
    public init(
        localStorageService: LocalStorageProtocol,
        newsService: NewsProtocol,
        notificationService: NotificationProtocol
    ) {
        self.localStorageService = localStorageService
        self.newsService = newsService
        self.notificationService = notificationService
    }
    
    public func makeHomeViewController() -> UIViewController {
        let dailyNewsViewModel = DailyNewsViewModel(
            localStorageService: localStorageService,
            newsService: newsService
        )
        return HomeViewController(dailyNewsViewModel: dailyNewsViewModel)
    }
    
    public func makeHotViewController() -> UIViewController {
        return HotViewController()
    }
    
    public func makeSettingsViewController() -> UIViewController {
        let viewFactory = SettingsViewFactory(
            localStorageService: localStorageService,
            notificationService: notificationService
        )
        return SettingsViewController(viewFactory: viewFactory)
    }
}
