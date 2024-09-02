//
//  TodayNewsCountView.swift
//  FeatureMain
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Shared

import FlexLayout
import PinLayout

public final class TodayNewsCountView: UIView {
    // MARK: - Components
    
    private let flexContainer = UIView()
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "추천받고 싶은 기사의 개수를 선택해주세요"
        label.font = Fonts.bold(size: 16.0)
        label.textColor = Colors.gray08
        label.numberOfLines = 0
        return label
    }()
    
    private let subTitleLabel = {
        let label = UILabel()
        label.text = "* 변경 시 내일부터 적용"
        label.font = Fonts.regular(size: 14.0)
        label.textColor = Colors.gray04
        label.numberOfLines = 0
        return label
    }()
    
    let tableView = {
        let tableView = UITableView()
        tableView.register(cellType: TodayNewsCountCell.self)
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
        return tableView
    }()
    
    let saveButton = NewsHabitConfirmButton(title: "저장")
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.background
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        flexContainer.pin.all()
        flexContainer.flex.layout()
    }
    
    private func setupLayout() {
        addSubview(flexContainer)
        flexContainer.flex.paddingHorizontal(20).define { flex in
            flex.addItem(titleLabel)
                .marginTop(40)
            
            flex.addItem(subTitleLabel)
                .marginTop(10)
            
            flex.addItem(tableView)
                .marginTop(25)
                .grow(1)
            
            flex.addItem(saveButton)
                .minHeight(56)
                .cornerRadius(8)
                .marginBottom(50)
        }
    }
}
