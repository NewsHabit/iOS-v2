//
//  MainFeatureFactory.swift
//  FeatureMainInterface
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Core

public class MainFeatureFactory {
    private let localStorage: LocalStorageProtocol
    
    public init(localStorage: LocalStorageProtocol) {
        self.localStorage = localStorage
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
