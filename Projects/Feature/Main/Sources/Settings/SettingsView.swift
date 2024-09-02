//
//  SettingsView.swift
//  FeatureMainInterface
//
//  Created by 지연 on 9/1/24.
//

import UIKit

public final class SettingsView: UITableView {
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
        backgroundColor = .clear
        separatorStyle = .none
        rowHeight = 56
        register(cellType: SettingsCell.self)
    }
}
