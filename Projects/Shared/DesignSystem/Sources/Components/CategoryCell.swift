//
//  CategoryCell.swift
//  SharedDesignSystem
//
//  Created by 지연 on 8/29/24.
//

import UIKit

import SharedUtil

import PinLayout

public final class CategoryCell: UICollectionViewCell, Reusable {
    // MARK: - Components
    
    private let nameLabel = {
        let label = UILabel()
        label.font = Fonts.regular(size: 14.0)
        label.textColor = Colors.background
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
        
        nameLabel.pin.center().sizeToFit()
        layer.cornerRadius = contentView.frame.height / 2
    }
    
    private func setupCell() {
        clipsToBounds = true
        contentView.addSubview(nameLabel)
    }
    
    // MARK: - Configure
    
    public func configure(with categoryName: String) {
        nameLabel.text = categoryName
    }
    
    public func setSelected(_ isSelected: Bool) {
        backgroundColor = isSelected ? Colors.gray08 : Colors.disabled
    }
}
