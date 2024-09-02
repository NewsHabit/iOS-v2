//
//  MonthlyRecordCell.swift
//  FeatureMain
//
//  Created by 지연 on 8/30/24.
//

import UIKit

import Shared

import PinLayout

public final class MonthlyRecordCell: UICollectionViewCell, Reusable {
    // MARK: - Components
    
    private let dayLabel = {
        let label = UILabel()
        label.font = Fonts.semiBold(size: 11.0)
        label.textColor = Colors.gray04
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        dayLabel.pin.all()
    }
    
    private func setupCell() {
        clipsToBounds = true
        layer.cornerRadius = 10
//        layer.borderWidth = 3
//        layer.borderColor = Colors.primary.cgColor
//        backgroundColor = Colors.primary.withAlphaComponent(0.7)
        contentView.addSubview(dayLabel)
    }
    
    // MARK: - Configure
    
    public func configure(with day: String) {
        dayLabel.text = day
    }
}