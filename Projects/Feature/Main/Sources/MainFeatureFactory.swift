//
//  MainFeatureFactory.swift
//  FeatureMainInterface
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Core
import Domain

public class MainFeatureFactory {
    private let localStorageService: LocalStorageProtocol
    private let notificationService: NotificationProtocol
    
    public init(
        localStorageService: LocalStorageProtocol,
        notificationService: NotificationProtocol
    ) {
        self.localStorageService = localStorageService
        self.notificationService = notificationService
    }
    
    public func makeHomeViewController() -> UIViewController {
        return HomeViewController()
    }
    
    public func makeHotViewController() -> UIViewController {
        return HotViewController()
    }
    
    public func makeSettingsViewController() -> UIViewController {
        return SettingsViewController()
    }
}
