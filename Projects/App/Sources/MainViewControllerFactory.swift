//
//  MainViewControllerFactory.swift
//  NewsHabit
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Core
import Feature

class MainViewControllerFactory: MainViewControllerFactoryProtocol {
    private let mainFeatureFactory: MainFeatureFactory
    
    init(localStorage: LocalStorageProtocol) {
        self.mainFeatureFactory = MainFeatureFactory(localStorage: localStorage)
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
