//
//  NewsHabitInputField.swift
//  SharedDesignSystem
//
//  Created by 지연 on 8/29/24.
//

import UIKit

import FlexLayout
import PinLayout

public final class NewsHabitInputField: UIView {
    private let maxLength: Int
    
    // MARK: - Components
    
    private let flexContainer = UIView()
    
    let textField = {
        let textField = UITextField()
        textField.font = Fonts.bold(size: 16.0)
        textField.textColor = .label
        textField.backgroundColor = Colors.background
        textField.borderStyle = .none
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private let separator = {
        let view = UIView()
        view.backgroundColor = Colors.gray03
        return view
    }()
    
    private let alertLabel = {
        let label = UILabel()
        label.font = Fonts.regular(size: 14.0)
        label.textColor = Colors.accent
        return label
    }()
    
    private lazy var lengthIndicatorLabel = {
        let label = UILabel()
        label.text = "0/\(maxLength)"
        label.font = Fonts.regular(size: 14.0)
        label.textColor = Colors.gray03
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Init
    
    public init(maxLength: Int, placeholder: String?) {
        self.maxLength = maxLength
        
        super.init(frame: .zero)
        
        setUpLayout()
        setUpTextField(placeholder: placeholder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        flexContainer.pin.all()
        flexContainer.flex.layout()
    }
    
    private func setUpLayout() {
        addSubview(flexContainer)
        flexContainer.flex.define { flex in
            flex.addItem(textField)
                .height(24)
            
            flex.addItem(separator)
                .height(1)
                .marginTop(8)
            
            flex.addItem()
                .direction(.row)
                .justifyContent(.spaceBetween)
                .marginTop(4)
                .define { flex in
                    flex.addItem(alertLabel)
                        .grow(1)
                    flex.addItem(lengthIndicatorLabel)
                        .width(50)
                }
        }
    }
}

private extension NewsHabitInputField {
    func setUpTextField(placeholder: String?) {
        textField.placeholder = placeholder
        textField.addTarget(
            self,
            action: #selector(handleTextFieldEditingChanged),
            for: .editingChanged
        )
    }
    
    @objc func handleTextFieldEditingChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        validate(text: text)
    }
    
    func validate(text: String) {
        let currentLength = text.count
        let isLengthValid = currentLength <= maxLength
        let isSpace = text.contains(" ")

        updateLengthIndicator(currentLength: currentLength, isValid: isLengthValid)
        updateAlertLabel(isLengthValid: isLengthValid, containsSpace: isSpace)

        let isValid = isLengthValid && !isSpace
        separator.backgroundColor = isValid ? Colors.gray03 : Colors.accent
        alertLabel.isHidden = isValid
    }

    func updateLengthIndicator(currentLength: Int, isValid: Bool) {
        lengthIndicatorLabel.text = "\(currentLength)/\(maxLength)"
        lengthIndicatorLabel.textColor = isValid ? Colors.gray03 : Colors.accent
    }

    func updateAlertLabel(isLengthValid: Bool, containsSpace: Bool) {
        if !isLengthValid {
            alertLabel.text = "1~\(maxLength)자의 닉네임을 사용해주세요"
        } else if containsSpace {
            alertLabel.text = "공백은 사용 불가합니다"
        }
    }
}
