//
//  MainViewControllerFactory.swift
//  NewsHabit
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Feature

class MainViewControllerFactory: ViewControllerFactory {
    func makeHomeViewController() -> UIViewController {
        let homeFeature = HomeFeature()
        return homeFeature.makeHomeViewController()
    }
    
    func makeHotViewController() -> UIViewController {
        let hotFeature = HotFeature()
        return hotFeature.makeHotViewController()
    }
    
    func makeSettingsViewController() -> UIViewController {
        let settingsFeature = SettingsFeature()
        return settingsFeature.makeSettingsViewController()
    }
}
