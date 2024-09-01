//
//  NewsHabitConfirmButton.swift
//  SharedDesignSystem
//
//  Created by 지연 on 8/29/24.
//

import UIKit

public final class NewsHabitConfirmButton: UIButton {
    public override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - Init
    
    public init(initialEnabled: Bool = false, title: String) {
        super.init(frame: .zero)
        
        self.isEnabled = initialEnabled
        setupButton(title: title)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup Methods
    
    private func setupButton(title: String) {
        tintColor = .white
        configuration = .plain()
        var attributedTitle = AttributedString(title)
        attributedTitle.font = Fonts.semiBold(size: 16.0)
        configuration?.attributedTitle = attributedTitle
    }
    
    private func updateAppearance() {
        backgroundColor = isEnabled ? Colors.primary : Colors.disabled
    }
}
