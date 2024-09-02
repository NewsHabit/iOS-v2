//
//  HotViewController.swift
//  FeatureMain
//
//  Created by 지연 on 8/30/24.
//

import UIKit

import Shared

public final class HotViewController: BaseViewController<HotView> {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        setLargeTitle("🔥 지금 뜨는 뉴스")
        setSubTitle("\(Date().formatAsFullDateTime()) 기준", Colors.gray04)
    }
}
