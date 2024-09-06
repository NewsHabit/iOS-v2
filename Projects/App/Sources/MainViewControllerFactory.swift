//
//  MainViewControllerFactory.swift
//  NewsHabit
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Core
import Domain
import Feature

final class MainViewControllerFactory: MainViewControllerFactoryProtocol {
    private let mainFeatureFactory: MainFeatureFactory
    
    init(
        localStorageService: LocalStorageProtocol,
        notificationService: NotificationProtocol
    ) {
        self.mainFeatureFactory = MainFeatureFactory(
            localStorageService: localStorageService,
            notificationService: notificationService
        )
    }
    
    func makeHomeViewController() -> UIViewController {
        return mainFeatureFactory.makeHomeViewController()
    }
    
    func makeHotViewController() -> UIViewController {
        return mainFeatureFactory.makeHotViewController()
    }
    
    func makeSettingsViewController() -> UIViewController {
        return mainFeatureFactory.makeSettingsViewController()
    }
}
