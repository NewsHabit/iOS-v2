//
//  CategoryView.swift
//  FeatureOnboardingExample
//
//  Created by 지연 on 8/29/24.
//

import UIKit

import Shared

import FlexLayout
import PinLayout

public final class CategoryView: UIView {
    // MARK: - Components
    
    private let flexContainer = UIView()
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "추천받고 싶은 카테고리를\n모두 선택해주세요"
        label.font = Fonts.bold(size: 24.0)
        label.textColor = Colors.gray08
        label.numberOfLines = 0
        return label
    }()
    
    private let subTitleLabel = {
        let label = UILabel()
        label.text = "관련된 기사를 매일 추천해드릴게요"
        label.font = Fonts.regular(size: 14.0)
        label.textColor = Colors.gray04
        label.numberOfLines = 0
        return label
    }()
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: CategoryCell.self)
        return collectionView
    }()
    
    let nextButton = NewsHabitConfirmButton(title: "다음")
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        flexContainer.pin.all()
        flexContainer.flex.layout()
    }
    
    private func setupLayout() {
        addSubview(flexContainer)
        flexContainer.flex.paddingHorizontal(20).define { flex in
            flex.addItem(titleLabel)
            
            flex.addItem(subTitleLabel)
                .marginTop(20)
            
            flex.addItem(collectionView)
                .marginTop(40)
                .grow(1)
            
            flex.addItem(nextButton)
                .minHeight(56)
                .cornerRadius(8)
                .marginBottom(50)
        }
    }
}
