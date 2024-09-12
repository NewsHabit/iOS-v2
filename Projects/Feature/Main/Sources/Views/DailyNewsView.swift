//
//  DailyNewsView.swift
//  FeatureMain
//
//  Created by 지연 on 8/29/24.
//

import UIKit

import Shared

import PinLayout

public final class DailyNewsView: UIView {
    // MARK: - Components
    
    let messageContainer = {
        let view = UIView()
        view.backgroundColor = Colors.gray01
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let messageLabel = {
        let label = UILabel()
        label.text = "💬 습관 하루 적립! 내일도 추천해드릴게요"
        label.font = Fonts.semiBold(size: 14.0)
        label.textColor = Colors.gray08
        return label
    }()
    
    let tableView = {
        let tableView = UITableView()
        tableView.register(cellType: DailyNewsCell.self)
        tableView.rowHeight = 120
        return tableView
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }
    
    private func setupView() {
        addSubview(messageContainer)
        messageContainer.addSubview(messageLabel)
        addSubview(tableView)
    }
    
    private func setupLayout() {
        messageContainer.pin
            .top(10)
            .horizontally(15)
            .height(56)
        
        messageLabel.pin
            .left(20)
            .vCenter()
            .sizeToFit()
        
        tableView.pin
            .below(of: messageContainer)
            .marginTop(5)
            .horizontally()
            .bottom()
    }
}
