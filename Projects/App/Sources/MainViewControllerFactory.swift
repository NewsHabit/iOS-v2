//
//  MainViewControllerFactory.swift
//  NewsHabit
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Feature

class MainViewControllerFactory: ViewControllerFactory {
    private let mainFeatureFactory = MainFeatureFactory()
    
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
