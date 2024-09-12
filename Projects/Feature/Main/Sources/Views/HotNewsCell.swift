//
//  HotNewsCell.swift
//  FeatureMain
//
//  Created by 지연 on 8/30/24.
//

import UIKit

import Domain
import Shared

import FlexLayout
import PinLayout

final class HotNewsCell: UITableViewCell, Reusable {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.font = Fonts.semiBold(size: 14.5)
        label.textColor = Colors.gray08
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.font = Fonts.regular(size: 12.0)
        label.textColor = Colors.gray04
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let thumbnailImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = Colors.gray04
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.pin.all()
        contentView.flex.layout()
    }
    
    private func setupLayout() {
        contentView.flex
            .direction(.row)
            .alignItems(.center)
            .paddingHorizontal(15)
            .define { flex in
                flex.addItem()
                    .height(75)
                    .direction(.row)
                    .shrink(1)
                    .define { flex in
                        flex.addItem()
                            .direction(.column)
                            .justifyContent(.spaceBetween)
                            .shrink(1)
                            .define { flex in
                                flex.addItem(titleLabel)
                                flex.addItem(descriptionLabel)
                            }
                        
                        flex.addItem(thumbnailImageView)
                            .marginLeft(15)
                            .size(75)
                    }
                
            }
    }
    
    // MARK: - Configure
    
    public func configure(with viewModel: HotNews) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        thumbnailImageView.kf.setImage(with: URL(string: viewModel.imgLink))
    }
}
