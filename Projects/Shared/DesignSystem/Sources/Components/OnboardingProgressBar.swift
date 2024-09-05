//
//  OnboardingProgressBar.swift
//  SharedDesignSystem
//
//  Created by 지연 on 9/5/24.
//

import UIKit

import PinLayout
import SharedUtil

public final class OnboardingProgressBar: UIView {
    private let count = OnboardingType.allCases.count
    
    // MARK: - Components
    
    private lazy var stepViews: [UIView] = (0..<count).map { _ in
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 2
        return view
    }
    
    // MARK: - Init
    
    public init(onboardingType: OnboardingType) {
        super.init(frame: .zero)
        
        setupView()
        setupStepView(for: onboardingType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        stepViews.forEach { stepView in
            stepView.backgroundColor = Colors.gray02
            addSubview(stepView)
        }
    }
    
    private func setupLayout() {
        let margin: CGFloat = 15
        let stepWidth = (frame.width - margin * CGFloat(count - 1)) / CGFloat(count)
        let stepHeight = frame.height
        
        for (index, stepView) in stepViews.enumerated() {
            stepView.pin
                .left(CGFloat(index) * (stepWidth + margin))
                .vCenter()
                .width(stepWidth)
                .height(stepHeight)
        }
    }
    
    private func setupStepView(for onboardingType: OnboardingType) {
        for (index, stepView) in stepViews.enumerated() {
            stepView.backgroundColor = index <= onboardingType.rawValue ?
            Colors.primary :
            Colors.gray02
        }
    }
}
