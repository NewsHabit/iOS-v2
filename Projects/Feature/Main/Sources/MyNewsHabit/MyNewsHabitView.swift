//
//  MyNewsHabitView.swift
//  FeatureMain
//
//  Created by 지연 on 9/2/24.
//

import UIKit

public final class MyNewsHabitView: UITableView {
    // MARK: - Init
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        separatorStyle = .none
        rowHeight = 56
        contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        register(cellType: MyNewsHabitCell.self)
    }
}
