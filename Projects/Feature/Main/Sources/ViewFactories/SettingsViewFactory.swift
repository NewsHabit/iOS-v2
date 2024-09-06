//
//  SettingsViewFactory.swift
//  FeatureMain
//
//  Created by 지연 on 9/6/24.
//

import Foundation

import Core
import Domain

public final class SettingsViewFactory {
    private let localStorageService: LocalStorageProtocol
    private let notificationService: NotificationProtocol
    
    public init(
        localStorageService: LocalStorageProtocol,
        notificationService: NotificationProtocol
    ) {
        self.localStorageService = localStorageService
        self.notificationService = notificationService
    }
    
    public func makeProfileViewController() -> ProfileViewController {
        let viewModel = ProfileViewModel(localStorageService: localStorageService)
        return ProfileViewController(viewModel: viewModel)
    }
    
    public func makeMyNewsHabitViewController() -> MyNewsHabitViewController {
        let viewFactory = MyNewsHabitViewFactory(localStorageService: localStorageService)
        return MyNewsHabitViewController(
            localStorageService: localStorageService,
            viewFactory: viewFactory
        )
    }
    
    public func makeNotificationViewController() -> NotificationViewController {
        return NotificationViewController()
    }
    
    public func makeDeveloperViewController() -> DeveloperViewController {
        return DeveloperViewController()
    }
}
