//
//  ProfileView.swift
//  FeatureMain
//
//  Created by 지연 on 9/2/24.
//

import UIKit

import Shared

import FlexLayout
import PinLayout

public final class ProfileView: UIView {
    private let maxNicknameLength = 8
    
    // MARK: - Components
    
    private let flexContainer = UIView()
    
    private let subTitleLabel = {
        let label = UILabel()
        label.text = "* 닉네임은 한/영/숫자/이모티콘 상관없이 8자 이내\n(공백 사용 불가)"
        label.font = Fonts.regular(size: 14.0)
        label.textColor = Colors.gray04
        label.numberOfLines = 0
        return label
    }()
    
    lazy var nicknameInputField = NewsHabitInputField(
        maxLength: maxNicknameLength,
        placeholder: "닉네임"
    )
    
    let doneButton = NewsHabitConfirmButton(title: "완료")
    
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
            flex.addItem(subTitleLabel)
                .marginTop(40)
            
            flex.addItem(nicknameInputField)
                .marginTop(20)
                .height(44)
                .grow(1)
            
            flex.addItem(doneButton)
                .minHeight(56)
                .cornerRadius(8)
                .marginBottom(20)
        }
    }
}
