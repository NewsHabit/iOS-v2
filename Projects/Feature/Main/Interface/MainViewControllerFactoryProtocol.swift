//
//  MainViewControllerFactoryProtocol.swift
//  FeatureMain
//
//  Created by 지연 on 9/3/24.
//

import UIKit

public protocol MainViewControllerFactoryProtocol {
    func makeHomeViewController() -> UIViewController
    func makeHotViewController() -> UIViewController
    func makeSettingsViewController() -> UIViewController
}
