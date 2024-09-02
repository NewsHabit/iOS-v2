//
//  MainTabBarController.swift
//  FeatureMainInterface
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import FeatureMainInterface
import Shared

public final class MainTabBarController: UITabBarController {
    private enum MainTab: CaseIterable {
        case home
        case hot
        case settings
        
        var imageString: String {
            switch self {
            case .home:     "house"
            case .hot:      "flame"
            case .settings: "gearshape"
            }
        }
    }
    
    private let factory: ViewControllerFactory
    
    // MARK: - Init
    
    public init(factory: ViewControllerFactory) {
        self.factory = factory
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = Colors.gray08
        tabBar.backgroundColor = Colors.background
        
        viewControllers = MainTab.allCases.map { tab in
            let viewController: UIViewController
            switch tab {
            case .home:     viewController = factory.makeHomeViewController()
            case .hot:      viewController = factory.makeHotViewController()
            case .settings: viewController = factory.makeSettingsViewController()
            }
            
            viewController.tabBarItem = UITabBarItem(
                title: nil,
                image: resizedImage(for: tab.imageString),
                selectedImage: resizedImage(for: tab.imageString + ".fill")
            )
            return UINavigationController(rootViewController: viewController)
        }
    }
    
    private func resizedImage(for imageString: String) -> UIImage? {
        return UIImage(systemName: imageString)?.resized(toHeight: 22)
    }
}

private extension UIImage {
    func resized(toHeight height: CGFloat) -> UIImage? {
        let canvasSize = CGSize(
            width: CGFloat(ceil(height/size.height * size.width)),
            height: height
        )
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
