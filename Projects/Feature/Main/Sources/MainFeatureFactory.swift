//
//  MainFeatureFactory.swift
//  FeatureMainInterface
//
//  Created by 지연 on 9/3/24.
//

import UIKit

public class MainFeatureFactory {
    public init() {}
    
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
