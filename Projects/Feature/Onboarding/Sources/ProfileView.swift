//
//  ProfileView.swift
//  FeatureOnboarding
//
//  Created by 지연 on 8/28/24.
//

import UIKit

import Shared

import FlexLayout
import PinLayout

public final class ProfileView: UIView {
    let flexContainer = UIView()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "프로필을 설정해주세요"
        label.font = Fonts.bold(size: 24.0)
        return label
    }()
    
    let subTitleLabel = {
        let label = UILabel()
        label.text = "* 닉네임은 한/영/숫자 상관없이 8자 이내"
        label.textColor = Colors.gray02
        label.font = Fonts.regular(size: 14.0)
        label.numberOfLines = 0
        return label
    }()
    
    let usernameTextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임"
        textField.font = Fonts.semiBold(size: 16.0)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = Colors.background
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.background
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
        
        flexContainer.flex.padding(20).define { flex in
            flex.addItem(titleLabel)
            
            flex.addItem(subTitleLabel)
                .marginTop(25)
            
            flex.addItem(usernameTextField)
                .marginTop(10)
                .height(44)
        }
    }
}
