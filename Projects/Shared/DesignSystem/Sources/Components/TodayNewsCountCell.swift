//
//  TodayNewsCountCell.swift
//  SharedDesignSystem
//
//  Created by 지연 on 8/29/24.
//

import UIKit

import SharedUtil

import PinLayout

public final class TodayNewsCountCell: UITableViewCell, Reusable {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.font = Fonts.regular(size: 16.0)
        label.textColor = Colors.gray08
        return label
    }()
    
    private let selectImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.gray08
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
    
    private func setupCell() {
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(selectImageView)
    }
    
    // MARK: - Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.pin.start(10).vCenter().sizeToFit()
        selectImageView.pin.size(20).end(10).vCenter()
    }
    
    // MARK: - Configure
    
    public func configure(with count: Int) {
        titleLabel.text = "\(count)개"
    }
    
    public func setSelected(_ isSelected: Bool) {
        selectImageView.image = isSelected ?
        UIImage(systemName: "circle.inset.filled") :
        UIImage(systemName: "circle")
    }
}
