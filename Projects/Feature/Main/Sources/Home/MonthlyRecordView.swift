//
//  MonthlyRecordView.swift
//  FeatureMain
//
//  Created by 지연 on 8/29/24.
//

import UIKit

import Shared

public final class MonthlyRecordView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.accent.withAlphaComponent(0.1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
