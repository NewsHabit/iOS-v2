//
//  SettingsCell.swift
//  FeatureMain
//
//  Created by 지연 on 9/1/24.
//

import UIKit

import Shared

public final class SettingsCell: UITableViewCell, Reusable {
    // MARK: - Components
    
    private let iconImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.gray08
        return imageView
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = Fonts.regular(size: 17.0)
        label.textColor = Colors.gray08
        return label
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
        
        iconImageView.pin
            .size(20)
            .left(20)
            .vCenter()
        
        titleLabel.pin
            .right(of: iconImageView)
            .marginLeft(15)
            .vCenter()
            .sizeToFit()
    }
    
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
    }
    
    // MARK: - Configure
    
    public func configure(with settingsType: SettingsType) {
        iconImageView.image = UIImage(systemName: settingsType.imageName)
        titleLabel.text = settingsType.title
    }
}
