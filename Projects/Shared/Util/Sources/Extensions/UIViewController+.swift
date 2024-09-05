//
//  UIViewController+.swift
//  SharedUtil
//
//  Created by 지연 on 9/4/24.
//

import UIKit

extension UIViewController {
    public var tabBarHeight: CGFloat {
        tabBarController?.tabBar.frame.height ?? 0
    }
}
