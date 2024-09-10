//
//  NotificationView.swift
//  FeatureMain
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Shared

import FlexLayout
import PinLayout

public final class NotificationView: UIView {
    // MARK: - Components
    
    private let flexContainer = UIView()
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "알림 허용"
        label.font = Fonts.regular(size: 16.0)
        label.textColor = Colors.gray08
        return label
    }()
    
    let switchControl = {
        let view = UISwitch()
        view.onTintColor = Colors.primary
        return view
    }()
    
    let timeLabel = {
        let label = UILabel()
        label.text = "09:00 AM"
        label.font = Fonts.semiBold(size: 16.0)
        label.textColor = Colors.primary
        label.textAlignment = .center
        label.backgroundColor = Colors.primary.withAlphaComponent(0.2)
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        label.isUserInteractionEnabled = true
        return label
    }()
    
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
        flexContainer.flex
            .padding(20)
            .define { flex in
                flex.addItem()
                    .direction(.row)
                    .justifyContent(.spaceBetween)
                    .define { flex in
                        flex.addItem(titleLabel)
                        flex.addItem(switchControl)
                    }
                
                flex.addItem(timeLabel)
                    .marginTop(25)
                    .minHeight(56)
                    .cornerRadius(8)
            }
    }
}
