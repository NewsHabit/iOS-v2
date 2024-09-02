//
//  NotificationTimeView.swift
//  FeatureMain
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Shared

import FlexLayout
import PinLayout

public final class NotificationTimeView: UIView {
    // MARK: - Components
    
    private let flexContainer = UIView()
    
    let datePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.locale = Locale(identifier: "en_US_POSIX") // 12시간제 AM/PM 표기
        picker.timeZone = TimeZone(identifier: "Asia/Seoul")
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()
    
    let saveButton = NewsHabitConfirmButton(initialEnabled: true, title: "저장")
    
    // MARK: - Init
    
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
        flexContainer.flex.paddingHorizontal(20).define { flex in
            flex.addItem(datePicker)
                .marginTop(25)
                .grow(1)
            
            flex.addItem(saveButton)
                .minHeight(56)
                .cornerRadius(8)
                .marginBottom(50)
        }
    }
}
