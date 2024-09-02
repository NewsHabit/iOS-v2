//
//  MyNewsHabitCell.swift
//  FeatureMain
//
//  Created by 지연 on 9/2/24.
//

import UIKit

import Shared

public final class MyNewsHabitCell: UITableViewCell, Reusable {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.font = Fonts.regular(size: 17.0)
        label.textColor = Colors.gray08
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.font = Fonts.regular(size: 15.0)
        label.textColor = Colors.gray04
        return label
    }()
    
    private let chevronImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = Colors.gray04
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Init
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.pin
            .left(20)
            .vCenter()
            .sizeToFit()
        
        chevronImageView.pin
            .size(12)
            .right(20)
            .vCenter()
        
        descriptionLabel.pin
            .left(of: chevronImageView)
            .marginRight(10)
            .vCenter()
            .sizeToFit()
    }
    
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(chevronImageView)
    }
    
    // MARK: - Configure
    
    public func configure(with myNewsHabitType: MyNewsHabitType) {
        titleLabel.text = myNewsHabitType.title
        descriptionLabel.text = myNewsHabitType.title
    }
}
