//
//  DailyNewsCell.swift
//  FeatureMain
//
//  Created by 지연 on 8/29/24.
//

import UIKit

import Shared

import FlexLayout
import Kingfisher
import PinLayout

final class DailyNewsCell: UITableViewCell, Reusable {
    // MARK: - Components
    
    private let titleView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private let readStateView = {
        let view = UIView()
        view.backgroundColor = Colors.accent
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = Fonts.semiBold(size: 14.5)
        label.textColor = Colors.gray08
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let categoryLabel = {
        let label = UILabel()
        label.textColor = Colors.gray01
        label.textAlignment = .center
        label.font = Fonts.bold(size: 10.0)
        label.backgroundColor = Colors.primary
        label.clipsToBounds = true
        label.layer.cornerRadius = 9
        label.translatesAutoresizingMaskIntoConstraints = false
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
                            .grow(1)
                            .shrink(1)
                            .define { flex in
                                flex.addItem(titleView)
                                    .height(20)
                                flex.addItem(descriptionLabel)
                            }
                        
                        flex.addItem(thumbnailImageView)
                            .marginLeft(15)
                            .size(75)
                    }
                
            }
        
        [readStateView, titleLabel, categoryLabel].forEach { titleView.addArrangedSubview($0) }
    
        NSLayoutConstraint.activate([
            readStateView.widthAnchor.constraint(equalToConstant: 8),
            readStateView.heightAnchor.constraint(equalToConstant: 8),
            
            categoryLabel.widthAnchor.constraint(equalToConstant: 50),
            categoryLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        layoutIfNeeded()
    }
    
    // MARK: - Configure
    
    public func configure(with viewModel: DailyNewsCellViewModel) {
        readStateView.isHidden = viewModel.isRead
        titleLabel.text = viewModel.dailyNews.title
        categoryLabel.text = CategoryType.convertAPIIdentifier(from: viewModel.dailyNews.category) 
        descriptionLabel.text = viewModel.dailyNews.description
        thumbnailImageView.kf.setImage(with: URL(string: viewModel.dailyNews.imgLink))
    }
}
