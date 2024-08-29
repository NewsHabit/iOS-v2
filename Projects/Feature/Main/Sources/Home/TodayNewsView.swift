//
//  TodayNewsView.swift
//  FeatureMain
//
//  Created by 지연 on 8/29/24.
//

import UIKit

import Shared

import PinLayout

public final class TodayNewsView: UIView {
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
        tableView.register(cellType: TodayNewsCell.self)
        tableView.rowHeight = 120
        return tableView
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        // 임시
        tableView.dataSource = self
    }
    
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
            .top(15)
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

extension TodayNewsView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TodayNewsCell.self)
        return cell
    }
}
