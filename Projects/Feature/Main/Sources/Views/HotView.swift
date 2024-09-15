//
//  HotView.swift
//  FeatureMain
//
//  Created by 지연 on 8/30/24.
//

import UIKit

import Shared

import PinLayout

public final class HotView: UIView {
    // MARK: - Components
    
    let refreshControl = UIRefreshControl()
    
    lazy var tableView = {
        let tableView = UITableView()
        tableView.register(cellType: HotNewsCell.self)
        tableView.rowHeight = 120
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.pin.all()
    }
    
    private func setupView() {
        addSubview(tableView)
    }
}
